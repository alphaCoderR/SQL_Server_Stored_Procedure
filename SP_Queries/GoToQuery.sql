 
-- *** Not recommended in modern day programming ***

declare @i int = 1;
start:
print 'Current Count: ' + cast(@i as varchar);
set @i = @i + 1;
if @i < 11 goto start