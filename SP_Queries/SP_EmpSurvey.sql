create procedure usp_EmployeeSurvey
as
begin

	declare @recordsToSkip int;

	declare @businessEntityID as int;
	declare @firstName as nvarchar(50),
			@lastName as nvarchar(50);

	-- Step 2 (Declaring Cursor)
	declare personCursor scroll cursor for
		select P.BusinessEntityID,
			P.FirstName,
			P.LastName
		from HumanResources.Employee E
		inner join Person.Person P on E.BusinessEntityID = P.BusinessEntityID
		where E.CurrentFlag = 1

	open personCursor;


	while @@FETCH_STATUS = 0
	begin
		set @recordsToSkip = round(((rand() * 4) + 1),0)
		fetch relative @recordsToSkip from personCursor
		into @businessEntityID, @firstName, @lastName
		-- Step 4 (Printing the values from the cursor in a loop)
		print ' Skipped ' + cast(@recordsToSkip as nvarchar(50))
					+ ' - ' + @lastName
					+ ', ' + @firstName + ' '

	end

	-- Step 5 - Close Cursor
	close personCursor;

	-- Step 6 - Deallocate Cursor
	deallocate personCursor;

end

execute usp_EmployeeSurvey;