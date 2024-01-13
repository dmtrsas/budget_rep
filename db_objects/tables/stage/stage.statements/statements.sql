GO
USE Budget
GO
IF OBJECT_ID('stage.statements') IS NOT NULL
	DROP TABLE stage.statements;
GO

CREATE TABLE stage.statements(
TXN_DATE date NOT NULL,
TXN_TIME time NOT NULL,
TXN_DESCR nvarchar (255) NOT NULL,
TXN_AMOUNT dec(10,2) NOT NULL,
TXN_CURRENCY nvarchar(20) NOT NULL,
BILL_DATE date not null,
ACCOUNT_NO nvarchar(30),
BILL_AMOUNT dec(10,2) NOT NULL,
BILL_CURRENCY nvarchar(20) NOT NULL,
PAN nvarchar(10) NOT NULL,
TXN_CATEGORY nvarchar(255) NOT NULL,
ROW_HASH nvarchar(64) NOT NULL
);
