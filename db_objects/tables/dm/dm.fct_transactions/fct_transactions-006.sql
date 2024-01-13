use budget
go

if exists 
(
  select * 
  from information_schema.columns 
  where table_name = 'fct_transactions'
  and column_name = 'user_id'
)
print 'column exists in the table';
else

alter table dm.fct_transactions
add user_id tinyint null;