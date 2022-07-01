import csv
import re

with open('vpsk.csv') as source_csv:
    source_csv_read = csv.reader(source_csv, delimiter=';')
    i = 0
    trunc_source_csv = [
        ['Операция', 'Сумма', 'Валюта', 'Дата операции по счету',
         'Комиссия/Money-back',
         'Обороты по счету', 'Цифровая карта', 'Категория операции', '', 'Дата транзакции', 'Время транзакции']]
    for row in source_csv_read:

        if not row or len(row) != 10:
            i += 1
        else:
            if bool(re.search('[а-яА-Я]', row[0])) is False:
                row[0] = row[0].split(' ')
                datetime = row[0]
                row.append(datetime[0])  # extract date from datetime column
                row.append(datetime[1])  # extract time from datetime column
                row.remove(row[0])       # remove datetime column
                # '[0-3][0-9]\.+[0-1][0-9]\.+[0-2][0-9]'
                row[8] = row[8].replace('\xa0', '')
                trunc_source_csv.append(row)
    i += 1
with open('vpsk_res.csv', 'a') as target_csv:
    for row in trunc_source_csv:
        for elem in row:
            elem = ";".join(elem)
        target_csv.writelines("%s\n" % str(row))
