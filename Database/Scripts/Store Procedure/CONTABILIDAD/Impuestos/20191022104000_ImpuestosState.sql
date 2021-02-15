--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ImpuestosState]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE CNT.[ImpuestosState]
GO

CREATE PROCEDURE [CNT].[ImpuestosState]
@id BIGINT,
@id_user INT
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[CNT].[ImpuestosState]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		22/10/19
*Desarrollador: (Jeteme)

SP para actualizar estado de tipo de impuestos
***************************************/
Declare @ds_error Varchar(Max)

Begin Try

		UPDATE CNT.Impuestos
		SET estado	= CASE estado WHEN 0 THEN 1 ELSE 0 END,
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


