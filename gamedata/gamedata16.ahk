; �̳��� TH15

class THKMC_GameData16 extends THKMC_GameData15 {
	__New( ) {
		base.__New()
		base._setEXEInfo("th16", "�������� 1.00a", 0x597F974D, 683520)
		; ֱ�Ӽ̳� th11 �� patchdata
		pd := this.patchdata
		this._setPatchData( 0x401f67, 0x4020e9, 0x400c00, 0x104, pd )
	}
}

