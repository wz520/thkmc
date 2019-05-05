;; THKMC_GameDataXXX 的基类
class THKMC_GameDataBase {
	__New( gamename, gamenameCN, timestamp, minfilesize ) {
		this._setEXEInfo( gamename, gamenameCN, timestamp, minfilesize )

		; 一串正则表达式，用于从 patchdata 中取出与键位码相关机器指令的操作数的 HEX 子串（取第一个子表达式。不能没有子表达式）
		; 其中 0fb6 是 MOVZX R32, BYTE PTR SS:[EBP+CONST32] 系列指令的头两个字节
		; 该表达式不适用于所有游戏，所以有些子类的构造函数会修改它。
		this.addrPattern := "i)\b0fb6[0-9a-f]+\s([0-9a-z]{2}f[ef]ffff)\s"
	}

	_setEXEInfo( gamename, gamenameCN, timestamp, minfilesize ) {
		this.gamename   := gamename   ;; 游戏代号（目前用于 INI 文件中的段名）
		this.gamenameCN := gamenameCN ;; 游戏的中文描述（显示给用户看的）

		; PE 头中的时间戳。用于确定EXE文件的游戏版本
		this.timestamp  := timestamp

		;; EXE 的【最小】文件大小。为了支持给EXE添加了区段的第三方补丁，所以并不指定精确的文件大小
		this.minfilesize   := minfilesize
	}

	_setPatchData( patchaddr, patchaddrjmpto, patchVAfix, patchvaluefix, patchdata ) {
		this.patchaddr      := patchaddr      ;; 补丁数据的起始地址(VA，即OD中所看到的地址)
		this.patchaddrjmpto := patchaddrjmpto ;; 目标地址，补丁最后的一个 jmp 指令的目标地址，也就是补丁的结束地址
		;; VA - File_Offset(EXE内偏移)
		;; 在 OD 的 CPU 窗口中随便选择一条EXE领空中的指令，右键菜单->查看->可执行文件，然后将 CPU 窗口中的地址减去“可执行文件”窗口中相同指令的地址即可算出该值
		;; 对于大多数东方STG的EXE，该值都是 0x400c00，不过也有例外，比如永夜抄就是 0x400200
		this.patchVAfix     := patchVAfix
		;; 在 OD 中从 patchaddr 向上查找 LEA R32, [ebp-XXX]，取其中的 XXX
		this.patchvaluefix  := patchvaluefix

		; 补丁的二进制数据的HEX字符串表示。所有非 HEX 字符都将被忽略
		this.patchdata := patchdata

		; SplitPath, A_ScriptFullPath, , , , scriptname
		; this.inifilepath := A_ScriptDir . "\" . scriptname . ".ini"
		this.inifilepath := "thkmc.ini"
	}

	; 用于与按键映射无关的自定义补丁代码。
	; 比如 TH07/TH08 需要加入破解自校验的代码才可以让修改过的 EXE 正常运行
	; 目前用于被 7,8 两个子类覆盖。本基类并不做任何事
	doCustomPatch( pEXEData ) {
	}

	; 把使用 HEX 字串表示的数值转换成 AHK 中的整数形式
	; 被转换的 HEX 字串必须是32位小端格式
	; 如果返回字符串 "OUT"，则认为超出范围，应该被跳过
	str2KeymapValue( s ) {
		KeymapValue := ToSigned(BSwap32_ahk( Pad0x(s)+0 ))
		KeymapValue := KeymapValue + this.patchvaluefix

		if ( KeymapValue > 0xff || KeymapValue < 0 ) {
			return "OUT" ; 超出范围， 忽略
		}

		return KeymapValue
	}

	; 上面的反函数
	keymapValue2Str( k ) {
		k := ToUnsigned( k - this.patchvaluefix )
		return PadLeadingZero( UnPad0x(ToHex( BSwap32_ahk( k ) )), 8 )
	}
}



#include gamedata\gamedata6.ahk
#include gamedata\gamedata6cn.ahk
#include gamedata\gamedata7.ahk
#include gamedata\gamedata8.ahk
#include gamedata\gamedata95.ahk

#include gamedata\gamedata10.ahk
#include gamedata\gamedata11.ahk
#include gamedata\gamedata12.ahk
#include gamedata\gamedata125.ahk
#include gamedata\gamedata128.ahk

#include gamedata\gamedata13.ahk
#include gamedata\gamedata14.ahk
#include gamedata\gamedata143.ahk
#include gamedata\gamedata15.ahk
#include gamedata\gamedata16.ahk
#include gamedata\gamedata165.ahk
#include gamedata\gamedata17tr.ahk

#include gamedata\gamedataalcostg.ahk


; 类名 "THKMC_GameDataXXX" 的 XXX 部分
THKMC_GameIDList := [ "6", "6cn", "7", "8", "95", "10", "11", "12", "125", "128", "13", "14", "143", "15", "16", "165", "17tr", "alcostg" ]

; 获取所有支持的游戏列表字符串（目前用于“关于”对话框）
THKMC_GetGameNameList()
{
	global THKMC_GameIDList
	result := []
	for k, id in THKMC_GameIDList {
		gamedata := new THKMC_GameData%id%()
		result.Push( Format("[{:s}]`t{:s}", gamedata.gamename, gamedata.gamenameCN) )
	}
	return array_join(result)
}
