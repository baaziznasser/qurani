
global $h_UniversalSpeech = false, $s_UniversalSpeechFile = @scriptDir & "\lib\UniversalSpeech.dll"
if @AutoItX64 then $s_UniversalSpeechFile = @scriptDir & "\lib\x64\UniversalSpeech.dll"

func UniversalSpeech_Load()
if $h_UniversalSpeech then return 1
if not (FileExists($s_UniversalSpeechFile)) then 
setError(1)
return 1
endIf

$h_UniversalSpeech = DLLOpen($s_UniversalSpeechFile)
if @error then
setError(2)
return -1
endIf

return $h_UniversalSpeech
endFunc

func UniversalSpeech_UnLoad()
if not ($h_UniversalSpeech) then return 1
if not (FileExists($s_UniversalSpeechFile)) then SetError(1, 1, -1)
DLLClose($h_UniversalSpeech)
if @error then
setError(2)
return -1
endIf

$h_UniversalSpeech = false
return 1
endFunc

func UniversalSpeech_getCurrentScreenReaderName()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf


local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "WSTR:cdecl", "getCurrentScreenReaderNameW")
if @error then
setError(2)
return 2
endIf
return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_getCurrentScreenReader()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Int:cdecl", "getCurrentScreenReader")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc


func UniversalSpeech_getScreenReaderName($i_num)
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "WSTR", "getScreenReaderNameW", "Int", $i_num)
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_getScreenReaderId($s_Name)
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Int", "getScreenReaderIdW", "WSTR", $s_Name)
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_getSupportedScreenReadersCount()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Int:cdecl", "getSupportedScreenReadersCount")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_setCurrentScreenReaderName($s_Name)
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Int", "setCurrentScreenReaderNameW", "WSTR", $s_Name)
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc



func UniversalSpeech_cbrLoad()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "cbrLoad")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc


func UniversalSpeech_cbrUnload()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "None", "cbrUnload")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_cbrIsAvailable()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "cbrIsAvailable")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_cbrSay($s_string)
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "cbrSayW", "WSTR", $s_string)
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_cbrStopSpeech()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "cbrStopSpeech")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc


func UniversalSpeech_dolLoad()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "dolLoad")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc


func UniversalSpeech_dolUnload()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "None", "dolUnload")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_dolIsAvailable()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "dolIsAvailable")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_dolSay($s_string)
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "dolSay", "WSTR", $s_string)
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_dolStopSpeech()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "dolStopSpeech")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_jfwLoad()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "jfwLoad")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_jfwUnload()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "None", "jfwUnload")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_jfwIsAvailable()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Int:cdecl", "jfwIsAvailable")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_jfwRunFunction($scriptName)
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "jfwRunFunctionW", "STRW", $scriptName)
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc
func UniversalSpeech_jfwRunScript($scriptName)
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "jfwRunScriptW", "WSTR", $scriptName)
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc


func UniversalSpeech_jfwGetUserSettingsDirectory($s_Buf, $i_BufMax)
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf


local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "jfwGetUserSettingsDirectory", "STR", $s_Buf, "Int", $i_BufMax)
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_jfwGetRunningVersion($s_Buf, $i_BufMax)
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf


local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "jfwGetRunningVersion", "STR", $s_Buf, "Int", $i_BufMax)
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_jfwSay($s_string, $i_Interrupt = 0)
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf


local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "jfwSay", "STR", $s_string, "Bool", $i_Interrupt)
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_jfwStopSpeech()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "jfwStopSpeech")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_nvdaLoad()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "nvdaLoad")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_nvdaUnload()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "None", "nvdaUnload")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_nvdaIsAvailable()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "nvdaIsAvailable")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_nvdaGetRunningVersion($s_buf, $i_BufMax = 0)
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "nvdaGetRunningVersion", "STR", $s_Buf, "Int", $i_BufMax)
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc


func UniversalSpeech_nvdaSay($s_string, $i_interrupt = 0)
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "nvdaSayW", "WSTR", $s_string, "Int", $i_interrupt)
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_nvdaStopSpeech()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "nvdaStopSpeech")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_saLoad()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "saLoad")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_saUnload()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "None", "saUnload")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_saIsAvailable()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "saIsAvailable")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_saSay($s_string)
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "saSayW", "WSTR", $s_string)
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_saStopSpeech()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "saStopSpeech")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc


func UniversalSpeech_sapiLoad()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "sapiLoad")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_sapiUnload()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "none", "sapiUnload")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_sapiEnable($b_enable = true)
UniversalSpeech_Load()
if @error then
setError(2)
return 2
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "sapiEnable", "Bool:cdecl", $b_Enable)
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_sapiIsEnabled()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "sapiIsEnabled")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_sapiIsAvailable()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "sapiIsAvailable")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_sapiGetNumVoices()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Int:cdecl", "sapiGetNumVoices")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_sapiGetRate()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Int:cdecl", "sapiGetRate")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_sapiSetRate($i_rate)
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "sapiSetRate", "Int", $i_rate)
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_sapiGetVolume()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Int:cdecl", "sapiGetVolume")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_sapiSetVolume($i_rate)
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "sapiSetVolume", "Int", $i_rate)
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc


func UniversalSpeech_sapiGetVoice()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Int:cdecl", "sapiGetVoice")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_sapiSetVoice($i_Num)
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "sapiSetVoice", "Int", $i_Num)
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_sapiGetVoiceName($i_num)
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "STR:cdecl*", "sapiGetVoiceName", "Int", $i_num)
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc


func UniversalSpeech_sapiGetValue($i_What)
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Int:cdecl", "sapiGetValue", "Int", $i_What)
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_sapiSetValue($i_What, $i_value)
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Int:cdecl", "sapiSetValue", "Int", $i_What, "Int", $i_value)
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc


func UniversalSpeech_sapiGetString($i_What)
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "WSTR:cdecl", "sapiGetString", "Int", $i_What)
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc


func UniversalSpeech_sapiIsPaused()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "sapiIsPaused")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc


func UniversalSpeech_sapiSetPaused($B_pause = true)
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "sapiSetPaused", "Bool:cdecl", $B_pause)
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_sapiIsSpeaking()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "sapiIsSpeaking")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_sapiSay($s_string, $i_Interrupt = 0)
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "sapiSayW", "WSTR", $s_string, "Int", $i_Interrupt)
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_sapiSaySSML($s_string, $i_Interrupt = 0)
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "sapiSaySSMLW", "WSTR", $s_string, "Int", $i_Interrupt)
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_sapiStopSpeech()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "sapiStopSpeech")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_sapiSetOutputCallback($i_sampleRate, $i_SapiWaveOutputCallback, $udata)
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "sapiSetOutputCallback", "Int:cdecl", $i_sampleRate, "Int:cdecl", $i_SapiWaveOutputCallback, "Int:cdecl", $udata)
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_sapiWait($i_Num)
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "sapiWait", "Int", $i_Num)
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc


func UniversalSpeech_weLoad()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "weLoad")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_weUnload()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "None", "weUnload")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_weIsAvailable()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "weIsAvailable")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc


func UniversalSpeech_weSay($s_string)
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "weSayW", "WSTR", $s_string)
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_weStopSpeech()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "weStopSpeech")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc




func UniversalSpeech_ztLoad()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "ztLoad")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_ztUnload()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "None", "ztUnload")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_ztIsAvailable()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "ztIsAvailable")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc


func UniversalSpeech_ztIsActive()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "ztIsActive")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_ztSay($s_string, $I_Interrupt = 0)
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "ztSayW", "WSTR", $s_string, "Bool", $i_Interrupt)
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_ztStopSpeech()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "ztStopSpeech")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc


func UniversalSpeech_speechSay($s_string, $I_Interrupt = 0)
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "speechSay", "WSTR", $s_string, "Bool", $i_Interrupt)
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_speechStop()
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Bool:cdecl", "speechStop")
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_speechGetValue($i_what)
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Int:cdecl", "speechGetValue", "Int", $i_what)
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_speechSetValue($i_what, $i_value)
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Int:cdecl", "speechSetValue", "Int", $i_what, "Int", $i_value)
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_speechGetString($i_what)
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "WSTR:cdecl", "speechGetString", "Int", $i_what)
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc

func UniversalSpeech_speechSetString($i_what, $s_value)
UniversalSpeech_Load()
if @error then
setError(1)
return 1
endIf

local $UniversalSpeechResult = DLLCall($h_UniversalSpeech, "Int:cdecl", "speechSetString", "Int", $i_what, "WSTR", $s_value)
if @error then
setError(2)
return 2
endIf

return $UniversalSpeechResult[0]
endFunc
