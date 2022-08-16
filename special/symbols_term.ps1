 #This file is intended to replace symbols which are unnecessary and difficult to process within SSIS
 #prior file processing

 $commadot = get-content -path G:\Budget\DB\banks_to_db\Prior_Result.csv
 $notcommadot = $commadot -replace "',","';"
 $notcommadot | set-content -path G:\Budget\DB\banks_to_db\Prior_Result.csv
 
 $quo = get-content -path G:\Budget\DB\banks_to_db\Prior_Result.csv
 $notquo = $quo -replace "'"," "
 $notquo | set-content -path G:\Budget\DB\banks_to_db\Prior_Result.csv
 
 $spaces = get-content -path G:\Budget\DB\banks_to_db\Prior_Result.csv
 $notspaces = $spaces -replace "  "," "
 $notspaces | set-content -path G:\Budget\DB\banks_to_db\Prior_Result.csv

 $brackets = get-content -path G:\Budget\DB\banks_to_db\Prior_Result.csv
 $firbracket_to_blanks = $brackets -replace '[][]',''
 $secbracket_to_blanks = $brackets -replace '[][]',''
 $firbracket_to_blanks | set-content -path G:\Budget\DB\banks_to_db\Prior_Result.csv
 $secbracket_to_blanks | set-content -path G:\Budget\DB\banks_to_db\Prior_Result.csv
 
 $semicolons_spaces = get-content -path G:\Budget\DB\banks_to_db\Prior_Result.csv
 $semicolons_spaces_elim = $semicolons_spaces -replace "; ",";" 
 $semicolons_spaces_elim | set-content -path G:\Budget\DB\banks_to_db\Prior_Result.csv
 
 $semicolons_spaces_2 = get-content -path G:\Budget\DB\banks_to_db\Prior_Result.csv
 $semicolons_spaces_elim_2 = $semicolons_spaces_2 -replace " ;",";"
 $semicolons_spaces_elim_2 | set-content -path G:\Budget\DB\banks_to_db\Prior_Result.csv
 
 
 #mtb file processing
 
 
 $dquo = get-content -path G:\Budget\DB\banks_to_db\MTB_Result.csv
 $notdquo = $dquo -replace '"',''
 $notdquo | set-content -path G:\Budget\DB\banks_to_db\MTB_Result.csv

 $commadot = get-content -path G:\Budget\DB\banks_to_db\MTB_Result.csv
 $notcommadot = $commadot -replace "',","';"
 $notcommadot | set-content -path G:\Budget\DB\banks_to_db\MTB_Result.csv
 
 $quo = get-content -path G:\Budget\DB\banks_to_db\MTB_Result.csv
 $notquo = $quo -replace "'"," "
 $notquo | set-content -path G:\Budget\DB\banks_to_db\MTB_Result.csv
 
 $spaces = get-content -path G:\Budget\DB\banks_to_db\MTB_Result.csv
 $notspaces = $spaces -replace "  "," "
 $notspaces | set-content -path G:\Budget\DB\banks_to_db\MTB_Result.csv

 $brackets = get-content -path G:\Budget\DB\banks_to_db\MTB_Result.csv
 $firbracket_to_blanks = $brackets -replace '[][]',''
 $secbracket_to_blanks = $brackets -replace '[][]',''
 $firbracket_to_blanks | set-content -path G:\Budget\DB\banks_to_db\MTB_Result.csv
 $secbracket_to_blanks | set-content -path G:\Budget\DB\banks_to_db\MTB_Result.csv
 
 $semicolons_spaces = get-content -path G:\Budget\DB\banks_to_db\MTB_Result.csv
 $semicolons_spaces_elim = $semicolons_spaces -replace "; ",";" 
 $semicolons_spaces_elim | set-content -path G:\Budget\DB\banks_to_db\MTB_Result.csv
 
 $semicolons_spaces_2 = get-content -path G:\Budget\DB\banks_to_db\MTB_Result.csv
 $semicolons_spaces_elim_2 = $semicolons_spaces_2 -replace " ;",";"
 $semicolons_spaces_elim_2 | set-content -path G:\Budget\DB\banks_to_db\MTB_Result.csv