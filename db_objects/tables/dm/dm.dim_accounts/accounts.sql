GO
USE Budget
GO
IF OBJECT_ID('dm.dim_accounts') IS NOT NULL
	DROP TABLE dm.dim_accounts;
GO

CREATE TABLE dm.dim_accounts (
ID smallint PRIMARY KEY IDENTITY (1,1) NOT NULL,
ACCOUNT_NAME nvarchar(255) NOT NULL,
ACCOUNT_NUMBER nvarchar (255) NOT NULL,
BALANCE dec (10,2) DEFAULT 0 NOT NULL,
BANK nvarchar(255) NOT NULL,
CURRENCY nchar(3) NOT NULL
);