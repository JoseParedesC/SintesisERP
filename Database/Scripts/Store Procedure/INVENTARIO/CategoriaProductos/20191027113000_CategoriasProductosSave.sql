--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[CategoriasProductosSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE Dbo.[CategoriasProductosSave]
GO

CREATE PROCEDURE [dbo].[CategoriasProductosSave]
@id BIGINT = null,
@nombre VARCHAR(100),
@id_user int

--WITH ENCRYPTION
AS

/***************************************
*Nombre:		[dbo].[CategoriasProductosSave]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		29/10/19
*Desarrollador: (JTHERAN)
***************************************/

BEGIN TRANSACTION
BEGIN TRY

	DECLARE @id_return INT, @error VARCHAR(MAX);
	IF EXISTS (SELECT 1 FROM dbo.CategoriasProductos A WHERE A.nombre = @nombre AND id <> ISNULL(@id,0))
	BEGIN
		RAISERROR('Ya existe grupo con este nombre...', 16,0);
	END

	IF(Isnull(@id,0) = 0)
	BEGIN
		INSERT INTO dbo.CategoriasProductos (nombre, id_user)
		VALUES(@nombre, @id_user)						
				
		SET @id_return = SCOPE_IDENTITY();
	END
	ELSE
	BEGIN
		UPDATE dbo.CategoriasProductos
		SET 
			nombre		= @nombre,
			id_user		= @id_user,
			updated		= GETDATE()
		WHERE id = @id;;
			
		set @id_return = @id
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


