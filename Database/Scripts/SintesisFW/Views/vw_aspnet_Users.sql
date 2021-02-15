--liquibase formatted sql
--changeset ,jtous:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[vw_aspnet_Users]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View dbo.[vw_aspnet_Users]
END
GO
 CREATE VIEW [dbo].[vw_aspnet_Users]
 AS 
 
	SELECT	[dbo].[aspnet_Users].[ApplicationId], 
			[dbo].[aspnet_Users].[UserId], 
			[dbo].[aspnet_Users].[UserName], 
			[dbo].[aspnet_Users].[LoweredUserName], 
			[dbo].[aspnet_Users].[MobileAlias], 
			[dbo].[aspnet_Users].[IsAnonymous], 
			[dbo].[aspnet_Users].[LastActivityDate]
	FROM [dbo].[aspnet_Users]
  
GO


