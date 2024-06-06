-- Calculating area
create procedure usp_calcArea
	@height float, -- Input Parameters
	@width float,
	@area float output --Setting it as an output parameter
as
begin
	set @area = @width * @height;
end


-- Executing the stored procedure
declare @result float;
execute usp_calcArea 11.87, 99.65, @result output;
print 'The area is : ' + cast(@result as nvarchar);