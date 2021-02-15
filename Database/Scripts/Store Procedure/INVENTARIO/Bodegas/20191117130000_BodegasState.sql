--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[BodegasState]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE Dbo.[BodegasState]
GO
CREATE PROCEDURE dbo.[BodegasState]
@id BIGINT,
@id_user INT
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[BodegasState]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		17/11/19
*Desarrollador: (JETEHERAN)
***************************************/
Declare @ds_error Varchar(Max)

Begin Try

		UPDATE Dbo.Bodegas
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
