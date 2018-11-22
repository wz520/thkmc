﻿#NoEnv
#SingleInstance, force
#Persistent


#include KeyNamesDX.ahk
#include utils.ahk
#include gamedata.ahk
#include PatchProcessor.ahk
#include LVRow.ahk
#include wzclipboard.ahk
#include LVUtils.ahk

title           = THKMC
helpfilecmd     = help.html,https://wz520.github.io/thkmc/help.html
g_bakfilesuffix = .thkmcbackup ; 备份文件后缀
g_inifilepath   = thkmc.ini

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
; outvar: exedata and filesize 
readEXEData(filename, ByRef exedata, ByRef filesize) {
	fileobj := FileOpen(filename, "r")
	if ( !isObject(fileobj) ) {
		throw Exception("以读取方式打开文件失败", filename)
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
	FileSelectFile, filepath, 3, %A_ScriptDir%, 请选择一个东方 STG 的主程序文件, 应用程序文件 (*.exe)
	if ( filepath = "" ) {
		; throw Exception("由于你没有选择文件，于是我不知道该修改啥……", "*")
		Exit
	}

	return filepath
}

; 如果 filename 为空，则使用对话框询问
; 有任何错误，则扔异常
doWork(filename) {
	if ( filename="" ) {
		filename := askInputFilename()
	}
	readEXEData( filename, exedata, filesize )

	succeeded := False
	global THKMC_GameIDList, chkTestMode
	Gui, Submit, NoHide
	for k, id in THKMC_GameIDList {
		gamedata        := new THKMC_GameData%id%()
		patch_processor := new THKMC_PatchProcessor(&exedata, filesize, gamedata)
		if ( doProcess(patch_processor, filename, chkTestMode) ) {
			addFileToList(filename, True)
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
		throw Exception(array_choose(wocao), "")
	}
	refreshFileList()
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

tryDoWork(filename="") {
	global HasError
	try {
		doWork(filename)
	}
	catch e {
		addErrorObjectToLog(e)
	}
	DoShowLog()
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
		; ignore errors
	}

	; 图标
	iconID := IL_Add(g_ImageListID, filename, 1)

	; 其他文件属性
	FileGetTime, filetime, %filename%
	FormatTime, filetimestring, %filetime% R T0
	FileGetAttrib, fileattrib, %filename%
	filesize := DecimalMark(filesize, 0)
	result := atTop
		? LV_InsertIfNotExist(filename, 1, 1, "Icon" . iconID, filename, gamenameCN, filesize, filetimestring, fileattrib, backupfileexists)
		: LV_Add("Icon" . iconID, filename, gamenameCN, filesize, filetimestring, fileattrib, backupfileexists)
	return result
}

loadFileList() {
	; 当文件列表很长时可能需要一点时间。所以显示一个提示框
	Gui, Praying: New, +Owner1 -SysMenu, 正在载入文件列表
	Gui, Add, Text, w200 r1 Center, 少女祈祷中...
	Gui, Show, Center AutoSize
	Gui, 1:Default
	Gui, 1:+Disabled
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
		Gui, 1:-Disabled
		Gui, Praying: Destroy
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

; 以下是一些程序运行时的配置项，与键位映射无关。
; 建议在 THKMC 主界面中修改，而不是直接在这里更改设置。
[thkmc]

; DoBackup：备份方式。备份文件名=原文件名.thkmcbackup
;   1 = 只在备份文件不存在时备份(默认)
;   2 = 总是备份(覆盖已有的备份文件)
;   3 = 不备份
DoBackup=1

; TestMode：测试模式。开启后会模拟打补丁的过程：会显示修改结果，但不会创建/修改EXE文件和备份文件。
;   1 = 开启
;   0 = 关闭
TestMode=0

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

LOpenINI() {
	global g_inifilepath
	ensureINIExists()
	Run, %g_inifilepath%
}

LOpenAndApply() {
	assertLVHasSelection()
	for c, row in LVRow {
		LV_GetText(filename, row)

		global title
		MsgBox, 0x34, %title%, 你选择的文件是：`r`n%filename%`r`n`r`n真的要重新更改此程序的键位映射吗？
		IfMsgBox, Yes
		{
			tryDoWork(filename)
		}
		
		break ; 只处理第一个高亮
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
		if ( GetKeyState("Ctrl") ) {
			ShortcutkeyToFuncMap["G"] := Func("LOpenAndApply")
			ShortcutkeyToFuncMap["D"] := Func("LOpenFolder")
			ShortcutkeyToFuncMap["B"] := Func("LRestoreFromBackup")
			ShortcutkeyToFuncMap["V"] := Func("LRunVPatch")
			ShortcutkeyToFuncMap["C"] := Func("LRunCustom")
			ShortcutkeyToFuncMap["Z"] := Func("LRunNyasama")
			ShortcutkeyToFuncMap["A"] := Func("LSelectAll")
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
	tryDoWork(filename)
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

		; Run, *open explorer.exe /select,%filename%  ; NOTE: Run 貌似没用
		DllCall("shell32.dll\ShellExecute", "ptr", 0, "str", "open", "str", "Explorer.exe", "str", " /select," . filename, "ptr", 0, "int", 10, "int")
	}
}



;; Load/Save Config

loadConfig(key, default) {
	global g_inifilepath
	ensureINIExists()
	IniRead, chkstate, %g_inifilepath%, thkmc, %key%, %default%
	return chkstate
}
saveConfig() {
	global ddlBackup, chkTestMode, g_inifilepath
	Gui, Submit, NoHide

	IniWrite, %ddlBackup%, %g_inifilepath%, thkmc, DoBackup
	IniWrite, %chkTestMode%, %g_inifilepath%, thkmc, TestMode
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
		newh := Height - 90
		GuiControl, Move, vFileLV, w%neww% h%newh%
	}
}

; 拖拽处理
GuiDropFiles(GuiHwnd, FileArray, CtrlHwnd, X, Y) {
	For i, f in FileArray {
		tryDoWork(f)
	}
}

GuiContextMenu(GuiHwnd, CtrlHwnd, EventInfo, IsRightClick, X, Y) {
	if (A_GuiControl = "vFileLV") {
		Menu, mnuLV, Show
	}
}






; ------------------------
; -- ENTRY
; ------------------------
cfgddl := loadConfig("DoBackup", 1)
cfgtestmode := loadConfig("TestMode", 0)

; 创建 GUI
Gui, +Hwndg_hWnd
Gui, Add, Button, gLOpenINI, 编辑 thkmc.ini(&E)
Gui, Add, Button, gLOpenEXE x+10, 打开程序并应用补丁(&O)
Gui, Add, Button, gLOpenAndApply x+10 hwndhBtnApply, 应用补丁(&A)
Gui, Add, Button, gLRunEXE x+10 hwndhBtnRun +Default, 运行(&R)
Gui, Add, Button, grefreshFileList x+10 y5 hwndhBtnRefresh, 刷新(&E)
Gui, Add, Button, gRunHelpAndExit x+10 y5, 帮助(&H)

Gui, Add, Text, xm+0, 备份到 *%g_bakfilesuffix% ？
Gui, Add, DropDownList, AltSubmit vddlBackup x+10 yp-3 w210 Choose%cfgddl%, 只在备份文件不存在时备份(推荐)|总是备份(若备份已存在则覆盖)|不备份(不推荐)
Gui, Add, Checkbox, x+10 yp-3 h30 vchkTestMode Checked%cfgtestmode%, 测试模式(&T)

Gui, Add, Text, xm CBlue, ※最近打开的文件（双击可运行程序，右击有菜单）:
Gui, Add, ListView, vvFileLV xm w740 h400 gLFileLV AltSubmit LV0x4000, 文件|游戏版本|大小|最后修改时间|属性|存在备份  ; LVS_EX_LABELTIP:=0x4000
LV_ModifyCol(3, "Integer")  ; For sorting purposes, indicate that column 2 is an integer.
g_ImageListID := IL_Create(10)
LV_SetImageList(g_ImageListID)
Gui, +Resize +OwnDialogs

; GUI ToolTip
GuiControlGet, hCtrl, Hwnd, chkTestMode
AttachTipToControl(hCtrl, "模拟打补丁的过程：会显示修改结果，但不会创建/修改EXE文件和备份文件")
AttachTipToControl(hBtnApply, "将 .INI 中的映射配置重新应用到选中的程序上")
AttachTipToControl(hBtnRun, "运行选中的游戏程序")
AttachTipToControl(hBtnRefresh, "刷新“最近打开的文件”列表")

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
Menu, mnuLV, Add, 关于, LAbout

OnExit, LOnExit

loadFileList()

return

LOnExit:
	saveFileList()
	saveConfig()
	ExitApp

GuiClose:
GuiEscape:
	ExitApp

LAbout() {
	global title
	Gui, +OwnDialogs
	MsgBox, 64, %title%,
(LTrim
	THKMC - 东方STG专用键盘键位映射修改工具 1.00

	Written by wz520 <wingzero1040@gmail.com>
	百度贴吧ID：天使的枷锁
)
}

LAutoSizeColumn() {
	LVAutoSizeHeader("vFileLV")
}
