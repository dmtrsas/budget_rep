GO
USE Budget
GO
IF OBJECT_ID('dm.dim_cards') IS NOT NULL
	DROP TABLE dm.dim_cards;
GO

CREATE TABLE dm.dim_cards (
ID smallint PRIMARY KEY IDENTITY (1,1) NOT NULL,
CARD_NAME nvarchar(255) NOT NULL,
CARD_NUMBER nvarchar (255) NOT NULL,
ACCNO nvarchar(255) NOT NULL
);

