use budget
go

if exists 
(
  select * 
  from information_schema.columns 
  where table_name = 'fct_transactions'
  and column_name = 'row_hash'
)
print 'column exists in the table';
else

alter table dm.fct_transactions
add row_hash nvarchar(70) null;