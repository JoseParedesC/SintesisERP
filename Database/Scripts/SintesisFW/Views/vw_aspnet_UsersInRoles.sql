--liquibase formatted sql
--changeset ,jtous:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[vw_aspnet_UsersInRoles]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View dbo.vw_aspnet_UsersInRoles
END
GO
CREATE VIEW [dbo].[vw_aspnet_UsersInRoles]
AS
	SELECT 
			[dbo].[aspnet_UsersInRoles].[UserId], 
			[dbo].[aspnet_UsersInRoles].[RoleId]
	FROM [dbo].[aspnet_UsersInRoles]
  
GO


