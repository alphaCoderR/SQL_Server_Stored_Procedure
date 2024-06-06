-- Stored Procedure to update employee new salary after a hike

create procedure HumanResources.usp_UpdateEmployeeHireInfo
	@BusinessEntityID int,
	@JobTitle nvarchar(50),
	@HireDate datetime,
	@RateChangeDate datetime,
	@Rate money,
	@PayFrequency tinyint,
	@CurrentFlag [dbo].[Flag]
with execute as caller
as
begin
	set nocount on;

	begin try
		begin transaction

		update HumanResources.Employee
		set [JobTitle] = @JobTitle,
			[HireDate] = @HireDate,
			[CurrentFlag] = @CurrentFlag
		where [BusinessEntityID] = @BusinessEntityID;

		insert into HumanResources.EmployeePayHistory
			([BusinessEntityID],
			[RateChangeDate],
			[Rate],
			[PayFrequency])
		values (@BusinessEntityID, @RateChangeDate, @Rate, @PayFrequency);

		commit transaction;
	end try

	begin catch
		-- Rollback any active or uncommitable transactions before
		-- inserting information in the errorlog
		if @@TRANCOUNT > 0
		begin
			rollback transaction;
		end

		execute [dbo].[uspLogError];
	end catch;
end;

-- Testing

-- use AdventureWorks2022;

declare @Rc int;
declare @BusinessEntityID int;
declare @JobTitle nvarchar(50);
declare @HireDate datetime;
declare @RateChangeDate datetime;
declare @Rate money;
declare @PayFrequency tinyint;
declare @CurrentFlag [dbo].[Flag];

-- TODO: Set the parameter values here
set @BusinessEntityID = 46;

-- Get Current Employee Details
select @JobTitle = JobTitle,
		@HireDate = HireDate,
		@RateChangeDate = getdate(),
		@CurrentFlag = CurrentFlag
from HumanResources.Employee
where BusinessEntityID = @BusinessEntityID;

-- Get Most recent pay
select top 1
		@Rate = Rate,
		@PayFrequency = PayFrequency
from HumanResources.EmployeePayHistory
where BusinessEntityID = @BusinessEntityID
order by BusinessEntityID, RateChangeDate asc;

-- Promote Employee
set @JobTitle = 'Production Supervisor - WC60';
set @Rate = @Rate * (1.1); -- 10% Hike

-- Calling the stored procedure
execute @Rc = [HumanResources].[usp_UpdateEmployeeHireInfo]
	@BusinessEntityID,
	@JobTitle,
	@HireDate,
	@RateChangeDate,
	@Rate,
	@PayFrequency,
	@CurrentFlag
go