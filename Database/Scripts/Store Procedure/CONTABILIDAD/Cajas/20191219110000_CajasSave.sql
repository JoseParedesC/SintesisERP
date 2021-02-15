--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[CajasSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE Dbo.CajasSave
GO
CREATE PROCEDURE dbo.CajasSave
@id BIGINT,
@codigo VARCHAR(10),
@nombre VARCHAR(100),
@id_bodega BIGINT,
@id_cliente BIGINT=null,
@id_vendedor BIGINT,
@id_centrocosto BIGINT=null,
@id_cuenta BIGINT,
@piecera VARCHAR(MAX),
@cabecera VARCHAR(MAX),
@id_cuentaant bigint,
@id_user int

--WITH ENCRYPTION
AS

/***************************************
*Nombre:		[dbo].[CajasSave]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		19/12/19
*Desarrollador: (JETEHERAN)
***************************************/

BEGIN TRANSACTION
BEGIN TRY

	DECLARE @Datos INT,  @PrepareXmlStatus INT , @id_return INT, @error VARCHAR(MAX);
	IF EXISTS (SELECT 1 FROM dbo.Cajas A WHERE codigo = @codigo AND id != @id)
	BEGIN
		RAISERROR('Ya existe caja con este código...', 16,0);
	END

	IF(Isnull(@id,0) = 0)
	BEGIN		
		INSERT INTO dbo.Cajas (codigo, nombre, id_bodega, id_cuenta, id_cliente, id_vendedor,id_centrocosto, piecera, cabecera, id_user, id_ctaant)
		VALUES(@codigo, @nombre, @id_bodega, CASE WHEN @id_cuenta = 0 THEN NULL ELSE @id_cuenta END, @id_cliente, @id_vendedor,@id_centrocosto ,@piecera, @cabecera, 
		@id_user, @id_cuentaant)
				
		SET @id_return = SCOPE_IDENTITY();	
	END
	ELSE
	BEGIN
		UPDATE dbo.Cajas
		SET
			nombre			= @nombre,
			id_bodega		= @id_bodega,
			id_cuenta		= @id_cuenta,
			id_cliente		= @id_cliente,
			id_vendedor		= @id_vendedor,
			id_centrocosto  = @id_centrocosto,
			cabecera		= @cabecera,
			piecera			= @piecera,
			id_user			= @id_user,
			id_ctaant		= @id_cuentaant,
			updated			= GETDATE()
		WHERE id = @id;
			
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
