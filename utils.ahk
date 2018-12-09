; 本文件是 THKMC 的一部分
;
; -- 一些辅助函数


;将10进制数转为16进制数。
ToHex(Hex){
	oldformat := A_FormatInteger
	SetFormat, integer, H
	Hex += 0
	;~ StringReplace, Hex, Hex, 0x
	SetFormat, integer, %oldformat%
	return, Hex
}

Pad0x(s){
	return "0x" . s
}
UnPad0x(s){
	return RegExReplace(s, "^0x", "")
}
ToSigned(n) {
	return n > 0x7FFFFFFF ? -(~n) - 1 : n
}
ToUnsigned(n) {
	return n & 0xffffffff
}
BSwap32_ahk(a) {
	return ((a<<24) & 0xFF000000) | ((a<<8) & 0xFF0000) | ((a>>8) & 0xFF00) | ((a>>24) & 0xFF)
}

MCode(ByRef code, hex) {
	hex := RegExReplace(hex, "i)[^0-9a-f]")  ; delete all non-hex chars
	codelen := StrLen(hex)//2
	VarSetCapacity(code,codelen)
	Loop % codelen
		NumPut("0x" . SubStr(hex,2*A_Index-1,2), code, A_Index-1, "Char")
	return codelen
}

; CURRENTLY ONLY LONG-JMP IS SUPPORTED
; addrfix is instruction-dependent,
; for example:
;	For jmp,call, addrfix is 5;
;	For je,jnz, addrfix is 6
addr2CallAddr(callAddr, targetAddr, addrfix=5) {
	return (targetAddr-(callAddr+addrfix)) & 0xffffffff
}

addr2Hex(addr) {
	return PadLeadingZero( UnPad0x(ToHex(BSwap32_ahk(addr))), 8 )
}

; opr_longjmp := operand for longjmp, here 'jmp' includes jmp,jz,jnz ...
; return hex representation of the jmp instruction
longjmpOrShortjmp(opr_longjmp, opr_shortjmp, addr) {
	; addr+3 for shortjmp, because the instruction would be 3 bytes shorter than longjmp
	return addr > 0x7f
			? opr_longjmp . " " . addr2Hex(addr)
			: opr_shortjmp . " " . PadLeadingZero( UnPad0x(ToHex(addr+3)), 2 )
}

PadLeadingZero(s, len) {
	slen := strlen(s)
	zlen := len - slen
	zeros =
	Loop % zlen
		zeros .= "0"
	return zeros . s
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; LOG 相关
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AddLog(text, seterror=False) {
	global logtext, HasError

	if ( seterror ) {
		HasError := True
	}

	if logtext=
		logtext := text
	else
		logtext .= "`n" . text
}

AddLogIfNotEmpty(text, params*) {
	if ( StrLen(text) != 0 ) {
		AddLog(text, params*)
	}
}

; 返回原先的 HasError 标志
ClearLog() {
	global logtext, HasError
	logtext=
	_HasError := HasError
	HasError:=False
	return _HasError
}

/*  ; DEPRECATED
DoShowLog() {
	global
	if (HasError || ShowLog) {
		OnMessage(0x53, "WM_HELP")
		Gui, +OwnDialogs  ; WM_HELP needs a GUI
		if (HasError) {
			MsgBox, 16400, %title%, %logtext%
		}
		else {
			MsgBox, 16448, %title%, %logtext%
		}
	}
}
*/

DoShowLog() {
	global logtext, HasError, ShowLog

	if (!HasError && !ShowLog) {
		return
	}

	global vLogText, vOK, vHelp
	Gui, WndLog: New, +Owner1 -SysMenu +Resize, 结果 - THKMC
	if RegExMatch(logtext, "`nm)^【警告】") {
		Gui, Color, Yellow, Aqua
	}

	if ( HasError ) {
		Gui, Color, Red, Yellow
	}
	Gui, Add, Edit, w500 r30 vvLogText, %logtext%
	Gui, Add, Button, gCloseLogWindow Default w150 vvOK, 确定
	Gui, Add, Button, gWM_HELP x+20 w150 vvHelp, 帮助(&H)
	Gui, Show, Center AutoSize
	GuiControl, Focus, vOK
	Gui, 1:Default
	Gui, 1:+Disabled
}

WndLogGuiSize(GuiHwnd, EventInfo, Width, Height) {
	if ( EventInfo != 1 ) {
		neww := Width - 20
		newh := Height - 40
		GuiControl, Move, vLogText, w%neww% h%newh%
		newh := Height - 30
		GuiControl, Move, vOK, y%newh%
		GuiControl, Move, vHelp, y%newh%
	}
}

CloseLogWindow() {
	Gui, 1:-Disabled
	Gui, WndLog: Destroy
}


WM_HELP(wParam, lParam) {
	RunHelpAndExit()
}

RunHelpAndExit() {
	global helpfilecmd, title

	; 只打开第一个找到的
	loop, Parse, helpfilecmd, `,
	{
		if ( RegExMatch(A_LoopField, "^https?://")) { ; URL
			CriticalRun(A_LoopField)
			return
		}
		else if ( FileExist(A_LoopField) ) {
			cmd := A_LoopField
			; 如果文件名以 txt 或 md 结尾，则用 notepad 打开
			if ( RegExMatch(cmd, "\.(md)$") ) {
				cmd := "notepad " . cmd
			}
			CriticalRun(cmd)
			return
		}
	}
	; 没找到
	Gui, +OwnDialogs  ; WM_HELP needs a GUI
	MsgBox, 16, %title%, 没有找到帮助文件……

	; ExitApp
} 

; 运行 cmd。
; 如果运行失败，用 MsgBox 显示出错信息
; 注：如果 workingdir 为 "CMDDIR"（必须为大写），则使用 cmd 的 dir 部分作 workingdir
CriticalRun(cmd, workingdir="") {
	global title

	if (workingdir == "CMDDIR")
		SplitPath, cmd, , workingdir

	Run, %cmd%, %workingdir%, UseErrorLevel
	le := A_LastError
	if ( le != 0 ) {
		errmsg := GetErrorMessage(le)
		OnMessage(0x53, "WM_HELP")
		Gui, +OwnDialogs
		MsgBox, 16400, %title%,
		(LTrim
			无法运行指定文件：
			【%cmd%】

			错误码：%le%
			错误信息：%errmsg%
		)
	}
} 

;根据错误码返回错误信息。
GetErrorMessage(ErrorCode) {
  VarSetCapacity(ErrorMsg, 256, 0)

  ;#define FORMAT_MESSAGE_FROM_SYSTEM     0x00001000
  DLLCall("FormatMessage","UInt",0x1000 ,"UInt",0,"UInt",ErrorCode,"UInt",0,"Str"
    ,ErrorMsg,"Uint", 256, "UInt", 0)

  StringReplace, ErrorMsg, ErrorMsg, `r`n, , All ;删除换行

  return ErrorMsg
} 




; 从 array 中随机选取一个元素
; arr: 必须是一个 array
array_choose(arr) {
	count := arr.MaxIndex()
	Random, sel, 1, count
	return arr[sel]
}

; 使用 sep 将 array 中的字符串进行连接，返回一个新的字符串
; sep 默认为 "`r`n"
array_join(arr, sep:="`r`n") {
	str=
    for i, s in arr
        str .= s . sep
    return SubStr(str, 1, -StrLen(sep))
}


; 将以 ASCII-HEX 格式表示的二进制数据与另一组二进制数据进行比较
compareHexToBinary(hex, pBinary, offsetBinary) {
	codelen := MCode(code, hex)
	try result := DllCall("msvcrt\memcmp", "ptr", pBinary + offsetBinary , "ptr", &code, "uint", codelen, "Cdecl")
	return result
}

; 将以 ASCII-HEX 表示的二进制数据以覆盖方式写入另一组二进制数据中
writeHexToBinary(hex, pBinary, offsetBinary) {
	codelen := MCode(code, hex)
	try result := DllCall("RtlMoveMemory", "ptr", pBinary + offsetBinary , "ptr", &code, "uint", codelen)
	return result
}

; http://rosettacode.org/wiki/Repeat_a_string#AutoHotkey
StringRepeat(s,num) {
	o=
	Loop, %num%
		o .= s
	Return o
}


; https://autohotkey.com/boards/viewtopic.php?f=5&t=6436&p=38484
AttachTipToControl(hCtrl, text:="") {
	hGui := text!="" ? DlLCall("GetParent", "Ptr", hCtrl) : hCtrl
	static hTip
	if !hTip
	{
		hTip := DllCall("CreateWindowEx", "UInt", 0x8, "Str", "tooltips_class32"
		     ,  "Ptr", 0, "UInt", 0x80000142 ;// WS_POPUP:=0x80000000|TTS_NOPREFIX:=0x02  // added by wz520: TTS_BALLOON:=40 | TTS_USEVISUALSTYLE:=0x100
		     ,  "Int", 0x80000000, "Int",  0x80000000, "Int", 0x80000000, "Int", 0x80000000
		     ,  "Ptr", hGui, "Ptr", 0, "Ptr", 0, "Ptr", 0, "Ptr")
 
		; TTM_SETMAXTIPWIDTH = 0x0418
		DllCall("SendMessage", "Ptr", hTip, "Int", 0x0418, "Ptr", 0, "Ptr", 0)
 
		if (A_OsVersion == "WIN_XP")
			AttachTipToControl(hGui)
	}
 
	static sizeof_TOOLINFO := 24 + (6 * A_PtrSize)
	VarSetCapacity(TOOLINFO, sizeof_TOOLINFO, 0)
	, NumPut(sizeof_TOOLINFO, TOOLINFO, 0, "UInt")
	, NumPut(0x0011, TOOLINFO, 4, "UInt") ; TTF_IDISHWND:=0x0001|TTF_SUBCLASS:=0x0010  // added by wz520: TTF_PARSELINKS:=0x1000
	, NumPut(hGui, TOOLINFO, 8, "Ptr")
	, NumPut(hCtrl, TOOLINFO, 8 + A_PtrSize, "Ptr")
	, NumPut(&text, TOOLINFO, 24 + (3 * A_PtrSize), "Ptr")
 
	static TTM_ADDTOOL := A_IsUnicode ? 0x0432 : 0x0404
	return DllCall("SendMessage", "Ptr", hTip, "Int", TTM_ADDTOOL, "Ptr", 0, "Ptr", &TOOLINFO)
}

; 为数值添加千分位分隔符（使用逗号）
; https://msdn.microsoft.com/en-us/library/dd318110.aspx
; numdigits: Number of fractional digits.  Default to 2
DecimalMark(num, numdigits=2) {
	locale := 0x0400 ; LOCALE_USER_DEFAULT
	; struct NUMBERFMT
	VarSetCapacity(numberfmt, 4*4+A_PtrSize*2, 0)
	NumPut(numdigits, numberfmt, 0, "UInt") ; NumDigits
	NumPut(1, numberfmt, 4, "UInt") ; LeadingZero
	NumPut(3, numberfmt, 8, "UInt") ; Grouping
	strDot := "."
	strComma := ","
	NumPut(&strDot, numberfmt, 12, "UPtr") ; lpDecimalSep
	NumPut(&strComma, numberfmt, 12+A_PtrSize, "UPtr") ; lpThousandSep
	NumPut(1, numberfmt, 12+A_PtrSize*2, "UInt") ; NegativeOrder

    size := DllCall("GetNumberFormat", "UInt", locale, "UInt", 0, "Str", num, "Ptr", &numberfmt, "Ptr", 0, "Int", 0)
    VarSetCapacity(buf, size * (A_IsUnicode ? 2 : 1), 0)
    DllCall("GetNumberFormat", "UInt", locale, "UInt", 0, "Str", num, "Ptr", &numberfmt, "Str", buf, "Int", size)
    return SubStr(buf, 1, StrLen(buf) - 0)
}

