import xlwings as xlv
import getMonsterLV


def getMonList():
    dx = []
    ap1 = xlv.App(visible=False, add_book=False)
    ap1.display_alerts = False
    wb1 = ap1.books.open('怪物源.xlsx')
    sht1 = wb1.sheets['sheet1']
    nrow = sht1.api.UsedRange.Rows.count
    # ncol = sht1.api.UsedRange.Columns.count
    rng_monster = sht1.range((1, 1), (nrow, 1))
    num = 1
    for x in rng_monster:
        dx.append(x.value)
    wb1.close()
    ap1.quit()
    return dx

print(getMonList())
print(getMonsterLV.getMonLV('ahh',46))