import PyPDF2
import re
import os


def getstatementslist():
    files = os.listdir(os.getcwd())
    statements_list = []
    for i in files:
        statement = re.match(r'Transactions\s.\d..pdf', i)
        if statement is None:
            pass
        else:
            statement = statement.group(0)
            statements_list.append(statement)
    return statements_list


def mtbstatementparse(filename):
    source_pdf = open(filename, 'rb')
    pdf_read = PyPDF2.PdfReader(source_pdf)
    num_pages = pdf_read.numPages
    page_no = 0
    # retrieve account number, account currency for further purposes (to match with data in destination DB)
    account_no = re.search(r'BY\d{2}MTBK3014\d{16}', pdf_read.getPage(0).extractText()).group(0)
    billing_currency = re.search(r'\w{3}Выписка по сч[е-ё]ту', pdf_read.getPage(0).extractText()).group(0)[:3:]
    # this is what we do for every page of input PDF file
    while page_no < num_pages:

        input_page = ((pdf_read.getPage(page_no)).extractText()).split('\nTранзации')  # extract text + split into pages
        input_page = re.split('\nT', input_page[0])  # \nT - the only adequate delimiter for splitting pages into rows
        input_page = input_page[1::]  # first row of a page (which includes service info) is not needed

        output_page = []
        txn_num = 0
        for transaction in input_page:

            transaction = transaction.replace('\n', ' ')
            # we check if this is debt repayment, if yes - skip
            if re.search('Погашение.основного.долга', transaction) is not None:
                txn_num += 1
            else:
                # now we check if a real transaction was split within itself as a result of splitting pages into rows

                # Incorrect splitting / last entry handling
                # if there are non-digits in last 4 - it's either real txn first part OR last txn with service info
                if re.match(r'\d\.\d{2}', transaction[-4::]) is None:

                    # if this transaction is the last
                    if re.search(r'\sсумма блокирована', str(transaction)) is not None:
                        transaction = re.split(r'-\sсумма обработана', transaction)
                        transaction = ((str(transaction[:1:]).replace("'", '')).replace("[", '')).replace(']', '')
                    # if this transaction was just split within
                    else:
                        transaction = transaction + ' T' + input_page[txn_num + 1].replace('\n', ' ')

                    output_page.append(transaction)
                    txn_num += 1

                # if there are non-digits in first 4 - it's real txn second part
                elif re.match(r'\d{2}\.\d', transaction[:5:]) is None:
                    txn_num += 1

                # most entries land here
                else:
                    output_page.append(transaction)
                    txn_num += 1
        for transaction in output_page:
            account_date = transaction[19:29:]
            transaction_date = (re.search(r'\d{2}\.\d{2}\.\d{4}\s', transaction).group(0)).strip()
            transaction = transaction.replace(transaction_date, '')
            transaction_time = (re.search(r'\s\d{2}:\d{2}:\d{2}', transaction).group(0)).strip()
            transaction = transaction.replace(transaction_time, '')
            card_number = re.search(r'\d{6}\*{6}\d{4}', transaction)
            if card_number is not None:  # if card number found
                card_number = card_number.group(0)[-4::]
            else:
                card_number = ' '
            transaction_descr_category = transaction
            # description and category extraction
            if re.search(r'Комиссия\s', transaction_descr_category) is None \
                    and re.search(r'Пополнение сч[а-я]та\s', transaction_descr_category) is None \
                    and re.search(r'Возврат', transaction_descr_category) is None:
                # if entry is not a commission and not a ERIP credit then we take it out:
                # remove dates and amounts, leave only description and category
                transaction_descr_category = re.split(str(card_number),
                                                      re.split(r'BYN\d|USD\d|EUR\d|RUB\d',
                                                               transaction_descr_category)[0])
                transaction_descr_category = transaction_descr_category[1]
                # taking out description + refund handling
                if re.match(r'(.{1,50}[^а-яА-Я]\s[A-Z]{2}\s){1,30}', transaction_descr_category) is None:
                    transaction_descr = ' '
                else:
                    transaction_descr = re.match(r'(.{1,50}[^а-яА-Я]\s[A-Z]{2}\s){1,30}', transaction_descr_category) \
                        .group(0)
                # removing description, only category left
                transaction_descr_category = transaction_descr_category.replace(transaction_descr, '')
                transaction_category = transaction_descr_category

            # if entry is a commission or ERIP credit or refund - fill in with constant data
            else:
                if re.search(r'Комиссия\s', transaction) is None \
                        and re.search(r'Возврат', transaction) is None:
                    transaction_descr = 'Пополнение счёта ' + account_no
                    transaction_category = 'Пополнение ЕРИП'
                elif re.search(r'Возврат', transaction) is not None:
                    transaction_descr = 'Возврат покупки'
                    transaction_category = 'Возврат'
                else:
                    transaction_descr = ' '
                    transaction_category = 'Комиссия по операции'

            # amounts extraction
            transaction_amount = re.search(r'[A-Z]{3}\d{1,5}\.\d{2}\s', transaction).group(0)[3::].replace('.', ',')

            transaction_currency = re.search(r'[A-Z]{3}\d{1,5}\.\d{2}\s', transaction).group(0)[:3:]
            billing_amount = re.search(r'\d{1,5}\.\d{2}[+-]', transaction).group(0).replace('.', ',')
            if billing_amount[-1::] == '-':
                billing_amount = '-' + billing_amount[:-1:]
                transaction_amount = '-' + transaction_amount
            elif billing_amount[-1::] == '+':
                billing_amount = billing_amount[:-1:]
            csv_output_string = str([transaction_date,
                                     transaction_time,
                                     transaction_descr,
                                     transaction_amount,
                                     transaction_currency,
                                     account_date,
                                     account_no,
                                     billing_amount,
                                     billing_currency,
                                     card_number,
                                     transaction_category])
            # Writing to a file
            with open('MResult.csv', 'a') as target_csv:
                target_csv.write(csv_output_string)
                target_csv.write('\n')

        page_no += 1


with open('MResult.csv', 'a') as target_csv:  # writing header to a result file
    target_csv.writelines("%s\n" % str(
        ['Transaction date', 'Transaction time', 'Transaction description',
         'Transaction Amount', 'Currency', 'Account Date', 'Account Number',
         'Billing amount', 'Billing currency', 'Card Number', 'Category']))
for filename in getstatementslist():
    mtbstatementparse(filename)
