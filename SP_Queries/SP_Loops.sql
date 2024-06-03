create procedure usp_count20By2
as
begin
	declare @i int = 2;
	while @i <= 20
	begin
		print 'Current Count : ' + cast(@i as nvarchar);
		set @i = @i + 2;
	end
end

execute usp_count20By2;