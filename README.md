# BUDGET_REPOSITORY
_________________________________________________________________
Description:

It's intended to transform data from bank transaсtion statements into csv plain text files with further processing through Microsoft SSIS package and loading into SQL Server database. 
Banks statements that are able to be processed: Priorbank, MTBank (Belarus). 

Nowadays, everything works as common ETL process: 
  1. extract - bank statements saved as csv/pdf files manually (as there's no possible solution to perform this action automatically);
  2. transform - statements are parsed, transformed, set to a unified format (fixed set of columns with appropriate names) using Python and Powershell scripts, and saved as plain text csv files with delimiters;
  3. load - transaction data within files are loaded into an RDBMS Microsoft SQL Server using a built-in tool of Microsoft SSDT - SSIS (SQL Server Integration Services).
_________________________________________________________________
Setup:
1. Run ./dbs/db_budget/db_budget_initial.sql folder script in Microsoft SSMS
2. Run tables scripts in Microsoft SSMS (./tables/mcc_codes/mcc_codes-init.txt should be wrapped into SQL INSERT statement)
3. PS scripts from ./special should be placed together with .pyscripts/statements_parse.py into the same <b>your own</b> folder (e.g. new /banks_to_db/ folder)
4. [Microsoft SSIS](https://learn.microsoft.com/en-us/sql/integration-services/sql-server-integration-services?view=sql-server-ver16) setup: 
	- Install SSIS
	- Create a new project in it
	- Import MTBPrior_Integration.dtsx package to SSIS
	- Connection managers' paths need to be changed - set <b>your own</b> correct connections for <b>CSVs</b>(e.g. to /banks_to_db/ folder), <b>DB connection</b> and <b>error text files</b>(e.g. to /banks_to_db/ folder) - 
	- Put these paths into the dataflow jobs

How to use:
1. Put the statements into the folder where statements_parse.py and .ps1 scripts reside (e.g. /banks_to_db/)
2. Run Master.ps1 - bank statements is parsed to CSVs
3. Run SSIS dataflow (jobs can be muted if necessary) - data is loaded from CSV to DB table Budget.TRANSACTIONS
_________________________________________________________________

Future development plans:
  - Stored procedures in the DB must be realized for deeper analytics of the data:
		to add type of transaction;
		to add transfers info (from-to);
		to unify different MCC descriptions in transactions table;
		aggregations should be realized;
  - Cleansing of the data: 
		possibility to load statements of any period without duplicating records; 
		to unify merchant names;
  - Visualization of the results
