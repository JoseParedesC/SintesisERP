--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[ST_CNTCategoriaFiscalServicioDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [Dbo].[ST_CNTCategoriaFiscalServicioDelete]
GO



CREATE PROCEDURE [dbo].[ST_CNTCategoriaFiscalServicioDelete]
@id BIGINT,
@id_user INT
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[ST_CNTCategoriaFiscalServicioDelete]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		20/11/20
*Desarrollador: (JTOUS)
***************************************/
Declare @ds_error Varchar(Max),@coderror int;
BEGIN TRANSACTION
BEGIN TRY 

		DELETE Dbo.CNTCategoriaFiscalServicios WHERE id = @id;

		SELECT @id;
COMMIT TRANSACTION;
END TRY
BEGIN CATCH
		ROLLBACK TRANSACTION;
	    SELECT @ds_error = ERROR_MESSAGE(), @coderror=ERROR_NUMBER()

		IF(@coderror=547)
		RAISERROR('No se puede eliminar, ya que tiene movimientos.',16,1)
	    ELSE
	    RAISERROR(@ds_error,16,1)
	    RETURN
END CATCH
GO


