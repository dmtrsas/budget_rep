py -3 G:\Budget\DB\prior_to_db\csvpriorparse.py


&"G:\Budget\DB\prior_to_db\symbols_term.ps1"
$FileName = "G:\Budget\DB\prior_to_db\Vpsk*.csv"
if (Test-Path $FileName) {
  Remove-Item $FileName
}