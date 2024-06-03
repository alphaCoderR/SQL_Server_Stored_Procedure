alter procedure usp_GetEmpAvgVacationHrsWithLog
as
begin try
	
	declare @logName varchar(255) = 'GetAverageEmployeeVacationHours'
	declare @now datetime
	declare @logMsg varchar(max)

	declare @totHrs float,
			@totEmp float,
			@avgHrs float;

	select @totHrs = sum(VacationHours) from HumanResources.Employee;

	select @totEmp = count(*) from HumanResources.Employee where HireDate > '2024-09-03';

	set @avgHrs = @totHrs / @totEmp;

	set @now = GETDATE()
	set @logMsg = 'Calculating the average employee vacation hours';
	-- Insering into the log table
	insert into dbo.Log(LogName, LogDate, LogMessage) values (@logName, @now, @logMsg);

	print 'Average Vacation Hours for Employees are : ' + cast(@avgHrs as nvarchar);
end try

begin catch
	set @now = GETDATE()
	set @logMsg = 'Error: ' + cast(error_number() as nvarchar)
					+ 'State: ' + cast(error_state() as nvarchar)
					+ 'Proc: ' + error_procedure()
					+ 'Msg: ' + error_message()
	-- Insering into the log table
	insert into dbo.Log(LogName, LogDate, LogMessage) values (@logName, @now, @logMsg);
	throw;
end catch

execute usp_GetEmpAvgVacationHrsWithLog;

-- Query for fetching results from the log table 
select * from dbo.Log
where LogName = 'GetAverageEmployeeVacationHours'
order by LogDate desc;