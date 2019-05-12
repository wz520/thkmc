
class WZSplashWindow {
	static CURSOR_APPSTARTING := 0x7F8A
	static CURSOR_WAIT := 0x7F02

	; NOTE: CURRENTLY THE cursor PARAMETER IS NOT ACTUALLY USED
	;
	; "cursor:=CURSOR_APPSTARTING" is not allowed because the default
	;    value for an optional parameter cannot be a variable.
	;    So use "cursor:=0x7F8A" instead.
	__New(name, title, message, cursor:=0x7F8A) {
		this.name := name
		this.title := title
		this.message := message
		; this.cursor := cursor
		this.defaultgui := A_DefaultGui
		this._destroyed := False

		Gui, %name%: New, +Owner%defaultgui% -SysMenu HwndhSplash, %title%
		Gui, Add, Text, w200 r1 Center HwndhText, %message%

		; TODO: This will also affect the main window, so disable it at the moment
		; if ( cursor ) {
		if ( 0 ) {
			Ptr := A_PtrSize ? "Ptr" : "UInt"
			GCL_HCURSOR=0xFFFFFFF4
			hCursor := DllCall("LoadCursor", Ptr, 0, Ptr, cursor)
			DllCall("SetClassLong", Ptr, hSplash, int, GCL_HCURSOR, Ptr, hCursor)
			DllCall("SetClassLong", Ptr, hText, int, GCL_HCURSOR, Ptr, hCursor)
		}
	}

	Show() {
		if ( this._destroyed ) {
			return
		}

		defaultgui := this.defaultgui
		Gui, Show, Center AutoSize
		Gui, %defaultgui%:Default
		Gui, %defaultgui%:+Disabled
	}

	Destroy() {
		if ( this._destroyed ) {
			return
		}

		defaultgui := this.defaultgui
		name := this.name
		Gui, %defaultgui%:-Disabled
		Gui, %name%: Destroy

		this._destroyed := True
	}

	__Delete() {
		this.Destroy()
	}
}
