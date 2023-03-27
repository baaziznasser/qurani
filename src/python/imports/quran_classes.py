import sqlite3

class quran_mgr:
	def __init__(self):
		self.data_list = []
		self.conn = None
		self.cursor = None
		self.text = ""

	def load_quran(self, db_path):
		self.conn = sqlite3.connect(db_path)
		self.cursor = self.conn.cursor()

	def get_surah(self, surah_number):
		self.cursor.execute(f"SELECT * FROM quran WHERE sura_number={surah_number}")
		rows = self.cursor.fetchall()
		self.data_list = [(row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8], row[9], row[10], None, None) for row in rows]
		return self.get_text()

	def get_hizb(self, hizb_number):
		self.cursor.execute(f"SELECT * FROM quran WHERE hizb={hizb_number}")
		rows = self.cursor.fetchall()
		self.data_list = [(row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8], row[9], row[10], None, None) for row in rows]
		return self.get_text()

	def get_juzz(self, juzz_number):
		self.cursor.execute(f"SELECT * FROM quran WHERE juz={juzz_number}")
		rows = self.cursor.fetchall()
		self.data_list = [(row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8], row[9], row[10], None, None) for row in rows]
		return self.get_text()

	def get_quarter(self, quarter_number):
		self.cursor.execute(f"SELECT * FROM quran WHERE hizbQuarter={quarter_number}")
		rows = self.cursor.fetchall()
		self.data_list = [(row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8], row[9], row[10], None, None) for row in rows]
		return self.get_text()

	def get_page(self, page_number):
		self.cursor.execute(f"SELECT * FROM quran WHERE page={page_number}")
		rows = self.cursor.fetchall()
		self.data_list = [(row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8], row[9], row[10], None, None) for row in rows]
		return self.get_text()

	def get_text(self, aya_to_line=False, show_numbers=True):
		if not self.data_list:
			return ""

		text = ""
		start = 0

		for ayah_index, ayah in enumerate(self.data_list):
			ayah_text = ayah[0]
			ayah_number = ayah[4]

			if show_numbers:
				ayah_text += f" ({ayah_number})"

			if aya_to_line:
				ayah_text = f"{ayah_text}\n"
			else:
				ayah_text += " "

			text += ayah_text

			end = start + len(ayah_text)
			self.data_list[ayah_index] += (start, end)
			start = end+1

		self.text = text
		return text

quran = quran_mgr()
quran.load_quran(r"D:\my_projectes\Autoit Projectes\qurani\v1.2\source_code\database\quran\quran.DB")

print(quran.get_surah(1))