--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_CNTCategoriaFiscalState]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_CNTCategoriaFiscalState]
GO
CREATE PROCEDURE dbo.ST_CNTCategoriaFiscalState
@id BIGINT,
@id_user INT
WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[ST_CNTCategoriaFiscalState]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		02/04/17
*Desarrollador: (JTOUS)
***************************************/
Declare @ds_error Varchar(Max)

Begin Try

		UPDATE Dbo.CNTCategoriaFiscal
		SET estado = CASE estado WHEN 0 THEN 1 ELSE 0 END,
		id_user = @id_user, 
		updated = GETDATE() 
		WHERE id = @id;

		SELECT @id;

End Try
Begin Catch
	    Select @ds_error = ERROR_MESSAGE()
	    RaisError(@ds_error,16,1)
	    Return
End Catch
GO