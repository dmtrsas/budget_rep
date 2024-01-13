use budget
go

if exists 
(
  select * 
  from information_schema.columns 
  where table_name = 'transactions'
  and column_name = 'mcc'
)
print 'column exists in the table';
else

alter table transactions
add mcc smallint not null;