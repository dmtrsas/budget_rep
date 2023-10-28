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
3. PS scripts from ./special should be placed together with .pyscripts/statements_parse.py into the same **working directory** (e.g. new /banks_to_db/ folder)
4. [Microsoft SSIS](https://learn.microsoft.com/en-us/sql/integration-services/sql-server-integration-services?view=sql-server-ver16) setup: 
	- Install SSIS
	- Create a new project in it
	- Import MTBPrior_Integration.dtsx package to SSIS
	- Change "Connection Managers" links to **your working directory links** for <b>CSV statements</b>, <b>DB connection</b> and <b>lookup/error text files</b>
 	- Change "Working directory" parameter in "Execute Process" jobs to **your working directory links**
	- Change connection to **your database** for "Run insert_expense_categ_agg_mm" job

How to use:
1. Download the statements (default location - C:\Users\%username%\Downloads\)
2. Start SSIS package execution. While executing SSIS package:
   
   2.1 old transformed statements(if there are any) will be deleted from working directory _(ps1 script)_
   
   2.2 new bank statements will be moved to working directory _(ps1 script)_
   
   2.3 new bank statements will be properly transformed _(py and ps1 scripts)_
   
   2.4 newly transformed (clean) statements will be loaded to DB table Budget.TRANSACTIONS _(SSIS dataflow)_
   
   2.5 stored procedure will be executed - it populates monthly aggregated expenses grouped by categories _(SP run wrapped in SSIS job)_
   
   2.6 bank statements that were transformed and loaded will be deleted, clean statements remain until next package run _(ps1 script)_
_________________________________________________________________

Future development plans:
- Stored procedures in the DB must be realized for deeper analytics of the data:
    
	- [ ] to add type of transaction

	- [ ] to add transfers info (from-to)

	- [ ] ~~-to unify different MCC descriptions in transactions table~~ -- not relevant now

	- [x] aggregations should be realized -- realized in insert_expense_categ_agg_mm
- Cleansing of the data: 
	- [ ] possibility to load statements of any period without duplicating records;
        
	- [ ] to unify merchant names;
- Visualization of the results (in progress using Power BI)
