create table dbo.Log
(
	LogName varchar(255) not null,
	LogDate datetime not null,
	LogMessage nvarchar(max) null
)

create index IdxLogNameLogDate on dbo.Log(LogName, LogDate)

select * from Log;