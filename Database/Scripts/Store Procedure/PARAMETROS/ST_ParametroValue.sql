--liquibase formatted sql
--changeset ,jtous:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_ParametroValue]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.ST_ParametroValue
GO
CREATE PROCEDURE dbo.ST_ParametroValue
	@codigo VARCHAR(50) = NULL
WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[ST_ParametroValue]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		27/03/17
*Desarrollador: (JTOUS)
***************************************/
DECLARE @error VARCHAR(MAX);
BEGIN TRY
		SELECT valor FROM [dbo].[Parametros]
		WHERE codigo = @codigo;
				
END TRY
BEGIN CATCH
	    Select @error   =  ERROR_MESSAGE()
	    RaisError(@error,16,1)
	    Return  
End Catch
GO
