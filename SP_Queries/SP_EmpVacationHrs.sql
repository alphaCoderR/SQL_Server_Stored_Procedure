alter procedure usp_GetEmpAvgVacationHrs
as
begin try
	declare @totHrs float,
			@totEmp float,
			@avgHrs float;

	select @totHrs = sum(VacationHours) from HumanResources.Employee;

	select @totEmp = count(*) from HumanResources.Employee where HireDate > '2024-09-03';

	set @avgHrs = @totHrs / @totEmp;
	print 'Average Vacation Hours for Employees are : ' + cast(@avgHrs as nvarchar);
end try

begin catch
	print N'Error Number = ' + cast(error_number() as nvarchar)
	print N'Error Severity = ' + cast(error_severity() as nvarchar)
	print N'Error State = ' + cast(error_state() as nvarchar)
	print N'Error Procedure = ' + error_procedure()
	print N'Error Line = ' + cast(error_line() as nvarchar)
	print N'Error Message = ' + error_message()
end catch

execute usp_GetEmpAvgVacationHrs;