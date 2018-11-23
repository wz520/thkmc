; 继承自 TH15

class THKMC_GameData143 extends THKMC_GameData15 {
	__New( ) {
		base.__New()
		base._setEXEInfo("th143", "弹幕天邪鬼 1.00a", 0x53546435, 939008)
		; 直接继承 th15 的 patchdata
		pd := this.patchdata
		this._setPatchData( 0x4021b7, 0x402339, 0x400c00, 0x104, pd )
	}
}

