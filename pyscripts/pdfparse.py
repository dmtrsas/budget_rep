import PyPDF2
import re
import os


def getstatementslist():
    files = os.listdir(os.getcwd())
    statements_list = []
    for i in files:
        statement = re.match('Transactions\s.\d..pdf', i)
        if statement is None:
            pass
        else:
            statement = statement.group(0)
            statements_list.append(statement)
    return statements_list


# def getcardnumber(filename):
#     with open(filename) as source_csv:
#         source_csv_read = csv.reader(source_csv, delimiter=';')
#         pan = ''
#         for entry in source_csv_read:
#             if not entry or re.search('Карта:', entry[0]) is None:
#                 pass
#             else:
#                 pan = entry[1][8:12:]
#                 return pan


def mtbstatementparse(filename):
    source_pdf = open(filename, 'rb')
    pdf_read = PyPDF2.PdfReader(source_pdf)
    num_pages = pdf_read.numPages
    page_no = 0
    # retrieve account number for further purposes (to match with data in destination DB)
    account_no = re.search('BY\d{2}MTBK3014\d{16}', pdf_read.getPage(0).extractText()).group(0)

    # this is what we do for every page of input PDF file
    while page_no < num_pages:

        input_page = ((pdf_read.getPage(page_no)).extractText()).split('\nTранзации')  # extract text + split into pages
        input_page = re.split(('\nT'), input_page[0])  # \nT - the only adequate delimiter for splitting pages into rows
        input_page = input_page[1::]  # first row of a page (which includes service info) is not needed

        output_page = []
        txn_num = 0
        for transaction in input_page:
            transaction = transaction.replace('\n', ' ')

            # now we check if a real transaction was split within itself as a result of splitting pages into rows

            # Incorrect splitting / last entry handling
            # if there are non-digits in last 4 - it's either real txn first part OR last txn with service info
            if re.match('\d.\d{2}', transaction[-4::]) is None:

                # if this transaction is the last
                if re.search('\sсумма блокирована', str(transaction)) is not None:
                    transaction = re.split('-\sсумма обработана', transaction)
                    transaction = ((str(transaction[:1:]).replace("'", '')).replace("[", '')).replace(']', '')
                # if this transaction was just split within
                else:
                    transaction = transaction + ' T' + input_page[txn_num + 1].replace('\n', ' ')

                output_page.append(transaction)
                txn_num += 1

            # if there are non-digits in first 4 - it's real txn second part
            elif re.match('\d{2}.\d', transaction[:5:]) is None:
                txn_num += 1

            # most entries land here
            else:
                output_page.append(transaction)
                txn_num += 1

        for transaction in output_page:
            transaction_date = transaction[:10:]
            transaction_time = transaction[11:19:]
            account_date = transaction[19:29:]
            card_number = re.search('\d{6}[*]{6}\d{4}', transaction)
            if card_number is not None:  # if card number found
                card_number = card_number.group(0)[-4::]

            csv_output_string = [transaction_date, transaction_time, account_date, card_number, account_no]
            print(csv_output_string)

        # Writing to a file
        with open('MResult.csv', 'a') as target_csv:
            output_page = '\n'.join(output_page)
            print(output_page)
            target_csv.writelines(output_page)
            target_csv.writelines('\n')

        page_no += 1


with open('MResult.csv', 'a') as target_csv:  # writing header to a result file
    target_csv.writelines("%s\n" % str(
        ['Transaction date', 'Transaction time', 'Transaction description',
         'Transaction Amount', 'Currency', 'Account Date', 'Account Number',
         'Billing amount', 'Billing currency', 'Card Number', 'Category']))
for filename in getstatementslist():
    mtbstatementparse(filename)
