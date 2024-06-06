select BusinessEntityID,
		FirstName,
		LastName
from Person.Person;


-- Setting up the cursor

-- Step 1 (Declaring Variables)
declare @businessEntityID as int;
declare @firstName as nvarchar(50),
		@lastName as nvarchar(50);

-- Step 2 (Declaring Cursor)
declare @personCursor as cursor;
set @personCursor = cursor for
	select BusinessEntityID,
		FirstName,
		LastName
	from Person.Person;

open @personCursor;



-- Test fetch status and loop
while @@FETCH_STATUS = 0
begin
	
	-- Step 3 (Fetch values into the cursor)
	fetch next from @personCursor into 
									@businessEntityID,
									@firstName,
									@lastName
	
	-- Step 4 (Printing the values from the cursor in a loop)
	print cast(@businessEntityID as nvarchar(50))
				+ ' - ' + @firstName
				+ ' - ' + @lastName

end

-- Step 5 - Close Cursor
close @personCursor;

-- Step 6 - Deallocate Cursor
deallocate @personCursor;