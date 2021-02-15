--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_FnGetIdList]') and OBJECTPROPERTY(id, N'IsScalarFunction') = 1)
DROP FUNCTION [dbo].[ST_FnGetIdList]
GO

CREATE Function  ST_FnGetIdList (@iden varchar(20))
RETURNS varchar(20)

--With Encryption 
As
BEGIN
	Declare @id INT = NULL;

	Select @id = id From ST_listados Where Iden = @iden;

	RETURN @id
End
GO
