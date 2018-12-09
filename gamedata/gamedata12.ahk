; 本作很坑爹的按 [ESP+XX] 来访问局部变量...
; 继承自 TH11

class THKMC_GameData12 extends THKMC_GameData11 {
	__New( ) {
		base.__New()
		this._setEXEInfo("th12", "东方星莲船 1.00b", 0x4a95ffdc, 737280)
		; 直接继承 th11 的 patchdata
		pd := this.patchdata
		this._setPatchData( 0x463093, 0x4631e1, 0x400c00, 0x80, pd )
	}

	; 屏蔽 TH11 的 custom patch
	doCustomPatch( pExeData ) {
	}
}

