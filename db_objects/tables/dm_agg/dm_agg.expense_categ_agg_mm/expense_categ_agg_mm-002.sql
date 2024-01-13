USE Budget
GO

if exists 
(
  select * 
  from information_schema.columns 
  where table_name = 'expense_categ_agg_mm'
  and column_name = 'user_id'
)
print 'column exists in the table';
else

alter table dm_agg.expense_categ_agg_mm
add user_id tinyint null;

GO