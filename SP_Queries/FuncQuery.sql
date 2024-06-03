-- Calculating distance using sql as a scripting language
declare @speed float
declare @time float
declare @distance float

set @speed = 5.73
set @time = 78.91
set @distance = @speed * @time

-- Converting the float variable to string for printing
print 'Calculated distance is : ' + cast(@distance as nvarchar)
-- Displaying a float variable using format func()
print 'Calculated distance is : ' + format(@distance, 'N2')

-- Converting the script to a stored procedure
create procedure usp_calcDistance
@speed[float], @time[float]
as
begin
	declare @distance float
	set @distance = @speed * @time
	print 'Calculated distance is : ' + cast(@distance as nvarchar)
	print 'Calculated distance is : ' + format(@distance, 'N2')
end;

execute usp_calcDistance 5.73, 78.91;