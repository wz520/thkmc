#include PEHelper.ahk

; ���������Ѵ򲹶���EXE����
class THKMC_PatchProcessor {
	__New( pEXEData, exesize, kmcdata ) {
		this._pEXEData := pEXEData ; ָ�� EXE ���������ݣ�����HEX���ݣ���ָ��
		this._exesize  := exesize  ; EXE �ļ���С
		this._d        := kmcdata  ; THKMC_GameData ���������ʵ��
	}

	; �д����쳣
	doPatch() {
		global THKMC_KeyNamesDX
		key_names := THKMC_KeyNamesDX

		inifilepath := this._d.inifilepath
		inifilesection := this._d.gamename

		; ��ȡ Default �κ͵�ǰ��Ϸ���������Ƿ��б� INCLUDE section�����������
		IniRead, includesection_default, %inifilepath%, Default, INCLUDE
		IniRead, includesection, %inifilepath%, %inifilesection%, INCLUDE

		; �������λ��صĲ�����
		matchstr=
		startingpos := 1
		patchdata   := this._d.patchdata
		Loop {
			startingpos += StrLen(matchstr1)
			; �ҳ����� BYTE PTR SS:[ EBPorESP �� CONST32 ]
			startingpos := RegExMatch(patchdata, this._d.addrPattern, matchstr, startingpos)
			if ( !startingpos ) {
				break ; �Ѵ��������а���
			}

			KeymapValue := this._d.str2KeymapValue(matchstr1)
			if (KeymapValue = "OUT") {
				continue ; ������Χ�� ����
			}

			; msgbox % KeymapValue
			KeymapKeys := this._findKeymapKeyFromValue(KeymapValue, key_names)
			if ( !KeymapKeys.MaxIndex() ) {
				; DEBUG: �û���Ӧ�ÿ���������ڲ�������Ϣ
				msg = ��DEBUG���ڲ�����ERR001��
				AddLog(msg, True)
				continue ; ִ�е����������Ҫ����DEBUG��������
			}

			; ��ʼ�� INI �ж�ȡ��λ���ã������� this._d �е������޸���Ӧ�� EXE ���ݣ�HEX-ASCII��
			for i, keymap in KeymapKeys {
				log_message=
				newkeymap := this._readKeymapFromINI(keymap, this._d.gamename, includesection, log_message) ; ��ǰ��Ϸ������
				if ( newkeymap = "ERROR" || newkeymap = "" ) {
					newkeymap := this._readKeymapFromINI(keymap, "Default", includesection_default, log_message) ; ��ȡʧ�ܣ����Դ� Default �ζ�ȡ
					if ( newkeymap = "ERROR" || newkeymap = "" ) {
						AddLogIfNotEmpty(log_message)
						continue  ; ���Ƕ�ȡʧ�ܣ��ü�λ�����ò����ڻ��ߵȺ��ұ�Ϊ�գ�������
					}
				}

				; ���Ⱥ��ұߵ��Ƿ�����ֵ������ǣ���ֱ�ӿ�����ɨ���룬������ת��
				if newkeymap is Integer
				{
					newkeymapValue := newkeymap & 0xff  ; ɨ����Ӧ��ֻ�е� 8 λ��Ч
				}
				else {
					newkeymapValue := key_names[newkeymap]
				}
				if ( newkeymapValue = "" ) {
					; �ü�λ���������� key_names ���Ǹ�����ļ�λ��
					errmsg = �޷�Ϊ��%keymap%��������ӳ�䣺�޷�ʶ��ļ�λ����%newkeymap%��
					throw Exception(errmsg, inifilepath)
				}

				newkeymapValue := this._d.keymapValue2Str( newkeymapValue )

				; �޸���ϣ��滻��ԭ��������
				patchdata := RegExReplace(patchdata, "\b" . matchstr1 . "\b", newkeymapValue, replcount, 1, startingpos)
				if ( replcount = 1 ) {
					msg = �����óɹ�����%keymap%��->��%newkeymap%��
					AddLog(msg)
				}
				else {
					errmsg = ӳ�䡾%keymap%��Ϊ��%newkeymap%��ʧ�ܣ�
					throw Exception(errmsg, inifilepath)
				}
			}
		}

		; �� patchdata ��������� JMP ָ������ת��ԭ��������
		codelen           := MCode(code, patchdata)
		addr_beginjmp     := this._d.patchaddr + codelen

        ; **DEBUG**��ȷ���������ݳ���С��ԭʼ���ݳ��ȡ���������Ϣ��Ӧ�ó����������û���ǰ
        if ( addr_beginjmp = this._d.patchaddrjmpto ) {
            throw Exception("�������ݳ��ȵ���ԭʼ���ݳ��ȡ��뽫����Ϣ�㱨�����ߡ�", this._d.inifilepath)
        }
        else if ( addr_beginjmp > this._d.patchaddrjmpto ) {
            throw Exception("�������ݳ��ȳ���ԭʼ���ݳ��ȡ��뽫����Ϣ�㱨�����ߡ�", this._d.inifilepath)
        }

		patchaddr_diff    := this._d.patchaddrjmpto - addr_beginjmp
		if ( patchaddr_diff <= 6 ) {
			; ��������ԭ�������˲����� 6 ���ֽڣ�����Ӧ������ NOP
			this._d.patchdata := patchdata . StringRepeat("90", patchaddr_diff)
		}
		else {
			; ���� 6 ���ֽڣ��� JMP ����ԭ��������
			calladdr          := addr2CallAddr( addr_beginjmp, this._d.patchaddrjmpto )
			this._d.patchdata := patchdata . " " . longjmpOrShortjmp("E9", "EB", calladdr)
		}
	}

	; �� patchdata д���ڴ棨���ļ����е� EXE ���ݣ������ƣ�
	updateEXECache() {
		codelen := MCode(code, this._d.patchdata)
		offset := this._d.patchaddr - this._d.patchVAfix  ;; Virtual Address -> Raw Offset in EXE
		try DllCall("RtlMoveMemory", "ptr", this._pEXEData + offset , "ptr", &code, "uint", codelen)
		this._d.doCustomPatch( this._pEXEData )
	}

	; ��� EXE �ļ��������Ƿ�����ĳһ���� STG ��Ϸ
	isEXEThisGame() {
		if (this._checkFilesize()) {
			pehelper := new CPEHelper(this._pEXEData, this._exesize)
			return pehelper.isPE && (pehelper.timestamp = this._d.timestamp)
		}
		return False
	}

;private
	_checkFilesize() {
		; ��ôд������ msgbox ����
		s1 := this._exesize
		s2 := this._d.minfilesize
		return s1 >= s2
	}

	; �� KeymapValue ��Ϊ����ѯ key_names �еļ���
	; ���ڿ����ж�������Է����б�
	_findKeymapKeyFromValue(KeymapValue, key_names) {
		result := []
		for k, v in key_names {
			if ( v = KeymapValue ) {
				result.Insert(k)
			}
		}
		return result
	}

	; �� this._d.inifilepath �ļ��ж�ȡ
	; ����� section ���ж�ȡʧ�ܣ����� includesection ����ʧ���� AddLog ������ "ERROR"
	; ������ؿգ���ͬ������ AddLog()
	; log_message ���ڷ���ִ��ʱ�� log��Ӧ�ô��� AddLog() ��
	; ���ڱ������ڲ����ܻ�ݹ飬�ڱ������ڲ����� AddLog() ���ܻ���ɶ���ظ��� log�����Ե��� AddLog() �����񽻸��˵�����
	_readKeymapFromINI(keymap, section, includesection, ByRef log_message) {
		inifilepath := this._d.inifilepath
		IniRead, newkeymap, %inifilepath%, %section%, %keymap%
		if ( newkeymap = "ERROR" ) {
			; ��ȡ INCLUDE ���е���Ӧ����
			if ( includesection != "ERROR" ) {
				IniRead, newkeymap, %inifilepath%, %includesection%, %keymap%
			}
			if ( newkeymap = "ERROR" ) {
				log_message := "��δָ����" . keymap
				return newkeymap ; �ü�λ�����ò����ڣ�����
			}
		}

		; �Ⱥ��ұ�Ϊ�գ����Ժ��Ե��� INCLUDE �����á�
		if ( newkeymap = "" ) {
			log_message := "���Ѻ��ԣ���" . keymap
		}
		else {
			; ������ȡ��ֵ������ð�ţ��еĻ�������ǲ��ֵ����������ұ߲��ֵ���������������
			; ���� th7:UP ��ʾ���� [th7] ���е� UP= �ұߵ�ֵ
			newkeymap_bycolon := StrSplit(newkeymap, ":")
			if ( newkeymap_bycolon[1] != "" && newkeymap_bycolon[2] != "" ) {
				; ����������ֵ�����¶�ȡָ�����е�ֵ
				newkeymap := this._readKeymapFromINI(newkeymap_bycolon[2], newkeymap_bycolon[1], "ERROR", log_message)
			}
		}

		return newkeymap
	}
}
