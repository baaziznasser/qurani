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

import time
import ctypes
class AudioPlayer:
	def __init__(self, bass_file):
		self.bass_module = ctypes.WinDLL(bass_file)
		self.func_type = ctypes.WINFUNCTYPE
		self.QWORD = ctypes.c_int64
		self.DOWNLOADPROC = self.func_type(ctypes.c_void_p, ctypes.c_void_p, ctypes.c_ulong, ctypes.c_void_p)
		self.HSTREAM = ctypes.c_ulong
		self.HCHANNEL = ctypes.c_ulong
		self.STREAMPROC = self.func_type(ctypes.c_ulong, self.HSTREAM, ctypes.c_void_p, ctypes.c_ulong, ctypes.c_void_p)
		self.BASS_ErrorGetCode = self.func_type(ctypes.c_int)(('BASS_ErrorGetCode', self.bass_module))
		self.BASS_Init = self.func_type(ctypes.c_bool, ctypes.c_int, ctypes.c_ulong, ctypes.c_ulong, ctypes.c_void_p, ctypes.c_void_p)(('BASS_Init', self.bass_module))
		self.BASS_Free = self.func_type(ctypes.c_bool)(('BASS_Free', self.bass_module))
		self.BASS_StreamCreate = self.func_type(self.HSTREAM, ctypes.c_ulong, ctypes.c_ulong, ctypes.c_ulong, self.STREAMPROC, ctypes.c_void_p)(('BASS_StreamCreate', self.bass_module))
		self.BASS_StreamCreateFile = self.func_type(self.HSTREAM, ctypes.c_bool, ctypes.c_void_p, self.QWORD, self.QWORD, ctypes.c_ulong)(('BASS_StreamCreateFile', self.bass_module))
		self.BASS_StreamCreateURL = self.BASS_StreamCreateURL = self.func_type(self.HSTREAM, ctypes.c_char_p, ctypes.c_ulong, ctypes.c_ulong, ctypes.c_void_p, ctypes.c_void_p)(('BASS_StreamCreateURL', self.bass_module))
		self.BASS_StreamFree = self.func_type(ctypes.c_bool, self.HSTREAM)(('BASS_StreamFree', self.bass_module))
		self.BASS_ChannelBytes2Seconds = self.func_type(ctypes.c_double, self.HSTREAM, self.QWORD)(('BASS_ChannelBytes2Seconds', self.bass_module))
		self.BASS_ChannelSeconds2Bytes = self.func_type(self.QWORD, self.HSTREAM, ctypes.c_double)(('BASS_ChannelSeconds2Bytes', self.bass_module))
		self.BASS_ChannelIsActive = self.func_type(ctypes.c_ulong, self.HSTREAM)(('BASS_ChannelIsActive', self.bass_module))
		self.BASS_ChannelPlay = self.func_type(ctypes.c_bool, self.HSTREAM, ctypes.c_bool)(('BASS_ChannelPlay', self.bass_module))
		self.BASS_ChannelStop = self.func_type(ctypes.c_bool, self.HSTREAM)(('BASS_ChannelStop', self.bass_module))
		self.BASS_ChannelPause = self.func_type(ctypes.c_bool, self.HSTREAM)(('BASS_ChannelPause', self.bass_module))
		self.BASS_ChannelGetLength = self.func_type(self.QWORD, self.HSTREAM, ctypes.c_ulong)(('BASS_ChannelGetLength', self.bass_module))
		self.BASS_ChannelSetPosition = self.func_type(ctypes.c_bool, self.HSTREAM, self.QWORD, ctypes.c_ulong)(('BASS_ChannelSetPosition', self.bass_module))
		self.BASS_ChannelGetPosition = self.func_type(self.QWORD, self.HSTREAM, ctypes.c_ulong)(('BASS_ChannelGetPosition', self.bass_module))
		self.BASS_ChannelSetAttribute = self.func_type(ctypes.c_bool, ctypes.c_ulong, ctypes.c_ulong, ctypes.c_float)(('BASS_ChannelSetAttribute', self.bass_module))
		self.BASS_ChannelGetAttribute = self.func_type(ctypes.c_bool, ctypes.c_ulong, ctypes.c_ulong, ctypes.POINTER(ctypes.c_float))(('BASS_ChannelGetAttribute', self.bass_module))

		self.BASS_Init(-1, 44100, 0, 0, 0)
	def dummy_download(self, total, done, url, buffer):
		pass

	def BASS_ChannelSetVolume(self, hndl, vol):
		vol = round(vol/100, 2)

		self.BASS_ChannelSetAttribute(hndl, 2, vol)

	def BASS_ChannelGetVolume(self, hndl):
		volume = ctypes.c_float(0.0)
		vol = self.BASS_ChannelGetAttribute(hndl, 2, ctypes.byref(volume))
		return int(volume.value*100) if vol else 0


if __name__ == '__main__':
	audio = AudioPlayer("bass.dll")
	handle = audio.BASS_StreamCreateURL(b"https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3", 0, 0, 0, 0)
	audio.BASS_ChannelPlay(handle, False)
	time.sleep(3)
	audio.BASS_ChannelSetVolume(handle, 400)
	time.sleep(5)
	audio.BASS_ChannelSetVolume(handle, 70)
	print(audio.BASS_ChannelGetVolume(handle))
	time.sleep(10)
	audio.BASS_ChannelPause(handle)
	time.sleep(2)
	audio.BASS_ChannelPlay(handle, False)
	time.sleep(10)