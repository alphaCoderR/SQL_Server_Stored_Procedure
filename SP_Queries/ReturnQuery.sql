declare @speed float;
declare @distance float = 120.87;
declare @time float = 69.99;
-- declare @time float = 0.00;

if @time = 0.0 
	return
set @speed = @distance / @time
select @speed