--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'isOb' AND TABLE_NAME = 'MovFactura')
BEGIN
	ALTER TABLE [dbo].[MovFactura] ADD [isOb] BIT NULL
	ALTER TABLE [dbo].[MovFactura] ADD [id_ctaobs] BIGINT NULL
END