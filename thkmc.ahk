;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Touhou Keyboard Mapping Changer
;;; Written by wz520
;;; Tested AutoHotkey Version: 1.1.30.01
;;; Download on Github: https://github.com/wz520/thkmc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


#NoEnv
#SingleInstance, force
#Persistent

#include gamedata.ahk
#include KeyNamesDX.ahk

#include <utils>
#include <PatchProcessor>
#include <LVRow>
#include <wzclipboard>
#include <LVUtils>
#include <PEHelper>
#include <WZSplashWindow>

title             = THKMC
helpfilecmd       = https://wz520.github.io/thkmc/help.html
g_bakfilesuffix   = .thkmcbackup ; 备份文件后缀
g_inifilepath     = thkmc.ini    ; 键位配置文件
g_configfilepath  = config.ini   ; 程序配置文件

SetWorkingDir, %A_ScriptDir%

ShowLog := True

; #NoTrayIcon  ;; 由于要用 TrayTip 显示一些提示，所以不能禁掉 TrayIcon
; 不过要把TrayTip菜单给删掉（仅编译版）
if ( A_IsCompiled ) {
	Menu, Tray, NoStandard
}



doBackup(inifilepath, exefilepath) {
	global ddlBackup
	global g_bakfilesuffix
	Gui, Submit, NoHide
	if ( ddlBackup = 1 || ddlBackup = 2 ) {
		backupfilepath=%exefilepath%%g_bakfilesuffix%
		if ( ddlBackup = 1 ) {
            ; 1 = 如果备份文件已存在，则不进行备份
			IfExist, %backupfilepath%
			{
				AddLog("【备份】备份文件已存在，跳过")
				backupfilepath=
			}
		}

		if ( backupfilepath != "" ) {
			FileCopy, %exefilepath%, %backupfilepath%, 1
			AddLog("【备份】成功！")
		}
	}
}

doProcess(patch_processor, filename, bTestMode) {
	if ( patch_processor.isEXEThisGame() ) {
		if ( bTestMode ) {
			AddLog("【提示】“测试模式”已开启。EXE文件不会被修改，备份文件也不会被创建。")
		}
		AddLog("【目标文件】" . filename)
		AddLog("【所属游戏】" . patch_processor._d.gamenameCN)

		patch_processor.doPatch()
		patch_processor.updateEXECache()

		if ( bTestMode ) {
			return True  ; 如果勾选“测试模式”，则在此直接返回
		}
		else {
			doBackup(patch_processor._d.inifilepath, filename)
			fileobj := FileOpen(filename, "w")
			if ( isObject(fileobj) ) {
				; 打开成功
				filesize := patch_processor._exesize
				if ( fileobj.RawWrite(patch_processor._pEXEData, filesize) = filesize ) {
					fileobj.Close()
					return True
				}
				else
					throw Exception("写入文件失败", filename)
			}
			else
				throw Exception("以写入方式打开文件失败", filename)
		}

	}

	return False
}



; throw exception on error
; outvar: exedata and filesize.
;   if file not found, filesize will be set to -1, and exedata will be
;     set to an empty string
readEXEData(filename, ByRef exedata, ByRef filesize) {
	filesize := -1
	exedata =
	; NOTE:
	; When inside a try-block, FileOpen() will throw an exception on error.
	; To throw our customized error when the file cannot be opened, we need
	;   to add one more try-block here to prevent the exeuction flow from
	;   jumping to the outer catch-block.
	fileobj =
	try {
		fileobj := FileOpen(filename, "r")
	}
	catch {
		; nothing
	}
	if ( !isObject(fileobj) ) {
		; NOTE:
		; If we don't put a try-block above, and this function is being
		;   executed inside a try-block, this line would be NEVER executed.
		throw Exception("以读取方式打开文件失败或者文件不存在", filename)
	}

	filesize := fileobj.Length

	;; 目前支持的游戏中还没有这么大的EXE
	if ( filesize > 1048576 ) {
		throw Exception("这文件太大我不敢看…… > _ <", filename)
	}

	;; FileOpen() 碰到带 BOM 的 UTF-8 或 UTF-16 的文本文件会自动跳过 BOM，
	;; 这会导致下面抛出“读取文件失败”异常
	;; 所以要先手动定位到文件起始处
	fileobj.Seek(0)

	; 分配内存用于存储 EXE 的二进制数据
	VarSetCapacity(exedata, filesize, 0)

	; 读取
	if ( fileobj.RawRead( exedata, filesize ) != filesize ) {
		throw Exception("读取文件失败", filename)
	}

	fileobj.Close()
}


askInputFilename() {
	Gui, +OwnDialogs
	FileSelectFile, files, M3, %A_ScriptDir%, 请选择一个东方 STG 的主程序文件, 应用程序文件 (*.exe)
	if ( errorlevel != 0 || files = "" ) {
		; throw Exception("由于你没有选择文件，于是我不知道该修改啥……", "*")
		Exit
	}

	dir=
	filepaths := []
	Loop, parse, files, `n
	{
		if (A_Index = 1)
			dir := A_LoopField
		else
			filepaths.Push(dir . "\" . A_LoopField)
	}

	return filepaths
}

; filename 不得为空，否则扔异常
; 本函数无返回值。若有任何错误，则扔异常
; NOTE: It's not recommended to call this function directly.  Use tryDoWork() instead.
_doWork(filename) {
	if ( filename="" ) {
		throw Exception("内部错误ERR233：没有文件名")
	}
	readEXEData( filename, exedata, filesize )

	succeeded := False
	global THKMC_GameIDList, chkTestMode
	Gui, 1:Default
	Gui, Submit, NoHide
	for k, id in THKMC_GameIDList {
		gamedata        := new THKMC_GameData%id%()
		patch_processor := new THKMC_PatchProcessor(&exedata, filesize, gamedata)
		if ( doProcess(patch_processor, filename, chkTestMode) ) {
			AddLog("`r`n修改成功！`r`n")
			succeeded := True
			break
		}
	}

	if ( !succeeded ) {
		wocao := []
		wocao.Push("此乃何物？吾不识也。")
		wocao.Push("无法识别的文件。")
		wocao.Push("啊哈哈，琪露诺看不懂。")
		wocao.Push("对不起，我的智商刚刚下线，这是啥我看不懂……")
		throw Exception(array_choose(wocao), filename)
	}
}

; e is an Exception object
addErrorObjectToLog(e, bShow:=False) {
	msg := "【错误】"  e.message
	if ( e.what ) {
		msg .= "`r`n【相关文件】"  e.what
	}
	AddLog(msg, True)

	if ( bShow ) {
		DoShowLog()
		ClearLog()
	}
}

; filenames 可以接受多个文件（使用数组）
tryDoWork(filenames="") {
	global HasError
	global chkAlwaysAddToList

	filepaths := !IsObject(filenames)
			? [filenames]
			: filenames.Count() = 0
				? [""]
				: filenames

	if ( filepaths[1] = "" ) {
		filepaths := askInputFilename()
	}

	Gui, 1:Default
	Gui, Submit, NoHide
	for k, f in filepaths {
		succeeded := False
		if ( k > 1 ) {
			AddLog("`r`n`r`n####################### 分割线 #######################`r`n`r`n")
		}

		try {
			_doWork(f)
			succeeded := True
		}
		catch e {
			addErrorObjectToLog(e)
		}

		if ( chkAlwaysAddToList || succeeded ) {
			addFileToList(f, True)
		}
	}
	DoShowLog()
	refreshFileList()

	; DEBUG
	if ( 0 ) {
		ExitApp, HasError ? 1 : 0
	}
	else {
		; 清除log
		return ClearLog()
	}
}




;; ------------
;; GUI 相关
;; ------------

assertLVHasSelection() {
	Gui, +OwnDialogs
	for c, r in LVRow {
	}
	if ( c <= 0 ) {
		global title
		MsgBox, 0x40, %title%, 没有高亮的项目 poi
		Exit
	}
}


; atTop: 添加到最上面
; return a value returned by LV_Add() or LV_InsertIfNotExist()
addFileToList(filename, atTop:=False) {
	global g_ImageListID, g_bakfilesuffix
	backupfilepath=%filename%%g_bakfilesuffix%
	backupfileexists := FileExist(backupfilepath) ? "√" : "×"

	; 获取文件属于哪个游戏
	gamenameCN := "未知"

	e =   ; clear error object
	try {
		readEXEData(filename, exedata, filesize)
		global THKMC_GameIDList
		for k, id in THKMC_GameIDList {
			gamedata        := new THKMC_GameData%id%()
			patch_processor := new THKMC_PatchProcessor(&exedata, filesize, gamedata)
			if ( patch_processor.isEXEThisGame() ) {
				gamenameCN := gamedata.gamenameCN
				break
			}
		}
	}
	catch e {
		gamenameCN := Format("【{:s}】", e.Message)
	}

	; 图标
	if ( isObject(e) ) {  ; there was an error
		iconID := 9999
	}
	else {
		iconID := IL_Add(g_ImageListID, filename, 1)
	}

	; 其他文件属性
	try {
		FileGetTime, filetime, %filename%
		FormatTime, filetimestring, %filetime% R T0
	}
	catch e {
		filetimestring = 无可奉告
	}
	try {
		FileGetAttrib, fileattrib, %filename%
	}
	catch e {
		fileattrib = 布吉岛
	}
	filesize := DecimalMark(filesize, 0)

	result := atTop
		? LV_InsertIfNotExist(filename, 1, 1, "Icon" . iconID, filename, gamenameCN, filesize, filetimestring, fileattrib, backupfileexists)
		: LV_Add("Icon" . iconID, filename, gamenameCN, filesize, filetimestring, fileattrib, backupfileexists)
	return result
}

loadFileList() {
	; 当文件列表很长时可能需要一点时间。所以显示一个提示框
	
	splash := new WZSplashWindow("Praying" , "正在载入文件列表", "少女祈祷中...")

	splash.Show()
	try {
		loop, Read, recentfiles.txt
		{
			l := A_LoopReadLine
			; 忽略空行和包含 *、? 的行
			if ( l = "" || RegExMatch(l, "[*?]") ) {
				continue
			}

			addFileToList(l)
		}
	}
	finally {
		LAutoSizeColumn()
		splash.Destroy()
	}
}

saveFileList() {
	fp := FileOpen("recentfiles.txt", "w`n", "UTF-16")
	if ( IsObject(fp) ) {
		loop, % LV_GetCount()
		{
			result := LV_GetText(l, A_Index)
			if (result)
				fp.WriteLine(l)
		}
		fp.Close()
	}
}

refreshFileList() {
	saveFileList()
	LV_Delete()
	loadFileList()
}



createINIFile(inifilepath) {
	filecontent=
	(LTrim
; 关于本设置文件的完整说明，请参看 thkmc_sample.ini

[Default]
UP=W
DOWN=S
LEFT=A
RIGHT=D

Z=j
X=k
C=l
LSHIFT=i
)

	fileobj := FileOpen(inifilepath, "w`n", "UTF-16")
	if ( isObject(fileobj) ) {
		if (fileobj.Write(filecontent)) {
			fileobj.Close()
		}
		else
			throw Exception("写入文件失败", inifilepath)
	}
	else
		throw Exception("以写入方式打开文件失败", inifilepath)
}

ensureINIExists() {
	global title, g_inifilepath
	IfNotExist, %g_inifilepath%
	{
		createINIFile(g_inifilepath)
		Gui, +OwnDialogs
		msg=【%g_inifilepath%】文件不存在。`r`n`r`n已自动生成。
		MsgBox, 64, %title%, %msg%
	}
}


confirmApply(filepaths) {
	global vCA_OK
	IsOK := False

	txtFiles := array_join(filepaths, "`r`n")

	Gui, WndConfirm:New, +LabelCA_ +Owner1 -SysMenu -Resize +LastFound, 确认 - THKMC

	Gui, Color, Fuchsia

	Gui, Add, Edit, w500 r25, 你选择的文件是：`r`n%txtFiles%`r`n`r`n真的要将 INI 文件中的键位映射设置应用到这些程序上吗？
	Gui, Add, Button, gCA_OK Default w150 vvCA_OK, 是(&Y)
	Gui, Add, Button, gCA_Close x+20 w150 , 否(&H)
	GuiControl, Focus, vCA_OK
	Gui, Show, Center AutoSize
	Gui, 1:+Disabled

	WinWaitClose

	return IsOK

CA_OK:
	IsOK := True
	; no return
CA_Close:
CA_Cancel:
	Gui, 1:-Disabled
	Gui, WndConfirm:Destroy
	return
}


LOpenINI() {
	global g_inifilepath
	ensureINIExists()
	Run, %g_inifilepath%
}

LOpenAndApply() {
	assertLVHasSelection()

	filepaths := []
	for c, row in LVRow {
		LV_GetText(filename, row)
		filepaths.Push(filename)
	}

	if (confirmApply(filepaths)) {
		tryDoWork(filepaths)
	}
}


; ListView 按键处理
LFileLV() {
	if ( A_GuiEvent = "DoubleClick" ) {
		LRunEXE()
	}
	else if ( A_GuiEvent = "K" ) {
		key := GetKeyName(Format("vk{:x}", A_EventInfo))
		ShortcutkeyToFuncMap := {}
		if ( GetKeyState("Ctrl") && !GetKeyState("Alt") ) {
			ShortcutkeyToFuncMap["G"] := Func("LOpenAndApply")
			ShortcutkeyToFuncMap["D"] := Func("LOpenFolder")
			ShortcutkeyToFuncMap["B"] := Func("LRestoreFromBackup")
			ShortcutkeyToFuncMap["V"] := Func("LRunVPatch")
			ShortcutkeyToFuncMap["C"] := Func("LRunCustom")
			ShortcutkeyToFuncMap["Z"] := Func("LRunNyasama")
			ShortcutkeyToFuncMap["A"] := Func("LSelectAll")
			ShortcutkeyToFuncMap["S"] := Func("LOpenShanghaiAlice")
		}
		else if ( GetKeyState("Alt") && !GetKeyState("Ctrl") ) {
			ShortcutkeyToFuncMap["Enter"] := Func("LOpenFileProperties")
		}
		else {
			ShortcutkeyToFuncMap["NumpadDel"] := Func("LRemove")
			ShortcutkeyToFuncMap["F5"]        := Func("refreshFileList")
		}
		if ( ShortcutkeyToFuncMap.HasKey(key) ) {
			ShortcutkeyToFuncMap[key].Call()
		}
	}
}

LOpenEXE() {
	tryDoWork()
}

LRunEXE() {
	assertLVHasSelection()
	for c, row in LVRow {
		LV_GetText(filename, row)
		CriticalRun(filename, "CMDDIR")
	}
}

RunOtherFileInEXEDir(newfilename) {
	assertLVHasSelection()
	for c, row in LVRow {
		LV_GetText(filename, row)
		SplitPath, filename, , dir
		filename=%dir%\%newfilename%
		CriticalRun(filename, "CMDDIR")
	}
}

LRunVPatch() {
	RunOtherFileInEXEDir("vpatch.exe")
}
LRunCustom() {
	RunOtherFileInEXEDir("custom.exe")
}

LRunNyasama() {
	assertLVHasSelection()
	for c, row in LVRow {
		LV_GetText(filename, row)
		SplitPath, filename, , dir, ext, namenoext
		filename=%dir%\%namenoext%c.%ext%
		CriticalRun(filename, "CMDDIR")
	}
}

LSelectAll() {
	LV_Modify(0, "Select")
}

; 返回错误信息，若有错误则扔异常
doRestoreFromBackup( filename, bKeep )
{
	global g_bakfilesuffix
	bakfilename = %filename%%g_bakfilesuffix%
	if ( !FileExist(bakfilename) ) {
		throw Exception("备份文件不存在", filename)
	}
	if ( bKeep ) {
		FileCopy, %bakfilename%, %filename%, 1
	}
	else {
		FileMove, %bakfilename%, %filename%, 1
	}
}

LRestoreFromBackup() {
	assertLVHasSelection()

	global title, g_bakfilesuffix
	MsgBox, 0x33, %title%,
	(LTrim
		恢复后是否要保留备份文件（*%g_bakfilesuffix%）？

		【是】  ：恢复并保留备份文件
		【否】  ：恢复并删除备份文件
		【取消】：不做任何事情
	)

	bKeep := True
	IfMsgBox, Cancel
	{
		return
	}
	else IfMsgBox, No
	{
		bKeep := False
	}

	success_count := 0
	for c, row in LVRow {
		LV_GetText(filename, row)
		try {
			doRestoreFromBackup(filename, bKeep)
			success_count++
		}
		catch e {
			e.what := filename
			addErrorObjectToLog(e, True)
		}
	}

	refreshFileList()
	TrayTip, %title%, 成功恢复了 %success_count% 个文件。
}

LDeleteBackup() {
	assertLVHasSelection()

	global title, g_bakfilesuffix
	MsgBox, 0x134, %title%, 真的要【从磁盘上】删除所有选中项目的备份文件(*%g_bakfilesuffix%)吗？

	IfMsgBox, No
	{
		return
	}

	success_count := 0
	for c, row in LVRow {
		LV_GetText(filename, row)
		try {
			bakfile =%filename%%g_bakfilesuffix%
			IfExist, %bakfile%
			{
				FileDelete, %bakfile%
				success_count++
			}
		}
		catch e {
			; ignore errors
		}
	}

	refreshFileList()
	TrayTip, %title%, 成功删除了 %success_count% 个备份文件。
}

; return a list
LVGetAllSelection() {
	files := []
	for c, row in LVRow {
		LV_GetText(filename, row)
		files.Push(filename)
	}
	return files
}


LCopyFullPath() {
	assertLVHasSelection()
	files := LVGetAllSelection()
	c := files.MaxIndex()
	if ( c ) {
		global title
		Clipboard := array_join(files)
		TrayTip, %title%, 复制%c%个文件的路径到剪贴板成功！
	}
}

LCopyOrCutFile(itemname) {
	assertLVHasSelection()
	bCopy := InStr(itemname, "复制") ? True : False
	files := LVGetAllSelection()
	c := files.MaxIndex()
	if ( c ) {
		global title
		verb := bCopy ? "复制" : "剪切"
		CopyFilesToClipboard(files, bCopy)
		TrayTip, %title%, %verb%%c%个文件到剪贴板成功！
	}
}

LOpenFolder() {
	assertLVHasSelection()
	for c, row in LVRow {
		LV_GetText(filename, row)

		; NOTE: Run 貌似没用，换成 DllCall()
		; Run, *open explorer.exe /select,%filename%  
		; DllCall("shell32.dll\ShellExecute", "ptr", 0, "str", "open", "str", "Explorer.exe", "str", " /select," . filename, "ptr", 0, "int", 10, "int")

		; NOTE: 不不不，其实 Run 还是有用的，只是我参数没写对。>_<
		Run, *open explorer.exe /select`,%filename%, , UseErrorLevel
	}
}

LOpenShanghaiAlice() {
	cmd = *open %A_AppData%\ShanghaiAlice
	CriticalRun(cmd)
}

LOpenFileProperties() {
	assertLVHasSelection()
	for c, row in LVRow {
		LV_GetText(filename, row)

		Run, properties %filename%, , UseErrorLevel
		if ( ErrorLevel = "ERROR" ) {
			global title
			TrayTip, %title% - 打开文件属性失败, 文件：%filename%, ,3
		}
	}
}


;; Load/Save Config

loadConfig(key, default) {
	global g_configfilepath, g_inifilepath
	IniRead, chkstate, %g_configfilepath%, thkmc, %key%

	if ( chkstate = "ERROR" ) {
		IniRead, chkstate, %g_inifilepath%, thkmc, %key%, %default%
	}

	return chkstate
}
saveConfig() {
	global ddlBackup, chkTestMode, chkAlwaysAddToList, g_configfilepath
	Gui, Submit, NoHide

	IniWrite, %ddlBackup%, %g_configfilepath%, thkmc, DoBackup
	IniWrite, %chkTestMode%, %g_configfilepath%, thkmc, TestMode
	IniWrite, %chkAlwaysAddToList%, %g_configfilepath%, thkmc, AlwaysAddToList
}



; return the count of the deleted items
LRemove() {
	assertLVHasSelection()
	global title
	delcount := 0
	MsgBox, 0x34, %title%, 真的要清除列表中所有已选中的项目吗？
	IfMsgBox, Yes
	{
		rownum := 0
		Loop {
			rownum := LV_GetNext(rownum)
			if ( rownum ) {
				LV_Delete(rownum--)
				delcount++
			} else
				break
		}
	}
	return delcount
}

LRemoveAll() {
	global title
	Gui, +OwnDialogs
	MsgBox, 0x34, %title%, 真的要清除列表中的所有项目吗？
	IfMsgBox, Yes
	{
		LV_Delete()
	}
}

GuiSize(GuiHwnd, EventInfo, Width, Height) {
	if ( EventInfo != 1 ) {
		neww := Width - 20
		newh := Height - 120
		GuiControl, Move, vFileLV, w%neww% h%newh%
	}
}

; 拖拽处理
GuiDropFiles(GuiHwnd, FileArray, CtrlHwnd, X, Y) {
	_files := []

	splash=
	for k, f in FileArray {
		attr := FileExist(f)
		if ( InStr(attr, "D") ) {
			if ( !IsObject(splash) ) {
				splash := new WZSplashWindow("SearchingEXE" , "正在搜索 .exe 文件", "少女祈祷中...")
				splash.Show()
			}

			loop, Files, %f%\*.exe, R
			{
				_files.Push(A_LoopFileFullPath)
			}
		}
		else {
			_files.Push(f)
		}
	}
	if ( IsObject(splash) ) {
		splash.Destroy()
	}

	if (confirmApply(_files)) {
		tryDoWork(_files)
	}
}

GuiContextMenu(GuiHwnd, CtrlHwnd, EventInfo, IsRightClick, X, Y) {
	if (A_GuiControl = "vFileLV") {
		Menu, mnuLV, Show, %A_GuiX%, %A_GuiY%
	}
}



; ------------------------
; -- ENTRY
; ------------------------

; 创建 GUI
Gui, +Hwndg_hWnd
Gui, Add, Button, gLOpenINI, 编辑 thkmc.ini(&E)
Gui, Add, Button, gLOpenEXE x+10, 打开程序并应用补丁(&O)
Gui, Add, Button, gLOpenAndApply x+10 hwndhBtnApply, 应用补丁(&A)
Gui, Add, Button, gLRunEXE x+10 hwndhBtnRun +Default, 运行(&R)
Gui, Add, Button, grefreshFileList x+10 y5 hwndhBtnRefresh, 刷新(&E)
Gui, Add, Button, gRunHelpAndExit hwndhBtnHelp x+10 y5, 帮助(&H)
Gui, Add, Custom, ClassSysLink hwndhSysLinkAbout gLSysLinkEvent x+5 w50 r1 y10, <a>关于...</a>

Gui, Add, Text, xm+0, 备份到 *%g_bakfilesuffix% ？
cfgvalue := loadConfig("DoBackup", 1)
Gui, Add, DropDownList, AltSubmit vddlBackup x+10 yp-3 w210 Choose%cfgvalue%, 只在备份文件不存在时备份(推荐)|总是备份(若备份已存在则覆盖)|不备份(不推荐)
cfgvalue := loadConfig("TestMode", 0)
Gui, Add, Checkbox, x+10 yp-3 h30 vchkTestMode Checked%cfgvalue%, 测试模式(&T)
cfgvalue := loadConfig("AlwaysAddToList", 0)
Gui, Add, Checkbox, x+10 h30 vchkAlwaysAddToList Checked%cfgvalue%, 总是添加至列表(&P)

Gui, Add, Text, x10, 查看更新：
Gui, Add, Custom, ClassSysLink hwndhSysLink gLSysLinkEvent x+5 w40 r1, <a>喵玉殿</a>
Gui, Add, Custom, ClassSysLink hwndhSysLinkGitHub gLSysLinkEvent x+5 w40 r1, <a>GitHub</a>
g_updatelink = http://bbs.nyasama.com/forum.php?mod=viewthread&tid=78904
g_githublink = https://github.com/wz520/thkmc

Gui, Add, Text, xm CBlue, ※最近打开的文件（双击可运行程序，右击有菜单）:
Gui, Add, ListView, vvFileLV xm w740 h400 gLFileLV AltSubmit LV0x4000, 文件|游戏版本|大小|最后修改时间|属性|存在备份  ; LVS_EX_LABELTIP:=0x4000
LV_ModifyCol(3, "Integer")  ; For sorting purposes, indicate that column 2 is an integer.
g_ImageListID := IL_Create(10)
LV_SetImageList(g_ImageListID)
Gui, +Resize +OwnDialogs

; GUI ToolTip
GuiControlGet, hCtrl, Hwnd, chkTestMode
AttachTipToControl(hCtrl, "模拟打补丁的过程：会显示修改结果，但不会创建/修改EXE文件和备份文件。`r`n【提示】若打补丁成功，仍会将文件路径添加至文件列表。")
GuiControlGet, hCtrl, Hwnd, chkAlwaysAddToList
AttachTipToControl(hCtrl, "即使打补丁失败也会将文件路径添加至文件列表。`r`n若不勾选此项， THKMC 只会在打补丁成功后才将文件路径添加至文件列表。")
AttachTipToControl(hBtnApply, "将 .INI 中的映射配置重新应用到选中的程序上")
AttachTipToControl(hBtnRun, "运行选中的游戏程序")
AttachTipToControl(hBtnRefresh, "刷新“最近打开的文件”列表")
AttachTipToControl(hBtnHelp, helpfilecmd)
AttachTipToControl(hSysLink, g_updatelink)
AttachTipToControl(hSysLinkGitHub, g_githublink)

Gui, Show, Center, %title%
GuiControl, Focus, vFileLV

; 快捷菜单
Menu, mnuLV, Add, 应用改键补丁`tCtrl+G, LOpenAndApply
Menu, mnuLV, Add
Menu, mnuLV, Add, 运行该程序`tEnter, LRunEXE
Menu, mnuLV, Default, 运行该程序`tEnter
Menu, mnuLV, Add, 运行所在目录下的 vpatch.exe`tCtrl+V, LRunVPatch
Menu, mnuLV, Add, 运行所在目录下的 custom.exe`tCtrl+C, LRunCustom
Menu, mnuLV, Add, 运行所在目录下的汉化版游戏程序(th???c.exe)`tCtrl+Z, LRunNyasama
Menu, mnuLV, Add, 打开所在目录`tCtrl+D, LOpenFolder
Menu, mnuLV, Add, 打开 ShanghaiAlice 目录`tCtrl+S, LOpenShanghaiAlice
Menu, mnuLV, Add
Menu, mnuLV, Add, 属性...`tAlt+Enter, LOpenFileProperties
Menu, mnuLV, Add
Menu, mnuLV, Add, 从备份文件恢复`tCtrl+B, LRestoreFromBackup
Menu, mnuLV, Add, 删除备份文件, LDeleteBackup
Menu, mnuLV, Add
Menu, mnuLV, Add, 复制完整路径, LCopyFullPath
Menu, mnuLV, Add, 剪切, LCopyOrCutFile
Menu, mnuLV, Add, 复制, LCopyOrCutFile
Menu, mnuLV, Add, 全选`tCtrl+A, LSelectAll
Menu, mnuLV, Add
Menu, mnuLV, Add, 移除高亮的项目`tDelete, LRemove
Menu, mnuLV, Add, 移除所有项目, LRemoveAll
Menu, mnuLV, Add
Menu, mnuLV, Add, 自动调整表格宽度, LAutoSizeColumn
Menu, mnuLV, Add, 刷新`tF5, refreshFileList
Menu, mnuLV, Add
Menu, mnuLV, Add, 关于..., LAbout

OnExit("LOnExit")

loadFileList()

return

LOnExit(ExitReason, ExitCode) {
	saveFileList()
	saveConfig()
}

GuiClose:
GuiEscape:
	ExitApp

lSysLinkEvent:
	if ( A_GuiEvent = "N" ) {
		code := NumGet(A_EventInfo, A_PtrSize+4, "Int") ; NMHDR->hwndFrom
		if ( code = -2 || code = -4 ) { ; NM_CLICK = -2, NM_RETURN = -4
			hwndFrom := NumGet(A_EventInfo, 0, "UPtr") ; NMHDR->hwndFrom
			if ( hwndFrom = hSysLink ) {
				Run, %g_updatelink%
			}
			else if (hwndFrom = hSysLinkGitHub) {
				Run, %g_githublink%
			}
			else if (hwndFrom = hSysLinkAbout) {
				LAbout()
			}
		}
	}
	return

GetAHKVersionString() {
	strIsUnicode := A_IsUnicode ? "Unicode" : "ANSI"
	strIs64bit := A_PtrSize = 8 ? "64位" : "32位"
	result=%A_AhkVersion% %strIsUnicode% %strIs64bit%
	return result
}

LAbout() {
	global title
	Gui, +OwnDialogs

	gamelist := THKMC_GetGameNameList()
	ahkver := GetAHKVersionString()

	MsgBox, 64, %title%,
(LTrim
	THKMC - 东方STG专用键盘键位映射修改工具 1.40

	AutoHotkey 版本：%ahkver%

	Written by wz520 <wingzero1040@gmail.com>
	百度贴吧ID：天使的枷锁

	支持的游戏：
	%gamelist%
)
}

LAutoSizeColumn() {
	LVAutoSizeHeader("vFileLV")
}

