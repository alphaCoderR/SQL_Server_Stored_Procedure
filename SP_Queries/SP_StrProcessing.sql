alter procedure usp_StringProcessing
	@value varchar(50)
as
begin
	declare @pos as int = 1;
	declare @curText as varchar(1);
	declare @strLength as int = len(@value);

	while @pos <= @strLength
	begin
		set @curText = SUBSTRING(@value,@pos,1);
		if @curText between '0' and '9'
			break
		else
		begin
			if @curText != ' '
			begin
				print cast(@pos as nvarchar) + ' ' + @curText;
			end
			set @pos = @pos + 1;
		end
	end
end
			
execute usp_StringProcessing 'New York 10001ADT';