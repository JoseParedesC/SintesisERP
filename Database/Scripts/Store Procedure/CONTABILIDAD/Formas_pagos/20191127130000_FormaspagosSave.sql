--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[FormasPagosSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE Dbo.FormasPagosSave
GO
CREATE PROCEDURE [dbo].[FormasPagosSave]
@id BIGINT = null,
@codigo VARCHAR(20),
@nombre VARCHAR(50),
@voucher BIT,
@tipo int,
@id_typeFE int,
@id_cuenta BIGINT = NULL,
@id_usercreated bigint,
@id_userupdated bigint

--WITH ENCRYPTION
AS

/***************************************
*Nombre:		[dbo].[FormasPagosSave]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		27/11/19
*Desarrollador: (JETEHERAN)
***************************************/

BEGIN TRANSACTION
BEGIN TRY

	DECLARE @id_return INT, @error VARCHAR(MAX);
	IF EXISTS (SELECT 1 FROM dbo.FormaPagos A WHERE A.codigo = @codigo AND id <> ISNULL(@id,0))
	BEGIN
		RAISERROR('Ya existe forma de pago con este código...', 16,0);
	END

	IF(Isnull(@id,0) = 0)
	BEGIN
		INSERT INTO dbo.FormaPagos (codigo, nombre, id_tipo, id_typeFE, id_cuenta, voucher, id_usercreated, id_userupdated)
		VALUES(@codigo, @nombre, @tipo, @id_typeFE, CASE WHEN @id_cuenta = 0 THEN NULL ELSE @id_cuenta END, @voucher, @id_usercreated, @id_userupdated)						
				
		SET @id_return = SCOPE_IDENTITY();
	END
	ELSE
	BEGIN
		UPDATE dbo.FormaPagos 
		SET 
			codigo		= @codigo,
			nombre		= @nombre,
			id_tipo		= @tipo,
			voucher		= @voucher,
			id_typeFE	= @id_typeFE,
			id_cuenta	= CASE WHEN @id_cuenta = 0 THEN NULL ELSE @id_cuenta END,
			id_userupdated= @id_userupdated,
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