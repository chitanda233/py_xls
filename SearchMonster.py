import xlwings as xw
import GetMonsterList as gmlist
import GetMonsterLv as gmlv

app = xw.App(visible=False, add_book=False)
app.display_alerts = False
app.screen_updating = False

workbook1 = app.books.open("怪物模板.xlsx")
workbook2 = app.books.open("整合模板.xlsx")

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
sht_all_monster = workbook2.sheets['模板']

# 新的整合模板，如果可以，就不用上面分类了
row_all_new_monster = sht_all_monster.api.UsedRange.Rows.count
col_all_new_monster = sht_all_monster.api.UsedRange.Columns.count

rng_all_new_monster = sht_all_monster.range((1, 1), (row_all_new_monster, col_all_new_monster))
rng_all_new_name = sht_all_monster.range((1, 1), (row_all_new_monster, 1))

monster_list = gmlist.get_mon_list()
print(monster_list)
monster_lv = gmlv.get_monster_lv("单打", 46)
# print(monster_lv)
monster_lvf = {}

# 实际上需要的怪物名字比较长，但是列表里面的只是单独的名字
# 所以需要正反两次比较，然后填充出一个比较完整的怪物列表来，
# 如果正反都没有，固定设置一个1档
for monster in monster_list:
    # print("开始输出monster： "+monster)
    if monster != 0.0:
        for key in monster_lv.keys():
            # print("开始输出key"+key)
            if key == monster:
                monster_lvf[key] = monster_lv[key]
            elif key in monster:
                monster_lvf[monster] = monster_lv[key]
            elif monster in key:
                monster_lvf[key] = monster_lv[key]
            else:
                monster_lvf[monster] = "1档"
print(monster_lvf)

for m in monster_list:
    keyword = m
    try:
        level = monster_lvf[keyword]
    except:
        print(m)
    else:
        L2 = []
        L3 = []
        # 找到对应怪物名字，存L2

        for name in rng_all_new_name:
            if not name is None:
                # 严格相等
                if keyword == name.value:
                    L1 = rng_all_new_monster.rows[name.row - 1]
                    L2.append(L1)
        if L2!=[]:
            for mon_row in L2:
                if mon_row(1, 2).value == level:
                    start = 'A' + str(nrow_out)
                    # 在单元格起始位置赋值，就可以整行赋值
                    sht_out.range(start).value = mon_row.value[4:]
                    nrow_out = nrow_out + 1

workbook_out.save('输出.xlsx')
workbook_out.close()
workbook1.close()
workbook2.close()

app.quit()
print("goodbye")
