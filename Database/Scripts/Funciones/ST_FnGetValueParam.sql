--liquibase formatted sql
--changeset ,jtous:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If Exists (Select 1 From dbo.sysobjects Where id = object_id(N'[dbo].[ST_FnGetValueParam]') And type In ('FN','TF'))
Drop Function ST_FnGetValueParam
Go
CREATE Function  Dbo.ST_FnGetValueParam (@codigo VARCHAR(20))
RETURNS varchar(MAX)

With Encryption 
As
BEGIN
	Declare @valor varchar(MAX) = NULL;

	Select @valor = valor From [dbo].[Parametros] Where codigo = @codigo;

	RETURN @valor
End
GO
