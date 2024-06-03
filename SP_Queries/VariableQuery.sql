declare @firstName varchar(40);
declare @personID int = 6995;

select @firstName = FirstName
from Person.Person
where BusinessEntityID = @personID;

print @firstName

-- Converting the script to stored procedure
create procedure usp_FindingPersonByID
@personID int
as
begin
	declare @firstName varchar(40)
	select @firstName = FirstName
	from Person.Person
	where BusinessEntityID = @personID;
	print @firstName
end;

execute usp_FindingPersonByID 69;