-- Printing Time using waitfor
print convert(varchar, getdate(), 109);
waitfor delay '00:00:05'
print convert(varchar, getdate(), 109);

-- Using waitfor command to access database info
declare @row int = 1;
declare @i int = 1;
while @i <= 5
begin
	select @row = count(*) from DatabaseLog;
	-- This will stop the exectution block for 5 sec
	waitfor delay '00:00:05';
	print 'Row Count:' + cast(@row as nvarchar);
	set @i = @i + 1;
end