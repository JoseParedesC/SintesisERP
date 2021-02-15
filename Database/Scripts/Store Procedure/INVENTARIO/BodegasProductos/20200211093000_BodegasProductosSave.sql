--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[BodegasProductosSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE Dbo.BodegasProductosSave
GO

CREATE PROCEDURE [dbo].[BodegasProductosSave]
@id BIGINT = null,
@id_producto BIGINT,
@id_bodega BIGINT,
@stockmin decimal(18,2),
@stockmax decimal(18,2),
@id_usercreated BIGINT,
@id_userupdated BIGINT

--WITH ENCRYPTION
AS

/***************************************
*Nombre:		[dbo].[BodegasProductosSave]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		20/11/19
*Desarrollador: (Jeteme)

SP para insertar Bodega de Productos
***************************************/

BEGIN TRANSACTION
BEGIN TRY

	DECLARE  @id_return INT, @error VARCHAR(MAX);
	
	IF(Isnull(@id,0) = 0)
	BEGIN		
		IF EXISTS(SELECT 1 FROM [dbo].[BodegasProducto] WHERE id_producto = @id_producto and id_bodega=@id_bodega) 
			RAISERROR('Esta Bodega ya se le ha definido su Stock', 16, 0);
		IF(@stockmax<@stockmin)
			RAISERROR('Stock maximo no puede ser menor al stock minimo',16,0);

		INSERT INTO [dbo].[BodegasProducto]([id_producto], [id_bodega], [stockmin], [stockmax], [id_usercreated],[id_userupdated])
		VALUES (@id_producto, @id_bodega, @stockmin,@stockmax, @id_usercreated,@id_userupdated);
				
		SET @id_return = SCOPE_IDENTITY();
	END
	ELSE
	BEGIN
		UPDATE [dbo].[BodegasProducto]
		SET
			[stockmin]			=@stockmin,
			[stockmax]			= @stockmax,
			id_userupdated		= @id_userupdated,
			updated		= GETDATE()
		WHERE id= @id;
			
		SET @id_return = @id;	
	END
	

COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);		
	ROLLBACK TRANSACTION;
END CATCH

SELECT @id_return;
	
	
	
			

GO


