import csv
import os
import re


def getstatementslist():
    files = os.listdir(os.getcwd())
    statements_list = []
    for i in files:
        statement = re.match('Vpsk_\d{8}.csv', i)
        if statement is None:
            pass
        else:
            statement = statement.group(0)
            statements_list.append(statement)


def priorstatementparse(filename):
    with open(filename) as source_csv:
        source_csv_read = csv.reader(source_csv, delimiter=';')
        i = 0  # entries iterator
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
                    row.remove(row[0])  # remove datetime column
                    row[7] = row[7].replace('\xa0', '')
                    # 7th element of many rows (after datetime column removal)
                    # contains unnecessary symbol
                    trunc_source_csv.append(row)
        i += 1
    with open('vpsk_res.csv', 'a') as target_csv:
        for row in trunc_source_csv:
            for elem in row:
                elem = ";".join(elem)
            target_csv.writelines("%s\n" % str(row))
