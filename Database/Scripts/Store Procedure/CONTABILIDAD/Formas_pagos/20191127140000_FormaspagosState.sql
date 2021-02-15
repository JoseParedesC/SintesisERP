--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[FormasPagosState]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE Dbo.FormasPagosState
GO
CREATE PROCEDURE dbo.FormasPagosState
@id BIGINT,
@id_user INT
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[FormasPagosState]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		27/11/19
*Desarrollador: (JETEHERAN)
***************************************/
Declare @ds_error Varchar(Max)

Begin Try

		UPDATE dbo.FormaPagos
		SET estado = CASE estado WHEN 0 THEN 1 ELSE 0 END,
		id_userupdated = @id_user, 
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