import xlwings as xw
import GetMonsterList
import GetMonsterLv
app = xw.App(visible=False, add_book=False)
wb = app.books.add()
dx=GetMonsterList.get_mon_list()
dl = GetMonsterLv.get_monster_lv('单打', 46)


wb.save("输出怪物.xlsx")
wb.close()
app.quit()
