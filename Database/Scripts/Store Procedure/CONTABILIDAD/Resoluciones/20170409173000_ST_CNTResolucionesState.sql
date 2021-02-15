--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_CNTResolucionesState]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_CNTResolucionesState]
GO

CREATE PROCEDURE [dbo].[ST_CNTResolucionesState]
@id BIGINT,
@id_user INT
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_CNTResolucionesState]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		09/04/17
*Desarrollador: (JTOUS)
***************************************/
Declare @ds_error Varchar(Max), @id_ccosto BIGINT,@isfe BIT = 0;
Begin Try
	
	SELECT @id_ccosto = id_ccosto, @isfe = isfe FROM Dbo.DocumentosTecnicaKey where id = @id;
	IF(ISNULL(@id_ccosto, 0) = 0)
		RAISERROR('No se puede modificar el estado, porque esta resolución no tiene centro costo relacionado.', 16, 0);
	
	IF EXISTS (SELECT 1 FROM dbo.DocumentosTecnicaKey WHERE id = @id AND estado != 0)
	BEGIN
		UPDATE Dbo.DocumentosTecnicaKey
		SET estado = CASE estado WHEN 0 THEN 1 ELSE 0 END,
		id_user = @id_user, 
		updated = GETDATE() 
		WHERE id = @id;
	END
	ELSE
	BEGIN
		IF(ISNULL(@isfe, 0) != 0)
			UPDATE dbo.DocumentosTecnicaKey SET estado = CASE WHEN id = @id THEN 1 ELSE 0 END WHERE id_ccosto = @id_ccosto and  isfe != 0;
		ELSE
			UPDATE dbo.DocumentosTecnicaKey SET estado = CASE WHEN id = @id THEN 1 ELSE 0 END WHERE id_ccosto = @id_ccosto and  isfe = 0;
	END

End Try
Begin Catch
	    Select @ds_error = ERROR_MESSAGE()
	    RaisError(@ds_error,16,1)
	    Return
End Catch

GO


