--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[TercerosDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE CNT.[TercerosDelete]
GO


CREATE PROCEDURE [CNT].[TercerosDelete]
@id BIGINT,
@id_user INT
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[CNT].[TercerosDelete]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci?n:		04/11/19
*Desarrollador: (Jeteme)
***************************************/
Declare @ds_error Varchar(Max),@coderror int;
BEGIN TRANSACTION
BEGIN TRY 

		DELETE CNT.TipoTerceros WHERE id_tercero = @id;
		DELETE CNT.Terceros WHERE id = @id;

COMMIT TRANSACTION;
END TRY
BEGIN CATCH
		ROLLBACK TRANSACTION;
	    SELECT @ds_error = ERROR_MESSAGE(), @coderror=ERROR_NUMBER()

		IF(@coderror=547)
		RAISERROR('Este cliente ya tiene movimiento, NO es posible Eliminarlo!',16,1)
	    ELSE
		RAISERROR(@ds_error,16,1)
	    RETURN
END CATCH

GO


