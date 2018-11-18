; 继承自 TH15

class THKMC_GameData165 extends THKMC_GameData15 {
	__New( ) {
		base.__New()
		base._setEXEInfo("th165", "秘封噩梦日记 1.00a", 0x5B5FB2EF, 740352)
		; 直接继承 th15 的 patchdata
		pd := this.patchdata
		this._setPatchData( 0x401bd7, 0x401d59, 0x400c00, 0x104, pd )
	}
}

