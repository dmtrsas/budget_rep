py -3 G:\Budget\DB\mtb_to_db\pdfparse.py


&"G:\Budget\DB\mtb_to_db\symbols_term_mtb.ps1"
$FileName = "G:\Budget\DB\mtb_to_db\Transactions *.pdf"
if (Test-Path $FileName) {
  Remove-Item $FileName
}