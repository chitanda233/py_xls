import xlwings as xlv

ap1 = xlv.App(visible=False, add_book=False)
ap1.display_alerts = False

wb2 = ap1.books.open("技能复制.xlsx")
sht2 = wb2.sheets["Sheet2"]
rng3 = sht2.range("A1:E17")

sht2.range("A1").value="HADHFASDHF"

wb2.save()
wb2.close()
ap1.quit()