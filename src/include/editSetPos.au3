#Include <ScrollBarConstants.au3>
; #FUNCTION# ====================================================================================================================
; Name...........: _GUICtrlEdit_SetPos
; Description....: Sets the caret to the specified line and column.
; Syntax.........: _GUICtrlEdit_SetPos ( $hWnd, $iLine [, $iColumn] )
; Parameters.....: $hWnd    - Handle or identifier (controlID) to the control.
;  $iLine   - The zero-based index of the line on which must set the caret. If this parameter is (-1),
; the caret will be set on the last line.
;  $iColumn - The zero-based index of the column on which must set the caret. If this parameter is (-1),
; the caret will be set at the end of the specified line. Default is 0.
; Return values..: Success  - 1.
;  Failure  - 0 and sets the @error flag to non-zero.
; Author.........: Yashied
; Modified.......:
; Remarks........: None
; Related........: _GUICtrlEdit_Scroll(), _GUICtrlEdit_SetSel()
; Link...........: None
; Example........: Yes
; ===============================================================================================================================
Func _GUICtrlEdit_SetPos($hWnd, $iLine, $iColumn = 0)
If Not IsHWnd($hWnd) Then
$hWnd = GUICtrlGetHandle($hWnd)
If $hWnd = 0 Then
Return SetError(1, 0, 0)
EndIf
EndIf

Local $Lenght, $Num = 0, $Count = _GUICtrlEdit_GetLineCount($hWnd)
If $iLine > $Count - 1 Then
$Num = _GUICtrlEdit_GetTextLen($hWnd)
Else
If $iLine < 0 Then
$iLine = $Count - 1
EndIf
For $i = 0 To $iLine - 1
$Num += _GUICtrlEdit_LineLength($hWnd, $i) + 2 ; + @CR + @LF
Next
$Lenght = _GUICtrlEdit_LineLength($hWnd, $iLine)
If ($iColumn < 0) Or ($iColumn > $Lenght) Then
$iColumn = $Lenght
EndIf
$Num += $iColumn
EndIf
_GUICtrlEdit_SetSel($hWnd, $Num, $Num)
_GUICtrlEdit_Scroll($hWnd, $SB_SCROLLCARET)
Return 1
EndFunc