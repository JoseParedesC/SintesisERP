--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[CajasState]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE Dbo.CajasState
GO

CREATE PROCEDURE dbo.CajasState
@id BIGINT,
@id_user INT
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[CajasState]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		19/12/19
*Desarrollador: (JETEHERAN)
***************************************/
Declare @ds_error Varchar(Max)

Begin Try

		UPDATE dbo.Cajas
		SET estado = CASE estado WHEN 0 THEN 1 ELSE 0 END,
		id_user = @id_user, 
		updated = GETDATE() 
		WHERE id = @id;

		SELECT @id;

End Try
Begin Catch
	    Select @ds_error = ERROR_MESSAGE()
	    RaisError(@ds_error,16,1);
End Catch
GO
