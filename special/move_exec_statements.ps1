#Powershell script: 1) detects and removes old resulting statements from working directory; 
#					2) moves all the statements from "Downloads" to working directory;
#					3) executes parsing python script;
#					4) executes symbols_term Powershell script; 


$Old_MTB = "G:\Budget\DB\banks_to_db\MTB_Result.csv"
$Old_Prior = "G:\Budget\DB\banks_to_db\Prior_Result.csv"

if (Test-Path $Old_Prior) {Remove-Item $Old_Prior} 
if (Test-Path $Old_MTB) {Remove-Item $Old_MTB}

$Move_from_prior = "c:\Users\dmitr\Downloads\Vpsk_*.csv"
$Move_from_mtb = "c:\Users\dmitr\Downloads\Выписка_*"
$Move_to = 'g:\Budget\DB\banks_to_db\'

Move-Item -Path $Move_from_prior -Destination $Move_to -force
Move-Item -Path $Move_from_mtb -Destination $Move_to -force


python G:\Budget\DB\banks_to_db\statements_parse.py

&"G:\Budget\DB\banks_to_db\symbols_term.ps1"
