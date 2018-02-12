import xlwings as xlv


def get_monster_lv(level_type, game_level):
    level_type = level_type
    game_level = game_level

    level_row_sht1 = 0
    level_row_sht2 = 0
    dicts = {}

    ap1 = xlv.App(visible=False, add_book=False)
    ap1.display_alerts = False
    wb1 = ap1.books.open('怪物模板.xlsx')
    sht1 = sht2 = None
    if level_type == "单打":
        sht1 = wb1.sheets['单打怪物分布']
        sht2 = wb1.sheets['海陆单打']
    elif level_type == "双打":
        sht2 = wb1.sheets['海陆双打']
        sht1 = wb1.sheets['双打怪物分布']

    if (sht1 is not None) & (sht2 is not None):
        nrow_sht1 = sht1.api.UsedRange.Rows.count
        ncol_sht1 = sht1.api.UsedRange.Columns.count
        nrow_sht2 = sht2.api.UsedRange.Rows.count
        ncol_sht2 = sht2.api.UsedRange.Columns.count

        rng_sht1 = sht1.range((1, 1), (nrow_sht1, ncol_sht1))
        rng_sht2 = sht2.range((1, 1), (nrow_sht2, ncol_sht2))

        # 找到这关在哪一行
        for x in rng_sht1:
            if x.value == game_level:
                level_row_sht1 = x.row
        num_sht1 = 1
        # 循环把这一行搞成一个dict
        for x1 in rng_sht1.rows[0]:
            key = x1.value
            word = str(sht1.range(level_row_sht1, num_sht1).value)
            dicts[key] = word
            num_sht1 = num_sht1 + 1

        # 在第二个页签做相同的处理
        for y in rng_sht2:
            if y.value == game_level:
                level_row_sht2 = y.row
        num_sht2 = 1
        for y1 in rng_sht2.rows[0]:
            key = y1.value
            word = str(sht2.range(level_row_sht2, num_sht2).value)
            dicts[key] = word
            num_sht2 = num_sht2 + 1

    wb1.close()
    ap1.quit()
    return dicts


