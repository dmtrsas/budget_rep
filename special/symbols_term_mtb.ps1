
 $dquo = get-content -path G:\Budget\DB\mtb_to_db\MResult.csv
 $notdquo = $dquo -replace '"',''
 $notdquo | set-content -path G:\Budget\DB\mtb_to_db\MResult.csv

 $commadot = get-content -path G:\Budget\DB\mtb_to_db\MResult.csv
 $notcommadot = $commadot -replace "',","';"
 $notcommadot | set-content -path G:\Budget\DB\mtb_to_db\MResult.csv
 
 $quo = get-content -path G:\Budget\DB\mtb_to_db\MResult.csv
 $notquo = $quo -replace "'"," "
 $notquo | set-content -path G:\Budget\DB\mtb_to_db\MResult.csv
 
 $spaces = get-content -path G:\Budget\DB\mtb_to_db\MResult.csv
 $notspaces = $spaces -replace "  "," "
 $notspaces | set-content -path G:\Budget\DB\mtb_to_db\MResult.csv

 $brackets = get-content -path G:\Budget\DB\mtb_to_db\MResult.csv
 $firbracket_to_blanks = $brackets -replace '[][]',''
 $secbracket_to_blanks = $brackets -replace '[][]',''
 $firbracket_to_blanks | set-content -path G:\Budget\DB\mtb_to_db\MResult.csv
 $secbracket_to_blanks | set-content -path G:\Budget\DB\mtb_to_db\MResult.csv
 
 $semicolons_spaces = get-content -path G:\Budget\DB\mtb_to_db\MResult.csv
 $semicolons_spaces_elim = $semicolons_spaces -replace "; ",";" 
 $semicolons_spaces_elim | set-content -path G:\Budget\DB\mtb_to_db\MResult.csv
 
 $semicolons_spaces_2 = get-content -path G:\Budget\DB\mtb_to_db\MResult.csv
 $semicolons_spaces_elim_2 = $semicolons_spaces_2 -replace " ;",";"
 $semicolons_spaces_elim_2 | set-content -path G:\Budget\DB\mtb_to_db\MResult.csv