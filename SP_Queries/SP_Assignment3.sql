alter procedure usp_GetFullName
	@personID int ,
	@fullName nvarchar(100) output
as
begin
	declare @returnCode int = 0;
	begin try
		declare @fName nvarchar(50), @lName nvarchar(50);
	
		set nocount on;
		select @fName = FirstName , @lName = LastName
		from Person.Person
		where BusinessEntityID = @personID;

		set @fullName = @fName + ' ' + @lName;

		if @fullName is null
			throw 51000, 'The record does not exist.', 1;
	end try
	begin catch
		set @returnCode = -1;
	end catch

	return @returnCode;
end


-- Testing the stored procedure -----

declare @fullName nvarchar(100), @response int;
-- Fetching the result from the stored procedure
execute @response = usp_GetFullName 20778, @fullName output;

if @response != -1
	print 'The full name of the person is : ' + @fullName;
else
	print 'Error getting full name of the person. !! ';



--select FirstName , LastName from Person.Person where BusinessEntityID = 20778;
