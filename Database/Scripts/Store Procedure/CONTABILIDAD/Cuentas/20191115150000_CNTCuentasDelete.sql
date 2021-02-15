--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[CNTCuentasDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE Dbo.CNTCuentasDelete
GO

CREATE PROCEDURE dbo.CNTCuentasDelete
@id BIGINT,
@id_user INT
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[CNTCuentasDelete]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		2019/12/17
*Desarrollador: (JETEHERAN)
***************************************/
Declare @error Varchar(Max), @coderror INT
BEGIN TRANSACTION
BEGIN TRY 

	DELETE dbo.CNTCuentas WHERE id = @id;

	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
		ROLLBACK TRANSACTION;
	    SELECT @error = ERROR_MESSAGE(),@coderror=ERROR_NUMBER()

		IF(@coderror=547)
		RAISERROR('Esta cuenta tiene movimiento referenciado, NO es posible Eliminarla!',16,1)
	    ELSE
	    RAISERROR(@error,16,1)
	    RETURN
END CATCH
GO
