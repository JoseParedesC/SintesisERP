--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[ST_CNTCategoriaFiscalServicioState]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [Dbo].[ST_CNTCategoriaFiscalServicioState]
GO

CREATE PROCEDURE dbo.ST_CNTCategoriaFiscalServicioState
@id BIGINT,
@id_user INT
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[ST_CNTCategoriaFiscalServicioState]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		20/11/20
*Desarrollador: (Jeteheran)
***************************************/
Declare @ds_error Varchar(Max)

Begin Try

		UPDATE Dbo.CNTCategoriaFiscalServicios
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