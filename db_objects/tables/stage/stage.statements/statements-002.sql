use budget
go

if exists 
(
  select * 
  from information_schema.columns 
  where table_name = 'stage.statements'
  and column_name = 'account_number'
)
print 'column exists in the table';
else

alter table stage.statements
add account_number nvarchar(30) null;