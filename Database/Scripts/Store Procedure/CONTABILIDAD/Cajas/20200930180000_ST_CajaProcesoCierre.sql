--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[ST_CajaProcesoCierre]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE Dbo.[ST_CajaProcesoCierre]
GO

CREATE PROCEDURE [dbo].[ST_CajaProcesoCierre]
	@id BIGINT ,
	@id_user INT
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[ST_CajaProcesoCierre]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		28/03/17
*Desarrollador: (JTOUS)
***************************************/
DECLARE @error VARCHAR(MAX), @id_return INT;
DECLARE @id_caja INT, @fecha varchar(10), @count int = 0, @valor numeric (18,4) = 0, @contabilizar bit = 0;
BEGIN TRY

IF EXISTS( SELECT 1 FROM [dbo].[CajasProceso] WHERE id = @id AND estado = 0)
BEGIN
	RAISERROR('La caja ya esta cerrada.', 16, 0);
END
ELSE
BEGIN
	SELECT TOP 1 @id_caja = id_caja, @fecha = CONVERT(varchar(10), fechaapertura, 120) FROM [dbo].[CajasProceso] WHERE id = @id;
	BEGIN TRY
	BEGIN TRAN
		UPDATE Dbo.Cajas SET [userproceso] = NULL, [cajaproceso] = 0 WHERE id = @id_caja;

		UPDATE [dbo].[CajasProceso] 
			SET estado				= 0,				 
				id_usercierre		= @id_user, 
				fechacierre			= GETDATE(), 
				updated				= GETDATE(),
				contabilizado		= @contabilizar
		WHERE id = @id;
		
	COMMIT TRAN;	
	END TRY
	BEGIN CATCH		
		ROLLBACK TRAN;
		Select @error   =  ERROR_MESSAGE();
		RaisError(@error,16,1);
	END CATCH
END
END TRY
BEGIN CATCH
	    --Getting the error description
	    Select @error   = ERROR_MESSAGE()
	    -- save the error in a Log file
	    RaisError(@error,16,1)
	    Return  
END CATCH
