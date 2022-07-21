import csv
import os
import re


def getstatementslist():
    files = os.listdir(os.getcwd())
    statements_list = []
    for i in files:
        statement = re.match(r'Vpsk_\d{8}.{0,3}\.csv', i)
        if statement is None:
            pass
        else:
            statement = statement.group(0)
            statements_list.append(statement)
    return statements_list


def getcardnumber(filename):
    with open(filename) as source_csv:
        source_csv_read = csv.reader(source_csv, delimiter=';')
        pan = ''
        for entry in source_csv_read:
            if not entry or re.search('Карта:', entry[0]) is None:
                pass
            else:
                pan = entry[1][8:12:]
                return pan


def getcurbill(filename):
    with open(filename) as source_csv:
        source_csv_read = csv.reader(source_csv, delimiter=';')
        curbill = ''
        for entry in source_csv_read:
            if not entry or re.search('Валюта счета: ', entry[0]) is None:
                pass
            else:
                curbill = entry[1]
                return curbill


def priorstatementparse(filename, pan, curbill):
    with open(filename) as source_csv:
        source_csv_read = csv.reader(source_csv, delimiter=';')

        # inserting rows into file
        i = 0  # entries iterator
        source_csv_rows = []
        source_csv_read = csv.reader(source_csv, delimiter=';')
        for row in source_csv_read:
            if not row or len(row) != 10:  # every row with necessary data in a source file contains 10 elements
                i += 1
            else:
                if bool(re.search('[а-яА-Я]', row[0])) is False:
                    # 8th column contains unnecessary symbol
                    row[8] = row[8].replace('\xa0', '')
                    # datetime column split into date and time
                    row[0] = row[0].split(' ')
                    datetime = row[0]
                    row.insert(1, datetime[0])
                    row.insert(2, datetime[1])
                    row.remove(row[0])
                    # empty column replaced with "category" column
                    category = row[-1]
                    row.insert(-2, category)
                    row.remove(row[-1])
                    row.remove(row[-3])
                    # insert card number and billing currency
                    row.insert(-2, pan)
                    row.insert(-3, curbill)
                    # append only needed elements
                    source_csv_rows.append(row[:11:])
        i += 1
        # writing rows to a file
    with open('Result.csv', 'a') as target_csv:
        for row in source_csv_rows:
            for elem in row:
                elem = ";".join(elem)
            target_csv.writelines("%s\n" % str(row))


with open('Result.csv', 'a') as target_csv:  # writing header to a result file
    target_csv.writelines("%s\n" % str(
        ['Transaction date', 'Transaction time', 'Transaction description',
         'Transaction Amount', 'Currency', 'Account Date', 'Account Number',
         'Billing amount', 'Billing currency', 'Card Number', 'Category']))
for filename in getstatementslist():
    priorstatementparse(filename, getcardnumber(filename), getcurbill(filename))
