#include PEHelper.ahk

; 用于生成已打补丁的EXE的类
class THKMC_PatchProcessor {
	__New( pEXEData, exesize, kmcdata ) {
		this._pEXEData := pEXEData ; 指向 EXE 二进制数据（不是HEX数据）的指针
		this._exesize  := exesize  ; EXE 文件大小
		this._d        := kmcdata  ; THKMC_GameData 或其子类的实例
	}

	; 有错扔异常
	doPatch() {
		global THKMC_KeyNamesDX
		key_names := THKMC_KeyNamesDX

		inifilepath := this._d.inifilepath
		inifilesection := this._d.gamename

		; 获取 Default 段和当前游戏所属段中是否有被 INCLUDE section，若有则记下
		IniRead, includesection_default, %inifilepath%, Default, INCLUDE
		IniRead, includesection, %inifilepath%, %inifilesection%, INCLUDE

		; 遍历与键位相关的操作数
		matchstr=
		startingpos := 1
		patchdata   := this._d.patchdata
		Loop {
			startingpos += StrLen(matchstr1)
			; 找出所有 BYTE PTR SS:[ EBPorESP ± CONST32 ]
			startingpos := RegExMatch(patchdata, this._d.addrPattern, matchstr, startingpos)
			if ( !startingpos ) {
				break ; 已处理完所有按键
			}

			KeymapValue := this._d.str2KeymapValue(matchstr1)
			if (KeymapValue = "OUT") {
				continue ; 超出范围， 忽略
			}

			; msgbox % KeymapValue
			KeymapKeys := this._findKeymapKeyFromValue(KeymapValue, key_names)
			if ( !KeymapKeys.MaxIndex() ) {
				; DEBUG: 用户不应该看到下面的内部错误信息
				msg = 【DEBUG】内部错误ERR001。
				AddLog(msg, True)
				continue ; 执行到这里表明需要重新DEBUG，先跳过
			}

			; 开始从 INI 中读取键位设置，并根据 this._d 中的设置修改相应的 EXE 数据（HEX-ASCII）
			for i, keymap in KeymapKeys {
				log_message=
				newkeymap := this._readKeymapFromINI(keymap, this._d.gamename, includesection, log_message) ; 当前游戏所属段
				if ( newkeymap = "ERROR" || newkeymap = "" ) {
					newkeymap := this._readKeymapFromINI(keymap, "Default", includesection_default, log_message) ; 读取失败，尝试从 Default 段读取
					if ( newkeymap = "ERROR" || newkeymap = "" ) {
						AddLogIfNotEmpty(log_message)
						continue  ; 还是读取失败（该键位的设置不存在或者等号右边为空），跳过
					}
				}

				; 检查等号右边的是否是数值，如果是，则直接看做是扫描码，不进行转换
				if newkeymap is Integer
				{
					newkeymapValue := newkeymap & 0xff  ; 扫描码应该只有低 8 位有效
				}
				else {
					newkeymapValue := key_names[newkeymap]
				}
				if ( newkeymapValue = "" ) {
					; 该键位名不存在于 key_names 。是个错误的键位名
					errmsg = 【警告】无法为【%keymap%】设置新映射：无法识别的键位名【%newkeymap%】

					; DEPRECATED: throw Exception(errmsg, inifilepath)
					; 现在将错误 INI 中的错误键位名视为警告
					AddLog(errmsg)
					continue
				}

				newkeymapValue := this._d.keymapValue2Str( newkeymapValue )

				; 修改完毕，替换掉原来的数据
				patchdata := RegExReplace(patchdata, "\b" . matchstr1 . "\b", newkeymapValue, replcount, 1, startingpos)
				if ( replcount = 1 ) {
					msg = 【设置成功】【%keymap%】->【%newkeymap%】
					AddLog(msg)
				}
				else {
					errmsg = 映射【%keymap%】为【%newkeymap%】失败！
					throw Exception(errmsg, inifilepath)
				}
			}
		}

		; 在 patchdata 的最后增加 JMP 指令以跳转到原来的流程
		codelen           := MCode(code, patchdata)
		addr_beginjmp     := this._d.patchaddr + codelen

        ; **DEBUG**，确保补丁数据长度小于原始数据长度。这两条信息不应该出现在最终用户面前
        if ( addr_beginjmp = this._d.patchaddrjmpto ) {
            throw Exception("补丁数据长度等于原始数据长度。请将此信息汇报给作者。", this._d.inifilepath)
        }
        else if ( addr_beginjmp > this._d.patchaddrjmpto ) {
            throw Exception("补丁数据长度超过原始数据长度。请将此信息汇报给作者。", this._d.inifilepath)
        }

		patchaddr_diff    := this._d.patchaddrjmpto - addr_beginjmp
		if ( patchaddr_diff <= 6 ) {
			; 若补丁比原内容少了不大于 6 个字节，补相应数量的 NOP
			this._d.patchdata := patchdata . StringRepeat("90", patchaddr_diff)
		}
		else {
			; 大于 6 个字节，则补 JMP 跳到原来的流程
			calladdr          := addr2CallAddr( addr_beginjmp, this._d.patchaddrjmpto )
			this._d.patchdata := patchdata . " " . longjmpOrShortjmp("E9", "EB", calladdr)
		}
	}

	; 将 patchdata 写入内存（非文件）中的 EXE 数据（二进制）
	updateEXECache() {
		codelen := MCode(code, this._d.patchdata)
		offset := this._d.patchaddr - this._d.patchVAfix  ;; Virtual Address -> Raw Offset in EXE
		try DllCall("RtlMoveMemory", "ptr", this._pEXEData + offset , "ptr", &code, "uint", codelen)
		this._d.doCustomPatch( this._pEXEData )
	}

	; 检查 EXE 文件的内容是否属于某一东方 STG 游戏
	isEXEThisGame() {
		if (this._checkFilesize()) {
			pehelper := new CPEHelper(this._pEXEData, this._exesize)
			return pehelper.isPE && (pehelper.timestamp = this._d.timestamp)
		}
		return False
	}

;private
	_checkFilesize() {
		; 这么写方便用 msgbox 调试
		s1 := this._exesize
		s2 := this._d.minfilesize
		return s1 >= s2
	}

	; 将 KeymapValue 作为键查询 key_names 中的键名
	; 由于可能有多个，所以返回列表
	_findKeymapKeyFromValue(KeymapValue, key_names) {
		result := []
		for k, v in key_names {
			if ( v = KeymapValue ) {
				result.Insert(k)
			}
		}
		return result
	}

	; 从 this._d.inifilepath 文件中读取
	; 如果从 section 段中读取失败，则尝试 includesection ，都失败则 AddLog 并返回 "ERROR"
	; 如果返回空，则同样调用 AddLog()
	; log_message 用于返回执行时的 log。应该传给 AddLog() 。
	; 由于本方法内部可能会递归，在本方法内部调用 AddLog() 可能会造成多个重复的 log，所以调用 AddLog() 的任务交给了调用者
	_readKeymapFromINI(keymap, section, includesection, ByRef log_message) {
		inifilepath := this._d.inifilepath
		IniRead, newkeymap, %inifilepath%, %section%, %keymap%
		if ( newkeymap = "ERROR" ) {
			; 读取 INCLUDE 段中的相应设置
			if ( includesection != "ERROR" ) {
				IniRead, newkeymap, %inifilepath%, %includesection%, %keymap%
			}
			if ( newkeymap = "ERROR" ) {
				log_message := "｛未指定｝" . keymap
				return newkeymap ; 该键位的设置不存在，跳过
			}
		}

		; 等号右边为空，可以忽略掉被 INCLUDE 的设置。
		if ( newkeymap = "" ) {
			log_message := "｛已忽略｝：" . keymap
		}
		else {
			; 看看读取的值中有无冒号，有的话则将左边那部分当做段名，右边部分当做键名进行引用
			; 比如 th7:UP 表示引用 [th7] 段中的 UP= 右边的值
			newkeymap_bycolon := StrSplit(newkeymap, ":")
			if ( newkeymap_bycolon[1] != "" && newkeymap_bycolon[2] != "" ) {
				; 引用了其他值，重新读取指定键中的值
				newkeymap := this._readKeymapFromINI(newkeymap_bycolon[2], newkeymap_bycolon[1], "ERROR", log_message)
			}
		}

		return newkeymap
	}
}
