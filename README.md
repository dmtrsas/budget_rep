# budget_rep
Own budget project code: 

It's intended to transform data from bank transaсtion statements into csv plain text files with further processing through Microsoft SSIS package and loading into SQL Server database. 

Banks statements that are able to be processed: Priorbank, MTBank (Belarus). 

Nowadays, everything works as common ETL process: 
  1. extract - bank statements saved as csv/pdf files manually (as there's no possible solution to perform this action automatically);
  2. transform - statements are parsed, transformed, set to a unified format (fixed set of columns with appropriate names) using Python and Powershell scripts, and saved as plain text csv files with delimiters;
  3. load - transaction data within files are loaded into an RDBMS Microsoft SQL Server using a built-in tool of Microsoft SSDT - SSIS (SQL Server Integration Services).

Plans for development in the future: 
  - Stored procedures in the DB must be realized for deeper analytics of the data:
    1.to add type of transaction
    2.to add transfers info (from-to)
    3.to unify different MCC descriptions in transactions table
    4.aggregations should be realized
  - Cleansing of the data: 
    1. possibility to load statements of any period without duplicating records 
    2. to unify merchant names
  - Visualization of the results
