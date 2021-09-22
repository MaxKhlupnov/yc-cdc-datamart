
/* Allow sql server agent*/
sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
sp_configure 'Agent XPs', 1;
GO
RECONFIGURE
GO
/*Start SQL Server Agent service*/
EXEC master.dbo.xp_servicecontrol N'START',N'SQLServerAGENT';
EXEC master.dbo.xp_servicecontrol N'QUERYSTATE',N'SQLSERVERAGENT'