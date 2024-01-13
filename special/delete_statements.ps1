$FileName_Prior = "G:\Budget\DB\banks_to_db\Vpsk*.csv"
$FileName_MTB = "G:\Budget\DB\banks_to_db\Выписка_*.pdf"

if (Test-Path $FileName_Prior) {Remove-Item $FileName_Prior} 
if (Test-Path $FileName_MTB) {Remove-Item $FileName_MTB}
