; ListView 辅助函数

; LV_InsertIfNotExist(textToFind, columnToFind, RowNumber, [Options, Field1, Field2, ...])
; return a value returned by LV_Insert().
LV_InsertIfNotExist(textToFind, columnToFind, params*)
{
	found  := False
	result := 0
	loop, % LV_GetCount()
	{
		result_get := LV_GetText(text, A_Index, columnToFind)
		if (result_get && text=textToFind) {
			found := True
		}
	}
	if ( !found ) {
		result := LV_Insert(params*)
	}
	return result
}

; AHK自带的自动调节宽度还不尽人意，部分表头不能完全显示，通过发送消息解决
; LVName: ListView 控件名
LVAutoSizeHeader(LVName) {
	LV_ModifyCol()
	LVM_SETCOLUMNWIDTH       = 0x101E
	LVSCW_AUTOSIZE_USEHEADER = 0xFFFFFFFE
	GuiControlGet, hwnd, hwnd, %LVName%
	Loop % LV_GetCount("Column")
	{
		SendMessage, LVM_SETCOLUMNWIDTH, A_Index, LVSCW_AUTOSIZE_USEHEADER, , ahk_id %hwnd%
	}
}
