alter procedure usp_generateRows
as
begin
	-- Set up Variables
	declare @WeekTable table(WeekNumber int,
								DateStarting smalldatetime)

	declare @n int = 0;
	declare @firstWeek smalldatetime = '03/06/2024'

	-- Loop through weeks
	while @n <= 52
	begin
		insert into @WeekTable values (@n, dateadd(WK,@n,@firstWeek))
		select @n = @n + 1;
		-- Applying Break case
		if @n = 52 
			break;
	end

	-- Show Results
	select * from @WeekTable;
end

execute usp_generateRows;
