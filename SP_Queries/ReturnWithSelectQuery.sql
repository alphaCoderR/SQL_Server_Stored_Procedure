use WideWorldImporters
go

create procedure Application.uspFindCountry
		@CountryID int
as
begin
	-- Demo of how to return a result using select statement
	set nocount on;
	select CountryName,
			LatestRecordedPopulation
	from Application.Countries
	where CountryID = @CountryID;
end

execute Application.uspFindCountry 32;