; 获取 PE 文件头信息
; 目前只能获取 timestamp

class CPEHelper {
	; pEXEData: 指向 EXE 数据的指针。【注意】本类不会复制指针所指内容。
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
		; 文件大小必须大于 0x40 (sizeof(IMAGE_DOS_HEADER))
		if ( this._size > 0x40 ) {
			; 'MZ' magic number
			uMZ := NumGet(this._p, 0x00, "UShort")
			if ( uMZ = 0x5a4d ) {
				; 获取 IMAGE_NT_HEADERS 结构偏移
				oPEHeader := NumGet(this._p, 0x3c, "UInt")
				; 偏移不得超出文件大小
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

	; 如果 isPE 为 False 则扔异常
	checkIsPE() {
		if ( !this.isPE ) {
			throw Exception("Invalid PE Header")
		}
	}

	timestamp[]
	{
		get {
			this.checkIsPE()

			; PEHeader+08h 即是 timestamp
			return NumGet(this._p, this.oPEHeader+0x08, "UInt")
		}
		set {
			throw Exception("Currently not supported")
		}
	}
}
