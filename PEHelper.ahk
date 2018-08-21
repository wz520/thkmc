; ��ȡ PE �ļ�ͷ��Ϣ
; Ŀǰֻ�ܻ�ȡ timestamp

class CPEHelper {
	; pEXEData: ָ�� EXE ���ݵ�ָ�롣��ע�⡿���಻�Ḵ��ָ����ָ���ݡ�
	__New( pEXEData, datasize ) {
		this._p := pEXEData
		this._size := datasize
		this.isPE := -1
		this.isPE := this._verify()
	}

	_verify() {
		if ( this.isPE != -1 ) {
			throw Exception("Do not call me twice.  Use isPE property")
		}
		result := False
		; �ļ���С������� 0x40 (sizeof(IMAGE_DOS_HEADER))
		if ( this._size > 0x40 ) {
			; 'MZ' magic number
			uMZ := NumGet(this._p, 0x00, "UShort")
			if ( uMZ = 0x5a4d ) {
				; ��ȡ IMAGE_NT_HEADERS �ṹƫ��
				oPEHeader := NumGet(this._p, 0x3c, "UInt")
				; ƫ�Ʋ��ó����ļ���С
				if ( oPEHeader < this._size ) {
					; 'PE' magic number
					uPE := NumGet(this._p, oPEHeader+0, "UInt")
					if ( uPE = 0x00004550 ) {
						this.oPEHeader := oPEHeader
						result := True
					}
				}
			}
		}
		return result
	}

	; ��� isPE Ϊ False �����쳣
	checkIsPE() {
		if ( !this.isPE ) {
			throw Exception("Invalid PE Header")
		}
	}

	timestamp[]
	{
		get {
			this.checkIsPE()

			; PEHeader+08h ���� timestamp
			return NumGet(this._p, this.oPEHeader+0x08, "UInt")
		}
		set {
			throw Exception("Currently not supported")
		}
	}
}
