## header file ###
### hide the system tray icon ###
#notrayIcon

### import the libraries ###
#include <GUIConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiEdit.au3>
#include <GuiComboBox.au3>
#include <GuiListBox.au3>
#include <GuiListView.au3>
#include <GuiMenu.au3>
#include <GuiRichEdit.au3>
#include <GuiTreeView.au3>

### import the external libraries ###

#include <include\Bass.au3>
#include <include\editSetPos.au3>
#include <include\fileOptions.au3>
#include <include\JSON.au3>
#include <include\sapiManager.au3>
#include <include\UniversalSpeech.au3>


### global vars ###
global $i_crnt_type = 1, $i_crnt_Num = 1, $i_CRNt_Max = 114
global $s_settingsfl = @ScriptDir & "\Qurani.conf", $o_settingsdt
LoadSettings()
### functions ###
func LoadSettings()
if IsObj($o_settingsdt) then Return 1
local $dt_read = FileRead($s_settingsfl)
if (@error) or ($dt_read = "") then
$o_settingsdt = Json_ObjCreate()
Return 0
endIf
$o_settingsdt = Json_decode($dt_read)
return 1
endFunc
func readSettings($key)
if not (IsObj($o_settingsdt)) then LoadSettings()
Return Json_get($o_settingsdt, $key)
endFunc

func WriteSettings($key, $value)
if not (IsObj($o_settingsdt)) then LoadSettings()
local $f_open = FileOpen($s_settingsfl, 138)
if @Error then Return SetError(1)
Json_Put($o_settingsdt, $key, $value)
local $s_stgenc = Json_encode($o_settingsdt, BitOr($JSON_UNESCAPED_UNICODE, $JSON_PRETTY_PRINT))
FileWrite($f_open, $s_stgenc)
If @Error then
FileClose($f_open)
Return SetError(2)
endIf
FileClose($f_open)
Return Json_get($o_settingsdt, $key)
endFunc

func read_page($i_num)
$i_num = Int($i_num)
local $rd_txt = FileRead(@scriptDir & "\quran\pages\" & StringFormat("%03i.json", $i_num))
local $obj_j = Json_decode($rd_txt)
local $a_ayahs_list = Json_get($obj_j, ".ayahs")
if not (IsArray($a_ayahs_list)) then Return SetError(1, 0, "")
local $s_pg_text = ""
for $o_ayah in $a_ayahs_list
local $i_ayah_num = Json_get($o_ayah, ".numberInSurah")
local $s_ayah_text = Json_get($o_ayah, ".text")
local $o_sura_ob = Json_get($o_ayah, ".surah")
local $s_sura_name = Json_get($o_sura_ob, ".name")
local $s_sura_num = Json_get($o_sura_ob, ".number")
if $i_ayah_num = 1 then
if $s_pg_text = "" then
$s_pg_text = "    " & $s_sura_name & " (" & $s_sura_num & ")    " & @crlf & @crlf
else
$s_pg_text &= @crlf & "    " & $s_sura_name & " (" & $s_sura_num & ")    " & @crlf & @crlf
endIf
endIf
$s_pg_text &= $s_ayah_text & " (" & $i_ayah_num & ")" & @crlf
next
return $s_pg_text
endFunc

func read_hizb($i_num)
$i_num = Int($i_num)
local $rd_txt = FileRead(@scriptDir & "\quran\hizb\" & StringFormat("%02i.json", $i_num))
local $obj_j = Json_decode($rd_txt)
local $a_ayahs_list = Json_get($obj_j, ".ayahs")
if not (IsArray($a_ayahs_list)) then Return SetError(1, 0, "")
local $s_pg_text = ""
for $o_ayah in $a_ayahs_list
local $i_ayah_num = Json_get($o_ayah, ".numberInSurah")
local $s_ayah_text = Json_get($o_ayah, ".text")
local $o_sura_ob = Json_get($o_ayah, ".surah")
local $s_sura_name = Json_get($o_sura_ob, ".name")
local $s_sura_num = Json_get($o_sura_ob, ".number")
if $i_ayah_num = 1 then
if $s_pg_text = "" then
$s_pg_text = "    " & $s_sura_name & " (" & $s_sura_num & ")    " & @crlf & @crlf
else
$s_pg_text &= @crlf & "    " & $s_sura_name & " (" & $s_sura_num & ")    " & @crlf & @crlf
endIf
endIf
$s_pg_text &= $s_ayah_text & " (" & $i_ayah_num & ")" & @crlf
next
return $s_pg_text
endFunc

func read_sura($i_num)
$i_num = Int($i_num)
local $rd_txt = FileRead(@scriptDir & "\quran\suras\" & StringFormat("%03i.json", $i_num))
local $obj_j = Json_decode($rd_txt)
local $a_ayahs_list = Json_get($obj_j, ".ayahs")
if not (IsArray($a_ayahs_list)) then Return SetError(1, 0, "")
local $s_pg_text = ""
for $o_ayah in $a_ayahs_list
local $i_ayah_num = Json_get($o_ayah, ".numberInSurah")
local $s_ayah_text = Json_get($o_ayah, ".text")
local $o_page_ob = Json_get($o_ayah, ".surah")
local $s_sura_name = Json_get($obj_j, ".name")
local $s_sura_num = Json_get($obj_j, ".number")
if $i_ayah_num = 1 then
if $s_pg_text = "" then
$s_pg_text = "    " & $s_sura_name & " (" & $s_sura_num & ")    " & @crlf & @crlf
else
$s_pg_text &= @crlf & "    " & $s_sura_name & " (" & $s_sura_num & ")    " & @crlf & @crlf
endIf
endIf
$s_pg_text &= $s_ayah_text & " (" & $i_ayah_num & ")" & @crlf
next
return $s_pg_text
endFunc