GO
USE Budget
GO
IF OBJECT_ID('dm.dim_users') IS NOT NULL
	DROP TABLE dm.dim_users;
GO

CREATE TABLE dm.dim_users (
ID smallint PRIMARY KEY IDENTITY (1,1) NOT NULL,
USERNAME nvarchar(255) NOT NULL, 
INSERT_DT date NOT NULL
);
