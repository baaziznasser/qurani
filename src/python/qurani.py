"""
This file is part of the Qurani project, created by Nacer Baaziz.
Copyright (c) 2023 Nacer Baaziz
Qurani is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.
Qurani is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with Qurani. If not, see https://www.gnu.org/licenses/.
You are free to modify this file, but please keep this header.
For more information, visit: https://github.com/baaziznasser/qurani
"""

#code start here

import wx
from imports import quran
from imports import search
from imports import tafsir

class qurani(wx.Frame):
	quranobj = quran.quran_mgr()
	quranobj.aya_to_line = False
	quranobj.show_ayah_number = False
	quranobj.load_quran("database/quran/quran.db")

	def __init__(self):
		wx.Frame.__init__(self, None, title="قرآني", size=(900, 700), style=wx.RESIZE_BORDER | wx.MINIMIZE_BOX | wx.MAXIMIZE_BOX | wx.CLOSE_BOX | wx.SYSTEM_MENU | wx.CAPTION)
		self.SetLayoutDirection(wx.LayoutDirection.Layout_RightToLeft)
		self.panel = wx.Panel(self, wx.ID_ANY)
		#create menu bar
		self.menu = wx.MenuBar(style=2)
		self.main_menu = wx.Menu(-1)
		self.type_pages = self.main_menu.AppendRadioItem(wx.ID_ANY, "الصفحات \tshift+1")
		self.Bind(wx.EVT_MENU, self.ev_type_pages, self.type_pages)
		self.type_surahs = self.main_menu.AppendRadioItem(wx.ID_ANY, "السور\tshift+2")
		self.Bind(wx.EVT_MENU, self.ev_type_surahs, self.type_surahs)
		self.type_quarters = self.main_menu.AppendRadioItem(wx.ID_ANY, "الأرباع\tshift+3")
		self.Bind(wx.EVT_MENU, self.ev_type_quarters, self.type_quarters)
		self.type_hizbs = self.main_menu.AppendRadioItem(wx.ID_ANY, "الأحزاب\tshift+4")
		self.Bind(wx.EVT_MENU, self.ev_type_hizbs, self.type_hizbs)
		self.type_juzs = self.main_menu.AppendRadioItem(wx.ID_ANY, "الأجزاء\tshift+5")
		self.Bind(wx.EVT_MENU, self.ev_type_juzs, self.type_juzs)
		self.save_pos = self.main_menu.Append(wx.ID_ANY, "حفظ الموضع الحالي \tctrl+s")
		self.save = self.main_menu.Append(wx.ID_ANY, "حفظ المحتوى الحالي ك... \tctrl+shift+s")
		self.quit = self.main_menu.Append(wx.ID_ANY, "غلق البرنامج")
		self.menu.Append(self.main_menu, "ال&رئيسية")

		self.nav_menu = wx.Menu(-1)
		self.next_item = self.nav_menu.Append(wx.ID_ANY, "التالي \talt+right")
		self.Bind(wx.EVT_MENU, self.ev_next, self.next_item)
		self.back_item = self.nav_menu.Append(wx.ID_ANY, "السابق \talt+left")
		self.Bind(wx.EVT_MENU, self.ev_back, self.back_item)

		self.menu.Append(self.nav_menu, "ال&تنقل")

		self.goto = self.nav_menu.Append(wx.ID_ANY, "الذهاب إلى ... \tctrl+shift+g")
		self.Bind(wx.EVT_MENU, self.ev_goto, self.goto)
		self.goto_line = self.nav_menu.Append(wx.ID_ANY, "الذهاب إلى سطر... \tctrl+g")
		self.Bind(wx.EVT_MENU, self.ev_goto_line, self.goto_line)

		self.SetMenuBar(self.menu)
		# create sizer
		sizer = wx.BoxSizer(wx.VERTICAL)
		
		# add title
		self.qtitle = wx.StaticText(self.panel, wx.ID_ANY, "الصفحة 1:", )
		sizer.Add(self.qtitle, 0, wx.ALL, 5)
		
		# add text control widget
		self.qtxt = wx.TextCtrl(self.panel, wx.ID_ANY, "", size=(860, 400), style=wx.TE_MULTILINE | wx.TE_READONLY | wx.TE_RICH2 | wx.TE_RIGHT | wx.TE_BESTWRAP)
		self.qtxt.Bind(wx.EVT_KEY_UP, self.ev_KeyPress)
		self.qtxt.Bind(wx.EVT_RIGHT_UP, self.ev_KeyPress)
		sizer.Add(self.qtxt, 1, wx.EXPAND | wx.ALL, 5)
		
		self.menu_txt = wx.Menu()
		self.play_context = self.menu_txt.Append(wx.ID_ANY, "الإستماع إلى الآية الحالية")
		self.copy_context = self.menu_txt.Append(wx.ID_ANY, "نسخ الآية الحالية")
		self.info_context = self.menu_txt.Append(wx.ID_ANY, "معلومات الآية الحالية")
		self.tafsir_context = self.menu_txt.Append(wx.ID_ANY, "تفسير الآية الحالية")
		self.erab_context = self.menu_txt.Append(wx.ID_ANY, "إعراب الآية الحالية")
		self.tanzil_context = self.menu_txt.Append(wx.ID_ANY, "أسباب نزول الآية الحالية")
		# add buttons
		buttons_sizer = wx.BoxSizer(wx.HORIZONTAL)
		self.next = wx.Button(self.panel, wx.ID_ANY, "التالي", size=(110, 30))
		self.next.Bind(wx.EVT_BUTTON, self.ev_next)
		self.next.SetMinSize((100, 30))
		buttons_sizer.Add(self.next, 0, wx.ALL, 5)
		self.tafsir = wx.Button(self.panel, wx.ID_ANY, "تفسير الآية الحالية", size=(200, 30))
		self.tafsir.SetMinSize((200, 30))
		buttons_sizer.Add(self.tafsir, 0, wx.ALL, 5)
		self.erab = wx.Button(self.panel, wx.ID_ANY, "إعراب الآية الحالية", size=(200, 30))
		self.erab.SetMinSize((200, 30))
		buttons_sizer.Add(self.erab, 0, wx.ALL, 5)
		self.tanzil = wx.Button(self.panel, wx.ID_ANY, "أسباب نزوول الآية الحالية", size=(200, 30))
		self.tanzil.SetMinSize((200, 30))
		buttons_sizer.Add(self.tanzil, 0, wx.ALL, 5)
		self.back = wx.Button(self.panel, wx.ID_ANY, "السابق", size=(110, 30))
		self.back.Bind(wx.EVT_BUTTON, self.ev_back)
		self.back.SetMinSize((110, 30))
		buttons_sizer.Add(self.back, 0, wx.ALL, 5)
		sizer.Add(buttons_sizer, 0, wx.EXPAND | wx.ALL, 20)
		
		buttons_sizer2 = wx.BoxSizer(wx.HORIZONTAL)
		self.search = wx.Button(self.panel, wx.ID_ANY, "البحث في القرآن الكريم")
		self.search.SetMinSize((220, 30))
		buttons_sizer2.Add(self.search, 0, wx.ALL, 5)
		self.quicknav = wx.Button(self.panel, wx.ID_ANY, "الوصول السريع", size=(220, 30))
		self.quicknav.SetMinSize((220, 30))
		buttons_sizer2.Add(self.quicknav, 0, wx.ALL, 5)
		self.savepos = wx.Button(self.panel, wx.ID_ANY, "حفظ الموضع الحالي", size=(220, 30))
		self.savepos.SetMinSize((220, 30))
		buttons_sizer2.Add(self.savepos, 0, wx.ALL, 5)
		self.settings = wx.Button(self.panel, wx.ID_ANY, "إعدادات البرنامج", size=(220, 30))
		self.settings.SetMinSize((220, 30))
		buttons_sizer2.Add(self.settings, 0, wx.ALL, 5)
		sizer.Add(buttons_sizer2, 0, wx.EXPAND | wx.ALL, 20)
		
		self.panel.SetSizer(sizer)
		
		# make window resizable
		self.SetMinSize((900, 800))
		self.Show()

		self.qtxt.SetValue(self.quranobj.get_page(1))

	def ev_KeyPress(self, ev):
		if hasattr(ev, "GetKeyCode"):

			print(self.quranobj.get_ayah_from_pos(self.qtxt.GetInsertionPoint()))
			keycode = ev.GetKeyCode()
		elif hasattr(ev, "Button"):
			print("ok2")
			keycode = ev
		else:
			keycode = None
		cr_pos = self.qtxt.GetInsertionPoint()
		col = self.qtxt.PositionToCoords(cr_pos)
		if keycode == wx.WXK_WINDOWS_MENU or (keycode == ev and ev.RightUp):
			self.qtxt.PopupMenu(self.menu_txt, col)
		else:
			ev.Skip()

	def ev_goto(self, ev):
		# Create the dialog
		dialog = wx.Dialog(self, title="الذهاب إلى")

		# Create SpinCtrl for number input
		num_lbl = wx.StaticText(dialog, wx.ID_ANY, "أدخل رقم للانتقال المباشر :")
		number_input = wx.SpinCtrl(dialog, wx.ID_ANY, str(self.quranobj.current_pos), min=1, max=self.quranobj.max_pos)
		number_input.SetFocus()
		# Create "Go" button
		go_button = wx.Button(dialog, wx.ID_ANY, "إ&ذهب")
		go_button.Bind(wx.EVT_BUTTON, lambda event: dialog.EndModal(wx.ID_OK))
		go_button.SetDefault()
		dialog.SetAffirmativeId(go_button.GetId())

		# Create "Cancel" button
		cancel_button = wx.Button(dialog, wx.ID_ANY, "إل&غاء")
		cancel_button.Bind(wx.EVT_BUTTON, lambda event: dialog.EndModal(wx.ID_CANCEL))
		dialog.SetEscapeId(cancel_button.GetId())
		# Add all widgets to dialog
		sizer = wx.BoxSizer(wx.VERTICAL)

		sizer.Add(num_lbl, flag=wx.ALIGN_CENTER)
		sizer.Add(number_input, flag=wx.ALIGN_CENTER)
		sizer.Add(wx.StaticLine(dialog), flag=wx.EXPAND|wx.TOP|wx.BOTTOM, border=10)
		sizer.Add(go_button, flag=wx.ALIGN_CENTER)
		sizer.Add(cancel_button, flag=wx.ALIGN_CENTER)
		dialog.SetSizer(sizer)
		sizer.Fit(dialog)

		# Show the dialog and get the result
		result = dialog.ShowModal()

		# Check if user clicked "Go" button
		if result == wx.ID_OK:
			input_value = number_input.GetValue()
			txt = self.quranobj.goto(input_value)
			if txt != "":
				self.qtxt.SetValue(txt)

		# Destroy the dialog
		dialog.Destroy()


	def ev_goto_line(self, ev):
		# Create the dialog
		dialog = wx.Dialog(self, title="الذهاب إلى")

		# Create SpinCtrl for number input
		num_lbl = wx.StaticText(dialog, wx.ID_ANY, "أدخل رقم السطر للانتقال المباشر :")
		col = self.qtxt.PositionToXY(self.qtxt.GetInsertionPoint())
		number_input = wx.SpinCtrl(dialog, wx.ID_ANY, str(col[2]+1), min=1, max=self.qtxt.GetNumberOfLines())
		number_input.SetFocus()
		# Create "Go" button
		go_button = wx.Button(dialog, wx.ID_ANY, "إ&ذهب")
		go_button.Bind(wx.EVT_BUTTON, lambda event: dialog.EndModal(wx.ID_OK))
		go_button.SetDefault()
		dialog.SetAffirmativeId(go_button.GetId())

		# Create "Cancel" button
		cancel_button = wx.Button(dialog, wx.ID_ANY, "إل&غاء")
		cancel_button.Bind(wx.EVT_BUTTON, lambda event: dialog.EndModal(wx.ID_CANCEL))
		dialog.SetEscapeId(cancel_button.GetId())
		# Add all widgets to dialog
		sizer = wx.BoxSizer(wx.VERTICAL)

		sizer.Add(num_lbl, flag=wx.ALIGN_CENTER)
		sizer.Add(number_input, flag=wx.ALIGN_CENTER)
		sizer.Add(wx.StaticLine(dialog), flag=wx.EXPAND|wx.TOP|wx.BOTTOM, border=10)
		sizer.Add(go_button, flag=wx.ALIGN_CENTER)
		sizer.Add(cancel_button, flag=wx.ALIGN_CENTER)
		dialog.SetSizer(sizer)
		sizer.Fit(dialog)

		# Show the dialog and get the result
		result = dialog.ShowModal()

		# Check if user clicked "Go" button
		if result == wx.ID_OK:
			input_value = number_input.GetValue()
			txt = self.quranobj.goto(input_value)
			if txt != "":
				self.qtxt.SetValue(txt)

		# Destroy the dialog
		dialog.Destroy()




	def ev_type_pages(self, ev):
		txt = self.quranobj.get_page(1)
		if txt != "":
			self.qtxt.SetValue(txt)

	def ev_type_surahs(self, ev):
		txt = self.quranobj.get_surah(1)
		if txt != "":
			self.qtxt.SetValue(txt)

	def ev_type_quarters(self, ev):
		txt = self.quranobj.get_quarter(1)
		if txt != "":
			self.qtxt.SetValue(txt)

	def ev_type_hizbs(self, ev):
		txt = self.quranobj.get_hizb(1)
		if txt != "":
			self.qtxt.SetValue(txt)

	def ev_type_juzs(self, ev):
		txt = self.quranobj.get_juzz(1)
		if txt != "":
			self.qtxt.SetValue(txt)



	def ev_next(self, ev):
		txt = self.quranobj.next()
		if txt != "":
			self.qtxt.SetValue(txt)

	def ev_back(self, ev):
		txt = self.quranobj.back()
		if txt != "":
			self.qtxt.SetValue(txt)

if __name__ == "__main__":
	app = wx.App()
	qurani()
	app.MainLoop()