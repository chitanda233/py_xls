import xlwings as xlv

# 替换技能参数表中的 debuff ID
ap1 = xlv.App(visible=False, add_book=False)
ap1.display_alerts = False
wb2 = ap1.books.open("技能复制.xlsx")

# 技能表 条件表 技能参数
sht2 = wb2.sheets["技能参数"]
rng3 = sht2.range("B1:V16")

for y in rng3:
    if y is None:
        pass
    elif isinstance(y.value, type(123.0)):
        if 100000 < y.value < 210000:
            print(y.value)
wb2.close()
ap1.quit()
