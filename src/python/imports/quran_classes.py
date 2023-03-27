import sqlite3
import json

class quran_mgr:
	def __init__(self):
		self.db = None
		self.current_type = 0
		self.meta = ""

	def load_quran(self, name):
		pass