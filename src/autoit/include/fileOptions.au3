
#include-once

#include "Array.au3"
Func _PathFunc($sFilePath, ByRef $sDrive, ByRef $sDir, ByRef $sFileName, ByRef $sExtension)
	Local $aArray = StringRegExp($sFilePath, "^\h*((?:\\\\\?\\)*(\\\\[^\?\/\\]+|[A-Za-z]:)?(.*[\/\\]\h*)?((?:[^\.\/\\]|(?(?=\.[^\/\\]*\.)\.))*)?([^\/\\]*))$", $STR_REGEXPARRAYMATCH)
	If @error Then ; This error should never happen.
		ReDim $aArray[5]
		$aArray[0] = $sFilePath
	EndIf
	$sDrive = $aArray[1]
	If StringLeft($aArray[2], 1) == "/" Then
		$sDir = StringRegExpReplace($aArray[2], "\h*[\/\\]+\h*", "\/")
	Else
		$sDir = StringRegExpReplace($aArray[2], "\h*[\/\\]+\h*", "\\")
	EndIf
	$aArray[2] = $sDir
	$sFileName = $aArray[3]
	$sExtension = $aArray[4]
	Return $aArray
EndFunc   ;==>_PathSplit

Func _GetFileExt($Path,$Dot=True)
$path = FileGetLongName($path)
If StringLen($Path) < 4 Then Return -1
$ret = StringSplit($Path,"\",2)
If IsArray($ret) Then
$ret = StringSplit($ret[UBound($ret)-1],".",2)
If IsArray($ret) Then
If $Dot Then
$Dot = "."
Else
$Dot = ""
EndIf
Return $Dot & $ret[UBound($ret)-1]
EndIf
EndIf
If @error Then Return -1
EndFunc

Func _GetFileName($Path, $ext = true)
$path = FileGetLongName($path)
local $Extrreturn = ""
If StringLen($Path) < 4 Then Return -1
local $ret = StringSplit($Path,"\",2)
If IsArray($ret) Then
local $ret2 = StringSplit($Path,".",2)
If IsArray($ret2) Then
if $ext then
$ret[UBound($ret)-1] = $ret[UBound($ret)-1]
else
$ret[UBound($ret)-1] = stringReplace($ret[UBound($ret)-1], "." & $ret2[UBound($ret2)-1], "")
endIf
return $ret[UBound($ret)-1]
else
return $ret[UBound($ret)-1]
endIf
EndIf
If @error Then Return -1
EndFunc

func _fileGetDirPath($sPath, $sDrive = "", $sDir = "", $sFileName = "", $sExtension = "")
$sPath = FileGetLongName($sPath)
Local $aPathSplit = _PathFunc($sPath, $sDrive, $sDir, $sFileName, $sExtension)
return String($aPathSplit[1]) & String($aPathSplit[2])
endFunc
func _fileGetDirName($sPath, $sDrive = "", $sDir = "", $sFileName = "", $sExtension = "")
$sPath = FileGetLongName($sPath)
if $sPath = "" then
return 0
else
Local $aPathSplit = stringSplit($sPath, "\")
if StringInStr(FileGetAttrib($sPath), "d") then
return String($aPathSplit[$aPathSplit[0]])
else
return String($aPathSplit[$aPathSplit[0]-1])
endIf
endIf
endFunc
