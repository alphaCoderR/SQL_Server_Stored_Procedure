create procedure uspUpperStr
as
begin
	declare @name varchar(40) = 'unknown'
	print @name
	set @name = 'India'
	print 'The uppercase value of `' + @name + '` is ' + upper(@name);
end

execute uspUpperStr