GO
USE Budget
GO
IF OBJECT_ID('dm.dim_mcc_codes') IS NOT NULL
	DROP TABLE dm.dim_mcc_codes;
GO

CREATE TABLE dm.dim_mcc_codes (
MCC smallint NOT NULL,
DESCRIPTION nvarchar(255) NOT NULL
);