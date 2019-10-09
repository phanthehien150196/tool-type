#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile_type=a3x
#AutoIt3Wrapper_Icon=C:\Users\phant\Downloads\Fasticon-Hand-Draw-Iphone-Photos.ico
#AutoIt3Wrapper_Compression=0
#AutoIt3Wrapper_Run_AU3Check=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <GUIConstantsEx.au3>
#include <GuiImageList.au3>
#include <GuiListView.au3>
#include <WindowsConstants.au3>
#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <File.au3>
#include <Array.au3>
#include <StringConstants.au3>
#include <EditConstants.au3>
#include <GuiConstants.au3>
#include <ButtonConstants.au3>


    ;Opt("GUICoordMode", 0)
Global $tg=0
Global $arr,$chon
Global $dem=-1
#Region ### START Koda GUI section ### Form=
$Form1_1 = GUICreate("ToolType", 242, 246, 316, 235)
GUISetBkColor(0x000000)
WinSetTrans($Form1_1, "",0.9 * 255)
$nhap = GUICtrlCreateButton("Add Text", 8, 16, 59, 25)
GUICtrlSetBkColor(-1, 0xABABAB)
$idListview = GUICtrlCreateListView("", 10, 50, 218, 180)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 50)
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, 0x808080)
$pin = GUICtrlCreateButton("Pin", 72, 16, 43, 25)
GUICtrlSetBkColor(-1, 0xABABAB)
$btSave = GUICtrlCreateButton("Save", 120, 16, 43, 25)
GUICtrlSetBkColor(-1, 0xABABAB)
$btOpen = GUICtrlCreateButton("Open", 168, 16, 51, 25)
GUICtrlSetBkColor(-1, 0xABABAB)

    GUISetState(@SW_SHOW)

    ; Add columns
    _GUICtrlListView_AddColumn($idListview, "Text", 400)

    ; Add items
    ;_GUICtrlListView_AddItem($idListview, "Item 1")

    ; Select item 2
	    _GUICtrlListView_SetItemSelected($idListview, 2)


    ;_GUICtrlListView_ClickItem($idListView, 2, "left", False, 2)
#EndRegion ### END Koda GUI section ###
HotKeySet("{F4}", "_abc")
While 1
	$nMsg = GUIGetMsg()


	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $nhap
			$a=chonfile()

			If $a<>"" Then
			loadfile($a)
			$chon=$a
			_GUICtrlListView_SetItemSelected($idListview,0)
			EndIf
		Case $pin
			pintop()
		Case $btSave
			luu()
		Case $btOpen
			mo()
	EndSwitch
WEnd

Func luu()
	If _GUICtrlListView_GetItemCount($idListview)>0 Then
		$x=FileOpen("log.txt",2)
		FileWriteLine($x,$chon)
		FileWriteLine($x,_GUICtrlListView_GetSelectedIndices($idListview))
		FileClose($x)
		MsgBox(0,"","Saved")
	Else
		MsgBox(0,"","Can't Save")
	EndIf
EndFunc

Func mo()
	$x=FileOpen("log.txt",0)
	$d1=FileReadLine($x,1)
	$d2=0
	If $d1=="" OR @error Then
		MsgBox(0,"","No File")
	Else
		$chon=$d1
		 $d2=FileReadLine($x,-1)
		_GUICtrlListView_DeleteAllItems($idListview)
		loadfile($d1)
		_GUICtrlListView_SetItemSelected($idListview,Number($d2))
		_GUICtrlListView_ScrollItem($idListview, $d2+1)

		ConsoleWrite(FileReadLine($x,-1))
	EndIf
	FileClose($x)
EndFunc

Func _GUICtrlListView_ScrollItem($ListView1, $iItemIndex=-1, $fPartialOK = True, $iIncrement = 16)

Local $iSuccess2

If $iItemIndex = -1 Then $iItemIndex = _GUICtrlListView_GetItemCount($ListView1)-1


$iSuccess2 = _GUICtrlListView_EnsureVisible($ListView1, $iItemIndex, $fPartialOK)

Return $iSuccess2

EndFunc

Func _abc()
	$id=_GUICtrlListView_GetSelectedIndices($idListview)+1
	ClipPut(xuly($arr[$id]))
	Send("^v")
	;Send((xuly($arr[$id])))
	_GUICtrlListView_SetItemSelected($idListview, $id)

_GUICtrlListView_ScrollItem($idListview, $id)

    ;MsgBox($MB_SYSTEMMODAL, "Information", "Selected Indices: " & _GUICtrlListView_GetSelectedIndices($idListview))
EndFunc

Func loadfile($a)
	_FileReadToArray($a, $arr)
For $i = 1 to UBound($arr) -1
	_GUICtrlListView_AddItem($idListview,$arr[$i])
Next
EndFunc

Func chonfile()
    Local $a="";
	; Create a constant variable in Local scope of the message to display in FileOpenDialog.
    Local Const $sMessage = "Chọn file truyện"

    ; Display an open dialog to select a list of file(s).
    Local $sFileOpenDialog = FileOpenDialog($sMessage, @WindowsDir & "\", "Text files (*.txt)", 1)
    If @error Then
        ; Display the error message.
        ;MsgBox($MB_SYSTEMMODAL, "", "No file(s) were selected.")
		$a=""
        ; Change the working directory (@WorkingDir) back to the location of the script directory as FileOpenDialog sets it to the last accessed folder.
        FileChangeDir(@ScriptDir)
    Else
        ; Change the working directory (@WorkingDir) back to the location of the script directory as FileOpenDialog sets it to the last accessed folder.
        FileChangeDir(@ScriptDir)

        ; Replace instances of "|" with @CRLF in the string returned by FileOpenDialog.
        $sFileOpenDialog = StringReplace($sFileOpenDialog, "|", @CRLF)

        ; Display the list of selected files.
        ;MsgBox($MB_SYSTEMMODAL, "", "You chose the following files:" & @CRLF & $sFileOpenDialog)
		$a=$sFileOpenDialog
		 _GUICtrlListView_DeleteAllItems($idListview)
    EndIf
	Return $a
EndFunc

Func pintop()
	;Local $tg=0
    ; Retrieve the handle of the active window.
    Local $hWnd = WinGetHandle("[ACTIVE]")

    ; Set the active window as being ontop using the handle returned by WinGetHandle.
    If $tg=0 Then
		WinSetOnTop($hWnd, "", $WINDOWS_ONTOP)
		$tg=1
	Else
		WinSetOnTop($hWnd, "", $WINDOWS_NOONTOP)
		$tg=0
	EndIf
EndFunc

Func trim($a)
Return StringStripWS($a, $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES)
EndFunc

Func xuly($a)
	$a=trim($a)
	$tg=0
	While $tg==0
		$r=StringLeft($a, 1)
		if $r=='*' OR $r=='+' OR $r=='=' OR $r==')' OR $r=='&' OR $r=='^' OR $r=='/' OR $r==',' OR $r==';' OR $r=='#' OR $r=='%' Then
			$a=trim(StringTrimLeft($a,1))
		Else
			$tg=1
		EndIf
	WEnd
	Return $a
EndFunc