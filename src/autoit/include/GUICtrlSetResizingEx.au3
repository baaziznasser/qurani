#include-once

#Region Header

#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <WinAPI.au3>

#CS

	Name:				GUICtrlSetResizingEx UDF
	Description:		Allows to set resizing for external controls created with _GUICtrl*_Create.
	Version:			1.3
	Author:				Copyright © 2015 CreatoR's Lab (G.Sandler), www.creator-lab.ucoz.ru, www.autoit-script.ru. All rights reserved.
	AutoIt version:		3.3.6.1 - 3.3.12.0
	
	Notes:				This library registers $WM_SIZE window message.
	
	History:
						1.3
						* Removed $hGUI parameter (check the examples).
						* Now works better on multiple GUIs.
						
						1.2
						* Fixed issue with fast resizing (window maximized/restored).
						* Added additional example.
						
						1.1
						* Docs added/updated.
						* Return values added.
						
						1.0
						* First public version.
						
#CE

#EndRegion

#Region Global Variables

Global $hGCSREx_Wnd = 0

Global Enum $iGCSREx_hWnd, $iGCSREx_hCtrl, $iGCSREx_iLabel, _
	$iGCSREx_iTotal
Global $aGCSREx_Ctrls[1][$iGCSREx_iTotal] = [[0]]

#EndRegion

#Region Public Functions

; #FUNCTION# ====================================================================================================
; Name...........: _GUICtrlSetResizingEx
; Description....: Extended function to set resizing for external controls (created with _GUICtrl*_Create).
; Syntax.........: _GUICtrlSetResizingEx($hGUI, $hCtrl, $iResizing)
; Parameters.....: $hGUI - GUI where the control is created.
;                  $hCtrl - Control handle/identifier as returned by _GUICtrl*_Create()/GUICtrlCreate...() function, or -1 for the last created control (only for controlID).
;                  $iResizing - See the Docking Values table in help file for _GUICtrlSetResizing function for values that can be used (add together multiple values if required).
;                 
; Return values..: Success - 1.
;                  Failure - 0.
;                 
; Author.........: G.Sandler
; Remarks........: When a GUI window is resized the controls within react - how they react is determined by this function. To be able to resize a GUI window it needs to have been created with the $WS_SIZEBOX and $WS_SYSMENU styles. See GUICreate().
; Related........: 
; Example........: Yes.
; ===============================================================================================================
Func _GUICtrlSetResizingEx($hCtrl, $iResizing)
	Local $hWnd, $aCPos, $iLabel
	
	If Not IsHWnd($hCtrl) Then
		Return GUICtrlSetResizing($hCtrl, $iResizing)
	EndIf
	
	$hWnd = _WinAPI_GetParent($hCtrl)
	
	If Not IsHWnd($hWnd) Then
		Return SetError(1, 0, 0)
	EndIf
	
	If $aGCSREx_Ctrls[0][0] = 0 Then
		GUIRegisterMsg($WM_SIZE, '__GCSREx_WM_SIZE')
	EndIf
	
	$aCPos = ControlGetPos($hWnd, '', $hCtrl)
	$iLabel = GUICtrlCreateLabel('', $aCPos[0], $aCPos[1], $aCPos[2], $aCPos[3])
	
	If Not $iLabel Then
		Return 0
	EndIf
	
	$aGCSREx_Ctrls[0][0] += 1
	ReDim $aGCSREx_Ctrls[$aGCSREx_Ctrls[0][0] + 1][$iGCSREx_iTotal]
	
	$aGCSREx_Ctrls[$aGCSREx_Ctrls[0][0]][$iGCSREx_hWnd] = $hWnd
	$aGCSREx_Ctrls[$aGCSREx_Ctrls[0][0]][$iGCSREx_hCtrl] = $hCtrl
	$aGCSREx_Ctrls[$aGCSREx_Ctrls[0][0]][$iGCSREx_iLabel] = $iLabel
	
	GUICtrlSetBkColor($iLabel, $GUI_BKCOLOR_TRANSPARENT)
	GUICtrlSetState($iLabel, $GUI_DISABLE)
	
	Return GUICtrlSetResizing($iLabel, $iResizing)
EndFunc

#EndRegion

#Region Internal Functions

; #INTERNAL FUNCTION# ====================================================================================================
; Name...........: __GCSREx_WM_SIZE
; Description....: Internal function to handle WM_SIZE window message.
; Author.........: G.Sandler
; ===============================================================================================================
Func __GCSREx_WM_SIZE($hWnd, $nMsg, $wParam, $lParam)
	$hGCSREx_Wnd = $hWnd
	AdlibRegister('__GCSREx_Resize', 5)
    Return $GUI_RUNDEFMSG
EndFunc

; #INTERNAL FUNCTION# ====================================================================================================
; Name...........: __GCSREx_Resize
; Description....: Internal function to resize controls (triggered by __GCSREx_WM_SIZE).
; Author.........: G.Sandler
; ===============================================================================================================
Func __GCSREx_Resize()
	Local $aCPos
	
	AdlibUnRegister('__GCSREx_Resize')
	
	For $i = 1 To $aGCSREx_Ctrls[0][0]
		If $aGCSREx_Ctrls[$i][$iGCSREx_hWnd] = $hGCSREx_Wnd Then
			$aCPos = ControlGetPos($aGCSREx_Ctrls[$i][$iGCSREx_hWnd], '', $aGCSREx_Ctrls[$i][$iGCSREx_iLabel])
			
			If IsArray($aCPos) Then
				_WinAPI_MoveWindow($aGCSREx_Ctrls[$i][$iGCSREx_hCtrl], $aCPos[0], $aCPos[1], $aCPos[2], $aCPos[3])
			EndIf
		EndIf
	Next
EndFunc

#EndRegion
