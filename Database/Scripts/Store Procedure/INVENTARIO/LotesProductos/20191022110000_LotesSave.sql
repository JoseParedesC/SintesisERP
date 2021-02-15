--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[LotesSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE Dbo.LotesSave
GO
CREATE PROCEDURE [dbo].[LotesSave]
@id BIGINT ,
@lote [varchar](30),
@vencimiento [smalldatetime],
@id_user BIGINT

--WITH ENCRYPTION
AS

/***************************************
*Nombre:		[dbo].[LoteSave]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		15/11/19
*Desarrollador: (Jeteme)

SP para modificar Lotes
***************************************/

BEGIN TRANSACTION
BEGIN TRY

	DECLARE  @id_return INT, @error VARCHAR(MAX);
	
	UPDATE dbo.LotesProducto 
	SET
		[lote]			    = @lote,
		[vencimiento_lote]	= @vencimiento,
		id_userupdated		= @id_user,
		updated		= GETDATE()
	WHERE id = @id;;
			
	SET @id_return = @id;
	

COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);		
	ROLLBACK TRANSACTION;
END CATCH

SELECT @id_return;
	
	
	
	
			