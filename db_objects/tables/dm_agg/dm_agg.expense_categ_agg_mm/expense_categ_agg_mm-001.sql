USE Budget
GO

ALTER SCHEMA dm_agg
    TRANSFER dbo.expense_categ_agg_mm;

GO