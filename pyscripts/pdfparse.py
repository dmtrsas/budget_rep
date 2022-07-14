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

    while page_no < num_pages:  # this is what we do for every page of input PDF file
        input_page = ((pdf_read.getPage(page_no)).extractText()).split('\nTранзации')  # splitting full text into pages
        input_page = re.split(('\nT'), input_page[0])  # splitting text pages into rows
        # WE NEED TO FIND OUT HOW NOT TO SPLIT CONTENT WITHIN TRANSACTIONS WHERE "\nT" exists
        input_page = input_page[1::]  # first row of a page (includes service info) is not needed

        output_page = []
        for transaction in input_page:
            transaction = transaction.replace('\n', ' ')
            output_page.append(transaction)

        # Writing to a file
        with open('MResult.csv', 'a') as target_pdf:
            output_page = '\n'.join(output_page)
            print(output_page)
            target_pdf.writelines(output_page)

        page_no += 1


with open('MResult.csv', 'a') as target_csv:  # writing header to a result file
    target_csv.writelines("%s\n" % str(
        ['Transaction date', 'Transaction time', 'Transaction description',
         'Transaction Amount', 'Currency', 'Account Date', 'Account Number',
         'Billing amount', 'Billing currency', 'Card Number', 'Category']))
for filename in getstatementslist():
    mtbstatementparse(filename)
