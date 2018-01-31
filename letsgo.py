import xlwings as xw

print("hello world")

app = xw.App(visible=False, add_book=False)
app.display_alerts = False
app.screen_updating = False

wb = app.books.add()
wb.sheets.add(after=wb.sheets[wb.sheets.count-1])
wb.sheets.add(after=wb.sheets[wb.sheets.count-1])
print(wb.sheets.count)

wb.sheets[0].range('A1').value = "hello world"
wb.sheets[1].range('A1').value = "hello world"

wb.save(r"test.xlsx")
wb.close()
app.quit()
print("goodbye world")
