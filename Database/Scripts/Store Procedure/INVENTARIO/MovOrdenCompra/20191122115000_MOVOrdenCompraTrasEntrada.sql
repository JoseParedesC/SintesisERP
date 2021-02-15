--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[MOVOrdenCompraTrasEntrada]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[MOVOrdenCompraTrasEntrada]
GO

CREATE PROCEDURE [dbo].[MOVOrdenCompraTrasEntrada]
@id BIGINT,
@id_user INT
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[MOVOrdenCompraTrasEntrada]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		5/12/19
*Desarrollador: (jeteme)
***************************************/
Declare @ds_error Varchar(Max)

Begin Try

		UPDATE dbo.MovOrdenCompras
		SET estado	=  Dbo.ST_FnGetIdList('TRASLA'),
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


