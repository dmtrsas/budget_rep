go 

begin
use Budget
begin transaction;

		declare 
		@constr_name nvarchar(255) = '',
		@drop_constr_command nvarchar(255) = '',
		@table_name nvarchar(255) = '';
		while 
		(select count (*) from sys.foreign_keys) > 0
		begin
				select @constr_name = FK_name, @table_name = table_name
					from 
							(
							select 
							fk.name as 'FK_name'
							,t.name as 'Table_name' 
							,row_number () over (order by fk.object_id desc) as 'RN'
							from sys.foreign_keys fk 
							join sys.tables t on t.object_id = fk.parent_object_id
							) fk
					where fk.RN = 1;
		
		
		
		set @drop_constr_command = 'alter table ' + @table_name + ' drop constraint ' + @constr_name;
		exec sp_executesql @drop_constr_command;
		
		end;
commit transaction;
print 'all FKs deleted';
end;

select * from sys.foreign_keys;

go