alter procedure usp_CalcPricePerPound
	@weight [float], @totPrice [float]
as
begin
	---- Conditional Statements along with nested if's
	declare @pricePerPound float;

	if @weight = 0
	begin
		print 'Weight cannot be 0, changing weight to 1';
		set @weight = 1;
		if @totPrice > 100
		begin
			print 'Price too large. Setting price to 100';
			set @totPrice = 100;
		end
	end
	else
	begin
		print 'Valid weight entered';
		if @totPrice > 100
		begin
			print 'Price too large. Setting price to 100';
			set @totPrice = 100;
		end
	end

	set @pricePerPound = @totPrice / @weight;
	print 'The price per pound is ' + cast(@pricePerPound as nvarchar);
end

execute usp_CalcPricePerPound 14.77, 197.35;