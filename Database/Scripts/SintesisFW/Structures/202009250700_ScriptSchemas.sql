--liquibase formatted sql
--changeset jtous:1 dbms:mssql endDelimiter:GO

CREATE USER [sintesis] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Schema [aspnet_Membership_BasicAccess]    Script Date: 2017/11/29 0:19:58 ******/
CREATE SCHEMA [aspnet_Membership_BasicAccess]
GO
/****** Object:  Schema [aspnet_Membership_FullAccess]    Script Date: 2017/11/29 0:19:58 ******/
CREATE SCHEMA [aspnet_Membership_FullAccess]
GO
/****** Object:  Schema [aspnet_Membership_ReportingAccess]    Script Date: 2017/11/29 0:19:58 ******/
CREATE SCHEMA [aspnet_Membership_ReportingAccess]
GO
/****** Object:  Schema [aspnet_Roles_BasicAccess]    Script Date: 2017/11/29 0:19:58 ******/
CREATE SCHEMA [aspnet_Roles_BasicAccess]
GO
/****** Object:  Schema [aspnet_Roles_FullAccess]    Script Date: 2017/11/29 0:19:58 ******/
CREATE SCHEMA [aspnet_Roles_FullAccess]
GO
/****** Object:  Schema [aspnet_Roles_ReportingAccess]    Script Date: 2017/11/29 0:19:58 ******/
CREATE SCHEMA [aspnet_Roles_ReportingAccess]
GO
/****** Object:  Schema [CNT]    Script Date: 25/09/2020 8:23:36 a. m. ******/
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'CNT')
BEGIN
	EXEC ('CREATE SCHEMA [CNT]')
END
GO
/****** Object:  Schema [FIN]    Script Date: 25/09/2020 8:23:36 a. m. ******/
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'FIN')
BEGIN
	EXEC ('CREATE SCHEMA [FIN]')
END
GO

