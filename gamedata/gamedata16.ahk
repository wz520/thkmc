; 继承自 TH15

class THKMC_GameData16 extends THKMC_GameData15 {
	__New( ) {
		base.__New()
		base._setEXEInfo("th16", "东方天空璋 1.00a", 0x597F974D, 683520)
		; 直接继承 th15 的 patchdata
		pd := this.patchdata
		this._setPatchData( 0x401f67, 0x4020e9, 0x400c00, 0x104, pd )
	}
}

