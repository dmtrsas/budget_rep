use Budget;

go

if exists 
(
  select * 
  from information_schema.columns 
  where table_name = 'transactions'
  and column_name = 'INSERT_DT'
)
print 'column INSERT_DT exists in the table';
else

alter table transactions add INSERT_DT date;


if exists 
(
  select * 
  from information_schema.columns 
  where table_name = 'transactions'
  and column_name = 'UPDATE_DT'
)
print 'column UPDATE_DT exists in the table';
else

alter table transactions add UPDATE_DT date;
