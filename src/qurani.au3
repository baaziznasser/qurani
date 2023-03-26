#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icons\qurani.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Res_Comment=برنامج القرآن الكريم
#AutoIt3Wrapper_Res_Description=قرآني
#AutoIt3Wrapper_Res_Fileversion=1.2.0.0
#AutoIt3Wrapper_Res_ProductName=قرآني
#AutoIt3Wrapper_Res_ProductVersion=1.2.0.0
#AutoIt3Wrapper_Res_CompanyName=nacer baaziz
#AutoIt3Wrapper_Res_LegalCopyright=copyright © 2023, nacer baaziz
#AutoIt3Wrapper_Res_Language=5121
#AutoIt3Wrapper_Run_AU3Check=n
#AutoIt3Wrapper_Run_Tidy=n
#AutoIt3Wrapper_Run_Au3Stripper=y
#Au3Stripper_Parameters=/sf /sv /rm /pe /tl
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;import the header file
#include <qurani_header.au3>

#set default options
Opt("GUICloseOnESC", 0)
Opt("GUIOnEventMode", 1)
Opt("GUIResizeMode", 1)

Global Enum $id_info = 1000, $id_tafsir, $id_e3rab, $id_tanzil, $id_copy
#build the main GUI
Global $h_Main = GUICreate("قرآني", 800, 700, -1, -1, BitOR($WS_HSCROLL, $WS_MAXIMIZEBOX, $WS_MINIMIZEBOX, $WS_SIZEBOX, $WS_SYSMENU, $WS_VSCROLL), $WS_EX_LAYOUTRTL)
GUISetHelp('hh.exe "' & @ScriptDir & '\Qurani.chm"')
GUISetIcon(@ScriptDir & "\icons\QURANI.ico")
GUISetOnEvent($GUI_event_close, "quit")

$h_main_Menu = GUICtrlCreateMenu("البرنامج")
$i_suwar = GUICtrlCreateMenuItem("السوَر (shift+1)", $h_main_Menu, -1, 1)
GUICtrlSetOnEvent(-1, "suras")
$i_pages = GUICtrlCreateMenuItem("الصفحات (shift+2)", $h_main_Menu, -1, 1)
GUICtrlSetOnEvent(-1, "pages")
$i_Quarter = GUICtrlCreateMenuItem("الأرباع (shift+3)", $h_main_Menu, -1, 1)
GUICtrlSetOnEvent(-1, "Quarter")
$i_ahzab = GUICtrlCreateMenuItem("الأحزاب (shift+4)", $h_main_Menu, -1, 1)
GUICtrlSetOnEvent(-1, "ahzab")
$i_ajzaa = GUICtrlCreateMenuItem("الأجزاء (shift+5)", $h_main_Menu, -1, 1)
GUICtrlSetOnEvent(-1, "ajzaa")
$i_custome = GUICtrlCreateMenuItem("مخصص (shift+6)", $h_main_Menu)
GUICtrlSetOnEvent(-1, "custome")
$i_save_pos = GUICtrlCreateMenuItem("حفظ الموضع الحالي (CTRL+s)", $h_main_Menu)
GUICtrlSetOnEvent(-1, "save_pos")
$i_psettings = GUICtrlCreateMenuItem("إعدادات البرنامج... (CTRL+O)", $h_main_Menu)
GUICtrlSetOnEvent(-1, "_settings_GUI")
$i_exit = GUICtrlCreateMenuItem("الخروج من البرنامج", $h_main_Menu)
GUICtrlSetOnEvent(-1, "quit")
$h_actions_menu = GUICtrlCreateMenu("إجراءات")
$i_ayah_info = GUICtrlCreateMenuItem("معلومات الآية الحالية... (CTRL+i)", $h_actions_menu)
GUICtrlSetOnEvent(-1, "_get_ayah_info")
$i_surah_info = GUICtrlCreateMenuItem("معلومات السورة الحالية... (CTRL+shift+i)", $h_actions_menu)
GUICtrlSetOnEvent(-1, "_get_surah_info")
$i_search = GUICtrlCreateMenuItem("البحث في القرآن الكريم... (CTRL+f)", $h_actions_menu)
GUICtrlSetOnEvent(-1, "_search_func")
$i_Copy = GUICtrlCreateMenuItem("نسخ المحدد (Ctrl+C)", $h_actions_menu)
GUICtrlSetOnEvent(-1, "_copy_selected")
$i_CopyFormated = GUICtrlCreateMenuItem("نسخ المحدد مع التنسيق", $h_actions_menu)
GUICtrlSetOnEvent(-1, "_copy_Format")
$i_CopyAyah = GUICtrlCreateMenuItem("نسخ الآية الحالية", $h_actions_menu)
GUICtrlSetOnEvent(-1, "_copy_ayah")
$i_SaveRTF = GUICtrlCreateMenuItem("حفظ النص في ملف RTF / TXT", $h_actions_menu)
GUICtrlSetOnEvent(-1, "_save_RTF")
$h_navmenu = GUICtrlCreateMenu("التصفح")
$i_nav_Go = GUICtrlCreateMenuItem("الذهاب إلى...", $h_navmenu)
GUICtrlSetOnEvent(-1, "nav_goto")
$i_nav_Next = GUICtrlCreateMenuItem("التالي (Alt+right)", $h_navmenu)
GUICtrlSetOnEvent(-1, "nav_next")
$i_nav_prev = GUICtrlCreateMenuItem("السابق (Alt+left)", $h_navmenu)
GUICtrlSetOnEvent(-1, "nav_prev")


$i_nav_gotoaya = GUICtrlCreateMenuItem("الذهاب إلى آية... (CTRL+shift+g)", $h_navmenu)
GUICtrlSetOnEvent(-1, "nav_goto_aya")
$i_nav_Next_aya = GUICtrlCreateMenuItem("الآية التالية (alt+shift+right)", $h_navmenu)
GUICtrlSetOnEvent(-1, "nav_next_aya")
$i_nav_prev_aya = GUICtrlCreateMenuItem("الآية السابقة (Alt+shift+left)", $h_navmenu)
GUICtrlSetOnEvent(-1, "nav_prev_aya")


$i_nav_quickaccess = GUICtrlCreateMenuItem("الوصول السريع", $h_navmenu)
GUICtrlSetOnEvent(-1, "quickAccess")

$h_tafsir = GUICtrlCreateMenu("تفسير القرآن")
$i_tafsir_aya = GUICtrlCreateMenuItem("تفسير الآية الحالية... (CTRL+T)", $h_tafsir)

GUICtrlSetOnEvent(-1, "tafsir_aya")
$i_tafsir_cust = GUICtrlCreateMenuItem("تفسير مخصص...", $h_tafsir)

GUICtrlSetOnEvent(-1, "tafsir_cust")
$h_tafsir_sel_menu = GUICtrlCreateMenu("التفسير المستخدم", $h_tafsir)
$i_tafsir_sel_muyassar = GUICtrlCreateMenuItem("التفسير المُيَسَّر", $h_tafsir_sel_menu, -1, 1)
If ReadSettings(".settings.tafsir", 1) = 1 Then GUICtrlSetState(-1, $GUI_checked)
GUICtrlSetOnEvent(-1, "tafsir_sel_muyassar")
$i_tafsir_sel_jalalayn = GUICtrlCreateMenuItem("تفسير الجلالين", $h_tafsir_sel_menu, -1, 1)
If ReadSettings(".settings.tafsir", 1) = 2 Then GUICtrlSetState(-1, $GUI_checked)
GUICtrlSetOnEvent(-1, "tafsir_sel_jalalayn")

$i_tafsir_sel_sa3dy = GUICtrlCreateMenuItem("تفسير السعدي", $h_tafsir_sel_menu, -1, 1)
If ReadSettings(".settings.tafsir", 1) = 3 Then GUICtrlSetState(-1, $GUI_checked)
GUICtrlSetOnEvent(-1, "tafsir_sel_sa3dy")

$i_tafsir_sel_katheer = GUICtrlCreateMenuItem("تفسير ابن كثير", $h_tafsir_sel_menu, -1, 1)
If ReadSettings(".settings.tafsir", 1) = 4 Then GUICtrlSetState(-1, $GUI_checked)
GUICtrlSetOnEvent(-1, "tafsir_sel_katheer")
$i_tafsir_sel_qortoby = GUICtrlCreateMenuItem("تفسير القُرطُبِي", $h_tafsir_sel_menu, -1, 1)
If ReadSettings(".settings.tafsir", 1) = 5 Then GUICtrlSetState(-1, $GUI_checked)
GUICtrlSetOnEvent(-1, "tafsir_sel_qortoby")

$i_tafsir_sel_tabary = GUICtrlCreateMenuItem("تفسير الطبري", $h_tafsir_sel_menu, -1, 1)
If ReadSettings(".settings.tafsir", 1) = 6 Then GUICtrlSetState(-1, $GUI_checked)
GUICtrlSetOnEvent(-1, "tafsir_sel_tabary")
$i_tafsir_sel_baghawy = GUICtrlCreateMenuItem("تفسير البغوي", $h_tafsir_sel_menu, -1, 1)
If ReadSettings(".settings.tafsir", 1) = 7 Then GUICtrlSetState(-1, $GUI_checked)
GUICtrlSetOnEvent(-1, "tafsir_sel_baghawy")


$i_e3rab = GUICtrlCreateMenuItem("إعراب الآية الحالية... (ctrl+e)", $h_tafsir)

GUICtrlSetOnEvent(-1, "e3rab_ayah")
$i_tanzil = GUICtrlCreateMenuItem("أسباب نزول  الآية الحالية... (ctrl+r)", $h_tafsir)
GUICtrlSetOnEvent(-1, "asbab_elnozol")

$h_menuPlayer = GUICtrlCreateMenu("المشغل الصوتي")
$i_play_aya = GUICtrlCreateMenuItem("الإستماع إلى الآية الحالية (CTRL+p)", $h_menuPlayer)
GUICtrlSetOnEvent(-1, "_play_this_ayah")
$i_play_toend = GUICtrlCreateMenuItem("الإستماع إلى آخر الصفحة (CTRL+shift+p)", $h_menuPlayer)
GUICtrlSetOnEvent(-1, "_play_to_end")
$i_setvolume_up = GUICtrlCreateMenuItem("رفع حجم الصوت (F8)", $h_menuPlayer)
GUICtrlSetOnEvent(-1, "_set_volumeUp")
$i_setvolume_Down = GUICtrlCreateMenuItem("خفض حجم الصوت (F7)", $h_menuPlayer)
GUICtrlSetOnEvent(-1, "_set_volumedown")
$i_manage_reciters = GUICtrlCreateMenuItem("إدارة القراء... (CTRL+shift+e)", $h_menuPlayer)
GUICtrlSetOnEvent(-1, "reciters_Manager")
$i_manage_repetition = GUICtrlCreateMenuItem("إدارة التكرار... (CTRL+Shift+t)", $h_menuPlayer)
GUICtrlSetOnEvent(-1, "_manage_repetition")

$h_menuDisplay = GUICtrlCreateMenu("العرض")
$i_dispSetFont = GUICtrlCreateMenuItem("تغيير الخط...", $h_menuDisplay)
GUICtrlSetOnEvent(-1, "_setfont")
$i_dispSetCol = GUICtrlCreateMenuItem("تغيير لون النص...", $h_menuDisplay)
GUICtrlSetOnEvent(-1, "_setColor")
$i_dispSetBCCol = GUICtrlCreateMenuItem("تغيير لون الخلفية...", $h_menuDisplay)
GUICtrlSetOnEvent(-1, "_setBkGColor")
$h_help_menu = GUICtrlCreateMenu("مساعدة")
$i_HelpFile = GUICtrlCreateMenuItem("فتح ملف المساعدة... (F1)", $h_help_menu)
GUICtrlSetOnEvent(-1, "_helpFile")
$h_contactitem = GUICtrlCreateMenu("التواصل مع مطور البرنامج", $h_help_menu)
$i_telg = GUICtrlCreateMenuItem("مراسلتي على telegram", $h_contactitem)
GUICtrlSetOnEvent(-1, "_telegram_contact")
$i_Whsp = GUICtrlCreateMenuItem("مراسلتي على whatsapp", $h_contactitem)
GUICtrlSetOnEvent(-1, "_Whatsapp_contact")
$i_me = GUICtrlCreateMenuItem("مراسلتي على facebook messenger", $h_contactitem)
GUICtrlSetOnEvent(-1, "_messenger_contact")
$i_fb = GUICtrlCreateMenuItem("حسابي على facebook", $h_contactitem)
GUICtrlSetOnEvent(-1, "_Facebook_contact")
$i_mail = GUICtrlCreateMenuItem("نسخ بريدي الإلكتروني إلى الحافظة", $h_contactitem)
GUICtrlSetOnEvent(-1, "_mail_contact")
$i_github = GUICtrlCreateMenuItem("زيارة صفحتي على github", $h_contactitem)
GUICtrlSetOnEvent(-1, "_github")
$i_WebSiteitem = GUICtrlCreateMenuItem("زيارة موقع البرنامج على الأنترنت...", $h_help_menu)
GUICtrlSetOnEvent(-1, "_goto_website")
$i_update_check = GUICtrlCreateMenuItem("البحث عن التحديثات...", $h_help_menu)
GUICtrlSetOnEvent(-1, "_checkUpdate")
$i_aboutitem = GUICtrlCreateMenuItem("عن البرنامج...", $h_help_menu)
GUICtrlSetOnEvent(-1, "_about_msg")
$i_nav_prev_btn = GUICtrlCreateButton("السابق", 620, 520, 110, 30)
GUICtrlSetOnEvent(-1, "nav_prev")
GUICtrlSetResizing(-1, 1)

GUIStartGroup("")

$i_title = GUICtrlCreateLabel("الصفحة 1", 150, 20, 400, 20, $SS_CENTER)
GUICtrlSetFont(-1, 18, 700, 0, "Times New Roman")
GUICtrlSetResizing(-1, 1)
GUIStartGroup("")
$h_text = _GUICtrlRichEdit_Create($h_Main, "", 20, 40, 760, 400, BitOR($ES_MULTILINE, $WS_VSCROLL, $ES_AUTOVSCROLL, 0x8000))
;_GUICtrlSetResizingEx($h_text, 1)
_GUICtrlRichEdit_SetRECT($h_text, 50, 50, 50, 50)

_setdefault_font()
setBkGColor()

_GUICtrlRichEdit_SetReadOnly($h_text, True)

$i_lblsizetoset = GUICtrlCreateLabel("", 20, 40, 760, 400)
GUICtrlSetState(-1, $GUI_disable)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetResizing(-1, 1)
$h_ContextMenu = GUICtrlCreateContextMenu($i_lblsizetoset)
GUICtrlCreateMenuItem("معلومات الآية الحالية", $h_ContextMenu)
GUICtrlSetOnEvent(-1, "_get_ayah_info")

GUICtrlCreateMenuItem("تفسير الآية الحالية", $h_ContextMenu)
GUICtrlSetOnEvent(-1, "tafsir_aya")
GUICtrlCreateMenuItem("إعراب الآية الحالية", $h_ContextMenu)
GUICtrlSetOnEvent(-1, "e3rab_ayah")
GUICtrlCreateMenuItem("أسباب نزول الآية الحالية", $h_ContextMenu)
GUICtrlSetOnEvent(-1, "asbab_elnozol")
GUICtrlCreateMenuItem("نسخ الآية الحالية", $h_ContextMenu)
GUICtrlSetOnEvent(-1, "_copy_ayah")

GUIStartGroup("")
$i_vlmdown = GUICtrlCreateIcon(@ScriptDir & "\icons\volume-.ico", -1, 75, 470, 35, 30)
_WinAPI_SetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE, BitAND(_WinAPI_GetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE), BitNOT($WS_TABSTOP)))
GUICtrlSetOnEvent(-1, "_set_volumedown")
GUICtrlSetResizing(-1, 1)
$i_vlmslider = GUICtrlCreateSlider(120, 470, 80, 30, $TBS_NOTHUMB)
_WinAPI_SetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE, BitAND(_WinAPI_GetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE), BitNOT($WS_TABSTOP)))
GUICtrlSetOnEvent(-1, "_set_volume")
GUICtrlSetLimit(-1, 200, 0)
GUICtrlSetData(-1, 100)
GUICtrlSetResizing(-1, 1)
$i_vlmup = GUICtrlCreateIcon(@ScriptDir & "\icons\volume+.ico", -1, 325, 470, 35, 30)
_WinAPI_SetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE, BitAND(_WinAPI_GetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE), BitNOT($WS_TABSTOP)))
GUICtrlSetOnEvent(-1, "_set_volumeup")
GUICtrlSetResizing(-1, 1)
$i_next_icon = GUICtrlCreateIcon(@ScriptDir & "\icons\next.ico", -1, 490, 470, 40, 30)
_WinAPI_SetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE, BitAND(_WinAPI_GetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE), BitNOT($WS_TABSTOP)))
GUICtrlSetOnEvent(-1, "nav_next_aya")
GUICtrlSetResizing(-1, 1)
$i_play_icon = GUICtrlCreateIcon(@ScriptDir & "\icons\play.ico", -1, 540, 470, 40, 30)
_WinAPI_SetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE, BitAND(_WinAPI_GetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE), BitNOT($WS_TABSTOP)))
GUICtrlSetOnEvent(-1, "_play_to_end")
GUICtrlSetResizing(-1, 1)
$i_back_icon = GUICtrlCreateIcon(@ScriptDir & "\icons\back.ico", -1, 590, 470, 40, 30)
_WinAPI_SetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE, BitAND(_WinAPI_GetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE), BitNOT($WS_TABSTOP)))
GUICtrlSetOnEvent(-1, "nav_prev_aya")
GUICtrlSetResizing(-1, 1)
GUIStartGroup("")
$i_nav_next_btn = GUICtrlCreateButton("التالي", 40, 520, 110, 30)
GUICtrlSetOnEvent(-1, "nav_next")
GUICtrlSetResizing(-1, 1)
GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
GUIStartGroup("")
$i_Tafsir_BTN = GUICtrlCreateButton("تفسير الآية الحالية", 150, 520, 140, 30)
GUICtrlSetOnEvent(-1, "tafsir_aya")
GUICtrlSetResizing(-1, 1)
GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
$i_e3rab_btn = GUICtrlCreateButton("إعراب الآية الحالية", 300, 520, 140, 30)
GUICtrlSetOnEvent(-1, "e3rab_ayah")
GUICtrlSetResizing(-1, 1)
GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
$i_tanzil_btn = GUICtrlCreateButton("أسباب نزول الآية الحالية", 450, 520, 160, 30)
GUICtrlSetOnEvent(-1, "asbab_elnozol")
GUICtrlSetResizing(-1, 1)
GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
GUIStartGroup("")
$i_savepos_btn = GUICtrlCreateButton("حفظ الموضع الحالي", 410, 560, 180, 30)
GUICtrlSetOnEvent(-1, "save_pos")
GUICtrlSetResizing(-1, 1)
GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
$i_Search_btn = GUICtrlCreateButton("البحث في القرآن الكريم", 210, 560, 180, 30)
GUICtrlSetOnEvent(-1, "_search_func")
GUICtrlSetResizing(-1, 1)
GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
$i_nav_quickaccessBTN = GUICtrlCreateButton("الوصول السريع", 40, 560, 150, 30)
GUICtrlSetOnEvent(-1, "quickAccess")
GUICtrlSetResizing(-1, 1)
GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
$i_Settings = GUICtrlCreateButton("إعدادات البرنامج...", 610, 560, 150, 30)
GUICtrlSetOnEvent(-1, "_settings_GUI")
GUICtrlSetResizing(-1, 1)
GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
If Not (Restore_pos()) Then
	Switch ReadSettings(".settings.opento", 1)
		Case 0
			$i_crnt_type = 1
			$i_crnt_Num = 1
			$i_CRNt_Max = 114
			_GUICtrlRichEdit_SetText($h_text, read_sura(1))
			GUICtrlSetData($i_title, $a_currentlist[1][3])
			GUICtrlSetState($i_suwar, $GUI_checked)
		Case 1
			$i_crnt_type = 2
			$i_crnt_Num = 1
			$i_CRNt_Max = 604
			_GUICtrlRichEdit_SetText($h_text, read_page(1))
			GUICtrlSetData($i_title, "الصفحة " & $i_crnt_Num)
			GUICtrlSetState($i_pages, $GUI_checked)
		Case 2
			$i_crnt_type = 5
			$i_crnt_Num = 1
			$i_CRNt_Max = 240
			_GUICtrlRichEdit_SetText($h_text, read_Quarter($i_crnt_Num))
			GUICtrlSetData($i_title, "الربع " & $i_crnt_Num)
			GUICtrlSetState($i_Quarter, $GUI_checked)
		Case 3
			$i_crnt_type = 3
			$i_crnt_Num = 1
			$i_CRNt_Max = 60
			_GUICtrlRichEdit_SetText($h_text, read_hizb($i_crnt_Num))
			GUICtrlSetData($i_title, "الحزب " & $i_crnt_Num)
			GUICtrlSetState($i_ahzab, $GUI_checked)
		Case 4
			$i_crnt_type = 4
			$i_crnt_Num = 1
			$i_CRNt_Max = 60
			_GUICtrlRichEdit_SetText($h_text, read_juz($i_crnt_Num))
			GUICtrlSetData($i_title, "الجزء " & $i_crnt_Num)
			GUICtrlSetState($i_ajzaa, $GUI_checked)
	EndSwitch

	For $i = 1 To $a_tocenter[0][0]
		_set_center($a_tocenter[$i][0], $a_tocenter[$i][1], $a_tocenter[$i][2])
	Next

	;	_GUICtrlRichEdit_GotoCharPos($h_text, 0)
EndIf
;_GUICtrlRichEdit_SetSel($h_text, 0, -1)
;_GUICtrlRichEdit_SetRECT($h_text, 100, 100, 100, 100)
$dum_getinfo = GUICtrlCreateDummy()
GUICtrlSetOnEvent(-1, "_speak_surah_name")
$i_dm_read_next_word = GUICtrlCreateDummy()
GUICtrlSetOnEvent(-1, "_speak_next_word")
$i_dm_read_Prev_word = GUICtrlCreateDummy()
GUICtrlSetOnEvent(-1, "_speak_Prev_word")
Dim $ack_table = [["+1", $i_suwar], ["+2", $i_pages], ["+3", $i_Quarter], ["+4", $i_ahzab], ["+5", $i_ajzaa], ["+6", $i_custome], ["^s", $i_save_pos], ["^o", $i_psettings], ["^f", $i_search], ["!{right}", $i_nav_Next], ["!{left}", $i_nav_prev], ["^g", $i_nav_Go], ["i", $dum_getinfo], ["+!{right}", $i_nav_Next_aya], ["+!{left}", $i_nav_prev_aya], ["^+g", $i_nav_gotoaya], ["^t", $i_tafsir_aya], ["^e", $i_e3rab], ["^r", $i_tanzil_btn], ["^q", $i_nav_quickaccess], ["^p", $i_play_aya], ["{f5}", $i_play_aya], ["^+p", $i_play_toend], ["{f6}", $i_play_toend], ["{f7}", $i_setvolume_Down], ["{f8}", $i_setvolume_up], ["^+s", $i_SaveRTF], ["^i", $i_ayah_info], ["^+i", $i_surah_info], ["^+e", $i_manage_reciters], ["^+t", $i_manage_repetition]]
GUISetState(@SW_SHOW, $h_Main)
;	GUICtrlSetState($h_text, $GUI_focus)
_basmala()
If GetKeyBord() = "arabic" Then
	Local $aDataInput = _WinAPI_GetKeyboardLayoutList()
	If IsArray($aDataInput) Then
		BlockInput($BI_DISABLE)
		For $i = 1 To $aDataInput[0]
			Send("{ALTDOWN}{LSHIFT}")
			Send("{ALTUP}")

			If Not (GetKeyBord() = "arabic") Then ExitLoop
		Next
		BlockInput($BI_enable)
	EndIf
EndIf
GUISetAccelerators($ack_table)
$s_crntKeyboardLNG = GetKeyBord()
$b_txt_focus = True
$i_prev_pos = 0
$i_sel_pos = -1

GUIRegisterMsg($WM_SIZE, "_WM_SIZE")
$b_is_playing = False
GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")
_GUICtrlRichEdit_SetEventMask($h_text, BitOR($ENM_KEYEVENTS, $ENM_LINK, $ENM_MOUSEEVENTS))

While 1
	If Not (GetKeyBord() = $s_crntKeyboardLNG) And ($s_crntKeyboardLNG = "arabic") Then
		GUISetAccelerators($ack_table)
		$s_crntKeyboardLNG = GetKeyBord()
	EndIf

	If ($b_is_playing) And (_BASS_ChannelIsActive($h_stream) = $BASS_ACTIVE_STOPPED) Then
		$b_is_playing = False
		GUICtrlSetImage($i_play_icon, @ScriptDir & "\icons\play.ico", -1)
	ElseIf (_BASS_ChannelIsActive($h_stream)) And Not ($b_is_playing) Then
		$b_is_playing = True
		GUICtrlSetImage($i_play_icon, @ScriptDir & "\icons\stop.ico", -1)
	EndIf

	Sleep(1000)
WEnd

Func Quit()
	If Not ($b_savedpos) Then
		If readSettings(".settings.restorelastpos", 0) = 1 Then
			save_pos()
		EndIf
	EndIf
	_SQLite_Close($h_db)
	_SQLite_Shutdown()
	Exit
EndFunc   ;==>Quit
Func _WM_SIZE($hWnd, $iMsg, $wParam, $lParam)
	If $hWnd = $h_Main Then
		AdlibRegister("_resize_rich")
	EndIf

EndFunc   ;==>_WM_SIZE
Func _resize_rich()
	_WinAPI_RedrawWindow($h_Main)
	; Get the new position and size of the labels
	$aPos_1 = ControlGetPos($h_Main, "", $i_lblsizetoset)

	$xpos = Int($aPos_1[0] - $aPos_1[2])
	ControlMove($h_Main, "", $h_text, $xpos, Int($aPos_1[1]), Int($aPos_1[2]), Int($aPos_1[3]))

	AdlibUnRegister("_resize_rich")
	_WinAPI_RedrawWindow($h_Main)
EndFunc   ;==>_resize_rich
Func _copy_selected()
	$s_text = _GUICtrlRichEdit_GetSelText($h_text)
	ClipPut($s_text)
	Return 1
EndFunc   ;==>_copy_selected
Func _copy_Format()
	Return _GUICtrlRichEdit_Copy($h_text)
EndFunc   ;==>_copy_Format
Func _copy_ayah()
	_get_aya()
	$s_text = _GUICtrlRichEdit_GetTextInRange($h_text, $a_currentlist[$i_last_aya][0], $a_currentlist[$i_last_aya][1])
	ClipPut($s_text)
EndFunc   ;==>_copy_ayah
Func _save_RTF()
	$s_fileopen_dlg = FileSaveDialog("إختر مكان الحفظ", @WorkingDir, "ملف RTF (*.RTF)|ملف نصي (*.TXT)", BitOR($FD_PATHMUSTEXIST, $FD_PROMPTOVERWRITE), GUICtrlRead($i_title), $h_Main)
	If @error Then Return -1
	_GUICtrlRichEdit_SetSel($h_text, 0, -1)
	If _GetFileExt($s_fileopen_dlg, False) = "RTF" Then
		_GUICtrlRichEdit_StreamToFile($h_text, $s_fileopen_dlg, True, 0, False)
	Else
		$s_text = _GUICtrlRichEdit_GetText($h_text, True, 1200)
		$h_open = FileOpen($s_fileopen_dlg, BitOR($FO_UTF8, $FO_OVERWRITE, $FO_CREATEPATH))
		FileWrite($h_open, $s_text)
		FileClose($h_open)
	EndIf


EndFunc   ;==>_save_RTF
Func _set_volume()
	$i_volume = GUICtrlRead($i_vlmslider)
	If (_BASS_ChannelIsActive($h_stream)) Then
		_BASS_ChannelSetVolume($h_stream, $i_volume)
	EndIf
EndFunc   ;==>_set_volume
Func _set_volumeUp()
	If $i_volume >= 200 Then
		$i_volume = 200
	Else
		$i_volume += 5
	EndIf
	GUICtrlSetData($i_vlmslider, $i_volume)
	If (_BASS_ChannelIsActive($h_stream)) Then
		_BASS_ChannelSetVolume($h_stream, $i_volume)
	EndIf
	If $b_accessibility Then UniversalSpeech_SpeechSay(Round($i_volume / 2) & "%", 1)
EndFunc   ;==>_set_volumeUp
Func _set_volumedown()
	If $i_volume <= 0 Then
		$i_volume = 0
	Else
		$i_volume -= 5
	EndIf
	GUICtrlSetData($i_vlmslider, $i_volume)
	If (_BASS_ChannelIsActive($h_stream)) Then
		_BASS_ChannelSetVolume($h_stream, $i_volume)
	EndIf
	If $b_accessibility Then UniversalSpeech_SpeechSay(Round($i_volume / 2) & "%", 1)
EndFunc   ;==>_set_volumedown

Func nav_next()
	If $i_crnt_Num + 1 > $i_CRNt_Max Then $i_crnt_Num = 0
	;	GUICtrlSetState($h_text, $GUI_focus)
	$i_crnt_Num += 1
	If $i_crnt_Num >= $i_CRNt_Max Then
		$i_crnt_Num = $i_CRNt_Max
	EndIf


	If $i_crnt_type = 1 Then
		_GUICtrlRichEdit_SetText($h_text, read_sura($i_crnt_Num))
		GUICtrlSetData($i_title, $a_currentlist[1][3])
		If $b_accessibility Then UniversalSpeech_SpeechSay(GUICtrlRead($i_title), 1)
	ElseIf $i_crnt_type = 2 Then
		GUICtrlSetData($i_title, "الصفحة " & $i_crnt_Num)
		If $b_accessibility Then UniversalSpeech_SpeechSay(GUICtrlRead($i_title), 1)
		_GUICtrlRichEdit_SetText($h_text, read_page($i_crnt_Num))
	ElseIf $i_crnt_type = 3 Then
		GUICtrlSetData($i_title, "الحزب " & $i_crnt_Num)
		If $b_accessibility Then UniversalSpeech_SpeechSay(GUICtrlRead($i_title), 1)
		_GUICtrlRichEdit_SetText($h_text, read_hizb($i_crnt_Num))
	ElseIf $i_crnt_type = 4 Then
		GUICtrlSetData($i_title, "الجزء " & $i_crnt_Num)
		If $b_accessibility Then UniversalSpeech_SpeechSay(GUICtrlRead($i_title), 1)
		_GUICtrlRichEdit_SetText($h_text, read_juz($i_crnt_Num))
	ElseIf $i_crnt_type = 5 Then
		GUICtrlSetData($i_title, "الربع " & $i_crnt_Num)
		If $b_accessibility Then UniversalSpeech_SpeechSay(GUICtrlRead($i_title), 1)
		_GUICtrlRichEdit_SetText($h_text, read_quarter($i_crnt_Num))
	EndIf

	For $i = 1 To $a_tocenter[0][0]
		_set_center($a_tocenter[$i][0], $a_tocenter[$i][1], $a_tocenter[$i][2])
	Next


	_GUICtrlRichEdit_GotoCharPos($h_text, 0)
	$i_prev_pos = 0
EndFunc   ;==>nav_next

Func nav_prev()
	If $i_crnt_Num - 1 < 1 Then $i_crnt_Num = $i_CRNt_Max + 1
	;	GUICtrlSetState($h_text, $GUI_focus)
	$i_crnt_Num -= 1
	If $i_crnt_Num <= 1 Then
		$i_crnt_Num = 1
	EndIf


	If $i_crnt_type = 1 Then

		_GUICtrlRichEdit_SetText($h_text, read_sura($i_crnt_Num))
		GUICtrlSetData($i_title, $a_currentlist[1][3])
		If $b_accessibility Then UniversalSpeech_SpeechSay(GUICtrlRead($i_title), 1)
	ElseIf $i_crnt_type = 2 Then
		GUICtrlSetData($i_title, "الصفحة " & $i_crnt_Num)
		If $b_accessibility Then UniversalSpeech_SpeechSay(GUICtrlRead($i_title), 1)
		_GUICtrlRichEdit_SetText($h_text, read_page($i_crnt_Num))
	ElseIf $i_crnt_type = 3 Then
		GUICtrlSetData($i_title, "الحزب " & $i_crnt_Num)
		If $b_accessibility Then UniversalSpeech_SpeechSay(GUICtrlRead($i_title), 1)
		_GUICtrlRichEdit_SetText($h_text, read_hizb($i_crnt_Num))
	ElseIf $i_crnt_type = 4 Then
		GUICtrlSetData($i_title, "الجزء " & $i_crnt_Num)
		If $b_accessibility Then UniversalSpeech_SpeechSay(GUICtrlRead($i_title), 1)
		_GUICtrlRichEdit_SetText($h_text, read_juz($i_crnt_Num))
	ElseIf $i_crnt_type = 5 Then
		GUICtrlSetData($i_title, "الربع " & $i_crnt_Num)
		If $b_accessibility Then UniversalSpeech_SpeechSay(GUICtrlRead($i_title), 1)
		_GUICtrlRichEdit_SetText($h_text, read_quarter($i_crnt_Num))
	EndIf

	For $i = 1 To $a_tocenter[0][0]
		_set_center($a_tocenter[$i][0], $a_tocenter[$i][1], $a_tocenter[$i][2])
	Next


	_GUICtrlRichEdit_GotoCharPos($h_text, 0)
	$i_prev_pos = 0
EndFunc   ;==>nav_prev
Func nav_goto()
	Do
		$i_navinp = InputBox("الذهاب إلى", "الرجاء اختيار رقم بين 1 و " & $i_CRNt_Max, $i_crnt_Num, " m", -1, -1, Default, Default, 0, $h_Main)
		If @error Then Return 0
		If Not (IsInt($i_navinp)) Then ContinueLoop
	Until ($i_navinp >= 1) And ($i_navinp <= $i_CRNt_Max)
	$i_crnt_Num = $i_navinp
	If $i_crnt_type = 1 Then
		_GUICtrlRichEdit_SetText($h_text, read_sura($i_crnt_Num))
		GUICtrlSetData($i_title, $a_currentlist[1][3])
	ElseIf $i_crnt_type = 2 Then
		_GUICtrlRichEdit_SetText($h_text, read_page($i_crnt_Num))
		GUICtrlSetData($i_title, "الصفحة " & $i_crnt_Num)
	ElseIf $i_crnt_type = 3 Then
		_GUICtrlRichEdit_SetText($h_text, read_hizb($i_crnt_Num))
		GUICtrlSetData($i_title, "الحزب " & $i_crnt_Num)
	ElseIf $i_crnt_type = 4 Then
		_GUICtrlRichEdit_SetText($h_text, read_juz($i_crnt_Num))
		GUICtrlSetData($i_title, "الجزء " & $i_crnt_Num)
	ElseIf $i_crnt_type = 5 Then
		_GUICtrlRichEdit_SetText($h_text, read_quarter($i_crnt_Num))
		GUICtrlSetData($i_title, "الربع " & $i_crnt_Num)

	EndIf

	For $i = 1 To $a_tocenter[0][0]
		_set_center($a_tocenter[$i][0], $a_tocenter[$i][1], $a_tocenter[$i][2])
	Next


	_GUICtrlRichEdit_GotoCharPos($h_text, 0)
	$i_prev_pos = 0
	GUICtrlSetState($h_text, $GUI_focus)
	If $b_accessibility Then UniversalSpeech_SpeechSay(GUICtrlRead($i_title), 1)
EndFunc   ;==>nav_goto
Func suras()
	If $i_crnt_type = 1 Then Return 0
	$i_crnt_type = 1
	$i_crnt_Num = 1
	$i_CRNt_Max = 114
	If $b_accessibility Then UniversalSpeech_SpeechSay("السور", 1)
	_GUICtrlRichEdit_SetText($h_text, read_sura($i_crnt_Num))
	GUICtrlSetData($i_title, $a_currentlist[1][3])

	For $i = 1 To $a_tocenter[0][0]
		_set_center($a_tocenter[$i][0], $a_tocenter[$i][1], $a_tocenter[$i][2])
	Next


	GUICtrlSetState($h_text, $GUI_focus)
	$i_prev_pos = 0
	Return 1

EndFunc   ;==>suras

Func pages()
	If $i_crnt_type = 2 Then Return 0
	$i_crnt_type = 2
	$i_crnt_Num = 1
	$i_CRNt_Max = 604
	If $b_accessibility Then UniversalSpeech_SpeechSay("الصفحات", 1)
	_GUICtrlRichEdit_SetText($h_text, read_page($i_crnt_Num))
	GUICtrlSetData($i_title, "الصفحة " & $i_crnt_Num)

	For $i = 1 To $a_tocenter[0][0]
		_set_center($a_tocenter[$i][0], $a_tocenter[$i][1], $a_tocenter[$i][2])
	Next



	GUICtrlSetState($h_text, $GUI_focus)
	$i_prev_pos = 0
	Return 1
EndFunc   ;==>pages
Func Quarter()
	If $i_crnt_type = 5 Then Return 0
	$i_crnt_type = 5
	$i_crnt_Num = 1
	$i_CRNt_Max = 240
	If $b_accessibility Then UniversalSpeech_SpeechSay("الأرباع", 1)
	_GUICtrlRichEdit_SetText($h_text, read_Quarter($i_crnt_Num))
	GUICtrlSetData($i_title, "الربع " & $i_crnt_Num)

	For $i = 1 To $a_tocenter[0][0]
		_set_center($a_tocenter[$i][0], $a_tocenter[$i][1], $a_tocenter[$i][2])
	Next

	GUICtrlSetState($h_text, $GUI_focus)
	$i_prev_pos = 0
	Return 1
EndFunc   ;==>Quarter

Func ahzab()
	If $i_crnt_type = 3 Then Return 0
	$i_crnt_type = 3
	$i_crnt_Num = 1
	$i_CRNt_Max = 60
	If $b_accessibility Then UniversalSpeech_SpeechSay("الأحزاب", 1)
	_GUICtrlRichEdit_SetText($h_text, read_hizb($i_crnt_Num))
	GUICtrlSetData($i_title, "الحزب " & $i_crnt_Num)

	For $i = 1 To $a_tocenter[0][0]
		_set_center($a_tocenter[$i][0], $a_tocenter[$i][1], $a_tocenter[$i][2])
	Next


	GUICtrlSetState($h_text, $GUI_focus)
	$i_prev_pos = 0
	Return 1
EndFunc   ;==>ahzab
Func ajzaa()
	If $i_crnt_type = 4 Then Return 0
	$i_crnt_type = 4
	$i_crnt_Num = 1
	$i_CRNt_Max = 30
	If $b_accessibility Then UniversalSpeech_SpeechSay("الأجزاء", 1)
	_GUICtrlRichEdit_SetText($h_text, read_juz($i_crnt_Num))
	GUICtrlSetData($i_title, "الجزء " & $i_crnt_Num)

	For $i = 1 To $a_tocenter[0][0]
		_set_center($a_tocenter[$i][0], $a_tocenter[$i][1], $a_tocenter[$i][2])
	Next



	GUICtrlSetState($h_text, $GUI_focus)
	$i_prev_pos = 0
	Return 1

EndFunc   ;==>ajzaa
Func custome()
	Opt("GUICloseOnESC", 1)
	Opt("GUIOnEventMode", 0)
	GUISetState(@SW_DISABLE, $h_Main)
	Local $h_custGUI = GUICreate("عرض مخصص", 400, 300, -1, -1, BitOR($WS_SYSMENU, $WS_CLIPCHILDREN, $WS_CLIPSIBLINGS, $WS_MAXIMIZEBOX, $WS_MINIMIZEBOX, $WS_SIZEBOX, $WS_SYSMENU), BitOR($WS_EX_LAYOUTRTL, $WS_EX_MDICHILD), $h_Main)
	GUICtrlCreateGroup("من", 10, 10, 380, 70)
	GUICtrlSetFont(-1, 14, 700, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	GUICtrlCreateLabel("السورة:", 20, 20, 200, 20)
	GUICtrlSetFont(-1, 16, 700, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	Local $i_combo_from_surahs = GUICtrlCreateCombo("", 20, 40, 200, 30, BitOR($GUI_SS_DEFAULT_COMBO, $CBS_DROPDOWNLIST))
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	GUICtrlCreateLabel("الآية:", 230, 20, 140, 20)
	GUICtrlSetFont(-1, 14, 700, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	Local $i_combo_Ayahs_from = GUICtrlCreateInput("", 230, 40, 140, 30, $es_number)

	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	Local $i_updown_from_ayas = GUICtrlCreateUpdown($i_combo_Ayahs_from, $UDS_ARROWKEYS)

	GUICtrlCreateGroup("إلى", 10, 100, 380, 70)
	GUICtrlSetFont(-1, 14, 700, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	GUICtrlCreateLabel("السورة:", 20, 110, 200, 20)
	GUICtrlSetFont(-1, 16, 700, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	Local $i_combo_to_surahs = GUICtrlCreateCombo("", 20, 130, 200, 30, BitOR($GUI_SS_DEFAULT_COMBO, $CBS_DROPDOWNLIST))
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	GUICtrlCreateLabel("الآية:", 230, 110, 140, 20)
	GUICtrlSetFont(-1, 16, 700, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	Local $i_combo_Ayahs_to = GUICtrlCreateInput("", 230, 130, 140, 30, $es_number)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	Local $i_updown_To_ayas = GUICtrlCreateUpdown($i_combo_Ayahs_to, $UDS_ARROWKEYS)
	If IsArray($a_surahs_meta) Then

		For $item In $a_surahs_meta
			GUICtrlSetData($i_combo_from_surahs, Json_get($item, ".number") & ". " & Json_get($item, ".name"))
			GUICtrlSetData($i_combo_to_surahs, Json_get($item, ".number") & ". " & Json_get($item, ".name"))
		Next
		_GUICtrlComboBox_SetCurSel($i_combo_from_surahs, 0)
		_GUICtrlComboBox_SetCurSel($i_combo_to_surahs, 0)
		GUICtrlSetLimit($i_updown_from_ayas, Json_get($a_surahs_meta[0], ".numberOfAyahs"), 1)
		GUICtrlSetLimit($i_updown_To_ayas, Json_get($a_surahs_meta[0], ".numberOfAyahs"), 1)

		GUICtrlSetData($i_combo_Ayahs_from, 1)
		GUICtrlSetData($i_combo_Ayahs_to, Json_get($a_surahs_meta[0], ".numberOfAyahs"))
		GUICtrlSetLimit($i_combo_Ayahs_from, StringLen(Json_get($a_surahs_meta[0], ".numberOfAyahs")))
		GUICtrlSetLimit($i_combo_Ayahs_to, StringLen(Json_get($a_surahs_meta[0], ".numberOfAyahs")))
	EndIf
	Local $i_cust_BTN = GUICtrlCreateButton("&فتح", 10, 180, 180, 30, 0x01)
	GUICtrlSetResizing(-1, 1)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	Local $i_Cancel_cust_btn = GUICtrlCreateButton("إل&غاء", 200, 180, 180, 30)
	GUICtrlSetResizing(-1, 1)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUISetState(@SW_SHOW, $h_custGUI)


	While 1
		Switch GUIGetMsg()
			Case $GUI_event_close, $i_Cancel_cust_btn
				GUIDelete($h_custGUI)
				ExitLoop
			Case $i_combo_from_surahs
				GUICtrlSetLimit($i_updown_from_ayas, Json_get($a_surahs_meta[_GUICtrlComboBox_GetCurSel($i_combo_from_surahs)], ".numberOfAyahs"), 1)
				GUICtrlSetData($i_combo_Ayahs_from, 1)
				GUICtrlSetLimit($i_combo_Ayahs_from, StringLen(Json_get($a_surahs_meta[_GUICtrlComboBox_GetCurSel($i_combo_from_surahs)], ".numberOfAyahs")))


			Case $i_combo_to_surahs
				GUICtrlSetLimit($i_updown_To_ayas, Json_get($a_surahs_meta[_GUICtrlComboBox_GetCurSel($i_combo_to_surahs)], ".numberOfAyahs"), 1)
				GUICtrlSetData($i_combo_Ayahs_to, Json_get($a_surahs_meta[_GUICtrlComboBox_GetCurSel($i_combo_to_surahs)], ".numberOfAyahs"))
				GUICtrlSetLimit($i_combo_Ayahs_to, StringLen(Json_get($a_surahs_meta[_GUICtrlComboBox_GetCurSel($i_combo_to_surahs)], ".numberOfAyahs")))

			Case $i_cust_BTN
				If (GUICtrlRead($i_combo_Ayahs_from) > Json_get($a_surahs_meta[_GUICtrlComboBox_GetCurSel($i_combo_from_surahs)], ".numberOfAyahs")) Or (GUICtrlRead($i_combo_Ayahs_from) < 1) Then
					GUICtrlSetState($i_combo_Ayahs_from, $GUI_focus)
					ContinueLoop
				EndIf
				If (GUICtrlRead($i_combo_Ayahs_to) > Json_get($a_surahs_meta[_GUICtrlComboBox_GetCurSel($i_combo_to_surahs)], ".numberOfAyahs")) Or (GUICtrlRead($i_combo_Ayahs_to) < 1) Then
					GUICtrlSetState($i_combo_Ayahs_to, $GUI_focus)
					ContinueLoop
				EndIf

				;				$i_crnt_type = 6
				;				$i_crnt_Num = 0
				;				$i_CRNt_Max = 0

				Local $i_ayahfrom = Json_get($a_surahs_meta[_GUICtrlComboBox_GetCurSel($i_combo_from_surahs)], ".firstAyahNumber") + (GUICtrlRead($i_combo_Ayahs_from) - 1)
				Local $i_ayahto = Json_get($a_surahs_meta[_GUICtrlComboBox_GetCurSel($i_combo_to_surahs)], ".firstAyahNumber") + (GUICtrlRead($i_combo_Ayahs_to) - 1)
				If $i_ayahfrom > $i_ayahto Then
					Local $i_ayah_temp = $i_ayahfrom
					$i_ayahfrom = $i_ayahto
					$i_ayahto = $i_ayah_temp
				EndIf
				GUIDelete($h_custGUI)
				If $b_accessibility Then UniversalSpeech_SpeechSay("مخصص", 1)
				GUISetState(@SW_ENABLE, $h_Main)
				WinActivate($h_Main, "")
				_GUICtrlRichEdit_SetText($h_text, read_custome($i_ayahfrom, $i_ayahto))
				#cs
								For $i = 1 To $a_tocenter[0][0]
									_set_center($a_tocenter[$i][0], $a_tocenter[$i][1], $a_tocenter[$i][2])
								Next
				#ce

				GUICtrlSetData($i_title, "عرض مخصص")

				GUICtrlSetState($h_text, $GUI_focus)
				$i_prev_pos = 0


				ExitLoop
		EndSwitch
	WEnd
	Opt("GUICloseOnESC", 0)
	Opt("GUIOnEventMode", 1)
	GUISetState(@SW_ENABLE, $h_Main)
	WinActivate($h_Main, "")

	Return 1

EndFunc   ;==>custome
Func save_pos()
	If $i_crnt_type = 6 Then
		If $b_accessibility Then UniversalSpeech_SpeechSay("خطأ: لا يمكنك حفظ الموضع هنا.", 1)
		_show_info_msg("لا يمكنك حفظ الموضع هنا", "خطأ", 3)
		Return SetError(1, 0, 0)
	EndIf
	Local $i_crnt_pos = _GUICtrlRichEdit_GetSel($h_text)[0]
	WriteSettings(".pos.type", $i_crnt_type)
	WriteSettings(".pos.number", $i_crnt_Num)
	WriteSettings(".pos.currentpos", $i_crnt_pos)
	If (@GUI_CtrlId = $i_save_pos) Or (@GUI_CtrlId = $i_savepos_btn) Then
		If $b_accessibility Then UniversalSpeech_SpeechSay("تم حفظ الموضع", 1)
		_show_info_msg("تم حفظ الموضع", "ملاحظة", 3)
	EndIf
	$b_savedpos = True
	Return 1
EndFunc   ;==>save_pos
Func Restore_pos()
	If (ReadSettings(".pos") = False) Or (ReadSettings(".pos") = "") Then Return SetError(1, 0, False)
	$i_crnt_type = ReadSettings(".pos.type")
	$i_crnt_Num = ReadSettings(".pos.number")
	Local $i_crnt_pos = ReadSettings(".pos.currentpos")
	WriteSettings(".pos", False)
	If $i_crnt_type = 1 Then
		$i_CRNt_Max = 114
		_GUICtrlRichEdit_SetText($h_text, read_sura($i_crnt_Num))
		GUICtrlSetData($i_title, $a_currentlist[1][3])
	ElseIf $i_crnt_type = 2 Then
		$i_CRNt_Max = 604
		_GUICtrlRichEdit_SetText($h_text, read_page($i_crnt_Num))
		GUICtrlSetData($i_title, "الصفحة " & $i_crnt_Num)

	ElseIf $i_crnt_type = 3 Then
		$i_CRNt_Max = 60
		_GUICtrlRichEdit_SetText($h_text, read_hizb($i_crnt_Num))
		GUICtrlSetData($i_title, "الحزب " & $i_crnt_Num)
	ElseIf $i_crnt_type = 4 Then
		$i_CRNt_Max = 30
		_GUICtrlRichEdit_SetText($h_text, read_juz($i_crnt_Num))
		GUICtrlSetData($i_title, "الجزء " & $i_crnt_Num)
	ElseIf $i_crnt_type = 5 Then
		$i_CRNt_Max = 240
		_GUICtrlRichEdit_SetText($h_text, read_Quarter($i_crnt_Num))
		GUICtrlSetData($i_title, "الربع " & $i_crnt_Num)
	EndIf

	For $i = 1 To $a_tocenter[0][0]
		_set_center($a_tocenter[$i][0], $a_tocenter[$i][1], $a_tocenter[$i][2])
	Next

	_GUICtrlRichEdit_GotoCharPos($h_text, $i_crnt_pos)
	$i_prev_pos = $i_crnt_pos
	GUICtrlSetState($h_text, $GUI_focus)
	Return 1
EndFunc   ;==>Restore_pos

Func get_info()
	MsgBox(64, _GUICtrlRichEdit_GetSel($h_text)[0], _get_aya())
EndFunc   ;==>get_info
Func nav_next_aya()
	_GUICtrlRichEdit_GotoCharPos($h_text, _get_aya("+1"))
	If $b_accessibility Then UniversalSpeech_SpeechSay(_GUICtrlRichEdit_GetTextInRange($h_text, $a_currentlist[$i_last_aya][0], $a_currentlist[$i_last_aya][1]), 1)
	$i_prev_pos = _GUICtrlRichEdit_GetSel($h_text)[0]
	If _BASS_ChannelIsActive($h_stream) Then
		_BASS_StreamFree($h_stream)
		$h_stream = -1
		AdlibUnRegister(_auto_play_Next)
		_play_to_end()
		Return 1
	EndIf

EndFunc   ;==>nav_next_aya

Func nav_prev_aya()

	_GUICtrlRichEdit_GotoCharPos($h_text, _get_aya("-1"))
	$i_prev_pos = _GUICtrlRichEdit_GetSel($h_text)[0]
	If $b_accessibility Then UniversalSpeech_SpeechSay(_GUICtrlRichEdit_GetTextInRange($h_text, $a_currentlist[$i_last_aya][0], $a_currentlist[$i_last_aya][1]), 1)
	If _BASS_ChannelIsActive($h_stream) Then
		_BASS_StreamFree($h_stream)
		$h_stream = -1
		AdlibUnRegister(_auto_play_Next)
		_play_to_end()
		Return 1
	EndIf

EndFunc   ;==>nav_prev_aya

Func nav_goto_aya()
	_get_aya()
	Do
		$i_navinp = InputBox("الذهاب إلى آية", "الرجاء اختيار رقم بين 1 و " & UBound($a_currentlist) & @CRLF & "ملاحظة : رقم الآية حسب ترتيبها في الصفحة الحالية وليس حسب ترتيبها في السورة.", $i_last_aya + 1, " m", -1, -1, Default, Default, 0, $h_Main)
		If @error Then Return 0
		If Not (IsInt($i_navinp)) Then ContinueLoop
	Until ($i_navinp >= 1) And ($i_navinp <= UBound($a_currentlist))


	_GUICtrlRichEdit_GotoCharPos($h_text, _get_aya($i_navinp))
	$i_prev_pos = _GUICtrlRichEdit_GetSel($h_text)[0]
	Return 1

EndFunc   ;==>nav_goto_aya

Func tafsir_aya()
	_get_aya()
	$i_surah_num = $a_currentlist[$i_last_aya][4]
	$i_ayah_num = $a_currentlist[$i_last_aya][2]
	$iRval = _SQLite_GetTable2D($h_Tafssir_db, "SELECT * FROM tafsir_" & $i_surah_num & ";", $a_dbres, $iRows, $iColumns)

	_pop_upmessage($h_Main, $a_dbres[$i_ayah_num][0], "تفسير الآية " & $i_ayah_num & " من " & $a_currentlist[$i_last_aya][3])
EndFunc   ;==>tafsir_aya

Func e3rab_ayah()
	_get_aya()
	$i_surah_num = $a_currentlist[$i_last_aya][4]
	$i_ayah_num = $a_currentlist[$i_last_aya][2]
	Local $h_dbe3rab = _SQLite_Open(@ScriptDir & "\database\tafasir\e3rab.db")
	$iRval = _SQLite_GetTable2D($h_dbe3rab, "SELECT * FROM e3rab_" & $i_surah_num & ";", $a_dbres, $iRows, $iColumns)
	_pop_upmessage($h_Main, $a_dbres[$i_ayah_num][0], "إعراب الآية " & $i_ayah_num & " من " & $a_currentlist[$i_last_aya][3])
	_SQLite_Close($h_dbe3rab)
EndFunc   ;==>e3rab_ayah

Func asbab_elnozol()
	_get_aya()
	$i_surah_num = $a_currentlist[$i_last_aya][4]

	$i_ayah_num = $a_currentlist[$i_last_aya][2]

	Local $h_dbtanzil = _SQLite_Open(@ScriptDir & "\database\tafasir\tanzil.db")
	$iRval = _SQLite_GetTable2D($h_dbtanzil, "SELECT * FROM tanzil  WHERE number = " & $a_currentlist[$i_last_aya][9] & ";", $a_dbres, $iRows, $iColumns)
	If (IsArray($a_dbres) = False) Or (UBound($a_dbres) < 2) Or ($a_dbres[1][1] = "") Then
		MsgBox(64, "تنبيه", "لا يوجد أسباب نزول لهذه الآية", "", $h_Main)
		Return 0
	EndIf
	_pop_upmessage($h_Main, $a_dbres[1][1], "أسباب نزول  الآية " & $i_ayah_num & " من " & $a_currentlist[$i_last_aya][3])
	_SQLite_Close($h_dbtanzil)
EndFunc   ;==>asbab_elnozol


Func tafsir_cust()
	Opt("GUICloseOnESC", 1)
	Opt("GUIOnEventMode", 0)
	GUISetState(@SW_DISABLE, $h_Main)
	Local $h_tafsircustGUI = GUICreate("تفسير مخصص", 400, 300, -1, -1, BitOR($WS_SYSMENU, $WS_CLIPCHILDREN, $WS_CLIPSIBLINGS, $WS_MAXIMIZEBOX, $WS_MINIMIZEBOX, $WS_SIZEBOX, $WS_SYSMENU), BitOR($WS_EX_LAYOUTRTL, $WS_EX_MDICHILD), $h_Main)
	GUICtrlCreateLabel("السورة:", 100, 10, 200, 20)
	GUICtrlSetFont(-1, 14, 700, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	Local $i_combo_surahs = GUICtrlCreateCombo("", 50, 30, 300, 30, BitOR($GUI_SS_DEFAULT_COMBO, $CBS_DROPDOWNLIST))
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	GUICtrlCreateLabel("من الآية:", 10, 80, 180, 20)
	GUICtrlSetFont(-1, 14, 700, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	Local $i_combo_Ayahs_from = GUICtrlCreateCombo("", 10, 100, 180, 30, BitOR($GUI_SS_DEFAULT_COMBO, $CBS_DROPDOWNLIST))
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	GUICtrlCreateLabel("إلى الآية:", 200, 80, 180, 20)
	GUICtrlSetFont(-1, 14, 700, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	Local $i_combo_Ayahs_to = GUICtrlCreateCombo("", 200, 100, 180, 30, BitOR($GUI_SS_DEFAULT_COMBO, $CBS_DROPDOWNLIST))
	GUICtrlSetResizing(-1, 1)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	If IsArray($a_surahs_meta) Then
		For $item In $a_surahs_meta
			GUICtrlSetData($i_combo_surahs, Json_get($item, ".number") & ". " & Json_get($item, ".name"))
		Next
		_GUICtrlComboBox_SetCurSel($i_combo_surahs, 0)
		For $i = 1 To Json_get($a_surahs_meta[0], ".numberOfAyahs")
			GUICtrlSetData($i_combo_Ayahs_from, $i)
			GUICtrlSetData($i_combo_Ayahs_to, $i)
		Next
		_GUICtrlComboBox_SetCurSel($i_combo_Ayahs_from, 0)
		_GUICtrlComboBox_SetCurSel($i_combo_Ayahs_to, _GUICtrlComboBox_GetCount($i_combo_Ayahs_to) - 1)
	EndIf
	Local $i_Tafsir_BTN = GUICtrlCreateButton("&تفسير", 10, 150, 180, 30, 0x01)
	GUICtrlSetResizing(-1, 1)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	Local $i_Cancel_tafsir_btn = GUICtrlCreateButton("إل&غاء", 200, 150, 180, 30)
	GUICtrlSetResizing(-1, 1)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUISetState(@SW_SHOW, $h_tafsircustGUI)


	While 1
		Switch GUIGetMsg()
			Case $GUI_event_close, $i_Cancel_tafsir_btn
				GUIDelete($h_tafsircustGUI)
				ExitLoop
			Case $i_combo_surahs
				GUICtrlSetData($i_combo_Ayahs_from, "")
				GUICtrlSetData($i_combo_Ayahs_to, "")
				For $i = 1 To Json_get($a_surahs_meta[_GUICtrlComboBox_GetCurSel($i_combo_surahs)], ".numberOfAyahs")
					GUICtrlSetData($i_combo_Ayahs_from, $i)
					GUICtrlSetData($i_combo_Ayahs_to, $i)
				Next
				_GUICtrlComboBox_SetCurSel($i_combo_Ayahs_from, 0)
				_GUICtrlComboBox_SetCurSel($i_combo_Ayahs_to, _GUICtrlComboBox_GetCount($i_combo_Ayahs_to) - 1)
			Case $i_Tafsir_BTN
				Local $i_surah_num = _GUICtrlComboBox_GetCurSel($i_combo_surahs) + 1
				Local $i_ayahs_from_num = _GUICtrlComboBox_GetCurSel($i_combo_Ayahs_from) + 1
				Local $i_ayahs_To_num = _GUICtrlComboBox_GetCurSel($i_combo_Ayahs_to) + 1
				If $i_ayahs_from_num > $i_ayahs_To_num Then
					Local $i_temp_ayah = $i_ayahs_from_num
					$i_ayahs_from_num = $i_ayahs_To_num
					$i_ayahs_To_num = $i_temp_ayah
				EndIf
				GUIDelete($h_tafsircustGUI)
				_tafsir_range($i_surah_num, $i_ayahs_from_num, $i_ayahs_To_num)
				ExitLoop
		EndSwitch
	WEnd
	Opt("GUICloseOnESC", 0)
	Opt("GUIOnEventMode", 1)

	GUISetState(@SW_ENABLE, $h_Main)
	WinActivate($h_Main, "")
	Return 1
EndFunc   ;==>tafsir_cust

Func tafsir_sel_muyassar()
	WriteSettings(".settings.tafsir", 1)
	GUICtrlSetState($i_tafsir_sel_muyassar, $GUI_checked)
	_SQLite_Close($h_Tafssir_db)
	Global $h_Tafssir_db = _SQLite_Open(@ScriptDir & "\database\tafasir\muyassar.DB")

EndFunc   ;==>tafsir_sel_muyassar

Func tafsir_sel_jalalayn()
	WriteSettings(".settings.tafsir", 2)
	GUICtrlSetState($i_tafsir_sel_jalalayn, $GUI_checked)
	_SQLite_Close($h_Tafssir_db)
	Global $h_Tafssir_db = _SQLite_Open(@ScriptDir & "\database\tafasir\jalalayn.DB")

EndFunc   ;==>tafsir_sel_jalalayn

Func tafsir_sel_sa3dy()
	WriteSettings(".settings.tafsir", 3)
	GUICtrlSetState($i_tafsir_sel_sa3dy, $GUI_checked)
	_SQLite_Close($h_Tafssir_db)
	Global $h_Tafssir_db = _SQLite_Open(@ScriptDir & "\database\tafasir\sa3dy.DB")


EndFunc   ;==>tafsir_sel_sa3dy
Func tafsir_sel_katheer()
	WriteSettings(".settings.tafsir", 4)
	GUICtrlSetState($i_tafsir_sel_katheer, $GUI_checked)
	_SQLite_Close($h_Tafssir_db)
	Global $h_Tafssir_db = _SQLite_Open(@ScriptDir & "\database\tafasir\katheer.DB")

EndFunc   ;==>tafsir_sel_katheer
Func tafsir_sel_qortoby()
	WriteSettings(".settings.tafsir", 5)
	GUICtrlSetState($i_tafsir_sel_qortoby, $GUI_checked)
	_SQLite_Close($h_Tafssir_db)
	Global $h_Tafssir_db = _SQLite_Open(@ScriptDir & "\database\tafasir\qortoby.DB")

EndFunc   ;==>tafsir_sel_qortoby
Func tafsir_sel_tabary()
	WriteSettings(".settings.tafsir", 6)
	GUICtrlSetState($i_tafsir_sel_tabary, $GUI_checked)
	_SQLite_Close($h_Tafssir_db)
	Global $h_Tafssir_db = _SQLite_Open(@ScriptDir & "\database\tafasir\tabary.DB")

EndFunc   ;==>tafsir_sel_tabary
Func tafsir_sel_baghawy()
	WriteSettings(".settings.tafsir", 7)
	GUICtrlSetState($i_tafsir_sel_baghawy, $GUI_checked)
	_SQLite_Close($h_Tafssir_db)
	Global $h_Tafssir_db = _SQLite_Open(@ScriptDir & "\database\tafasir\baghawy.DB")
EndFunc   ;==>tafsir_sel_baghawy
Func _settings_GUI()
	Opt("GUICloseOnESC", 1)
	Opt("GUIOnEventMode", 0)
	GUISetState(@SW_DISABLE, $h_Main)
	Local $h_stg_GUI = GUICreate("إعدادات البرنامج", 400, 600, -1, -1, BitOR($WS_SYSMENU, $WS_CLIPCHILDREN, $WS_CLIPSIBLINGS, $WS_MAXIMIZEBOX, $WS_MINIMIZEBOX, $WS_SIZEBOX, $WS_SYSMENU), BitOR($WS_EX_LAYOUTRTL, $WS_EX_MDICHILD), $h_Main)
	GUICtrlCreateLabel("التبويبة الافتراضية", 10, 20, 120, 20)
	GUICtrlSetFont(-1, 14, 700, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	Local $i_set_type = GUICtrlCreateCombo("", 10, 40, 120, 30, BitOR($GUI_SS_DEFAULT_COMBO, $CBS_DROPDOWNLIST))
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	GUICtrlSetData(-1, "السور|الصفحات|الأرباع|الأحزاب|الأجزاء")
	GUICtrlSetState(-1, $GUI_focus)
	_GUICtrlComboBox_SetCurSel($i_set_type, readSettings(".settings.opento", 1))
	Local $i_se_savpos = GUICtrlCreateCheckbox("فتح البرنامج على آخر موضع", 190, 40, 200, 30)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	If readSettings(".settings.restorelastpos", 0) = 1 Then GUICtrlSetState(-1, $GUI_checked)
	Local $i_se_basmala = GUICtrlCreateCheckbox("البسملة عند فتح البرنامج", 10, 80, 150, 30)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	If readSettings(".settings.basmala", 1) = 1 Then GUICtrlSetState(-1, $GUI_checked)
	Local $i_se_ignorenumbers = GUICtrlCreateCheckbox("إخفاء أرقام الآيات", 240, 80, 150, 30)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	If readSettings(".settings.hideAyaNumber", 0) = 1 Then GUICtrlSetState(-1, $GUI_checked)
	Local $i_se_ignoretashkil = GUICtrlCreateCheckbox("تجاهل التشكيل", 10, 120, 150, 30)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	If readSettings(".settings.hideAyatashkil", 0) = 1 Then GUICtrlSetState(-1, $GUI_checked)
	Local $i_se_ignoresimboles = GUICtrlCreateCheckbox("تجاهل علامات الترتيل", 240, 120, 150, 30)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	If readSettings(".settings.hideAyaSimbols", 0) = 1 Then GUICtrlSetState(-1, $GUI_checked)
	GUICtrlCreateLabel("خط القرآن المستخدم", 100, 160, 200, 20)
	GUICtrlSetFont(-1, 14, 700, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	Local $i_styleused = GUICtrlCreateCombo("", 100, 180, 200, 30, BitOR($GUI_SS_DEFAULT_COMBO, $CBS_DROPDOWNLIST))
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	GUICtrlSetData(-1, "الخط الإملائي الحديث|الخط العثماني")
	_GUICtrlComboBox_SetCurSel($i_styleused, readSettings(".settings.quranstyle", 0))
	Local $ayah_sel = GUICtrlCreateCheckbox("تحديد الآية عند الإستماع", 100, 230, 200, 30)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	If ReadSettings(".settings.aya_sel", 1) = 1 Then GUICtrlSetState(-1, $GUI_checked)
	Local $ayah_devise = GUICtrlCreateCheckbox("وضع كل آية في سطر", 100, 280, 200, 30)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	If ReadSettings(".settings.ayahnewline", 1) = 1 Then GUICtrlSetState(-1, $GUI_checked)
	GUICtrlCreateLabel("التحقق قبل تحميل المصحف الصوتي", 50, 320, 300, 20)
	GUICtrlSetFont(-1, 14, 700, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	Local $i_download_check = GUICtrlCreateCombo("", 50, 340, 300, 30, BitOR($GUI_SS_DEFAULT_COMBO, $CBS_DROPDOWNLIST))
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	GUICtrlSetData(-1, "لا تتحقق من وجود الملفات|تحقق من وجود أسماء الملفات فقط|تحقق من وجود أسماء الملفات ومقارنة أحجامها")
	_GUICtrlComboBox_SetCurSel(-1, Int(ReadSettings(".settings.downloadCheckFile", 2)))
	Local $i_disable_sleep = GUICtrlCreateCheckbox("منع الحاسوب من الدخول في وضع السكون تلقائيا", 50, 390, 300, 30)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	If ReadSettings(".settings.preventSleep", 1) = 1 Then GUICtrlSetState(-1, $GUI_checked)
	Local $i_accessibility = GUICtrlCreateCheckbox("تمكين إمكانية الوصول لقارئات الشاشة", 50, 440, 300, 30)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	If ReadSettings(".settings.Accessibility", _CheckScreenReader()) = 1 Then GUICtrlSetState(-1, $GUI_checked)
	Local $i_ok_btn = GUICtrlCreateButton("حفظ", 10, 500, 90, 30, 0x01)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	Local $i_Cancel_btn = GUICtrlCreateButton("إلغاء", 300, 500, 90, 30)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	GUIStartGroup("")
	GUISetState(@SW_SHOW, $h_stg_GUI)
	While 1
		Switch GUIGetMsg()
			Case $GUI_event_close, $i_Cancel_btn
				GUIDelete()
				ExitLoop
			Case $i_ok_btn
				WriteSettings(".settings.opento", _GUICtrlComboBox_GetCurSel($i_set_type))
				WriteSettings(".settings.quranstyle", _GUICtrlComboBox_GetCurSel($i_styleused))

				If _IsChecked($i_se_savpos) Then
					WriteSettings(".settings.restorelastpos", 1)
				Else
					WriteSettings(".settings.restorelastpos", 0)
				EndIf
				If _IsChecked($i_se_basmala) Then
					WriteSettings(".settings.basmala", 1)
				Else
					WriteSettings(".settings.basmala", 0)
				EndIf
				If _IsChecked($i_se_ignorenumbers) Then
					WriteSettings(".settings.hideAyaNumber", 1)
				Else
					WriteSettings(".settings.hideAyaNumber", 0)
				EndIf
				If _IsChecked($i_se_ignoretashkil) Then
					WriteSettings(".settings.hideAyatashkil", 1)
				Else
					WriteSettings(".settings.hideAyatashkil", 0)
				EndIf
				If _GUICtrlComboBox_GetCurSel($i_styleused) = 0 Then

					If _IsChecked($i_se_ignoresimboles) Then
						WriteSettings(".settings.hideAyaSimbols", 1)
					Else
						WriteSettings(".settings.hideAyaSimbols", 0)
					EndIf
					_load_normal()
				Else
					WriteSettings(".settings.hideAyaSimbols", 0)
					_load_utman()
				EndIf
				If _IsChecked($ayah_devise) Then
					WriteSettings(".settings.ayahnewline", 1)
					$b_ayahtoline = True
				Else
					WriteSettings(".settings.ayahnewline", 0)
					$b_ayahtoline = False
				EndIf
				WriteSettings(".settings.downloadCheckFile", _GUICtrlComboBox_GetCurSel($i_download_check))
				If _IsChecked($i_accessibility) Then
					WriteSettings(".settings.Accessibility", 1)
					$b_accessibility = True
				Else
					WriteSettings(".settings.Accessibility", 0)
					$b_accessibility = False
				EndIf
				If _IsChecked($ayah_sel) Then
					WriteSettings(".settings.aya_sel", 1)
					$b_sel_ayah = True
				Else
					WriteSettings(".settings.aya_sel", 0)
					$b_sel_ayah = False
				EndIf

				If _IsChecked($i_disable_sleep) Then
					WriteSettings(".settings.preventSleep", 1)
					_WinAPI_SetThreadExecutionState(BitOR($ES_CONTINUOUS, $ES_SYSTEM_REQUIRED, $ES_AWAYMODE_REQUIRED))
				Else
					WriteSettings(".settings.preventSleep", 0)
					_WinAPI_SetThreadExecutionState($ES_CONTINUOUS)
				EndIf
				GUIDelete()
				ExitLoop

		EndSwitch
	WEnd
	Opt("GUICloseOnESC", 0)
	Opt("GUIOnEventMode", 1)
	GUISetState(@SW_ENABLE, $h_Main)
	WinActivate($h_Main, "")
	Return 1
EndFunc   ;==>_settings_GUI
Func _search_func()
	Opt("GUICloseOnESC", 1)
	Opt("GUIOnEventMode", 0)
	GUISetState(@SW_DISABLE, $h_Main)
	Local $h_SrchGUI = GUICreate("البحث في القرآن الكريم", 400, 360, -1, -1, BitOR($WS_SYSMENU, $WS_CLIPCHILDREN, $WS_CLIPSIBLINGS, $WS_MAXIMIZEBOX, $WS_MINIMIZEBOX, $WS_SIZEBOX, $WS_SYSMENU), BitOR($WS_EX_LAYOUTRTL, $WS_EX_MDICHILD), $h_Main)


	GUICtrlCreateLabel("عبارة البحث", 150, 10, 100, 20)
	GUICtrlSetFont(-1, 14, 700, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	Global $i_searchinp = GUICtrlCreateInput($s_searchSTR, 50, 30, 300, 30)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	GUICtrlSetState(-1, $GUI_focus)


	Global $i_search_check1 = GUICtrlCreateCheckbox("تجاهل التشكيل", 10, 80, 180, 30)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	If StringRegExp(GUICtrlRead($i_searchinp), "[ًٌٍَُِّْ]", 0) = 1 Then
		If (_IsChecked($i_search_check1)) Then GUICtrlSetState($i_search_check1, $GUI_unchecked)
	Else
		If Not (GUICtrlRead($i_searchinp) = "") Then
			If Not (_IsChecked($i_search_check1)) Then GUICtrlSetState($i_search_check1, $GUI_checked)
		EndIf
	EndIf

	Local $i_search_check2 = GUICtrlCreateCheckbox("حصر البحث", 210, 80, 180, 30)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	If Not (IsArray($a_surahs_meta)) Then GUICtrlSetState(-1, $GUI_disable)

	GUICtrlCreateLabel("من السورة: ", 10, 130, 180, 20)
	GUICtrlSetFont(-1, 14, 700, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	Local $i_from_surah = GUICtrlCreateCombo("", 10, 150, 180, 30, BitOR($GUI_SS_DEFAULT_COMBO, $CBS_DROPDOWNLIST))
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	GUICtrlSetState($i_from_surah, $GUI_disable)
	GUICtrlCreateLabel("من الآية: ", 210, 130, 180, 20)
	GUICtrlSetFont(-1, 14, 700, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	Local $i_from_ayah = GUICtrlCreateInput("", 210, 150, 180, 30, $es_number)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	Local $i_updown_from_ayas = GUICtrlCreateUpdown($i_from_ayah, $UDS_ARROWKEYS)
	GUICtrlSetState($i_from_ayah, $GUI_disable)

	GUICtrlCreateLabel("إلى السورة: ", 10, 190, 180, 20)
	GUICtrlSetFont(-1, 14, 700, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	Local $i_to_surah = GUICtrlCreateCombo("", 10, 210, 180, 30, BitOR($GUI_SS_DEFAULT_COMBO, $CBS_DROPDOWNLIST))
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	GUICtrlSetState($i_to_surah, $GUI_disable)
	GUICtrlCreateLabel("إلى الآية: ", 210, 190, 180, 20)
	GUICtrlSetFont(-1, 14, 700, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	Local $i_to_ayah = GUICtrlCreateInput("", 210, 210, 180, 30, $es_number)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	GUICtrlSetState($i_to_ayah, $GUI_disable)
	Local $i_updown_To_ayas = GUICtrlCreateUpdown($i_to_ayah, $UDS_ARROWKEYS)
	Local $i_start_srch = GUICtrlCreateButton("بدء البحث", 10, 260, 150, 30, 0x01)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	Local $i_cancel_srch = GUICtrlCreateButton("إل&غاء", 240, 260, 150, 30)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)


	GUISetState(@SW_SHOW, $h_SrchGUI)


	If IsArray($a_surahs_meta) Then
		For $item In $a_surahs_meta
			GUICtrlSetData($i_from_surah, Json_get($item, ".number") & ". " & Json_get($item, ".name"))
			GUICtrlSetData($i_to_surah, Json_get($item, ".number") & ". " & Json_get($item, ".name"))
		Next
		_GUICtrlComboBox_SetCurSel($i_from_surah, 0)
		_GUICtrlComboBox_SetCurSel($i_to_surah, 113)

		GUICtrlSetLimit($i_updown_from_ayas, Int(Json_get($a_surahs_meta[0], ".numberOfAyahs")), 1)
		GUICtrlSetLimit($i_updown_To_ayas, Int(Json_get($a_surahs_meta[113], ".numberOfAyahs")), 1)
		GUICtrlSetData($i_from_ayah, 1)
		GUICtrlSetData($i_to_ayah, Int(Json_get($a_surahs_meta[113], ".numberOfAyahs")))
		GUICtrlSetLimit($i_from_ayah, StringLen(Int(Json_get($a_surahs_meta[0], ".numberOfAyahs"))))
		GUICtrlSetLimit($i_to_ayah, StringLen(Int(Json_get($a_surahs_meta[113], ".numberOfAyahs"))))
	EndIf
	GUIRegisterMsg($WM_COMMAND, "WM_srch_command")

	While 1
		Switch GUIGetMsg()

			Case $GUI_event_close, $i_cancel_srch
				GUIDelete($h_SrchGUI)
				ExitLoop

			Case $i_search_check2
				If _IsChecked($i_search_check2) Then
					GUICtrlSetState($i_from_surah, $GUI_Enable)
					GUICtrlSetState($i_from_ayah, $GUI_Enable)
					GUICtrlSetState($i_to_surah, $GUI_Enable)
					GUICtrlSetState($i_to_ayah, $GUI_Enable)
				Else
					GUICtrlSetState($i_from_surah, $GUI_disable)
					GUICtrlSetState($i_from_ayah, $GUI_disable)
					GUICtrlSetState($i_to_surah, $GUI_disable)
					GUICtrlSetState($i_to_ayah, $GUI_disable)
				EndIf
			Case $i_from_surah
				GUICtrlSetLimit($i_updown_from_ayas, Json_get($a_surahs_meta[_GUICtrlComboBox_GetCurSel($i_from_surah)], ".numberOfAyahs"), 1)
				GUICtrlSetData($i_from_ayah, 1)
				GUICtrlSetLimit($i_from_ayah, StringLen(Json_get($a_surahs_meta[_GUICtrlComboBox_GetCurSel($i_from_surah)], ".numberOfAyahs")))

			Case $i_to_surah
				GUICtrlSetLimit($i_updown_To_ayas, Json_get($a_surahs_meta[_GUICtrlComboBox_GetCurSel($i_to_surah)], ".numberOfAyahs"), 1)
				GUICtrlSetData($i_to_ayah, Json_get($a_surahs_meta[_GUICtrlComboBox_GetCurSel($i_to_surah)], ".numberOfAyahs"))
				GUICtrlSetLimit($i_to_ayah, StringLen(Json_get($a_surahs_meta[_GUICtrlComboBox_GetCurSel($i_to_surah)], ".numberOfAyahs")))

			Case $i_start_srch
				If GUICtrlRead($i_searchinp) = "" Then
					GUICtrlSetState($i_searchinp, $GUI_focus)
					DllCall("user32.dll", "int", "MessageBeep", "int", 0x00000040)
					ContinueLoop
				EndIf
				If (GUICtrlRead($i_from_ayah) > Json_get($a_surahs_meta[_GUICtrlComboBox_GetCurSel($i_from_surah)], ".numberOfAyahs")) Or (GUICtrlRead($i_from_ayah) < 1) Then
					GUICtrlSetState($i_from_ayah, $GUI_focus)
					DllCall("user32.dll", "int", "MessageBeep", "int", 0x00000040)
					ContinueLoop
				EndIf
				If (GUICtrlRead($i_to_ayah) > Json_get($a_surahs_meta[_GUICtrlComboBox_GetCurSel($i_to_surah)], ".numberOfAyahs")) Or (GUICtrlRead($i_to_ayah) < 1) Then
					GUICtrlSetState($i_to_ayah, $GUI_focus)
					DllCall("user32.dll", "int", "MessageBeep", "int", 0x00000040)
					ContinueLoop
				EndIf

				$s_searchSTR = StringRegExpReplace(GUICtrlRead($i_searchinp), "[أإآئءؤ]", "ا")
				Local $s_sqldt, $s_tabletosearch, $s_regexp_expr
				If _IsChecked($i_search_check1) Then
					$s_tabletosearch = "text_No_tashkil"
					$s_regexp_expr = "[^ا-يةئءؤأإآى\s\[\]]+"
				Else
					$s_tabletosearch = "text"
					$s_regexp_expr = "[^ا-يةئءؤأإآى\sًٌٍَُِّْ\[\]]+"
				EndIf
				If _IsChecked($i_search_check2) Then
					$i_sel_surah_from = Json_get($a_surahs_meta[_GUICtrlComboBox_GetCurSel($i_from_surah)], ".firstAyahNumber")
					$i_sel_surah_from = ($i_sel_surah_from + (GUICtrlRead($i_from_ayah) - 1))
					$i_sel_surah_to = Json_get($a_surahs_meta[_GUICtrlComboBox_GetCurSel($i_to_surah)], ".firstAyahNumber")
					$i_sel_surah_to = ($i_sel_surah_to + (GUICtrlRead($i_to_ayah) - 1))
					If $i_sel_surah_from > $i_sel_surah_to Then
						Local $i_temp_ayah = $i_sel_surah_from
						$i_sel_surah_from = $i_sel_surah_to
						$i_sel_surah_to = $i_temp_ayah
					EndIf
					$s_sqldt = "SELECT text, number, sura_name, sura_number, numberInSurah FROM quran WHERE number between " & $i_sel_surah_from & " AND " & $i_sel_surah_to & " AND INSTR(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(" & $s_tabletosearch & ", 'أ', 'ا'), 'إ', 'ا'), 'آ', 'ا'), 'ؤ', 'ا'), 'ئ', 'ا'), 'ء', 'ا'), 'ٱ', 'ا'), '" & StringRegExpReplace($s_searchSTR, $s_regexp_expr, "") & "') > 0;"

;					$s_sqldt = "SELECT text, number, sura_name, sura_number, numberInSurah FROM quran WHERE number between " & $i_sel_surah_from & " AND " & $i_sel_surah_to & " AND INSTR(" & $s_tabletosearch & ", '" & StringRegExpReplace($s_searchSTR, $s_regexp_expr, "") & "');"
				Else
					$s_sqldt = "SELECT text, number, sura_name, sura_number, numberInSurah FROM quran WHERE INSTR(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(" & $s_tabletosearch & ", 'أ', 'ا'), 'إ', 'ا'), 'آ', 'ا'), 'ؤ', 'ا'), 'ئ', 'ا'), 'ء', 'ا'), 'ٱ', 'ا'), '" & StringRegExpReplace($s_searchSTR, $s_regexp_expr, "") & "') > 0;"
				EndIf

				Local $hh_db_open = _SQLite_Open(@ScriptDir & "\database\quran\Verses.DB")
				If @error Then
					MsgBox(16,, "error", "we couldn't load database", "", $h_SrchGUI)
					ContinueLoop
				EndIf

				$iRval = _SQLite_GetTable2D($hh_db_open, $s_sqldt, $a_dbres, $iRows, $iColumns)
				If $iRval = $SQLITE_OK Then
					If $iRows >= 1 Then
						GUIDelete($h_SrchGUI)
						_ArrayDelete($a_dbres, 0)
						If $b_accessibility Then UniversalSpeech_SpeechSay("عدد النتائج المتحصل عليها من خلال عملية البحث هو : " & UBound($a_dbres) & " نتيجة", 1)
						_search_res($a_dbres)
						ExitLoop
					Else
						MsgBox(16, "لا نتيجة", "لم نَعثُر على أي نتيجة مطابقة لعبارة البحث التي أدخلتها, الرجاء حاول التأكد من ما كتبت, أو يمكنك تجاهل التشكيل للحصول على نتائج أكثر.", "", $h_SrchGUI)
						ContinueLoop
					EndIf
				Else
					MsgBox(16, "لا نتيجة", "لم نَعثُر على أي نتيجة مطابقة لعبارة البحث التي أدخلتها, الرجاء حاول التأكد من ما كتبت, أو يمكنك تجاهل التشكيل للحصول على نتائج أكثر.", "", $h_SrchGUI)
					ContinueLoop

				EndIf

		EndSwitch
	WEnd
	Opt("GUICloseOnESC", 0)
	Opt("GUIOnEventMode", 1)
	GUISetState(@SW_ENABLE, $h_Main)
	WinActivate($h_Main, "")
	Return 1
EndFunc   ;==>_search_func
Func WM_srch_command($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg
	Local $hWndFrom, $iIDFrom, $iCode
	$hWndFrom = $lParam
	$iIDFrom = BitAND($wParam, 0xFFFF)     ; Low Word
	$iCode = BitShift($wParam, 16)     ; Hi Word
	Switch $iIDFrom
		Case $i_searchinp
			Switch $iCode
				Case $EN_CHANGE

					If StringRegExp(GUICtrlRead($iIDFrom), "[^ا-يةئءؤأإآى\sًٌٍَُِّْ]+", 0) = 1 Then
						GUICtrlSetData($iIDFrom, StringRegExpReplace(GUICtrlRead($iIDFrom), "[^ا-يةئءؤأإآى\sًٌٍَُِّْ]+", ""))
						DllCall("user32.dll", "int", "MessageBeep", "int", 0x00000040)

					EndIf
					If StringRegExp(GUICtrlRead($iIDFrom), "[ًٌٍَُِّْ]", 0) = 1 Then
						If (_IsChecked($i_search_check1)) Then GUICtrlSetState($i_search_check1, $GUI_unchecked)
					Else
						If Not (GUICtrlRead($iIDFrom) = "") Then
							If Not (_IsChecked($i_search_check1)) Then GUICtrlSetState($i_search_check1, $GUI_checked)
						EndIf
					EndIf
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_srch_command
Func _search_res($a_array_result)
	Local $old_esc_close = Opt("GUICloseOnESC")
	Local $old_event_mode = Opt("GUIOnEventMode")
	Opt("GUICloseOnESC", 1)
	Opt("GUIOnEventMode", 0)
	Local $h_srch_resGUI = GUICreate("نتائج البحث", 450, 480, -1, -1, BitOR($WS_SYSMENU, $WS_CLIPCHILDREN, $WS_CLIPSIBLINGS, $WS_MAXIMIZEBOX, $WS_MINIMIZEBOX, $WS_SIZEBOX, $WS_SYSMENU), BitOR($WS_EX_LAYOUTRTL, $WS_EX_MDICHILD), $h_Main)
	GUICtrlCreateLabel("النتائج", 75, 20, 300, 20)
	GUICtrlSetFont(-1, 14, 700, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	Local $i_srchResList = GUICtrlCreateList("", 75, 40, 300, 150, BitXOR($GUI_SS_DEFAULT_LIST, $LBS_SORT))
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	GUICtrlCreateLabel("&نص الآية", 125, 220, 200, 20)
	GUICtrlSetFont(-1, 14, 700, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	Local $i_res_edit = GUICtrlCreateEdit("", 25, 240, 400, 150, BitOR($WS_TabStop, $es_ReadOnly))
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	Local $i_openinsurah = GUICtrlCreateButton("فتح في السورة", 10, 410, 120, 30)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	Local $i_moreoptions = GUICtrlCreateButton("المزيد من الخيارات...", 140, 410, 120, 30)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	Local $h_morContext = GUICtrlCreateContextMenu($i_moreoptions)
	Local $i_mr_tafsir = GUICtrlCreateMenuItem("تفسير الآية", $h_morContext)
	Local $i_mr_e3rab = GUICtrlCreateMenuItem("إعراب الآية", $h_morContext)
	Local $i_mr_tanzil = GUICtrlCreateMenuItem("أسباب نزول الآية", $h_morContext)
	Local $i_mr_copy = GUICtrlCreateMenuItem("نسخ الآية", $h_morContext)
	Local $i_close_res = GUICtrlCreateButton("إغلاق", 270, 410, 120, 30)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	GUISetState(@SW_DISABLE, $h_Main)
	GUISetState(@SW_SHOW, $h_srch_resGUI)
	Local $a_main_array = $a_array_result
	If IsArray($a_main_array) Then

		For $i = 0 To UBound($a_main_array) - 1
			GUICtrlSetData($i_srchResList, $a_main_array[$i][2] & " الآية " & $a_main_array[$i][4])
		Next
	EndIf
	Local $i_ret_type = 1
	While 1
		Switch GUIGetMsg()
			Case $GUI_event_close, $i_close_res
				GUIDelete($h_srch_resGUI)
				ExitLoop
			Case $i_srchResList
				GUICtrlSetData($i_res_edit, $a_main_array[_GUICtrlListBox_GetCurSel($i_srchResList)][0])
			Case $i_openinsurah
				If _GUICtrlListBox_GetCurSel($i_srchResList) >= 0 Then
					$i_crnt_type = 1
					$i_CRNt_Max = 114
					$i_crnt_Num = $a_main_array[_GUICtrlListBox_GetCurSel($i_srchResList)][3]
					_GUICtrlRichEdit_SetText($h_text, read_sura($i_crnt_Num))
					#cs
										For $i = 1 To $a_tocenter[0][0]
											_set_center($a_tocenter[$i][0], $a_tocenter[$i][1], $a_tocenter[$i][2])
										Next
					#ce

					_GUICtrlRichEdit_GotoCharPos($h_text, _get_aya($a_main_array[_GUICtrlListBox_GetCurSel($i_srchResList)][4]))
					$i_prev_pos = _GUICtrlRichEdit_GetSel($h_text)[0]
					GUICtrlSetData($i_title, $a_currentlist[1][3])
					GUIDelete($h_srch_resGUI)
					ExitLoop
				EndIf
			Case $i_moreoptions
				ShowMenu($h_srch_resGUI, $i_moreoptions, $h_morContext)
			Case $i_mr_tafsir
				If _GUICtrlListBox_GetCurSel($i_srchResList) >= 0 Then
					$iRval = _SQLite_GetTable2D($h_Tafssir_db, "SELECT * FROM tafsir_" & $a_main_array[_GUICtrlListBox_GetCurSel($i_srchResList)][3] & ";", $a_dbres, $iRows, $iColumns)
					If IsArray($a_dbres) Then _pop_upmessage($h_srch_resGUI, $a_dbres[$a_main_array[_GUICtrlListBox_GetCurSel($i_srchResList)][4]][0], "تفسير الآية " & $a_main_array[_GUICtrlListBox_GetCurSel($i_srchResList)][4] & " من " & $a_main_array[_GUICtrlListBox_GetCurSel($i_srchResList)][2])
				EndIf
			Case $i_mr_e3rab
				If _GUICtrlListBox_GetCurSel($i_srchResList) >= 0 Then
					Local $h_dbe3rab = _SQLite_Open(@ScriptDir & "\database\tafasir\e3rab.db")
					$iRval = _SQLite_GetTable2D($h_dbe3rab, "SELECT * FROM e3rab_" & $a_main_array[_GUICtrlListBox_GetCurSel($i_srchResList)][3] & ";", $a_dbres, $iRows, $iColumns)
					If IsArray($a_dbres) Then _pop_upmessage($h_srch_resGUI, $a_dbres[$a_main_array[_GUICtrlListBox_GetCurSel($i_srchResList)][4]][0], "إعراب الآية " & $a_main_array[_GUICtrlListBox_GetCurSel($i_srchResList)][4] & " من " & $a_main_array[_GUICtrlListBox_GetCurSel($i_srchResList)][2])
				EndIf
			Case $i_mr_tanzil
				If _GUICtrlListBox_GetCurSel($i_srchResList) >= 0 Then
					Local $h_dbtanzil = _SQLite_Open(@ScriptDir & "\database\tafasir\tanzil.db")
					$iRval = _SQLite_GetTable2D($h_dbtanzil, "SELECT * FROM tanzil Where number =" & $a_main_array[_GUICtrlListBox_GetCurSel($i_srchResList)][1] & ";", $a_dbres, $iRows, $iColumns)

					If IsArray($a_dbres) Then
						If $a_dbres[1][1] = "" Then
							MsgBox(64, "تنبيه", "المعذرة, لا تتوفر أسباب نزول لهذه الآية.", "", $h_srch_resGUI)
							ContinueLoop
						EndIf
						_pop_upmessage($h_srch_resGUI, $a_dbres[1][1], "أسباب نزول الآية " & $a_main_array[_GUICtrlListBox_GetCurSel($i_srchResList)][4] & " من " & $a_main_array[_GUICtrlListBox_GetCurSel($i_srchResList)][2])
					EndIf
				EndIf

			Case $i_mr_copy
				ClipPut($a_main_array[_GUICtrlListBox_GetCurSel($i_srchResList)][0])
		EndSwitch
	WEnd

	Opt("GUICloseOnESC", $old_esc_close)
	Opt("GUIOnEventMode", $old_event_mode)
	GUISetState(@SW_ENABLE, $h_Main)
	WinActivate($h_Main, "")
	Return 1
EndFunc   ;==>_search_res

Func _tafsir_range($i_Surahs_Num, $i_ayahs_from, $i_ayahs_to)
	$iRval = _SQLite_GetTable2D($h_Tafssir_db, "SELECT * FROM tafsir_" & $i_Surahs_Num & " WHERE numberInSurah Between " & $i_ayahs_from & " AND " & $i_ayahs_to & ";", $a_dbres, $iRows, $iColumns)
	Local $s_texttafsir = ""
	For $i = 1 To UBound($a_dbres) - 1
		$s_texttafsir &= $a_dbres[$i][0] & @CRLF & @CRLF
	Next
	_pop_upmessage($h_Main, $s_texttafsir, "تفسير الآيات المحددة من  " & Json_get($a_surahs_meta[$i_Surahs_Num - 1], ".name"))
	Return 1
EndFunc   ;==>_tafsir_range

Func quickAccess()
	Opt("GUICloseOnESC", 1)
	Opt("GUIOnEventMode", 0)

	Local $qckaccess = GUICreate("الوصول السريع", 400, 300, -1, -1, BitOR($WS_SYSMENU, $WS_CLIPCHILDREN, $WS_CLIPSIBLINGS, $WS_MAXIMIZEBOX, $WS_MINIMIZEBOX, $WS_SIZEBOX, $WS_SYSMENU), BitOR($WS_EX_LAYOUTRTL, $WS_EX_MDICHILD), $h_Main)
	Local $i_surah_quick = GUICtrlCreateRadio("سور", 20, 10, 100, 40)
	GUICtrlSetResizing(-1, 1)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetState(-1, $GUI_checked)
	Local $i_page_quick = GUICtrlCreateRadio("صفحات", 150, 10, 100, 40)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	Local $i_quarter_quick = GUICtrlCreateRadio("أرباع", 280, 10, 100, 40)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	Local $i_hizb_quick = GUICtrlCreateRadio("أحزاب", 20, 60, 100, 40)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	Local $i_juz_quick = GUICtrlCreateRadio("أجزاء", 280, 60, 100, 40)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)

	GUIStartGroup()

	GUICtrlCreateLabel("إنتقل إلى", 50, 130, 300, 20)
	GUICtrlSetFont(-1, 14, 700, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	Local $i_comboquickaccess = GUICtrlCreateCombo("", 50, 150, 300, 30, BitOR($GUI_SS_DEFAULT_COMBO, $CBS_DROPDOWNLIST))
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	GUIStartGroup()
	Local $i_quickGo = GUICtrlCreateButton("إنتقل", 20, 200, 100, 40, 0x01)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	Local $i_quickCancel = GUICtrlCreateButton("إلغاء", 140, 200, 100, 40)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)

	For $i = 1 To 114
		GUICtrlSetData($i_comboquickaccess, Json_get($a_surahs_meta[$i - 1], ".name"))
	Next
	_GUICtrlComboBox_SetCurSel($i_comboquickaccess, 0)
	GUISetState(@SW_DISABLE, $h_Main)
	GUISetState(@SW_SHOW, $qckaccess)
	While 1

		Switch GUIGetMsg()
			Case $GUI_event_close, $i_quickCancel
				GUIDelete($qckaccess)
				ExitLoop

			Case $i_surah_quick
				GUICtrlSetData($i_comboquickaccess, "")
				For $i = 1 To 114
					GUICtrlSetData($i_comboquickaccess, Json_get($a_surahs_meta[$i - 1], ".name"))
				Next
				_GUICtrlComboBox_SetCurSel($i_comboquickaccess, 0)
			Case $i_page_quick
				GUICtrlSetData($i_comboquickaccess, "")
				For $i = 1 To 604
					GUICtrlSetData($i_comboquickaccess, StringFormat("%03i", $i))
				Next
				_GUICtrlComboBox_SetCurSel($i_comboquickaccess, 0)

			Case $i_quarter_quick
				GUICtrlSetData($i_comboquickaccess, "")
				For $i = 1 To 240
					GUICtrlSetData($i_comboquickaccess, StringFormat("%03i", $i))
				Next
				_GUICtrlComboBox_SetCurSel($i_comboquickaccess, 0)

			Case $i_hizb_quick
				GUICtrlSetData($i_comboquickaccess, "")
				For $i = 1 To 60
					GUICtrlSetData($i_comboquickaccess, StringFormat("%02i", $i))
				Next
				_GUICtrlComboBox_SetCurSel($i_comboquickaccess, 0)

			Case $i_juz_quick
				GUICtrlSetData($i_comboquickaccess, "")
				For $i = 1 To 30
					GUICtrlSetData($i_comboquickaccess, StringFormat("%02i", $i))
				Next
				_GUICtrlComboBox_SetCurSel($i_comboquickaccess, 0)

			Case $i_quickGo
				If _IsChecked($i_surah_quick) Then
					$i_crnt_type = 1
					$i_CRNt_Max = 114
					$i_crnt_Num = _GUICtrlComboBox_GetCurSel($i_comboquickaccess) + 1
					_GUICtrlRichEdit_SetText($h_text, read_sura($i_crnt_Num))

					_GUICtrlRichEdit_GotoCharPos($h_text, 0)
					$i_prev_pos = _GUICtrlRichEdit_GetSel($h_text)[0]
					GUICtrlSetData($i_title, $a_currentlist[1][3])
				ElseIf _IsChecked($i_page_quick) Then
					$i_crnt_type = 2
					$i_CRNt_Max = 604
					$i_crnt_Num = _GUICtrlComboBox_GetCurSel($i_comboquickaccess) + 1
					_GUICtrlRichEdit_SetText($h_text, read_page($i_crnt_Num))

					_GUICtrlRichEdit_GotoCharPos($h_text, 0)
					$i_prev_pos = _GUICtrlRichEdit_GetSel($h_text)[0]
					GUICtrlSetData($i_title, "الصفحة " & $i_crnt_Num)
				ElseIf _IsChecked($i_quarter_quick) Then
					$i_crnt_type = 5
					$i_CRNt_Max = 240
					$i_crnt_Num = _GUICtrlComboBox_GetCurSel($i_comboquickaccess) + 1
					_GUICtrlRichEdit_SetText($h_text, read_quarter($i_crnt_Num))
					_GUICtrlRichEdit_GotoCharPos($h_text, 0)
					$i_prev_pos = _GUICtrlRichEdit_GetSel($h_text)[0]
					GUICtrlSetData($i_title, "الربع " & $i_crnt_Num)

				ElseIf _IsChecked($i_hizb_quick) Then
					$i_crnt_type = 3
					$i_CRNt_Max = 60
					$i_crnt_Num = _GUICtrlComboBox_GetCurSel($i_comboquickaccess) + 1
					_GUICtrlRichEdit_SetText($h_text, read_hizb($i_crnt_Num))
					_GUICtrlRichEdit_GotoCharPos($h_text, 0)
					$i_prev_pos = _GUICtrlRichEdit_GetSel($h_text)[0]
					GUICtrlSetData($i_title, "الحزب " & $i_crnt_Num)
				ElseIf _IsChecked($i_juz_quick) Then
					$i_crnt_type = 4
					$i_CRNt_Max = 30
					$i_crnt_Num = _GUICtrlComboBox_GetCurSel($i_comboquickaccess) + 1
					_GUICtrlRichEdit_SetText($h_text, read_juz($i_crnt_Num))
					_GUICtrlRichEdit_GotoCharPos($h_text, 0)
					$i_prev_pos = _GUICtrlRichEdit_GetSel($h_text)[0]
					GUICtrlSetData($i_title, "الجزء " & $i_crnt_Num)
				EndIf

				For $i = 1 To $a_tocenter[0][0]
					_set_center($a_tocenter[$i][0], $a_tocenter[$i][1], $a_tocenter[$i][2])
				Next


				If $b_accessibility Then UniversalSpeech_SpeechSay(GUICtrlRead($i_title), 1)
				GUIDelete($qckaccess)
				ExitLoop

		EndSwitch
	WEnd
	Opt("GUICloseOnESC", 0)
	Opt("GUIOnEventMode", 1)
	GUISetState(@SW_ENABLE, $h_Main)
	WinActivate($h_Main, "")
	Return 1
EndFunc   ;==>quickAccess

Func _speak_surah_name()
	_get_aya()
	$str_to_speak = StringFormat("%s, الآية: %i, الصفحة: %i, الربع: %i, الحزب: %i, الجزء: %i.", $a_currentlist[$i_last_aya][3], $a_currentlist[$i_last_aya][2], $a_currentlist[$i_last_aya][7], $a_currentlist[$i_last_aya][8], $a_currentlist[$i_last_aya][6], $a_currentlist[$i_last_aya][5])
	If $b_accessibility Then UniversalSpeech_SpeechSay($str_to_speak, 1)
EndFunc   ;==>_speak_surah_name
Func _basmala()
	If Int(readSettings(".settings.basmala", 1)) = 1 Then
		Local $a_sflist = _FileListToArrayRec(@ScriptDir & "\basmala", "*.OGG", $FLTAR_FILES, $FLTAR_NORECUR, $FLTAR_SORT, $FLTAR_FULLPATH)
		If Not (IsArray($a_sflist)) Then Return SetError(1, 0, -1)
		$randnum = Random(1, $a_sflist[0], 1)
		_BASS_ChannelPlay(_BASS_StreamCreateFile(False, $a_sflist[$randnum], 0, 0, $BASS_STREAM_AUTOFREE), 1)
	EndIf
	Return 1
EndFunc   ;==>_basmala

Func _setfont()
	Local $a_crnt_font = _GUICtrlRichEdit_GetFont($h_text)

	Local $a_crnt_Atrb = _GUICtrlRichEdit_GetdefaultAttributes($h_text)

	$b_itastate = (StringInStr($a_crnt_Atrb, "it+") >= 1)
	Local $s_fnt_name = ReadSettings(".font.name", "KFGQPC Uthman Taha Naskh")
	Local $s_fnt_size = ReadSettings(".font.size", 18)
	Local $s_fnt_bold = ReadSettings(".font.bold", False)
	Local $s_fnt_Italic = ReadSettings(".font.Italic", False)
	Local $s_fnt_Underline = ReadSettings(".font.Underline", False)
	Local $s_fnt_Strikethru = ReadSettings(".font.Strikethru", False)
	Local $s_fnt_Weight = ReadSettings(".font.Weight", 0)
	Local $s_fnt_Color = ReadSettings(".font.color", 0)
	Local $a_fontselnew = _ChooseFont($s_fnt_name, $s_fnt_size, $s_fnt_Color, $s_fnt_Weight, $s_fnt_Italic, $s_fnt_Underline, $s_fnt_Strikethru, $h_Main)
	If Not (@error) And (IsArray($a_fontselnew)) Then
		$s_fnt_name = $a_fontselnew[2]
		$s_fnt_size = Int($a_fontselnew[3])
		$s_fnt_Weight = Int($a_fontselnew[4])
		$s_fnt_Color = Int($a_fontselnew[5])

		$s_fnt_Italic = BitAND($a_fontselnew[1], 2) = 2
		$s_fnt_Underline = BitAND($a_fontselnew[1], 4) = 4
		$s_fnt_Strikethru = BitAND($a_fontselnew[1], 8) = 8
		If $s_fnt_Weight >= 700 Then
			$s_fnt_bold = True
		Else
			$s_fnt_bold = False
		EndIf

		WriteSettings(".font.name", $s_fnt_name)
		WriteSettings(".font.size", $s_fnt_size)
		WriteSettings(".font.bold", $s_fnt_bold)
		WriteSettings(".font.Italic", $s_fnt_Italic)
		WriteSettings(".font.Underline", $s_fnt_Underline)
		WriteSettings(".font.Strikethru", $s_fnt_Strikethru)
		WriteSettings(".font.Weight", $s_fnt_Weight)
		WriteSettings(".font.color", $s_fnt_Color)
		_GUICtrlRichEdit_SetDefaultFont($h_text, $s_fnt_size, $s_fnt_name)
		_GUICtrlRichEdit_SetDefaultcolor($h_text, $s_fnt_Color)
		$s_atrbtoset = ""
		If ($s_fnt_Weight >= 700) Or ($s_fnt_bold = True) Then
			$s_atrbtoset &= "+bo"
		Else
			$s_atrbtoset &= "-bo"
		EndIf

		If ($s_fnt_Italic) Then
			$s_atrbtoset &= "+it"
		Else
			$s_atrbtoset &= "-it"
		EndIf

		If ($s_fnt_Underline) Then
			$s_atrbtoset &= "+un"
		Else
			$s_atrbtoset &= "-un"
		EndIf

		If ($s_fnt_Underline) Then
			$s_atrbtoset &= "+un"
		Else
			$s_atrbtoset &= "-un"
		EndIf

		If ($s_fnt_Strikethru) Then
			$s_atrbtoset &= "+st"
		Else
			$s_atrbtoset &= "-st"
		EndIf
		_GUICtrlRichEdit_SetDefaultAttributes($h_text, $s_atrbtoset)
	EndIf

EndFunc   ;==>_setfont
Func _setdefault_font()
	Local $s_fnt_name = ReadSettings(".font.name", "KFGQPC Uthman Taha Naskh")
	Local $s_fnt_size = ReadSettings(".font.size", 18)
	Local $s_fnt_bold = ReadSettings(".font.bold", False)
	Local $s_fnt_Italic = ReadSettings(".font.Italic", False)
	Local $s_fnt_Underline = ReadSettings(".font.Underline", False)
	Local $s_fnt_Strikethru = ReadSettings(".font.Strikethru", False)
	Local $s_fnt_Weight = ReadSettings(".font.Weight", 0)
	Local $s_fnt_Color = ReadSettings(".font.color", 0)
	_GUICtrlRichEdit_SetDefaultFont($h_text, $s_fnt_size, $s_fnt_name)
	_GUICtrlRichEdit_SetDefaultcolor($h_text, $s_fnt_Color)
	$s_atrbtoset = ""
	If ($s_fnt_Weight >= 700) Or ($s_fnt_bold = True) Then
		$s_atrbtoset &= "+bo"
	Else
		$s_atrbtoset &= "-bo"
	EndIf

	If ($s_fnt_Italic) Then
		$s_atrbtoset &= "+it"
	Else
		$s_atrbtoset &= "-it"
	EndIf

	If ($s_fnt_Underline) Then
		$s_atrbtoset &= "+un"
	Else
		$s_atrbtoset &= "-un"
	EndIf

	If ($s_fnt_Underline) Then
		$s_atrbtoset &= "+un"
	Else
		$s_atrbtoset &= "-un"
	EndIf

	If ($s_fnt_Strikethru) Then
		$s_atrbtoset &= "+st"
	Else
		$s_atrbtoset &= "-st"
	EndIf
	_GUICtrlRichEdit_SetDefaultAttributes($h_text, $s_atrbtoset)

EndFunc   ;==>_setdefault_font

Func _setColor()
	Local $s_fnt_Color = ReadSettings(".font.color", 0)
	$i_new_color = _ChooseColor(0, $s_fnt_Color, 0, $h_Main)
	If Not (@error) Then
		WriteSettings(".font.color", $i_new_color)

		_GUICtrlRichEdit_SetDefaultcolor($h_text, $i_new_color)
	EndIf
EndFunc   ;==>_setColor

Func _setBkGColor()
	Local $s_fnt_Color = ReadSettings(".font.bkgColor", 16777215)
	$i_new_color = _ChooseColor(0, $s_fnt_Color, 0, $h_Main)
	If Not (@error) Then
		WriteSettings(".font.bkgColor", $i_new_color)
		_GUICtrlRichEdit_SetDefaultBkColor($h_text, $i_new_color)
	EndIf
EndFunc   ;==>_setBkGColor

Func setBkGColor()
	Local $s_fnt_Color = ReadSettings(".font.bkgColor", 16777215)
	_GUICtrlRichEdit_SetDefaultBkColor($h_text, $s_fnt_Color)
EndFunc   ;==>setBkGColor
Func _speak_next_word()
	If UniversalSpeech_jfwIsAvailable() Then
		UniversalSpeech_jfwLoad()
		UniversalSpeech_jfwRunscript("SayNextWord")
		If @error Then MsgBox(16, "", @error)
	EndIf
	#cs
	$i_sel = Int(_GUICtrlRichEdit_GetSel($h_text)[1])
	$i_next_pos = _GUICtrlRichEdit_GetCharPosOfNextWord($h_text, $i_sel)
	$i_next_pos_lengh = _GUICtrlRichEdit_GetCharPosOfNextWord($h_text, $i_next_pos)
	if $i_next_pos = $i_next_pos_lengh then Return 1
	$i_next_pos_lengh -= 1
	$i_bcpcheck = _GUICtrlRichEdit_GetCharPosOfNextWord($h_text, $i_next_pos_lengh)
	if _GUICtrlRichEdit_GetCharPosOfNextWord($h_text, $i_bcpcheck)-($i_bcpcheck+1) >= 2 then $i_next_pos_lengh -= 1
	_GUICtrlRichEdit_SetSel($h_text, $i_next_pos, $i_next_pos_lengh)
	$s_texttospeak = _GUICtrlRichEdit_GetSelText($h_text)
	if StringRegExp($s_texttospeak, "[\(\)\d]", 0) then
	_speak_next_word()
	Return 0
	elseif StringRegExp($s_texttospeak, "[\r\n]", 0) then
	_GUICtrlRichEdit_SetSel($h_text, $i_next_pos+1, $i_next_pos_lengh+1)
	$s_texttospeak = _GUICtrlRichEdit_GetSelText($h_text)
	
	elseif StringInSTR($s_texttospeak, " ") then
	_GUICtrlRichEdit_SetSel($h_text, $i_next_pos, $i_next_pos_lengh-1)
	$s_texttospeak = _GUICtrlRichEdit_GetSelText($h_text)
	
	endIf
			if $b_accessibility then UniversalSpeech_SpeechSay($s_texttospeak, 1)
	#ce
	Return 1
EndFunc   ;==>_speak_next_word
Func _speak_prev_word()
	$i_sel = Int(_GUICtrlRichEdit_GetSel($h_text)[1])
	$i_prev_pos = _GUICtrlRichEdit_GetCharPosOfPreviousWord($h_text, $i_sel)
	$i_prev_pos_lengh = _GUICtrlRichEdit_GetCharPosOfNextWord($h_text, $i_prev_pos)
	If $i_prev_pos = $i_prev_pos_lengh Then Return 1
	$i_prev_pos_lengh -= 1
	$i_bcpcheck = _GUICtrlRichEdit_GetCharPosOfPreviousWord($h_text, $i_prev_pos_lengh)
	If _GUICtrlRichEdit_GetCharPosOfNextWord($h_text, $i_bcpcheck) - ($i_bcpcheck + 1) > 2 Then $i_prev_pos_lengh -= 1


	While $i_prev_pos >= $i_prev_pos_lengh
		$i_prev_pos = _GUICtrlRichEdit_GetCharPosOfPreviousWord($h_text, $i_prev_pos)
		$i_prev_pos_lengh = _GUICtrlRichEdit_GetCharPosOfNextWord($h_text, $i_next_pos)
		If $i_prev_pos = $i_prev_pos_lengh Then Return 1
		$i_prev_pos_lengh -= 1
		$i_bcpcheck = _GUICtrlRichEdit_GetCharPosOfPreviousWord($h_text, $i_prev_pos_lengh)
		If _GUICtrlRichEdit_GetCharPosOfNextWord($h_text, $i_bcpcheck) - ($i_bcpcheck + 1) > 2 Then $i_prev_pos_lengh -= 1
	WEnd
	_GUICtrlRichEdit_SetSel($h_text, $i_prev_pos, $i_prev_pos_lengh + 1)
	$s_texttospeak = _GUICtrlRichEdit_GetSelText($h_text)
	If StringRegExp($s_texttospeak, "[\(\)\d\s]", 0) Then
		_speak_prev_word()
		Return 0
	ElseIf StringRegExp($s_texttospeak, "[\r\n]", 0) Then
		_GUICtrlRichEdit_SetSel($h_text, $i_prev_pos + 1, $i_prev_pos_lengh + 1)
		$s_texttospeak = _GUICtrlRichEdit_GetSelText($h_text)
	EndIf
	If $b_accessibility Then UniversalSpeech_SpeechSay($s_texttospeak, 1)
	Return 1
EndFunc   ;==>_speak_prev_word

Func _play_this_ayah()
	If _BASS_ChannelIsActive($h_stream) Then
		_BASS_StreamFree($h_stream)
		$h_stream = -1
		AdlibUnRegister(_auto_play_Next)
		AdlibUnRegister("_play_to_end")
		$i_repeated = 1
		$i_repeated_all = 1
		Return 1
	EndIf
	AdlibUnRegister("_play_to_end")
	$i_repeated = 1
	$i_repeated_all = 1

	_get_aya()
	_playaya($a_currentlist[$i_last_aya][4], $a_currentlist[$i_last_aya][2])
	If $b_sel_ayah Then
		_GUICtrlRichEdit_SetSel($h_text, $a_currentlist[$i_last_aya][0], $a_currentlist[$i_last_aya][1])
	Else
		_GUICtrlRichEdit_GotoCharPos($h_text, $a_currentlist[$i_last_aya][0])
	EndIf
EndFunc   ;==>_play_this_ayah
Func _play_to_end()
	If _BASS_ChannelIsActive($h_stream) Then
		If $i_repeated_all = 1 Then
			_BASS_StreamFree($h_stream)
			$h_stream = -1
			AdlibUnRegister(_auto_play_Next)
			$i_repeated = 1
			Return 1
		Else
			$i_time = (_BASS_ChannelBytes2Seconds($h_stream, _BASS_ChannelGetLength($h_stream, $BASS_POS_BYTE)) * 1000)
			AdlibRegister("_play_to_end", $i_time)
			$i_repeated = 1
			Return 1
		EndIf
	EndIf
	AdlibUnRegister("_play_to_end")
	_get_aya()
	_playaya($a_currentlist[$i_last_aya][4], $a_currentlist[$i_last_aya][2])
	$i_time = (_BASS_ChannelBytes2Seconds($h_stream, _BASS_ChannelGetLength($h_stream, $BASS_POS_BYTE)) * 1000)

	If $b_sel_ayah Then
		_GUICtrlRichEdit_SetSel($h_text, $a_currentlist[$i_last_aya][0], $a_currentlist[$i_last_aya][1])
	Else
		_GUICtrlRichEdit_GotoCharPos($h_text, $a_currentlist[$i_last_aya][0])
	EndIf

	;	If Not ($i_last_aya + 1 >= UBound($a_currentlist)) Then
	AdlibRegister("_auto_play_Next", $i_time)
EndFunc   ;==>_play_to_end
Func _auto_play_Next()
	If (_BASS_ChannelIsActive($h_stream)) Then
		$i_time = (_BASS_ChannelBytes2Seconds($h_stream, _BASS_ChannelGetLength($h_stream, $BASS_POS_BYTE) - _BASS_ChannelGetPosition($h_stream, $BASS_POS_BYTE)) * 1000)
		AdlibRegister(_auto_play_Next, $i_time)
		Return 1
	EndIf
	If ($i_repetition > $i_repeated) Then
		_GUICtrlRichEdit_GotoCharPos($h_text, _get_aya())
		$i_repeated += 1
	Else
		$i_old_post = $i_last_aya
		_GUICtrlRichEdit_GotoCharPos($h_text, _get_aya("+1"))
		If $i_last_aya = $i_old_post Then
			If ($i_repeated_all <= $i_repetition_all) And Not ($i_repetition_all <= 1) Then
				_GUICtrlRichEdit_GotoCharPos($h_text, _get_aya(1))
				$i_repeated = 1
			Else
				Return 1
			EndIf

		EndIf
		$i_repeated = 1
	EndIf
	If $b_sel_ayah Then _GUICtrlRichEdit_SetSel($h_text, $a_currentlist[$i_last_aya][0], $a_currentlist[$i_last_aya][1])
	_playaya($a_currentlist[$i_last_aya][4], $a_currentlist[$i_last_aya][2])
	$i_time = (_BASS_ChannelBytes2Seconds($h_stream, _BASS_ChannelGetLength($h_stream, $BASS_POS_BYTE)) * 1000)

	If Not ($i_last_aya + 1 >= UBound($a_currentlist)) Then
		AdlibRegister(_auto_play_Next, $i_time)
		Return 1
	EndIf
	If ($i_repetition_all > $i_repeated_all) Then
		If $i_repeated = $i_repetition Then
			AdlibRegister("_play_to_end", $i_time)
			$i_repeated_all += 1
			$i_repeated = 1
			_GUICtrlRichEdit_GotoCharPos($h_text, _get_aya(1))

		Else
			AdlibRegister(_auto_play_Next, $i_time)
		EndIf
		Return 1
	EndIf
	If $i_repeated = $i_repetition Then
		AdlibUnRegister(_auto_play_Next)
		$i_repeated_all = 1
		$i_repeated = 1
	Else
		AdlibRegister(_auto_play_Next, $i_time)
	EndIf
	Return 1
EndFunc   ;==>_auto_play_Next
Func reciters_Manager()
	Local $i_rec_test = 0, $i_surah_tst
	Opt("GUICloseOnESC", 1)
	Opt("GUIOnEventMode", 0)
	GUISetState(@SW_DISABLE, $h_Main)
	Local $h_recitersGUI = GUICreate("إدارة القراء", 400, 250, -1, -1, BitOR($WS_SYSMENU, $WS_CLIPCHILDREN, $WS_CLIPSIBLINGS, $WS_MAXIMIZEBOX, $WS_MINIMIZEBOX, $WS_SIZEBOX, $WS_SYSMENU), BitOR($WS_EX_LAYOUTRTL, $WS_EX_MDICHILD), $h_Main)
	GUICtrlCreateLabel("القارئ", 100, 10, 200, 20)
	GUICtrlSetFont(-1, 14, 700, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	Local $i_combo_reciters = GUICtrlCreateList("", 20, 30, 360, 80, BitOR($LBS_DISABLENOSCROLL, $WS_vSCROLL, $WS_hSCROLL))
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	Local $i_test = GUICtrlCreateButton("تجريب القارء...", 40, 110, 150, 30)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)

	Local $i_more = GUICtrlCreateButton("خيارات القارء...", 210, 110, 150, 30)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	$h_cntxt = GUICtrlCreateContextMenu($i_combo_reciters)
	$i_SetDefault = GUICtrlCreateMenuItem("إختيار القارئ الإفتراضي", $h_cntxt)
	$i_downloadrec = GUICtrlCreateMenuItem("تحميل المصحف كامل...", $h_cntxt)
	$i_removeRec = GUICtrlCreateMenuItem("حذف المصحف المحمل...", $h_cntxt)
	Local $i_ok_btn = GUICtrlCreateButton("حسنا", 10, 160, 100, 30, 0x01)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	Local $i_Cancel_btn = GUICtrlCreateButton("إلغاء", 190, 160, 100, 30)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlSetResizing(-1, 1)
	GUISetState(@SW_SHOW, $h_recitersGUI)

	$iRval = _SQLite_GetTable2D($h_recitersDb, "SELECT * FROM reciters;", $a_dbres, $iRows, $iColumns)
	If IsArray($a_dbres) Then
		_ArraySort($a_dbres, 0, 1, 0, 1)
		For $i = 1 To UBound($a_dbres) - 1
			GUICtrlSetData($i_combo_reciters, $a_dbres[$i][1] & " (" & $a_dbres[$i][2] & " " & $a_dbres[$i][3] & " " & $a_dbres[$i][5] & ")")
			If $a_dbres[$i][0] = readSettings(".settings.reciterId", 10) Then _GUICtrlListBox_SetCurSel($i_combo_reciters, $i - 1)
		Next
	EndIf
	While 1
		If $i_rec_test >= 3 Then
			$i_rec_test = 0
		ElseIf ($i_rec_test > 0) And Not (_BASS_ChannelIsActive($h_stream)) Then
			$i_rec_test += 1
			_playaya($i_surah_tst, $i_rec_test, Int($a_dbres[_GUICtrlListBox_GetCurSel($i_combo_reciters) + 1][0]), $a_dbres[_GUICtrlListBox_GetCurSel($i_combo_reciters) + 1][4])
		EndIf

		Switch GUIGetMsg()
			Case $GUI_event_close, $i_Cancel_btn
				GUIDelete($h_recitersGUI)
				ExitLoop
			Case $i_test
				If $i_rec_test = 0 Then
					$i_surah_tst = Random(1, 114, 1)
					$i_rec_test = 1
					_playaya($i_surah_tst, $i_rec_test, Int($a_dbres[_GUICtrlListBox_GetCurSel($i_combo_reciters) + 1][0]), $a_dbres[_GUICtrlListBox_GetCurSel($i_combo_reciters) + 1][4])
				Else
					$i_rec_test = 0
					_BASS_StreamFree($h_stream)
					$h_stream = -1
				EndIf
			Case $i_combo_reciters
				$i_rec_test = 0
			Case $i_more
				ShowMenu($h_recitersGUI, $i_more, $h_cntxt)
			Case $i_removeRec
				If FileExists(@ScriptDir & "\reciters\" & Int($a_dbres[_GUICtrlListBox_GetCurSel($i_combo_reciters) + 1][0])) Then
					If MsgBox(36, "حذف المصحف", "هل حقا ترغب في حذف المصحف الصوتي بصوت " & $a_dbres[_GUICtrlComboBox_GetCurSel($i_combo_reciters) + 1][1] & @CRLF & "لو قمت بالمتابعة لا يمكنك الإستفادة من خدمات البرنامج الصوتية بدون أنترنت" & @CRLF & "يمكنك في أي وقت إعادة تحميله من خلال البرنامج", "", $h_recitersGUI) = 6 Then
						DirRemove(@ScriptDir & "\reciters\" & Int($a_dbres[_GUICtrlComboBox_GetCurSel($i_combo_reciters) + 1][0]), 1)
						MsgBox(64, "تم", "تم حذف المصحف الصوتي بنجاح", "", $h_recitersGUI)
					EndIf
				EndIf
			Case $i_downloadrec
				If @Compiled Then
					ShellExecute(@ScriptFullPath, "--dl " & Int($a_dbres[_GUICtrlListBox_GetCurSel($i_combo_reciters) + 1][0]), @ScriptDir, "RunAs")
				Else
					ShellExecute(@AutoItExe, '"' & @ScriptFullPath & '" --dl ' & Int($a_dbres[_GUICtrlListBox_GetCurSel($i_combo_reciters) + 1][0]), @ScriptDir, "RunAs")
				EndIf
				GUIDelete($h_recitersGUI)
				ExitLoop

			Case $i_ok_btn, $i_SetDefault
				If _GUICtrlListBox_GetCurSel($i_combo_reciters) < 0 Then ContinueLoop
				WriteSettings(".settings.reciterId", Int($a_dbres[_GUICtrlListBox_GetCurSel($i_combo_reciters) + 1][0]))
				$s_recitersDir = $a_dbres[_GUICtrlListBox_GetCurSel($i_combo_reciters) + 1][4]
				$i_reciterId = Int($a_dbres[_GUICtrlListBox_GetCurSel($i_combo_reciters) + 1][0])
				GUIDelete($h_recitersGUI)
				ExitLoop
		EndSwitch
	WEnd
	Opt("GUICloseOnESC", 0)
	Opt("GUIOnEventMode", 1)
	GUISetState(@SW_ENABLE, $h_Main)
	WinActivate($h_Main, "")
	_BASS_StreamFree($h_stream)
	$h_stream = -1
EndFunc   ;==>reciters_Manager
Func _about_msg()
	$s_abt_text = "عن برنامج قرآني" & @CRLF & _
			"يعتبر هذا البرنامج جامع للقرآن الكريم, حيث يمكنكم من قراءة القرآن الكريم, الإستماع إلى الآيات صوتيا, تفسير الآيات  بمختلف التفاسير, إعراب الآيات, معرفة أسباب نزول الآيات, البحث في القرآن الكريم, وغيرها من الميزات التي يمكنكم التعرف عليها بكل سهولة." & @CRLF & _
			"    ملاحظة :" & @CRLF & _
			"هذا البرنامج هو وقف للاه تعالى, الرجاء حاولوا مساعدتي في نشره وإيصاله لأكبر عدد من المستخدمين كي تعم الفائدة, وأجركم على الله." & @CRLF & _
			"رجاءا لا تنسوني من خالص دعائكم" & @CRLF

	MsgBox(64, "عن قرآني", $s_abt_text, "", $h_Main)
EndFunc   ;==>_about_msg
Func _goto_website()
	ShellExecute("https://ng-space.com/projects/programs/qurani/")
EndFunc   ;==>_goto_website
Func _telegram_contact()
	ShellExecute("https://t.me/nacerbaaziz")
EndFunc   ;==>_telegram_contact
Func _Whatsapp_contact()
	ShellExecute("https://wa.me/213561921067")
EndFunc   ;==>_Whatsapp_contact
Func _messenger_contact()
	ShellExecute("https://m.me/baaziznacer1")
EndFunc   ;==>_messenger_contact
Func _Facebook_contact()
	ShellExecute("https://fb.com/baaziznacer1")
EndFunc   ;==>_Facebook_contact
Func _mail_contact()
	ClipPut("nacerstile@gmail.com")
EndFunc   ;==>_mail_contact
Func _github()
	ShellExecute("https://github.com/baaziznasser")
EndFunc   ;==>_github
Func _helpfile()
	ShellExecute('hh.exe', '"' & @ScriptDir & '\Qurani.chm"')
EndFunc   ;==>_helpfile
Func _get_ayah_info()
	_get_aya()
	$s_sajda = Int($a_currentlist[$i_last_aya][10])
	If $s_sajda = 1 Then
		$s_sajda = "نعم"
	Else
		$s_sajda = "لا"
	EndIf

	$s_sajdaOb = Int($a_currentlist[$i_last_aya][11])
	If ($s_sajdaOb = 1) Then
		$s_sajdaOb = "نعم"
	Else
		$s_sajdaOb = "لا"
	EndIf
	Local $s_infotext = StringFormat("%s\r\nالآية: %i\r\nالصفحة: %i\r\nالربع: %i\r\nالحزب: %i\r\nالجزء: %i\r\nتحتوي الآية على سجدة: %s\r\nالسجدة إجبارية: %s.\r\n", $a_currentlist[$i_last_aya][3], $a_currentlist[$i_last_aya][2], $a_currentlist[$i_last_aya][7], $a_currentlist[$i_last_aya][8], $a_currentlist[$i_last_aya][6], $a_currentlist[$i_last_aya][5], $s_sajda, $s_sajdaOb)
	_pop_upmessage($h_Main, $s_infotext, "معلومات الآية " & $a_currentlist[$i_last_aya][2] & " من " & $a_currentlist[$i_last_aya][3])
EndFunc   ;==>_get_ayah_info

Func _get_surah_info()
	_get_aya()
	Local $revelationType = "مدنية"
	If json_get($a_surahs_meta[$a_currentlist[$i_last_aya][4] - 1], ".revelationType") = "Meccan" Then $revelationType = "مكية"
	Local $s_infotext = StringFormat("%s\r\nرقم السورة : %i\r\nعدد آيات السورة : %i\r\nتبدأ من الآية رقم : %i\r\nتنتهي في الآية رقم : %i\r\nنوع السورة : %s", json_get($a_surahs_meta[$a_currentlist[$i_last_aya][4] - 1], ".name"), Int(json_get($a_surahs_meta[$a_currentlist[$i_last_aya][4] - 1], ".number")), Int(json_get($a_surahs_meta[$a_currentlist[$i_last_aya][4] - 1], ".numberOfAyahs")), Int(json_get($a_surahs_meta[$a_currentlist[$i_last_aya][4] - 1], ".firstAyahNumber")), Int(json_get($a_surahs_meta[$a_currentlist[$i_last_aya][4] - 1], ".lastAyahNumber")), $revelationType)
	_pop_upmessage($h_Main, $s_infotext, "معلومات " & $a_currentlist[$i_last_aya][3])
EndFunc   ;==>_get_surah_info

Func WM_NOTIFY($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $wParam
	Local $hWndFrom, $iCode, $tNMHDR, $tMsgFilter, $hMenu
	$tNMHDR = DllStructCreate($tagNMHDR, $lParam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
	$iCode = DllStructGetData($tNMHDR, "Code")
	Switch $hWndFrom
		Case $h_text
			Select
				Case $iCode = $EN_MSGFILTER
					$tMsgFilter = DllStructCreate($tagMSGFILTER, $lParam)
					If DllStructGetData($tMsgFilter, "msg") = $WM_RBUTTONUP Then
						ShowMenu($h_Main, $h_text, $h_ContextMenu)
					ElseIf DllStructGetData($tMsgFilter, "msg") = $WM_KEYDOWN Then
						If _IsPressed("5D") Then
							While _IsPressed("5D")
								Sleep(25)
							WEnd
							;					Local $a_pos = _GUICtrlRichEdit_GetXYFromCharPos($h_text, _GUICtrlRichEdit_GetSel($h_text)[1])
							;					MouseMove($a_pos[0], $a_pos[1])
							ShowMenu($h_Main, $h_text, $h_ContextMenu)
						Else
							If (_IsPressed(10) And _IsPressed(79)) Then
								While (_IsPressed(10) And _IsPressed(79))
									Sleep(25)
								WEnd
								ShowMenu($h_Main, $h_text, $h_ContextMenu)
							EndIf
						EndIf
					ElseIf DllStructGetData($tMsgFilter, "msg") = $WM_SYSKEYDOWN Then
						If (_IsPressed(10) And _IsPressed(79)) Then
							While (_IsPressed(10) And _IsPressed(79))
								Sleep(25)
							WEnd
							ShowMenu($h_Main, $h_text, $h_ContextMenu)
						EndIf
					EndIf
			EndSelect
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY
Func _manage_repetition()
	Opt("GUICloseOnESC", 1)
	Opt("GUIOnEventMode", 0)

	Local $h_repeateGUI = GUICreate("التكرار", 350, 200, -1, -1, BitOR($WS_SYSMENU, $WS_CLIPCHILDREN, $WS_CLIPSIBLINGS, $WS_MAXIMIZEBOX, $WS_MINIMIZEBOX, $WS_SIZEBOX, $WS_SYSMENU), BitOR($WS_EX_LAYOUTRTL, $WS_EX_MDICHILD), $h_Main)
	GUICtrlCreateLabel("تكرار الآية", 10, 10, 150, 20)
	GUICtrlSetResizing(-1, 1)
	GUICtrlSetFont(-1, 14, 700, 0, "Times New Roman")
	Local $inp_aya_rep = GUICtrlCreateInput($i_repetition, 35, 30, 100, 30, $es_number)
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetResizing(-1, 1)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlCreateUpdown($inp_aya_rep, $UDS_ARROWKEYS)
	GUICtrlSetLimit(-1, 10, 1)
	GUICtrlCreateLabel("عدد الدورات", 190, 10, 150, 20)
	GUICtrlSetResizing(-1, 1)
	GUICtrlSetFont(-1, 14, 700, 0, "Times New Roman")

	Local $inp_sura_rep = GUICtrlCreateInput($i_repetition_all, 215, 30, 100, 30, $es_number)
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetResizing(-1, 1)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUICtrlCreateUpdown($inp_sura_rep, $UDS_ARROWKEYS)
	GUICtrlSetLimit(-1, 10, 1)
	Local $set_def_repetition = GUICtrlCreateCheckbox("جعل الإعدادات إفتراضية", 25, 80, 300, 30)
	GUICtrlSetResizing(-1, 1)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")

	Local $i_ok_btn = GUICtrlCreateButton("حسنا", 10, 120, 100, 30, 0x01)
	GUICtrlSetResizing(-1, 1)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")

	Local $i_Cancel_btn = GUICtrlCreateButton("إلغاء", 240, 120, 100, 30)
	GUICtrlSetResizing(-1, 1)
	GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman")
	GUISetState(@SW_DISABLE, $h_Main)
	GUISetState(@SW_SHOW, $h_repeateGUI)
	While 1
		Switch GUIGetMsg()
			Case $GUI_event_close, $i_Cancel_btn
				GUIDelete($h_repeateGUI)
				ExitLoop
			Case $i_ok_btn
				Local $first_num = GUICtrlRead($inp_aya_rep)
				If ($first_num < 0) Or ($first_num > 10) Then
					GUICtrlSetState($inp_aya_rep, $GUI_focus)
					ContinueLoop
				EndIf
				Local $last_num = GUICtrlRead($inp_sura_rep)
				If ($last_num < 0) Or ($last_num > 10) Then
					GUICtrlSetState($inp_sura_rep, $GUI_focus)
					ContinueLoop
				EndIf
				$i_repetition = $first_num
				$i_repetition_all = $last_num

				If _IsChecked($set_def_repetition) Then
					WriteSettings(".settings.Rep_num", $i_repetition)
					WriteSettings(".settings.Rep_cycles", $i_repetition_all)
				EndIf
				GUIDelete($h_repeateGUI)
				ExitLoop
		EndSwitch
	WEnd
	GUISetState(@SW_ENABLE, $h_Main)
	WinActivate($h_Main, "")
	Opt("GUICloseOnESC", 0)
	Opt("GUIOnEventMode", 1)
	Return 1
EndFunc   ;==>_manage_repetition

Func _checkUpdate()
	Local $b_read_dt = InetRead("http://api.ng-space.com/updates/qurani.json", 11)
	If $b_read_dt = "" Then
		$b_read_dt = InetRead("http://api.mx-blind.com/updates/qurani.json", 11)
		If $b_read_dt = "" Then
			MsgBox(16, "خطأ", "تعذر البحث عن التحديثات، الرجاء المحاولة لاحقا." & @CRLF & "في حال تكرر الخطأ أكثر من مرة يرجى التواصل مع المطور.", "", $h_Main)
			Return -1
		EndIf
	EndIf
	Local $s_update_conv = BinaryToString($b_read_dt, 4)
	Local $o_obj_dt = Json_decode($s_update_conv)
	If Not (IsObj($o_obj_dt)) Then
		MsgBox(16, "خطأ", "تعذر البحث عن التحديثات، الرجاء المحاولة لاحقا." & @CRLF & "في حال تكرر الخطأ أكثر من مرة يرجى التواصل مع المطور.", "", $h_Main)
		Return -1
	EndIf
	Local $o_qurani_up = Json_get($o_obj_dt, ".qurani")
	If Not (IsObj($o_qurani_up)) Then
		MsgBox(16, "خطأ", "تعذر البحث عن التحديثات، الرجاء المحاولة لاحقا." & @CRLF & "في حال تكرر الخطأ أكثر من مرة يرجى التواصل مع المطور.", "", $h_Main)
		Return -1

	EndIf
	$s_version_new = Json_get($o_qurani_up, ".version")
	Local $s_date_new = Json_get($o_qurani_up, ".date")
	If $s_version_new > $S_crnt_VersionString Then
		If MsgBox(36, "يتوفر تحديث جديد", StringFormat("يتوفر تحديث جديد من قرآني، الإصدار %s.\r\nتم نشر التحديث بتاريخ %s.\r\nهل تريد تحميل الإصدار؟", $s_version_new, $s_date_new), "", $h_Main) = 6 Then ShellExecute(Json_get($o_qurani_up, ".url"))
		Return 1
	Else
		MsgBox(64, "لا يتوفر تحديث جديد", "أنت بالفعل تستخدم أحدث إصدار من البرنامج, الإصدار رقم " & $S_crnt_VersionString, "", $h_Main)
		Return 1
	EndIf
	Return 0
EndFunc   ;==>_checkUpdate
