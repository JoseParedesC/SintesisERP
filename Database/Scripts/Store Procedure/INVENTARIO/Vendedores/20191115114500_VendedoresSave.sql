--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[VendedoresSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[VendedoresSave]
GO
CREATE PROCEDURE [dbo].[VendedoresSave]
@id BIGINT,
@codigo [varchar](20),
@nombre [varchar](150),
@id_user BIGINT

--WITH ENCRYPTION
AS

/***************************************
*Nombre:		[dbo].[VendedoresSave]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		15/11/19
*Desarrollador: (Jeteme)

SP para insertar y modificar Marcas
***************************************/

BEGIN TRANSACTION
BEGIN TRY

	DECLARE  @id_return INT, @error VARCHAR(MAX);
	
	IF EXISTS(SELECT 1 FROM [dbo].[Vendedores] WHERE codigo = @codigo AND id != @id) 
		RAISERROR('Ya existe vendedor con este mismo código', 16, 0);

	IF(Isnull(@id,0) = 0)
	BEGIN		
		INSERT INTO [dbo].[Vendedores]([codigo], [nombre],[id_usercreated], [id_userupdated])
		VALUES (@codigo, @nombre, @id_user, @id_user);
				
		SET @id_return = SCOPE_IDENTITY();
	END
	ELSE
	BEGIN
		UPDATE dbo.Vendedores 
		SET
			codigo				= @codigo,
			[nombre]			= @nombre,
			id_userupdated		= @id_user,
			updated				= GETDATE()
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


