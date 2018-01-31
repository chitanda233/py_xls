import xlwings as xw

app = xw.App(visible=False, add_book=False)
app.display_alerts = False
app.screen_updating = False

filepath = '怪物模板.xlsx'
workbook1 = app.books.open(filepath)

#输出的book
workbook_out = app.books.add()
#输出的sheet
sht_out = workbook_out.sheets['sheet1']
#用来记数算输出了多少行
nrow_out = sht_out.api.UsedRange.Rows.count

#用来输入的sheet，这个要替换
sht = workbook1.sheets["旧版怪"]

#输入的sheet的所有内容
nrow = sht.api.UsedRange.Rows.count
ncol = sht.api.UsedRange.Columns.count

rng_all = sht.range((1, 1), (nrow, ncol))
rng_name = sht.range((1, 1), (nrow, 1))
keyword = "侦察机"
level = "1档"

L2 = []
L3 = []
#先找到队应名字的怪物,存到L2里面
for name in rng_name:
    if name.value == keyword:
        L1 = rng_all.rows[name.row - 1]
        L2.append(L1)

for mon_row in L2:
    if (mon_row(1, 2).value == level):
        start = 'A' + str(nrow_out)
        print(start)
        sht_out.range(start).value = mon_row.value[4:]
        nrow_out = nrow_out + 1

workbook_out.save('输出.xlsx')
workbook_out.close()
workbook1.close()
app.quit()

print("goodbye")
