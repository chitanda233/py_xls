import xlwings as xw
import GetMonsterList as gmlist
import GetMonsterLv as gmlv

app = xw.App(visible=False, add_book=False)
app.display_alerts = False
app.screen_updating = False

filepath = '怪物模板.xlsx'
workbook1 = app.books.open(filepath)

# 输出的book
workbook_out = app.books.add()
# 输出的sheet
sht_out = workbook_out.sheets['sheet1']
# 用来记数算输出了多少行
nrow_out = sht_out.api.UsedRange.Rows.count

# 用来输入的sheet，这个要替换
sht_old_monster = workbook1.sheets["旧版怪"]
sht_hlk_monster = workbook1.sheets["海陆空怪"]
sht_tra_monster = workbook1.sheets['轨迹怪']

# 输入的sheet的所有内容
row_all_old_monster = sht_old_monster.api.UsedRange.Rows.count
col_all_old_monster = sht_old_monster.api.UsedRange.Columns.count

rng_all_old_monster = sht_old_monster.range((1, 1), (row_all_old_monster, col_all_old_monster))
rng_all_old_name = sht_old_monster.range((1, 1), (row_all_old_monster, 1))

monster_list = gmlist.get_mon_list()
print(monster_list)
monster_lv = gmlv.get_monster_lv("单打", 46)
print(monster_lv)

for monster in monster_list:
    print("开始输出monster："+monster)
    for key in monster_lv.keys():
        # print("开始输出key"+key)
        if str(key) == monster:
            pass
        elif str(key) in monster:
            monster_lv[key]=monster_lv[key]
        elif monster in (key):
            monster_lv[monster]=monster_lv[key]


print(monster_lv)

for mon in monster_list:
    keyword = mon
    level = monster_lv[keyword]
    L2 = []
    L3 = []
    # 先找到队应名字的怪物,存到L2里面
    for name in rng_all_old_name:
        if (keyword in name.value) or (name.value in keyword):
            L1 = rng_all_old_monster.rows[name.row - 1]
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
