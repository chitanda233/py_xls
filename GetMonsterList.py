import xlwings as xlv
import GetMonsterLv
import timeit


def get_mon_list():
    dx = []
    ap1 = xlv.App(visible=False, add_book=False)
    ap1.display_alerts = False
    wb1 = ap1.books.open('怪物源.xlsx')
    sht1 = wb1.sheets['sheet1']
    nrow = sht1.api.UsedRange.Rows.count
    # ncol = sht1.api.UsedRange.Columns.count
    rng_monster = sht1.range((1, 1), (nrow, 1))
    for x in rng_monster:
        if not('固定' in x):
            dx.append(x.value)
    wb1.close()
    ap1.quit()
    return dx


# start = timeit.default_timer()
# print(get_mon_list())
# print(GetMonsterLv.get_monster_lv('单打', 46))
# end = timeit.default_timer()
# print(str(end - start))
