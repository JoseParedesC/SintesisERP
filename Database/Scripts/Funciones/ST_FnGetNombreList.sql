--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_FnGetNombreList]') and OBJECTPROPERTY(id, N'IsScalarFunction') = 1)
DROP FUNCTION [dbo].[ST_FnGetNombreList]
GO

CREATE Function  ST_FnGetNombreList (@id INT)
RETURNS varchar(100)

--With Encryption 
As
BEGIN
	Declare @nombre varchar(100) = NULL;

	Select @nombre = nombre From ST_listados Where id = @id;

	RETURN @nombre
End
GO
