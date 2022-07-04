
 $commadot = get-content -path G:\Budget\DB\prior_to_db\Result.csv
 $notcommadot = $commadot -replace "',","';"
 $notcommadot | set-content -path G:\Budget\DB\prior_to_db\Result.csv
 
 $quo = get-content -path G:\Budget\DB\prior_to_db\Result.csv
 $notquo = $quo -replace "'"," "
 $notquo | set-content -path G:\Budget\DB\prior_to_db\Result.csv
 
 $spaces = get-content -path G:\Budget\DB\prior_to_db\Result.csv
 $notspaces = $spaces -replace "  "," "
 $notspaces | set-content -path G:\Budget\DB\prior_to_db\Result.csv

 $brackets = get-content -path G:\Budget\DB\prior_to_db\Result.csv
 $firbracket_to_blanks = $brackets -replace '[][]',''
 $secbracket_to_blanks = $brackets -replace '[][]',''
 $firbracket_to_blanks | set-content -path G:\Budget\DB\prior_to_db\Result.csv
 $secbracket_to_blanks | set-content -path G:\Budget\DB\prior_to_db\Result.csv
 
 $semicolons_spaces = get-content -path G:\Budget\DB\prior_to_db\Result.csv
 $semicolons_spaces_elim = $semicolons_spaces -replace "; ",";" 
 $semicolons_spaces_elim | set-content -path G:\Budget\DB\prior_to_db\Result.csv
 
 $semicolons_spaces_2 = get-content -path G:\Budget\DB\prior_to_db\Result.csv
 $semicolons_spaces_elim_2 = $semicolons_spaces_2 -replace " ;",";"
 $semicolons_spaces_elim_2 | set-content -path G:\Budget\DB\prior_to_db\Result.csv