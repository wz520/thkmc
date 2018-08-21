class THKMC_GameData6cn extends THKMC_GameData6 {
	__New( ) {
		base.__New()
		base._setEXEInfo("th6", "东方红魔乡 渔场汉化版", 0x3D6F56A4, 506880)
		; 直接继承 th6 的 patchdata
		pd := this.patchdata
		this._setPatchData( 0x41d825, 0x41dc2f, 0x400c00, 0x108, pd )
	}
}
