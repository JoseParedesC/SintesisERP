--liquibase formatted sql
--changeset ,kmartinez:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FIN].[LineasCreditoDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [FIN].[LineasCreditoDelete]
GO

CREATE PROCEDURE [FIN].[LineasCreditoDelete]
@id BIGINT,
@id_user INT
 
 
AS
/***************************************
*Nombre:		 [FIN].[LineasCreditoDelete]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		28/10/2020
*Desarrollador: (Kmartinez)
*Descripcion: Elimina un registro de la tabla lineas credito al igual que el servicio
***************************************/
Declare @ds_error Varchar(Max),@coderror int
BEGIN TRANSACTION
BEGIN TRY 

		DELETE [FIN].[Financiero_lineacreditos] WHERE id_lineascredito = @id;
		DELETE [FIN].[LineasCreditos] WHERE id = @id;

		SELECT @id;
COMMIT TRANSACTION;
END TRY
BEGIN CATCH
		ROLLBACK TRANSACTION;
	    SELECT @ds_error = ERROR_MESSAGE(), @coderror=ERROR_NUMBER()
 	 
END CATCH