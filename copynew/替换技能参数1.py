import xlwings as xlv

# 替换技能参数表中的 技能ID

ap1 = xlv.App(visible=False, add_book=False)
ap1.display_alerts = False
wb1 = ap1.books.open('替换ID.xlsx')
sht1 = wb1.sheets['技能ID']
nrow = sht1.api.UsedRange.Rows.count
rng1 = sht1.range((1, 1), (nrow, 1))
rng2 = sht1.range((1, 2), (nrow, 2))
dicts = {}
for x in rng1:
    key = x.value
    word = sht1.range(x.row, 2).value
    dicts[x.value] = word
wb2 = ap1.books.open("技能复制.xlsx")

# 技能表 条件表 技能参数
sht2 = wb2.sheets["技能参数"]
rng3 = sht2.range("C2:W33")
for y in rng3:
    if y is None:
        pass
    elif isinstance(y.value, type(123.0)):
        if y.value > 40000000:
            for k in dicts.keys():
                if y.value == k:
                    sht2.range(y.get_address()).value = dicts[k]
                    print(dicts[k])
wb2.save()
wb1.close()
wb2.close()
ap1.quit()
