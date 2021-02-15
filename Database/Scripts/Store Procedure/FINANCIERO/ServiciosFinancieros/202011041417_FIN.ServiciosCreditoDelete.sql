--liquibase formatted sql
--changeset ,kmartinez:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FIN].[ServiciosCreditoDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [FIN].[ServiciosCreditoDelete]
GO

CREATE PROCEDURE [FIN].[ServiciosCreditoDelete]
@id BIGINT,
@id_user INT
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[FIN].[ServiciosCreditoDelete]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		28/10/2020
*Desarrollador: (Kmartinez)
*Descripcion: Este Store proc sirve para eliminar un registro en la tabla de listado
***************************************/
Declare @ds_error Varchar(Max),@coderror int
BEGIN TRANSACTION
BEGIN TRY 

		DELETE [FIN].[Financiero_lineacreditos] WHERE id = @id;

		SELECT @id;
COMMIT TRANSACTION;
END TRY
BEGIN CATCH
		ROLLBACK TRANSACTION;
	    SELECT @ds_error = ERROR_MESSAGE(), @coderror=ERROR_NUMBER()
 	 
END CATCH
