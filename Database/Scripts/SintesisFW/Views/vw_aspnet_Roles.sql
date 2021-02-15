--liquibase formatted sql
--changeset ,jtous:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[vw_aspnet_Roles]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View dbo.vw_aspnet_Roles
END
GO
CREATE VIEW [dbo].[vw_aspnet_Roles]
AS 

	SELECT	[dbo].[aspnet_Roles].[ApplicationId], 
			[dbo].[aspnet_Roles].[RoleId], 
			[dbo].[aspnet_Roles].[RoleName], 
			[dbo].[aspnet_Roles].[LoweredRoleName], 
			[dbo].[aspnet_Roles].[Description]
	FROM [dbo].[aspnet_Roles]
  
GO


