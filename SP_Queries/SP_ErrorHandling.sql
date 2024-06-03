
-- New method to handle errors (More like a structured method)
create procedure usp_DivideByZero
as
begin
	print 'Stored Procedure Starts'

	begin try
		-- Generating a divide by 0 error
		select 1/0;
	end try

	begin catch
		select
			error_number() as errNumber,
			error_severity() as errSeverity,
			error_state() as errState,
			error_procedure() as errProcedure,
			error_line() as errLine,
			error_message() as errMsg;
		print 'Divide by 0 error!'
	end catch

	print 'Stored Procedure Completed'
end;

execute usp_DivideByZero;


-- List of all default msystem messages
select * from sys.messages;


-- Traditional method to handle errors
DECLARE @Num1 float = 5.0;
-- DECLARE @Num2 float = 3.0;
DECLARE @Num2 float = 0.0;
declare @num3 float;

set @num3 = @Num1 / @Num2
if @@ERROR != 0 print 'Result : Division by 0 error'
else print 'Result: ' + cast(@num3 as nvarchar)



