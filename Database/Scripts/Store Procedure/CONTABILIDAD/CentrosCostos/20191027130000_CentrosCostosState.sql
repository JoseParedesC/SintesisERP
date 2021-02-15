--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[CentrosCostosState]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE CNT.CentrosCostosState
GO
CREATE PROCEDURE CNT.[CentrosCostosState]
@id BIGINT,
@id_user INT
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[CNT].[CentroCostoState]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		22/10/19
*Desarrollador: (jeteme)
***************************************/
Declare @ds_error Varchar(Max)

Begin Try

		UPDATE CNT.CentroCosto
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