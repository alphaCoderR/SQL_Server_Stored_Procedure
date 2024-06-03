alter procedure usp_CalcWeight 
@quantity[float]
as
begin
	declare @priceWeight as float = 27.93;

	declare @totWeight as float;
	declare @UoM as varchar(10) = 'g';

	set @totWeight = @quantity * @priceWeight;
	print 'The total weight is : ' + cast(@totWeight as nvarchar);
	if @totWeight >= 1000
	begin
		print 'Converting to Kg';
		set @totWeight = @totWeight * 0.001;
		set @UoM = 'Kg';
		print 'The total weight in Kg is : ' + cast(@totWeight as nvarchar);
	end
end

execute usp_CalcWeight 50.00;