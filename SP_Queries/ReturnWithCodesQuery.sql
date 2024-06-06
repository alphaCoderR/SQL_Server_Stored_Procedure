create procedure uspCalcSpeed
					@distance float,
					@time float,
					@speed float output
as
begin try
	set @speed = @distance / @time;
	return 0;
end try
begin catch
	return 1;
end catch



-- Testing 
declare @speed float, @returnValue int;

-- Calling stored procedure to calciulate speed
execute @returnValue = uspCalcSpeed 120.55, 58.67, @speed output

-- Displaying the result along with some computation
if @returnValue != 0
	print 'Unable to calculate speed';
else
	print 'The calculated value of speed is : ' + cast(@speed as nvarchar);

-- Displaying the result as a table
select @speed as Speed, @returnValue as ReturnValue ;