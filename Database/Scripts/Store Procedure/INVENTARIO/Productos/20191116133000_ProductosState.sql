--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ProductosState]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.ProductosState
GO


CREATE PROCEDURE [dbo].[ProductosState]
@id BIGINT,
@id_user INT
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ProductosState]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci?n:		16/11/19
*Desarrollador: (JETEHERAN)
***************************************/
Declare @ds_error Varchar(Max)

Begin Try

		UPDATE Dbo.Productos
		SET estado = CASE estado WHEN 0 THEN 1 ELSE 0 END,
		id_userupdated = @id_user, 
		updated = GETDATE() 
		WHERE id = @id;

End Try
Begin Catch
	    Select @ds_error = ERROR_MESSAGE()
	    RaisError(@ds_error,16,1)
	    Return
End Catch


GO


