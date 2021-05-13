--liquibase formatted sql
--changeset ,JARCINIEGAS:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
/*Cabecera de Crear SCHEMA que no Existe*/
IF NOT EXISTS (SELECT 1 FROM SYS.SCHEMAS WHERE NAME = 'NOM')
BEGIN
     EXEC sp_executesql N'CREATE SCHEMA NOM AUTHORIZATION dbo;';
END
GO
