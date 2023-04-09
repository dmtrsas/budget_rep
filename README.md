# BUDGET_REPOSITORY
Own budget project code: 

It's intended to transform data from bank transaсtion statements into csv plain text files with further processing through Microsoft SSIS package and loading into SQL Server database. 

Banks statements that are able to be processed: Priorbank, MTBank (Belarus). 

Nowadays, everything works as common ETL process: 
  1. extract - bank statements saved as csv/pdf files manually (as there's no possible solution to perform this action automatically);
  2. transform - statements are parsed, transformed, set to a unified format (fixed set of columns with appropriate names) using Python and Powershell scripts, and saved as plain text csv files with delimiters;
  3. load - transaction data within files are loaded into an RDBMS Microsoft SQL Server using a built-in tool of Microsoft SSDT - SSIS (SQL Server Integration Services).


How to use:
  1. Run dbs folder script in Microsoft SSMS
  2. Run tables scripts in Microsoft SSMS
  3. PS scripts from ./special should be placed together into the same folder as .pyscripts/statements_parse.py
  4. [Microsoft SSIS](https://learn.microsoft.com/en-us/sql/integration-services/sql-server-integration-services?view=sql-server-ver16) : 
		4.1 Install SSIS
		4.2 Create a new project in it
		4.3 Create new Connection Managers in SSIS using appropriate paths to parsing result files
		4.4 Import MTBPrior_Integration.dtsx package to SSIS
		4.5 Set up your correct Connection Managers in dataflows jobs
	

Plans for development in the future: 
  - Stored procedures in the DB must be realized for deeper analytics of the data:
		to add type of transaction
		to add transfers info (from-to)
		to unify different MCC descriptions in transactions table
		aggregations should be realized
  - Cleansing of the data: 
		possibility to load statements of any period without duplicating records 
		to unify merchant names
  - Visualization of the results
