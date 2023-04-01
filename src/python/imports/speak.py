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

import os
import time
from ctypes import cdll as dll
univ_dll = os.path.join(os.getcwd(), "libraries", "UniversalSpeech.dll")
class univ_speech:
	def __init__(self):
		try:
			self.lib = dll.LoadLibrary(univ_dll)
		except:
			self.lib = None

	def speak(self, text: str, stop: bool = False):
		if self.lib == None:
			return None
		try:
			self.lib.speechSay(text, stop)
		except:
			return None
		return 1

	def stop(self):
		if self.lib == None:
			return None
		try:
			self.lib.speechStop()
		except:
			return None
		return 1

