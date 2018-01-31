import xlwings as xw
import getMonster
import getMonsterLV
app = xw.App(visible=False, add_book=False)
wb = app.books.add()
dx=getMonster.getMonList()
dl=getMonsterLV.getMonLV('单打',46)


wb.save("输出怪物.xlsx")
wb.close()
app.quit()
