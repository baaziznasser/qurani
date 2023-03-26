func _downloader($i_recId)
local $a_dbres, $iRows, $iColumns

local $h_db_download = _SQLite_Open(@ScriptDir & "\database\reciters.db")
	$iRval = _SQLite_GetTable2d($h_db_download, "SELECT * FROM reciters Where id = " & $i_recId & ";", $a_dbres, $iRows, $iColumns)
if IsArray($a_dbres) then
local $s_reciterURL = $a_dbres[1][4]
local $s_recitername = $a_dbres[1][1]
else
msgBox(16, "خطأ " & $i_recId, _SQLite_ErrMsg() & @crlf & "لا يمكن تحميل القارء المحدد, يرجى إعادة المحاولة")
exit(1)
endIf

	If not (_WinAPI_IsInternetConnected()) then 
msgBox(16, "خطأ", "لا يوجد إتصال بالأنترنت, يرجى إعادة المحاولة حينما يتوفر إتصال.")
exit(2)
endIf
local $s_suras_read = fileread(@scriptDir & "\database\Surahs.Json")
local $o_suras_dt = Json_decode($s_suras_read)
if not (isObj($o_suras_dt)) then
msgBox(16, "خطأ", "لم نتمكن من قراءة قاعدة البيانات الخاصة بالسور, يرجى التحقق من أن جميع الملفات الخاصة بالبرنامج متوفرة.")
exit(3)
endIf
global $a_suras_dt = Json_get($o_suras_dt, ".surahs")
if not (isArray($a_suras_dt)) then
msgBox(16, "خطأ", "لم نتمكن من قراءة قاعدة البيانات الخاصة بالسور, يرجى التحقق من أن جميع الملفات الخاصة بالبرنامج متوفرة.")
exit(4)
endIf
local $oldCloseMode = Opt("GUICloseOnESC")
local $oldEventMode = Opt("GUIOnEventMode")
Opt("GUICloseOnESC", 1)
Opt("GUIOnEventMode", 0)

global $downloader = GUICreate("تحميل المصحف الصوتي", 400, 380, -1, -1, BitOR($WS_MAXIMIZEBOX, $WS_MINIMIZEBOX, $WS_SIZEBOX, $WS_SYSMENU), $WS_EX_LAYOUTRTL)
global $path = @ScriptDir & "\reciters\" & $i_recId & "\"
$labelTxt = GUICtrlCreateLabel("جاري تحميل المصحف بصوت " & $s_recitername, 50, 10, 300, 30)
global $DownloaderInfo = GUICtrlCreateLabel("", 50, 80, 300, 50)
GUICtrlCreateLabel("نسبة تحميل السورة", 150, 150, 100, 20)
global $Progress = GUICtrlCreateProgress(150, 170, 100, 30, $ws_TabStop)
GUICtrlCreateLabel("نسبة تحميل المصحف", 150, 210, 100, 20)
global $Progress2 = GUICtrlCreateProgress(100, 230, 200, 30, $ws_TabStop)
GUIStartGroup("")
global $i_pause = GUICtrlCreateButton("إيقاف مؤقت", 10, 290, 150, 30)
global $button = GUICtrlCreateButton("إيقاف التحميل", 240, 290, 150, 30)
GUICtrlSetState(-1, $GUI_focus)
global $iIndex = 0, $b_paused = False
global $Target
global $url
GUIStartGroup("")
$Target = $path
$url = $s_reciterURL

global $status = false


local $h_TimeOutInf = TimerInit()
global $onprogress = false, $curent = false, $sec = 0, $crntSize = 0, $Elapsedtime = "00:00:00", $remainingtime = "00:00:00"
global $i_current_surah = 1, $i_current_ayah = 1, $i_current_downloaded = 0
if not (FileExists($Target & StringFormat("%03i\", $i_current_surah))) then DirCreate($Target & StringFormat("%03i\", $i_current_surah))
global $hDownloadNo = _RSMWare_GetData($url & StringFormat("%03i%03i.mp3", $i_current_surah, $i_current_ayah), $Target & StringFormat("%03i\%03i.mp3", $i_current_surah, $i_current_ayah))
GUISetState(@sw_Show, $downloader)
$i_error = 0
While 1
Switch GUIGetMsg()
Case $GUI_EVENT_CLOSE, $button
$asc = MsgBox(4132, "إيقاف التحميل", "هل حقا تريد إلغاء تحميل المصحف؟" & @crlf & "يمكنكم في أي وقت إستأناف التحميل.", "", $downloader)
if $asc = 6 then

$h_TimeOutInf = ""
GUIDelete($downloader)

Opt("GUICloseOnESC", $oldCloseMode)
Opt("GUIOnEventMode", $oldEventMode)


If $hDownloadNo <> 0 Then InetClose($hDownloadNo)
$hDownloadNo = false
$i_error = 250
exitLoop
endIf
case $i_pause
if $b_Paused then
$b_Paused = False
GUICtrlSetData($i_pause, "إيقاف مؤقت")
else
$b_Paused = True
GUICtrlSetData($i_pause, "إستأناف التحميل")
InetClose($hDownloadNo)
$status = -1
endIf
EndSwitch
if $b_Paused then ContinueLoop
if TimerDiff($h_TimeOutInf) >= 1000 then
SetUpdateProgress()
$h_TimeOutInf = TimerInit()
endIf
if $status = -1 then
$status = 0
Switch ReadSettings(".settings.downloadCheckFile", 2)
Case 2
if (FileExists($Target & StringFormat("%03i\%03i.mp3", $i_current_surah, $i_current_ayah))) then
if (FileGetSize($Target & StringFormat("%03i\%03i.mp3", $i_current_surah, $i_current_ayah)) = InetGetSize($url & StringFormat("%03i%03i.mp3", $i_current_surah, $i_current_ayah))) then
$Status = 1
GUICtrlSetData($DownloaderInfo, "جاري تحميل الآية " & $i_current_ayah & " من " & Json_get($a_suras_dt[$i_current_surah-1], ".name"))
GUICtrlSetData($Progress, Round(Ceiling(($i_current_ayah / Int(Json_get($a_suras_dt[$i_current_surah-1], ".numberOfAyahs"))) * 100)))
GUICtrlSetData($Progress2, Round(Ceiling(($i_current_surah / 114) * 100)))
ContinueLoop
endIf
endIf
case 1
if (FileExists($Target & StringFormat("%03i\%03i.mp3", $i_current_surah, $i_current_ayah))) then
$Status = 1
GUICtrlSetData($DownloaderInfo, "جاري تحميل الآية " & $i_current_ayah & " من " & Json_get($a_suras_dt[$i_current_surah-1], ".name"))
GUICtrlSetData($Progress, Round(Ceiling(($i_current_ayah / Int(Json_get($a_suras_dt[$i_current_surah-1], ".numberOfAyahs"))) * 100)))
GUICtrlSetData($Progress2, Round(Ceiling(($i_current_downloaded / 6236) * 100)))
ContinueLoop
endIf
EndSwitch


$hDownloadNo = _RSMWare_GetData($url & StringFormat("%03i%03i.mp3", $i_current_surah, $i_current_ayah), $Target & StringFormat("%03i\%03i.mp3", $i_current_surah, $i_current_ayah))
$onprogress = false
$curent = false
elseIf $Status = 1 then
$i_current_downloaded += 1

if $i_current_ayah < Int(Json_get($a_suras_dt[$i_current_surah-1], ".numberOfAyahs")) then
$status = 0
$i_current_ayah += 1
Switch ReadSettings(".settings.downloadCheckFile", 2)
Case 2
if (FileExists($Target & StringFormat("%03i\%03i.mp3", $i_current_surah, $i_current_ayah))) then
if (FileGetSize($Target & StringFormat("%03i\%03i.mp3", $i_current_surah, $i_current_ayah)) = InetGetSize($url & StringFormat("%03i%03i.mp3", $i_current_surah, $i_current_ayah))) then
$Status = 1
GUICtrlSetData($DownloaderInfo, "جاري تحميل الآية " & $i_current_ayah & " من " & Json_get($a_suras_dt[$i_current_surah-1], ".name"))
GUICtrlSetData($Progress, Round(Ceiling(($i_current_ayah / Int(Json_get($a_suras_dt[$i_current_surah-1], ".numberOfAyahs"))) * 100)))
GUICtrlSetData($Progress2, Round(Ceiling(($i_current_downloaded / 6236) * 100)))
ContinueLoop
endIf
endIf
case 1
if (FileExists($Target & StringFormat("%03i\%03i.mp3", $i_current_surah, $i_current_ayah))) then
$Status = 1
GUICtrlSetData($DownloaderInfo, "جاري تحميل الآية " & $i_current_ayah & " من " & Json_get($a_suras_dt[$i_current_surah-1], ".name"))
GUICtrlSetData($Progress, Round(Ceiling(($i_current_ayah / Int(Json_get($a_suras_dt[$i_current_surah-1], ".numberOfAyahs"))) * 100)))
GUICtrlSetData($Progress2, Round(Ceiling(($i_current_downloaded / 6236) * 100)))
ContinueLoop
endIf
EndSwitch

$hDownloadNo = _RSMWare_GetData($url & StringFormat("%03i%03i.mp3", $i_current_surah, $i_current_ayah), $Target & StringFormat("%03i\%03i.mp3", $i_current_surah, $i_current_ayah))
$onprogress = false
$curent = false

else
if $i_current_surah = 114 then
$onprogress = false
$curent = false
$h_TimeOutInf = -1
GUIDelete($downloader)
msgBox(64, "تم التحميل", "لقد تم تحميل المصحف بصوت " & $s_recitername, "")
exit
else
$i_current_ayah = 1
$i_current_surah += 1
if not (FileExists($Target & StringFormat("%03i\", $i_current_surah))) then DirCreate($Target & StringFormat("%03i\", $i_current_surah))
Switch ReadSettings(".settings.downloadCheckFile", 2)
Case 2
if (FileExists($Target & StringFormat("%03i\%03i.mp3", $i_current_surah, $i_current_ayah))) then
if (FileGetSize($Target & StringFormat("%03i\%03i.mp3", $i_current_surah, $i_current_ayah)) = InetGetSize($url & StringFormat("%03i%03i.mp3", $i_current_surah, $i_current_ayah))) then
$Status = 1
GUICtrlSetData($DownloaderInfo, "جاري تحميل الآية " & $i_current_ayah & " من " & Json_get($a_suras_dt[$i_current_surah-1], ".name"))
GUICtrlSetData($Progress, Round(Ceiling(($i_current_ayah / Int(Json_get($a_suras_dt[$i_current_surah-1], ".numberOfAyahs"))) * 100)))
GUICtrlSetData($Progress2, Round(Ceiling(($i_current_downloaded / 6236) * 100)))
ContinueLoop
endIf
endIf
case 1
if (FileExists($Target & StringFormat("%03i\%03i.mp3", $i_current_surah, $i_current_ayah))) then
$Status = 1
GUICtrlSetData($DownloaderInfo, "جاري تحميل الآية " & $i_current_ayah & " من " & Json_get($a_suras_dt[$i_current_surah-1], ".name"))
GUICtrlSetData($Progress, Round(Ceiling(($i_current_ayah / Int(Json_get($a_suras_dt[$i_current_surah-1], ".numberOfAyahs"))) * 100)))
GUICtrlSetData($Progress2, Round(Ceiling(($i_current_downloaded / 6236) * 100)))
ContinueLoop
endIf
EndSwitch

$hDownloadNo = _RSMWare_GetData($url & StringFormat("%03i%03i.mp3", $i_current_surah, $i_current_ayah), $Target & StringFormat("%03i\%03i.mp3", $i_current_surah, $i_current_ayah))
$onprogress = false
$curent = false

endIf
endIf



endIf
WEnd
Opt("GUICloseOnESC", $oldCloseMode)
Opt("GUIOnEventMode", $oldEventMode)

if $i_error >= 1 then Return SetError($i_error, 0, false)
return $status
endFunc

Func _RSMWare_GetData($ss_url, $ss_Target)
Local $hDownload = InetGet($ss_url, $ss_Target, 1, 1)
Return $hDownload
EndFunc ;==>_RSMWare_GetData

Func SetUpdateProgress()
Local $state
If ($hDownloadNo <> 0) Then
$state = InetGetInfo($hDownloadNo)
If @error = 0 Then
local $i_suraprog = Round(Ceiling(($i_current_ayah / Int(Json_get($a_suras_dt[$i_current_surah-1], ".numberOfAyahs"))) * 100))
$onprogress = Round(Ceiling(($i_current_surah / 114) * 100))

$infor = "جاري تحميل الآية " & $i_current_ayah & " من " & Json_get($a_suras_dt[$i_current_surah-1], ".name")
if not (InetGetInfo($hDownloadNo, $INET_DOWNLOADSIZE) = 0) then
if $onProgress <= 0 then $onProgress = 0
GUICtrlSetData($Progress, $i_suraprog)
GUICtrlSetData($Progress2, Round(Ceiling(($i_current_downloaded / 6236) * 100)))
GUICtrlSetData($DownloaderInfo, $infor)
endIf
If $state[2] Then
If $state[3] Then
InetClose($hDownloadNo)
$status = 1
else
InetClose($hDownloadNo)
$status = false
endIf
endIf

EndIf
endIf
return ""
EndFunc ;==>SetProgress
Func ByteSuffix($iBytes)
	Local $iIndex = 0, $aArray = [' bytes', ' KB', ' MB', ' GB', ' TB', ' PB', ' EB', ' ZB', ' YB']
	While $iBytes > 1023
		$iIndex += 1
		$iBytes /= 1024
	WEnd
	Return Round($iBytes, 2) & $aArray[$iIndex]
EndFunc   ;==>ByteSuffix
