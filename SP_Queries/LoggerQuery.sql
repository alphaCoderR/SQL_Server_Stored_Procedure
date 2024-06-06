
-- Creating Stored Procedure for logger table
alter procedure usp_LogWrite
	@LogName varchar(255),
	@LogMessage nvarchar(max)
as
begin
	
	-- Checking if the table already exists
	if object_id('dbo.Log', 'U') is null
	begin
		create table dbo.Log
		(
			LogName varchar(255) not null,
			LogDate datetime not null,
			LogMessage nvarchar(max) null
		)
		create index IdxLogNameLogDate on dbo.Log(LogName, LogDate)
	end

	declare @now as datetime = getdate()
	insert into dbo.Log(LogName, LogDate, LogMessage) values (@LogName, @now, @LogMessage);

end

execute usp_LogWrite 'Test', 'Test Message';

-- SQL Script
create table dbo.Log
(
	LogName varchar(255) not null,
	LogDate datetime not null,
	LogMessage nvarchar(max) null
)

create index IdxLogNameLogDate on dbo.Log(LogName, LogDate)

select top 10 * from dbo.Log order by LogDate desc;