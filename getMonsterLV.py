import xlwings as xlv


def getMonLV(leveltype, gamelevel):
    level_type = leveltype
    game_level = gamelevel

    level_row = 0
    dicts = {}

    ap1 = xlv.App(visible=False, add_book=False)
    ap1.display_alerts = False
    wb1 = ap1.books.open('怪物模板.xlsx')
    sht1 = wb1.sheets['单打怪物分布']

    nrow = sht1.api.UsedRange.Rows.count
    ncol = sht1.api.UsedRange.Columns.count

    rng_all = sht1.range((1, 1), (nrow, ncol))

    for x in rng_all:
        if x.value == game_level:
            level_row = x.row

    num = 1
    for x in rng_all.rows[0]:
        key = x.value
        word = sht1.range(level_row, num).value
        dicts[key] = word
        num = num + 1

    wb1.close()
    ap1.quit()
    return dicts


print(getMonLV('单打', 46))
