import PyPDF2
import re

pdf_fileObj = open('transactions.pdf', 'rb')
pdf_fileReader = PyPDF2.PdfReader(pdf_fileObj)
numberofPages = pdf_fileReader.numPages
page_no = 1

while page_no < numberofPages:
    parsed_Page = [((pdf_fileReader.getPage(page_no)).extractText()).split('\n')[2:]]

    with open('parsedresult.txt', 'a') as res:
        for line in parsed_Page:
            for elem in line:
                '|'.join(line)+'|'

            res.writelines('|'.join(line) + '|')

        print(line)
    page_no += 1
pdf_fileObj.close()
