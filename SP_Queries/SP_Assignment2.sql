declare @i int = 2;
while @i <= 20
begin
	print cast(@i as nvarchar);
	if @i = 10
	begin
		print 'halfway there!'
	end
	set @i = @i + 2;
end