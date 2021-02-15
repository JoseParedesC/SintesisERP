--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[MarcasSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE Dbo.MarcasSave
GO

CREATE PROCEDURE [dbo].[MarcasSave]
@id BIGINT = null,
@codigo [varchar](4),
@nombre [varchar](50),
@id_usercreated BIGINT,
@id_userupdated BIGINT

--WITH ENCRYPTION
AS

/***************************************
*Nombre:		[dbo].[MarcasSave]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		15/11/19
*Desarrollador: (Jeteme)

SP para insertar y modificar Marcas
***************************************/

BEGIN TRANSACTION
BEGIN TRY


	DECLARE  @id_return INT, @error VARCHAR(MAX);
	
	IF(Isnull(@id,0) = 0)
	BEGIN		
		IF EXISTS(SELECT 1 FROM [dbo].[Marcas] WHERE codigo = @codigo) 
			RAISERROR('Marca ya existe con este mismo codigo', 16, 0);

		INSERT INTO [dbo].[Marcas]([codigo], [nombre],[id_usercreated], [id_userupdated])
		VALUES (@codigo, @nombre, @id_usercreated, @id_userupdated);
				
		SET @id_return = SCOPE_IDENTITY();
	END
	ELSE
	BEGIN
		UPDATE dbo.Marcas 
		SET
			[codigo]			= @codigo,
			[nombre]			= @nombre,
			id_userupdated		= @id_userupdated,
			updated		= GETDATE()
		WHERE id = @id;;
			
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


