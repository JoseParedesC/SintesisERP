--liquibase formatted sql
--changeset ,jtous:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[vw_aspnet_Applications]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View dbo.vw_aspnet_Applications
END
GO
CREATE VIEW [dbo].[vw_aspnet_Applications]
AS 

	SELECT	[dbo].[aspnet_Applications].[ApplicationName], 
			[dbo].[aspnet_Applications].[LoweredApplicationName], 
			[dbo].[aspnet_Applications].[ApplicationId], 
			[dbo].[aspnet_Applications].[Description]
	FROM [dbo].[aspnet_Applications]
  
GO


