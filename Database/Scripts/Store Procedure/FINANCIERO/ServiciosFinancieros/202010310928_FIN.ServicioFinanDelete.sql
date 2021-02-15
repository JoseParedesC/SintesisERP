--liquibase formatted sql
--changeset ,kmartinez:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FIN].[ServicioFinanDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [FIN].[ServicioFinanDelete]
GO

CREATE PROCEDURE [FIN].[ServicioFinanDelete]
@id BIGINT,
@id_user INT
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[FIN].[ServicioFinanDelete]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		27/10/2020
*Desarrollador: (Kmartinez)
*Descripcion: Este SP tiene como funcionalidad eliminar un registro desde la configuracion de la tabla que tiene como opcion eliminar 

***************************************/
Declare @ds_error Varchar(Max),@coderror int
BEGIN TRANSACTION
BEGIN TRY 
		
		DELETE [FIN].[ServiciosFinanciero] WHERE id = @id;

		SELECT @id;
COMMIT TRANSACTION;
END TRY
BEGIN CATCH
		ROLLBACK TRANSACTION;
	    SELECT @ds_error = ERROR_MESSAGE(),@coderror=ERROR_NUMBER()	 
END CATCH