 #This file is intended to replace symbols which are unnecessary and difficult to process within SSIS
 #prior file processing
 
 $prior_file = "G:\Budget\DB\banks_to_db\Prior_Result.csv"

 $commadot = get-content -path $prior_file
 $notcommadot = $commadot -replace "',","';"
 $notcommadot | set-content -path $prior_file
 
 $quo = get-content -path $prior_file
 $notquo = $quo -replace "'",""
 $notquo | set-content -path $prior_file
 
 $spaces = get-content -path $prior_file
 $notspaces = $spaces -replace "  ",""
 $notspaces | set-content -path $prior_file

 $brackets = get-content -path $prior_file
 $firbracket_to_blanks = $brackets -replace '[][]',''
 $secbracket_to_blanks = $brackets -replace '[][]',''
 $firbracket_to_blanks | set-content -path $prior_file
 $secbracket_to_blanks | set-content -path $prior_file
 
 $semicolons_spaces = get-content -path $prior_file
 $semicolons_spaces_elim = $semicolons_spaces -replace "; ",";" 
 $semicolons_spaces_elim | set-content -path $prior_file
 
 $semicolons_spaces_2 = get-content -path $prior_file
 $semicolons_spaces_elim_2 = $semicolons_spaces_2 -replace " ;",";"
 $semicolons_spaces_elim_2 | set-content -path $prior_file
 
 
 #mtb file processing
 
 $mtb_file = "G:\Budget\DB\banks_to_db\MTB_Result.csv"
 
 $dquo = get-content -path $mtb_file
 $notdquo = $dquo -replace '"',''
 $notdquo | set-content -path $mtb_file

 $commadot = get-content -path $mtb_file
 $notcommadot = $commadot -replace "',","';"
 $notcommadot | set-content -path $mtb_file
 
 $quo = get-content -path $mtb_file
 $notquo = $quo -replace "'",""
 $notquo | set-content -path $mtb_file
 
 $spaces = get-content -path $mtb_file
 $notspaces = $spaces -replace "  ",""
 $notspaces | set-content -path $mtb_file

 $brackets = get-content -path $mtb_file
 $firbracket_to_blanks = $brackets -replace '[][]',''
 $secbracket_to_blanks = $brackets -replace '[][]',''
 $firbracket_to_blanks | set-content -path $mtb_file
 $secbracket_to_blanks | set-content -path $mtb_file
 
 $semicolons_spaces = get-content -path $mtb_file
 $semicolons_spaces_elim = $semicolons_spaces -replace "; ",";" 
 $semicolons_spaces_elim | set-content -path $mtb_file
 
 $semicolons_spaces_2 = get-content -path $mtb_file
 $semicolons_spaces_elim_2 = $semicolons_spaces_2 -replace " ;",";"
 $semicolons_spaces_elim_2 | set-content -path $mtb_file