#Powershell Master file: 1) launches python statements parsing script; 
#						 2) executes symbols_term Powershell script; 
#						 3) deletes original statements from the directory


py -3 G:\Budget\DB\banks_to_db\statements_parse.py

&"G:\Budget\DB\banks_to_db\symbols_term.ps1"

$FileName_Prior = "G:\Budget\DB\banks_to_db\Vpsk*.csv"
$FileName_MTB = "G:\Budget\DB\banks_to_db\transactions *.pdf"

if (Test-Path $FileName_Prior) {Remove-Item $FileName_Prior} 
if (Test-Path $FileName_MTB) {Remove-Item $FileName_MTB}