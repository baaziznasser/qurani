global $o_sapiSpeech = 0


func _sapiLoad(ByRef $o_Sapi_OBJ)
if IsObj($o_Sapi_OBJ) then
setError(2)
return -1
else
$o_Sapi_OBJ = ObjCreate("SAPI.SpVoice")
if IsObj($o_Sapi_OBJ) then
$o_Sapi_OBJ.AlertBoundary() = 256
setError(0)
return 1
else
$o_Sapi_OBJ = false
setError(1)
return 0
endIf
endIf
endFunc

func _sapiUnLoad(ByRef $o_Sapi_OBJ)
if not (IsObj($o_Sapi_OBJ)) then return -1
$o_Sapi_OBJ = 0
return 1
endFunc

func _SapiGetAllVoices(ByRef $o_Sapi_OBJ, $s_separator = "|")
if not (IsObj($o_Sapi_OBJ)) then
setError(1)
return -1
endIf
local $s_Return = ""
local $separator = $s_separator
local $ovo = $o_Sapi_OBJ.GetVoices().Count() - 1
if @error then
setError(1)
return ""
else
local $ovoice
for $i = 0 To $ovo
$ovoice = $o_Sapi_OBJ.GetVoices().Item($i)
if not ($i = $ovo) then
$s_return &= $ovoice.Getdescription() & $separator
else
$s_return &= $ovoice.Getdescription()
endIf
next
return $s_return
endIf
endFunc
func _SapiGetVoice(ByRef $o_Sapi_OBJ)
if not (IsObj($o_Sapi_OBJ)) then
setError(1)
return -1
endIf
return $o_Sapi_OBJ.Voice.Getdescription()
endFunc

func _SapiSetVoice(ByRef $o_Sapi_OBJ, $sa_voice = "default")
if not (IsObj($o_Sapi_OBJ)) then
setError(1)
return -1
endIf
if $sa_voice = "default" then
return $o_Sapi_OBJ.Voice.Getdescription()
else
local $o_voices
For $i = 0 To $o_Sapi_OBJ.GetVoices().Count() - 1
$o_voices = $o_Sapi_OBJ.GetVoices().Item($i)
If $o_voices.Getdescription() = $sa_voice Then
$o_Sapi_OBJ.Voice = $o_voices
exitLoop
endIf
next
setError(0)
return $o_Sapi_OBJ.Voice.Getdescription()
endIf

endFunc

func _sapiGetVolume(ByRef $o_Sapi_OBJ)
if not (IsObj($o_Sapi_OBJ)) then
setError(1)
return -1
endIf
return $o_Sapi_OBJ.volume()
endFunc

func _sapiSetVolume(ByRef $o_Sapi_OBJ, $i_Volume = "default")
if not (IsObj($o_Sapi_OBJ)) then
setError(1)
return -1
endIf
if $i_volume = "default" then
local $i_vlm = $o_Sapi_OBJ.volume()
else
local $i_vlm = 0
$i_vlm += $i_Volume
if $i_Vlm <=  0 then $i_Vlm = 0
if $i_Vlm >=  100 then $i_Vlm = 100
endIf
$o_Sapi_OBJ.volume() = $i_Vlm
return $o_Sapi_OBJ.volume()
endFunc
func _SapiGetRate(ByRef $o_Sapi_OBJ)
if not (IsObj($o_Sapi_OBJ)) then
setError(1)
return -1
endIf
return $o_Sapi_OBJ.rate()
endFunc

func _sapiSetRate(ByRef $o_Sapi_OBJ, $i_rate = "default")
if not (IsObj($o_Sapi_OBJ)) then
setError(1)
return -1
endIf
if $i_rate = "default" then
local $i_rt = $o_Sapi_OBJ.Rate()
else
local $i_rt = 0
$i_rt += $i_rate
if $i_rt <= -10 then $i_rt = -10
if $i_rt >=  10 then $i_rt = 10
endIf
$o_Sapi_OBJ.Rate() = $i_rt
return $o_Sapi_OBJ.rate()
endFunc

func _SapiGetStatus(ByRef $o_Sapi_OBJ, $Property = "RunningState")
if not (IsObj($o_Sapi_OBJ)) then
setError(1)
return -1
endIf
return Execute("$o_Sapi_OBJ.Status." & $Property & "()")
endFunc

func _sapiSpeak(ByRef $o_Sapi_OBJ, $s_string, $i_flag = 0)
if not (IsObj($o_Sapi_OBJ)) then
setError(1)
return -1
endIf
return $o_Sapi_OBJ.Speak($s_string, $i_flag)
endFunc

func _sapiPause(ByRef $o_Sapi_OBJ)
if not (IsObj($o_Sapi_OBJ)) then
setError(1)
return -1
endIf
return $o_Sapi_OBJ.pause()
endFunc

func _sapiResume(ByRef $o_Sapi_OBJ)
if not (IsObj($o_Sapi_OBJ)) then
setError(1)
return -1
endIf
return $o_Sapi_OBJ.resume()
endFunc

func _sapiSkip(ByRef $o_Sapi_OBJ, $NumItems = 1, $Type = "Sentence")
if not (IsObj($o_Sapi_OBJ)) then
setError(1)
return -1
endIf
return $o_Sapi_OBJ.Skip($Type, $NumItems)
endFunc

func _sapiSaveToFile($s_string, $s_file, $s_voiceName = default, $i_volume = default, $i_rate = default)
local $o_audio = ObjCreate("SAPI.SpVoice")
if not (IsObj($o_audio)) then
return setError(1, 0, -1)
endIf
if $s_voiceName = default then $s_voiceName = $o_audio.Voice.Getdescription()
if $i_rate = default then $i_rate = $o_audio.rate()
if $i_volume = default then $i_volume = $o_audio.Volume()
local $ObjFile = ObjCreate("SAPI.SpFileStream.1")
if not (IsObj($ObjFile)) then
return setError(2, 0, -1)
endIf
$objFile.Open($s_File,3)
$o_audio.AudioOutputStream = $objFile
_SapiSetVoice($o_audio, $s_voiceName)
_SapiSetRate($o_audio, $i_rate)
_sapiSetVolume($o_audio, $i_volume)
$o_audio.Speak($s_string)
if @Error then Return SetError(1, 0, -1)
While $o_audio.Status.RunningState = 1
Sleep(100)
msgBox(64, "", "", "")
Wend
return 1
endFunc