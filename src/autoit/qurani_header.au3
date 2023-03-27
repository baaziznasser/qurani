## header file ###
### hide the system tray icon ###
#NoTrayIcon

### import the libraries ###
#include <WinAPIGdi.au3>
#include <WinAPIProc.au3>
#include <GUIButton.au3>
#include <Color.au3>
#include <WinAPIGdi.au3>
#include <FontConstants.au3>
#include <array.au3>
#include <WinAPISysWin.au3>
#include <GUIConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiEdit.au3>
#include <GuiComboBox.au3>
#include <GuiListBox.au3>
#include <GuiListView.au3>
#include <GuiMenu.au3>
#include <GuiRichEdit.au3>
#include <GuiTreeView.au3>
#include <SQLite.au3>
#include <WinAPILocale.au3>
#include <WinAPIDiag.au3>

### import the external libraries ###
#include <include\mutex.au3>
#include <include\WinHttp.au3>
#include <include\GUICtrlSetResizingEx.au3>
#include <include\Bass.au3>
#include <include\quran_downloader.au3>

#include <include\editSetPos.au3>
#include <include\fileOptions.au3>
#include <include\JSON.au3>
#include <include\sapiManager.au3>
#include <include\UniversalSpeech.au3>

### global vars ###
Global $b_savedpos = False
Global $s_searchSTR = ""
Global $i_crnt_type = 1, $i_crnt_Num = 1, $i_CRNt_Max = 114
Global $s_settingsfl = @ScriptDir & "\Qurani.conf", $o_settingsdt
Global $s_last_played = "", $i_repetition = readSettings(".settings.Rep_num", 1), $i_repetition_all = readSettings(".settings.Rep_cycles", 1), $i_repeated = 1, $i_repeated_all = 1


Global $s_recitersDir = "", $i_reciterId = 0
Global $S_crnt_VersionString = "1.2.0.0"

_check_fonts()
LoadSettings()
Global $b_accessibility = readSettings(".settings.Accessibility", _CheckScreenReader())
Global $b_ayahtoline = readSettings(".settings.ayahnewline", 1)
If readSettings(".settings.preventSleep", 1) = 1 Then _WinAPI_SetThreadExecutionState(BitOR($ES_CONTINUOUS, $ES_SYSTEM_REQUIRED, $ES_AWAYMODE_REQUIRED))
Global $b_sel_ayah = (readSettings(".settings.aya_sel", 1) = 1)
UniversalSpeech_Load()
UniversalSpeech_sapiEnable(False)
$o_suras_obj = Json_decode(FileRead(@ScriptDir & "\DataBase\Surahs.json"))
Global $a_surahs_meta = Json_get($o_suras_obj, ".surahs")
If Not (IsArray($a_surahs_meta)) Then 
$a_surahs_meta = -1
	MsgBox(16, "error", "we can not load the data base")
	Exit (1)
endIf
Global $a_currentlist[1][5], $i_last_aya = 0, $i_last_aya_in_surah = 0, $a_tocenter[1][3]
$a_tocenter[0][0] = 0
Global $a_dbres, $iRows, $iColumns, $iRval
_SQLite_Startup(@ScriptDir & "\lib\sqlite3.dll")
If @error Then
	MsgBox(16, "error", "we can not load the data base library")
	Exit (1)
EndIf
process_cmdLine()
_check_open_process()
If readSettings(".settings.quranstyle", 0) = 0 Then
	Global $h_db = _SQLite_Open(@ScriptDir & "\database\Quran\Quran.DB")
	If @error Then
		MsgBox(16, "error", "we can not load the data base")
		Exit (1)
	EndIf
Else
	Global $h_db = _SQLite_Open(@ScriptDir & "\database\Quran\uthmani.DB")
	If @error Then
		MsgBox(16, "error", "we can not load the data base")
		Exit (1)
	EndIf

EndIf
If Not (FileExists(@ScriptDir & "\database\Surahs.Json")) Then
	MsgBox(16, "error", "we can not load the data base")
	Exit (1)
EndIf
Global $h_recitersDb = _SQLite_Open(@ScriptDir & "\database\reciters.DB")
If @error Then
	MsgBox(16, "error", "we can not load the data base")
	Exit (1)
EndIf
Global $i_reciterId = readSettings(".settings.reciterId", 10)

$iRval = _SQLite_GetTable($h_recitersDb, "SELECT url FROM reciters Where id = " & $i_reciterId & ";", $a_dbres, $iRows, $iColumns)
If IsArray($a_dbres) Then
	If UBound($a_dbres) <= 2 Then

		MsgBox(16, "error", "we can not load the data base")
		Exit (1)
	EndIf

	$s_recitersDir = $a_dbres[2]

EndIf

If readSettings(".settings.tafsir", 1) = 1 Then
	Global $h_Tafssir_db = _SQLite_Open(@ScriptDir & "\database\tafasir\muyassar.DB")
ElseIf readSettings(".settings.tafsir", 1) = 2 Then
	Global $h_Tafssir_db = _SQLite_Open(@ScriptDir & "\database\tafasir\jalalayn.DB")
ElseIf readSettings(".settings.tafsir", 1) = 3 Then
	Global $h_Tafssir_db = _SQLite_Open(@ScriptDir & "\database\tafasir\sa3dy.db")
ElseIf readSettings(".settings.tafsir", 1) = 4 Then
	Global $h_Tafssir_db = _SQLite_Open(@ScriptDir & "\database\tafasir\katheer.db")
ElseIf readSettings(".settings.tafsir", 1) = 5 Then
	Global $h_Tafssir_db = _SQLite_Open(@ScriptDir & "\database\tafasir\qortoby.db")
ElseIf readSettings(".settings.tafsir", 1) = 6 Then
	Global $h_Tafssir_db = _SQLite_Open(@ScriptDir & "\database\tafasir\tabary.db")
ElseIf readSettings(".settings.tafsir", 1) = 7 Then
	Global $h_Tafssir_db = _SQLite_Open(@ScriptDir & "\database\tafasir\baghawy.db")
Else
	Global $h_Tafssir_db = _SQLite_Open(@ScriptDir & "\database\tafasir\muyassar.DB")
	WriteSettings(".settings.tafsir", 1)
EndIf
_BASS_Startup(@ScriptDir & "\lib\Bass.dll")
If @error Then
	MsgBox(16, "error", "error opening audio library")
	Exit
EndIf
_BASS_Init(0, -1, 44100, 0, "")
If @error Then
	MsgBox(16, "error", "error opening audio library")
	Exit
EndIf

OnAutoItExitRegister("quit")
Global $h_stream = -1, $i_volume = 100
### functions ###
Func GetKeyBord($s_Lng = @KBLayout)
	Local $kebordID = '0x' & StringTrimLeft($s_Lng, 3) & StringTrimLeft($s_Lng, 3)
	Local $idBord = _WinAPI_GetLocaleInfo(BitAND($kebordID, 0xFFFF), $LOCALE_SENGLANGUAGE)
	Return $idBord
EndFunc   ;==>GetKeyBord

Func LoadSettings()
	If IsObj($o_settingsdt) Then Return 1
	Local $dt_read = FileRead($s_settingsfl)
	If (@error) Or ($dt_read = "") Then
		$o_settingsdt = Json_ObjCreate()
		Return 0
	EndIf
	$o_settingsdt = Json_decode($dt_read)
	Return 1
EndFunc   ;==>LoadSettings
Func readSettings($s_key, $s_default = "")
	If Not (IsObj($o_settingsdt)) Then LoadSettings()
	Local $g_tt = Json_get($o_settingsdt, $s_key)
	If @error Then Return $s_default
	Return $g_tt
EndFunc   ;==>readSettings

Func WriteSettings($key, $value)
	If Not (IsObj($o_settingsdt)) Then LoadSettings()
	Local $f_open = FileOpen($s_settingsfl, 138)
	If @error Then Return SetError(1)
	Json_Put($o_settingsdt, $key, $value)
	Local $s_stgenc = Json_encode($o_settingsdt, BitOR($JSON_UNESCAPED_UNICODE, $JSON_PRETTY_PRINT))
	FileWrite($f_open, $s_stgenc)
	If @error Then
		FileClose($f_open)
		Return SetError(2)
	EndIf
	FileClose($f_open)
	Return Json_get($o_settingsdt, $key)
EndFunc   ;==>WriteSettings

Func _load_main_array($a_array)
	$a_dbres = $a_array
	Local $s_pg_text = ""
	ReDim $a_currentlist[UBound($a_dbres) - 1][12]
	Local $i_hide_tashkil_read = readSettings(".settings.hideAyatashkil", 0), $i_hide_simbols_read = readSettings(".settings.hideAyaSimbols", 0), $i_hide_numbers_read = readSettings(".settings.hideAyaNumber", 0)
	ReDim $a_tocenter[1][3]
	$a_tocenter[0][0] = 0
	For $i = 1 To UBound($a_dbres) - 1
		Local $i_ayah_num = $a_dbres[$i][4]
		Local $s_ayah_text = $a_dbres[$i][0]
		Local $s_sura_name = $a_dbres[$i][2]
		Local $s_sura_num = $a_dbres[$i][3]
		$a_currentlist[$i - 1][2] = $i_ayah_num
		$a_currentlist[$i - 1][3] = $s_sura_name
		$a_currentlist[$i - 1][4] = $s_sura_num
		$a_currentlist[$i - 1][5] = $a_dbres[$i][5]
		$a_currentlist[$i - 1][6] = $a_dbres[$i][6]
		$a_currentlist[$i - 1][7] = $a_dbres[$i][7]
		$a_currentlist[$i - 1][8] = $a_dbres[$i][8]
		$a_currentlist[$i - 1][9] = $a_dbres[$i][1]
		$a_currentlist[$i - 1][10] = $a_dbres[$i][9]
		$a_currentlist[$i - 1][11] = $a_dbres[$i][10]
		If $i_ayah_num = 1 Then
			If $s_pg_text = "" Then
				$s_pg_text = $s_sura_name & " (" & $s_sura_num & ")" & @LF & @LF
				ReDim $a_tocenter[UBound($a_tocenter) + 1][3]
				$a_tocenter[UBound($a_tocenter) - 1][0] = 0
				$a_tocenter[UBound($a_tocenter) - 1][1] = $a_tocenter[UBound($a_tocenter) - 1][0] + StringLen($s_sura_name & " (" & $s_sura_num & ")")
				$a_tocenter[UBound($a_tocenter) - 1][2] = 28
				$a_tocenter[0][0] = UBound($a_tocenter) - 1
			Else
				ReDim $a_tocenter[UBound($a_tocenter) + 1][3]
				$a_tocenter[UBound($a_tocenter) - 1][0] = StringLen($s_pg_text & @LF) - 1
				$a_tocenter[UBound($a_tocenter) - 1][1] = $a_tocenter[UBound($a_tocenter) - 1][0] + StringLen($s_sura_name & " (" & $s_sura_num & ")")
				$a_tocenter[UBound($a_tocenter) - 1][2] = 28
				$a_tocenter[0][0] = UBound($a_tocenter) - 1
				$s_pg_text &= @LF & $s_sura_name & " (" & $s_sura_num & ")" & @LF & @LF
			EndIf
			If $s_sura_num > 1 Then
				$s_ayah_text = StringReplace($s_ayah_text, "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ", "")
				ReDim $a_tocenter[UBound($a_tocenter) + 1][3]
				$a_tocenter[UBound($a_tocenter) - 1][0] = StringLen($s_pg_text) - 1
				$a_tocenter[UBound($a_tocenter) - 1][1] = $a_tocenter[UBound($a_tocenter) - 1][0] + StringLen("بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ")
				$a_tocenter[UBound($a_tocenter) - 1][2] = 24
				$a_tocenter[0][0] = UBound($a_tocenter) - 1
				$s_pg_text &= "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ" & @LF
			EndIf

		EndIf
		$s_regparam = ""
		If ($i_hide_tashkil_read = 1) And ($i_hide_simbols_read = 1) Then
			$s_regparam = "[^ا-يةئءؤأإآى\s]+"
		ElseIf ($i_hide_tashkil_read = 1) And Not ($i_hide_simbols_read = 1) Then
			$s_regparam = "[ًٌٍَُِّْ]"
		ElseIf ($i_hide_simbols_read = 1) And Not ($i_hide_tashkil_read = 1) Then
			$s_regparam = "[^ا-يةئءؤأإآى\sًٌٍَُِّْ]+"
		EndIf
		If Not ($s_regparam = "") Then
			$s_ayah_text = StringRegExpReplace($s_ayah_text, $s_regparam, "")
		EndIf

		If $b_ayahtoline Then
			If Not ($i_hide_numbers_read = 1) Then
				$s_pg_text &= $s_ayah_text & " (" & $i_ayah_num & ")" & @LF
			Else
				$s_pg_text &= $s_ayah_text & @LF
			EndIf
		Else
			If Not ($i_hide_numbers_read = 1) Then
				$s_pg_text &= $s_ayah_text & " (" & $i_ayah_num & ") "
			Else
				$s_pg_text &= $s_ayah_text & " "
			EndIf
		EndIf
			If Not ($i_hide_numbers_read = 1) Then
		$a_currentlist[$i - 1][0] = StringInStr($s_pg_text, $s_ayah_text & " (" & $i_ayah_num & ")", 0, -1) - 1
else
		$a_currentlist[$i - 1][0] = StringInStr($s_pg_text, $s_ayah_text & " ", 0, -1) - 1
endif
		$a_currentlist[$i - 1][1] = $a_currentlist[$i - 1][0] + StringLen($s_ayah_text)
	Next
	Return $s_pg_text
EndFunc   ;==>_load_main_array
Func read_page($i_num)
	$i_last_aya = 0
	$i_num = Int($i_num)

	$iRval = _SQLite_GetTable2D($h_db, "SELECT * FROM quran WHERE page = " & $i_num & ";", $a_dbres, $iRows, $iColumns)
	If Not (IsArray($a_dbres)) Then Return SetError(1, 0, "")
	Return _load_main_array($a_dbres)
EndFunc   ;==>read_page

Func read_hizb($i_num)
	$i_last_aya = 0
	$i_num = Int($i_num)
	$iRval = _SQLite_GetTable2D($h_db, "SELECT * FROM quran WHERE hizb =" & $i_num & ";", $a_dbres, $iRows, $iColumns)
	If Not (IsArray($a_dbres)) Then Return SetError(1, 0, "")
	Return _load_main_array($a_dbres)
EndFunc   ;==>read_hizb

Func read_Quarter($i_num)
	$i_last_aya = 0
	$i_num = Int($i_num)
	$iRval = _SQLite_GetTable2D($h_db, "SELECT * FROM quran WHERE hizbQuarter = " & $i_num & ";", $a_dbres, $iRows, $iColumns)
	If Not (IsArray($a_dbres)) Then Return SetError(1, 0, "")
	Return _load_main_array($a_dbres)
EndFunc   ;==>read_Quarter

Func read_sura($i_num)
	$i_last_aya = 0
	$i_num = Int($i_num)
	$iRval = _SQLite_GetTable2D($h_db, "SELECT * FROM quran WHERE sura_number = " & $i_num & ";", $a_dbres, $iRows, $iColumns)
	If Not (IsArray($a_dbres)) Then Return SetError(1, 0, "")
	Return _load_main_array($a_dbres)
EndFunc   ;==>read_sura

Func read_juz($i_num)
	$i_last_aya = 0
	$i_num = Int($i_num)

	$iRval = _SQLite_GetTable2D($h_db, "SELECT * FROM quran WHERE juz = " & $i_num & ";", $a_dbres, $iRows, $iColumns)
	If Not (IsArray($a_dbres)) Then Return SetError(1, 0, "")
	Return _load_main_array($a_dbres)
EndFunc   ;==>read_juz

Func read_custome($i_ayah_from, $i_ayah_to)
	$i_last_aya = 0
	;	$i_num = Int($i_num)

	$iRval = _SQLite_GetTable2D($h_db, "SELECT * FROM quran WHERE number Between " & $i_ayah_from & " AND " & $i_ayah_to & ";", $a_dbres, $iRows, $iColumns)
	If Not (IsArray($a_dbres)) Then Return SetError(1, 0, "")
	Return _load_main_array($a_dbres)
EndFunc   ;==>read_custome
Func _get_aya($num = Default)
	Local $i_c_pos = _GUICtrlRichEdit_GetSel($h_text)[0]
	If $i_c_pos <= $a_currentlist[$i_last_aya][0] Then
		Local $i__start = 0, $i__end = $i_last_aya
	ElseIf $i_c_pos > $a_currentlist[$i_last_aya][0] Then
		Local $i__start = $i_last_aya, $i__end = UBound($a_currentlist) - 1
	EndIf
	Local $i_ret = 0
	For $i = $i__start To $i__end
		If $i_c_pos = $a_currentlist[$i][0] Then
			$i_ret = $a_currentlist[$i][0]
			$i_last_aya = $i
			ExitLoop
		ElseIf $i_c_pos < $a_currentlist[$i][0] Then
			If $i = 0 Then
				If $a_currentlist[$i][0] > 0 Then
					$i_ret = -1
					$i_last_aya = 0
					ExitLoop
				EndIf
				$i_ret = 0
				$i_last_aya = 0
				ExitLoop

			Else
				$i_ret = $a_currentlist[$i - 1][0]
				$i_last_aya = $i - 1
				ExitLoop
			EndIf
		ElseIf $i_c_pos > $a_currentlist[$i][0] Then
			If Not ($i = $i__end) Then
				If $i_c_pos < $a_currentlist[$i + 1][0] Then
					$i_ret = $a_currentlist[$i][0]
					$i_last_aya = $i
					ExitLoop
				EndIf
			Else
				$i_ret = $a_currentlist[$i][0]
				$i_last_aya = $i
				ExitLoop
			EndIf

		EndIf
	Next

	If $num = Default Then
		Return $i_ret
	ElseIf StringInStr($num, "-") Then
		If Not ($i_last_aya = 0) Then
			$i_last_aya -= Int(StringReplace($num, "-", ""))
			If $i_last_aya < 0 Then $i_last_aya = 0
			Return $a_currentlist[$i_last_aya][0]
		Else
			$i_last_aya = 0
			Return $a_currentlist[$i_last_aya][0]
		EndIf
	ElseIf StringInStr($num, "+") Then
		If $i_c_pos < $a_currentlist[0][0] Then $i_last_aya = -1
		If Not ($i_last_aya + Int(StringReplace($num, "+", "")) >= UBound($a_currentlist) - 1) Then
			$i_last_aya += Int(StringReplace($num, "+", ""))
			Return $a_currentlist[$i_last_aya][0]
		Else
			$i_last_aya = UBound($a_currentlist) - 1
			Return $a_currentlist[$i_last_aya][0]
		EndIf
	Else
		If ($num - 1 >= 0) And ($num - 1 <= (UBound($a_currentlist) - 1)) Then
			$i_last_aya = $num - 1
			Return $a_currentlist[$i_last_aya][0]
		Else
			Return SetError(1, 0, -1)
		EndIf
	EndIf
	Return SetError(1, 0, -1)
EndFunc   ;==>_get_aya
Func _IsChecked($idControlID)
	Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc   ;==>_IsChecked

Func _pop_upmessage($h_wnd, $s_message, $s_title = "")
	Local $old_esc_close = Opt("GUICloseOnESC")
	Local $old_event_mode = Opt("GUIOnEventMode")
	Opt("GUICloseOnESC", 1)
	Opt("GUIOnEventMode", 0)
	GUISetState(@SW_DISABLE, $h_wnd)
	Local $h_pop_GUI = GUICreate($s_title, 500, 320, -1, -1, BitOR($WS_SYSMENU, $WS_CLIPCHILDREN, $WS_CLIPSIBLINGS, $WS_MAXIMIZEBOX, $WS_MINIMIZEBOX, $WS_SIZEBOX, $WS_SYSMENU), BitOR($WS_EX_LAYOUTRTL, $WS_EX_MDICHILD), $h_wnd)
	GUICtrlCreateLabel($s_title, -99, -99, -99, -99)
	GUICtrlSetResizing(-1, 1)
	GUICtrlSetFont(-1, 16, 700, 0, "Times New Roman")
	Local $i_txtmessage = GUICtrlCreateEdit(StringReplace($s_message, @LF, @CRLF), 10, 10, 480, 220, BitOR($ES_MULTILINE, $WS_VSCROLL, $ES_AUTOVSCROLL, 0x8000, $ES_READONLY, $WS_TABSTOP))
	GUICtrlSetResizing(-1, 1)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	Local $i_pop_Copy = GUICtrlCreateButton("نسخ إلى الحافظة", 10, 240, 180, 30)
	GUICtrlSetResizing(-1, 1)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	Local $i_pop_exit = GUICtrlCreateButton("إغلاق", 200, 240, 190, 30)
	GUICtrlSetResizing(-1, 1)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUISetState(@SW_SHOW, $h_pop_GUI)
	_GUICtrlEdit_SetPos($i_txtmessage, 0)
	While 1
		Switch GUIGetMsg()
			Case $GUI_event_close, $i_pop_exit
				GUIDelete($h_pop_GUI)
				ExitLoop
			Case $i_pop_Copy
				ClipPut($s_message)
		EndSwitch
	WEnd

	Opt("GUICloseOnESC", $old_esc_close)
	Opt("GUIOnEventMode", $old_event_mode)
	GUISetState(@SW_ENABLE, $h_wnd)
	WinActivate($h_wnd, "")
EndFunc   ;==>_pop_upmessage


Func _GUICtrlRichEdit_SetDefaultcolor($hWnd, $iColor = Default)
	If Not _WinAPI_IsClassName($hWnd, $__g_sRTFClassName) Then Return SetError(101, 0, False)

	Local $tCharFormat = DllStructCreate($tagCHARFORMAT)
	DllStructSetData($tCharFormat, 1, DllStructGetSize($tCharFormat))
	If $iColor = Default Then
		DllStructSetData($tCharFormat, 3, $CFE_AUTOCOLOR)
		$iColor = 0
	Else
		If BitAND($iColor, 0xff000000) Then Return SetError(1022, 0, False)
	EndIf

	DllStructSetData($tCharFormat, 2, $CFM_COLOR)
	DllStructSetData($tCharFormat, 6, $iColor)
	Return _SendMessage($hWnd, $EM_SETCHARFORMAT, $SCF_ALL, DllStructGetPtr($tCharFormat))
EndFunc   ;==>_GUICtrlRichEdit_SetDefaultcolor

Func _GUICtrlRichEdit_SetDefaultFont($hWnd, $iPoints = Default, $sName = Default, $iCharset = Default, $iLcid = Default)
	; MSDN does not give a mask (CFM) for bPitchAndFamily so it appears that it cannot be set => omitted here
	Local $iDwMask = 0

	If Not _WinAPI_IsClassName($hWnd, $__g_sRTFClassName) Then Return SetError(101, 0, False)
	If Not ($iPoints = Default Or __GCR_IsNumeric($iPoints, ">0")) Then Return SetError(102, 0, False)
	If $sName <> Default Then
		Local $aS = StringSplit($sName, " ")
		For $i = 1 To UBound($aS) - 1
			If Not StringIsAlpha($aS[$i]) Then Return SetError(103, 0, False)
		Next
	EndIf
	If Not ($iCharset = Default Or __GCR_IsNumeric($iCharset)) Then Return SetError(104, 0, False)
	If Not ($iLcid = Default Or __GCR_IsNumeric($iLcid)) Then Return SetError(105, 0, False)

	Local $tCharFormat = DllStructCreate($tagCHARFORMAT2)
	DllStructSetData($tCharFormat, 1, DllStructGetSize($tCharFormat))

	If $iPoints <> Default Then
		$iDwMask = $CFM_SIZE
		DllStructSetData($tCharFormat, 4, Int($iPoints * 20))
	EndIf
	If $sName <> Default Then
		If StringLen($sName) > $LF_FACESIZE - 1 Then SetError(-1, 0, False)
		$iDwMask = BitOR($iDwMask, $CFM_FACE)
		DllStructSetData($tCharFormat, 9, $sName)
	EndIf
	If $iCharset <> Default Then
		$iDwMask = BitOR($iDwMask, $CFM_CHARSET)
		DllStructSetData($tCharFormat, 7, $iCharset)
	EndIf
	If $iLcid <> Default Then
		$iDwMask = BitOR($iDwMask, $CFM_LCID)
		DllStructSetData($tCharFormat, 13, $iLcid)
	EndIf
	DllStructSetData($tCharFormat, 2, $iDwMask)

	Local $iRet = _SendMessage($hWnd, $EM_SETCHARFORMAT, $SCF_ALL, $tCharFormat, 0, "wparam", "struct*")
	If Not $iRet Then Return SetError(@error + 200, 0, False)
	Return True
EndFunc   ;==>_GUICtrlRichEdit_SetDefaultFont

Func _GUICtrlRichEdit_SetDefaultAttributes($hWnd, $sStatesAndEffects, $bWord = False)
	Local Const $aV[17][3] = [ _
			["bo", $CFM_BOLD, $CFE_BOLD], ["di", $CFM_DISABLED, $CFE_DISABLED], _
			["em", $CFM_EMBOSS, $CFE_EMBOSS], ["hi", $CFM_HIDDEN, $CFE_HIDDEN], _
			["im", $CFM_IMPRINT, $CFE_IMPRINT], ["it", $CFM_ITALIC, $CFE_ITALIC], _
			["li", $CFM_LINK, $CFE_LINK], ["ou", $CFM_OUTLINE, $CFE_OUTLINE], _
			["pr", $CFM_PROTECTED, $CFE_PROTECTED], ["re", $CFM_REVISED, $CFE_REVISED], _
			["sh", $CFM_SHADOW, $CFE_SHADOW], ["sm", $CFM_SMALLCAPS, $CFE_SMALLCAPS], _
			["st", $CFM_STRIKEOUT, $CFE_STRIKEOUT], ["sb", $CFM_SUBSCRIPT, $CFE_SUBSCRIPT], _
			["sp", $CFM_SUPERSCRIPT, $CFE_SUPERSCRIPT], ["un", $CFM_UNDERLINE, $CFE_UNDERLINE], _
			["al", $CFM_ALLCAPS, $CFE_ALLCAPS]]

	If Not _WinAPI_IsClassName($hWnd, $__g_sRTFClassName) Then Return SetError(101, 0, False)
	If Not IsBool($bWord) Then Return SetError(103, 0, False)

	Local $iMask = 0, $iEffects = 0, $n, $s
	For $i = 1 To StringLen($sStatesAndEffects) Step 3
		$s = StringMid($sStatesAndEffects, $i + 1, 2)
		$n = -1
		For $j = 0 To UBound($aV) - 1
			If $aV[$j][0] = $s Then
				$n = $j
				ExitLoop
			EndIf
		Next
		If $n = -1 Then Return SetError(1023, $s, False) ; not found
		$iMask = BitOR($iMask, $aV[$n][1])
		$s = StringMid($sStatesAndEffects, $i, 1)
		Switch $s
			Case "+"
				$iEffects = BitOR($iEffects, $aV[$n][2])
			Case "-"
				; do nothing
			Case Else
				Return SetError(1022, $s, False)
		EndSwitch
	Next
	Local $tCharFormat = DllStructCreate($tagCHARFORMAT)
	DllStructSetData($tCharFormat, 1, DllStructGetSize($tCharFormat))
	DllStructSetData($tCharFormat, 2, $iMask)
	DllStructSetData($tCharFormat, 3, $iEffects)
	Local $wParam = ($bWord ? BitOR($SCF_WORD, $SCF_ALL) : $SCF_ALL)
	Local $iRet = _SendMessage($hWnd, $EM_SETCHARFORMAT, $wParam, $tCharFormat, 0, "wparam", "struct*")
	If Not $iRet Then Return SetError(700, 0, False)
	Return True
EndFunc   ;==>_GUICtrlRichEdit_SetDefaultAttributes

Func _GUICtrlRichEdit_SetDefaultBkColor($hWnd, $iBkColor = Default)
	If Not _WinAPI_IsClassName($hWnd, $__g_sRTFClassName) Then Return SetError(101, 0, False)

	Local $tCharFormat = DllStructCreate($tagCHARFORMAT2)
	DllStructSetData($tCharFormat, 1, DllStructGetSize($tCharFormat))
	If $iBkColor = Default Then
		DllStructSetData($tCharFormat, 3, $CFE_AUTOBACKCOLOR)
		$iBkColor = 0
	Else
		If BitAND($iBkColor, 0xff000000) Then Return SetError(1022, 0, False)
	EndIf

	DllStructSetData($tCharFormat, 2, $CFM_BACKCOLOR)
	DllStructSetData($tCharFormat, 12, $iBkColor)
	Return _SendMessage($hWnd, $EM_SETCHARFORMAT, $SCF_ALL, $tCharFormat, 0, "wparam", "struct*") <> 0
EndFunc   ;==>_GUICtrlRichEdit_SetDefaultBkColor


Func _GUICtrlRichEdit_GetDefaultAttributes($hWnd)
	Local Const $aV[17][3] = [ _
			["bo", $CFM_BOLD, $CFE_BOLD], ["di", $CFM_DISABLED, $CFE_DISABLED], _
			["em", $CFM_EMBOSS, $CFE_EMBOSS], ["hi", $CFM_HIDDEN, $CFE_HIDDEN], _
			["im", $CFM_IMPRINT, $CFE_IMPRINT], ["it", $CFM_ITALIC, $CFE_ITALIC], _
			["li", $CFM_LINK, $CFE_LINK], ["ou", $CFM_OUTLINE, $CFE_OUTLINE], _
			["pr", $CFM_PROTECTED, $CFE_PROTECTED], ["re", $CFM_REVISED, $CFE_REVISED], _
			["sh", $CFM_SHADOW, $CFE_SHADOW], ["sm", $CFM_SMALLCAPS, $CFE_SMALLCAPS], _
			["st", $CFM_STRIKEOUT, $CFE_STRIKEOUT], ["sb", $CFM_SUBSCRIPT, $CFE_SUBSCRIPT], _
			["sp", $CFM_SUPERSCRIPT, $CFE_SUPERSCRIPT], ["un", $CFM_UNDERLINE, $CFE_UNDERLINE], _
			["al", $CFM_ALLCAPS, $CFE_ALLCAPS]]

	If Not _WinAPI_IsClassName($hWnd, $__g_sRTFClassName) Then Return SetError(101, 0, "")

	Local $tCharFormat = DllStructCreate($tagCHARFORMAT2)
	DllStructSetData($tCharFormat, 1, DllStructGetSize($tCharFormat))
	; $wParam = ($bDefault ? $SCF_DEFAULT : $SCF_SELECTION)	; SCF_DEFAULT doesn't work
	Local $iMask = _SendMessage($hWnd, $EM_GETCHARFORMAT, $SCF_SELECTION, $tCharFormat, 0, "wparam", "struct*")

	Local $iEffects = DllStructGetData($tCharFormat, 3)

	Local $sStatesAndAtts = "", $sState, $bM, $bE
	For $i = 0 To UBound($aV, $UBOUND_ROWS) - 1
		$bM = BitAND($iMask, $aV[$i][1]) = $aV[$i][1]
		$bE = BitAND($iEffects, $aV[$i][2]) = $aV[$i][2]
		If $bM Then
			If $bE Then
				$sState = "+"
			Else
				$sState = "-"
			EndIf
		Else
			$sState = "~"
		EndIf
		If $sState <> "-" Then $sStatesAndAtts &= $aV[$i][0] & $sState
	Next
	Return $sStatesAndAtts
EndFunc   ;==>_GUICtrlRichEdit_GetDefaultAttributes

Func _playaya($i_surah, $i_ayah, $i__rec_id = Default, $s__rec_url = Default)
	If $i__rec_id = Default Then $i__rec_id = $i_reciterId
	If $s__rec_url = Default Then $s__rec_url = $s_recitersDir

	$i_surah = Int($i_surah)
	$i_ayah = Int($i_ayah)
	If ($i_surah < 1) Or ($i_ayah < 1) Then Return SetError(1, 0, -1)
	$i_surah = StringFormat("%03i", $i_surah)
	$i_ayah = StringFormat("%03i", $i_ayah)
	If FileExists(@ScriptDir & "\reciters\" & $i__rec_id & "\" & $i_surah & "\" & $i_ayah & ".mp3") Then
		Local $s_filename = @ScriptDir & "\reciters\" & $i__rec_id & "\" & $i_surah & "\" & $i_ayah & ".mp3"
		If Not ($s_last_played = $s_filename) Then
			_BASS_StreamFree($h_stream)
			$h_stream = _BASS_StreamCreateFile(False, $s_filename, 0, 0, 0)
			$s_last_played = $s_filename
			$i_repeated = 1
		Else
			If ($h_stream = -1) Then $h_stream = _BASS_StreamCreateFile(False, $s_filename, 0, 0, 0)
		EndIf
	Else
		Local $s_filename = $s__rec_url & $i_surah & "" & $i_ayah & ".mp3"
		If Not ($s_last_played = $s_filename) Then
			_BASS_StreamFree($h_stream)
			$h_stream = _BASS_StreamCreateUrl($s_filename, 0, 0)
			$s_last_played = $s_filename
			$i_repeated = 1
		Else
			If ($h_stream = -1) Then $h_stream = _BASS_StreamCreateUrl($s_filename, 0, 0)
		EndIf
	EndIf
	_BASS_ChannelPlay($h_stream, 1)
	_BASS_ChannelSetVolume($h_stream, $i_volume)
EndFunc   ;==>_playaya

Func _show_info_msg($s_msgtext, $s_title, $i_icon = 0)
	ToolTip($s_msgtext, MouseGetPos()[0], MouseGetPos()[1], $s_title, $i_icon, 3)
	AdlibRegister("_hide_info_msg", 3000)
EndFunc   ;==>_show_info_msg
Func _hide_info_msg()
	ToolTip("")
	AdlibUnRegister("_hide_info_msg")
EndFunc   ;==>_hide_info_msg
Func _set_center($i_from, $i_to, $i_font_size = 22)
	$a__crnt_sel = _GUICtrlRichEdit_GetSel($h_text)
	_GUICtrlRichEdit_SetSel($h_text, $i_from, $i_to)
	_GUICtrlRichEdit_SetParaAlignment($h_text, "c")
	_GUICtrlRichEdit_SetFont($h_text, $i_font_size)
	;_GUICtrlRichEdit_setSel($h_text, $a__crnt_sel[0], $a__crnt_sel[1])
EndFunc   ;==>_set_center
Func process_cmdLine()
	If $CMDLine[0] <> 2 Then Return SetError(1, 0, -1)
	For $i = 1 To $CMDLine[0]
		Switch $CMDLine[$i]
			Case "--dl"
				If $CMDLine[0] <= $i Then Return SetError(2, 0, -1)
				If Int($CMDLine[$i + 1]) < 1 Then Return SetError(3, 0, -1)
				_downloader(Int($CMDLine[$i + 1]))
				Exit
		EndSwitch
	Next
EndFunc   ;==>process_cmdLine
; Show a menu in a given GUI window which belongs to a given GUI ctrl
Func ShowMenu($hWnd, $idCtrl, $idContext)
	Local $aPos, $x, $y
	Local $hMenu = GUICtrlGetHandle($idContext)

	$aPos = ControlGetPos($hWnd, "", $idCtrl)

	$x = $aPos[0]
	$y = $aPos[1] + $aPos[3]

	ClientToScreen($hWnd, $x, $y)
	TrackPopupMenu($hWnd, $hMenu, $x, $y)
EndFunc   ;==>ShowMenu

; Convert the client (GUI) coordinates to screen (desktop) coordinates
Func ClientToScreen($hWnd, ByRef $x, ByRef $y)
	Local $tPoint = DllStructCreate("int;int")

	DllStructSetData($tPoint, 1, $x)
	DllStructSetData($tPoint, 2, $y)

	DllCall("user32.dll", "int", "ClientToScreen", "hwnd", $hWnd, "struct*", $tPoint)

	$x = DllStructGetData($tPoint, 1)
	$y = DllStructGetData($tPoint, 2)
	; release Struct not really needed as it is a local
	$tPoint = 0
EndFunc   ;==>ClientToScreen

; Show at the given coordinates (x, y) the popup menu (hMenu) which belongs to a given GUI window (hWnd)
Func TrackPopupMenu($hWnd, $hMenu, $x, $y)
	DllCall("user32.dll", "int", "TrackPopupMenuEx", "hwnd", $hMenu, "int", 0, "int", $x, "int", $y, "hwnd", $hWnd, "ptr", 0)
EndFunc   ;==>TrackPopupMenu
Func _check_fonts()
	If IsArray(_WinAPI_EnumFontFamilies(0, "KFGQPC Uthman Taha Naskh")) Then Return 1
	_WinAPI_AddFontResourceEx(@ScriptDir & "\fonts\naskh.otf", 0, True)
	_WinAPI_AddFontResourceEx(@ScriptDir & "\fonts\naskh_B.otf", 0, True)
	Return 1
EndFunc   ;==>_check_fonts

Func _CheckScreenReader()
	If Not (UniversalSpeech_cbrIsAvailable()) And (UniversalSpeech_dolIsAvailable()) And (UniversalSpeech_jfwIsAvailable()) And (UniversalSpeech_nvdaIsAvailable()) And (UniversalSpeech_weIsAvailable()) And (UniversalSpeech_ztIsAvailable()) Then Return False
	Return True
EndFunc   ;==>_CheckScreenReader
Func _load_utman()
	_SQLite_Close($h_db)
	$h_db = _SQLite_Open(@ScriptDir & "\database\Quran\uthmani.DB")
	If @error Then
		MsgBox(16, "error", "we can not load the data base")
		Exit (1)
	EndIf
	Return 1
EndFunc   ;==>_load_utman
Func _load_normal()
	_SQLite_Close($h_db)
	$h_db = _SQLite_Open(@ScriptDir & "\database\Quran\Quran.DB")
	If @error Then
		MsgBox(16, "error", "we can not load the data base")
		Exit (1)
	EndIf
	Return 1
EndFunc   ;==>_load_normal
Func _check_open_process()
	Local $Mutex_id = "qurani_v1.0.0.0"
	If _MutexExists($Mutex_id) Then
		MsgBox(16, "البرنامج يعمل بالفعل", "يبدو أن البرنامج بالفعل يعمل في الوقت الحالي, عليك غلق النسخة المفتوحة قبل محاولة فتحه من جديد.")
		Exit
	EndIf
	_MutexCreate($Mutex_id, $hMutex)
EndFunc   ;==>_check_open_process
