--liquibase formatted sql
--changeset ,kmartinez:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FIN].[LineasCreditosSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [FIN].[LineasCreditosSave]
GO

CREATE PROCEDURE [FIN].[LineasCreditosSave]
@id BIGINT = null,
@ISIvaIncluido bit = 0,
@codigo VARCHAR(50),
@nombre VARCHAR(50),
@ISIva  bit = 0,
@porcenIva NUMERIC(18,2)= null,
@porcentaje NUMERIC(18,2),
@id_iva BIGINT = null,
@id_ctaantCredito BIGINT = null,
@id_ctaantIntCorri  BIGINT = null,
@id_ctaantIntMora  BIGINT = null,
@id_ctaantFianza BIGINT= null,
@id_user int

--WITH ENCRYPTION
AS

/***************************************
*Nombre:		[CIN].[ST_LineasCreditosSave]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		28/10/2020
*Desarrollador: (Kmartinez)
***************************************/

BEGIN TRANSACTION
BEGIN TRY
	
	DECLARE @id_return INT, @error VARCHAR(MAX);

	IF(Isnull(@id,0) = 0)
	BEGIN
		IF EXISTS (SELECT 1 FROM [FIN].[LineasCreditos] L WHERE L.codigo = @codigo AND id != ISNULL(@id,0))
		BEGIN
			RAISERROR('Ya existe Lineas Credito con este c�digo...', 16,0);
		END
		ELSE
		BEGIN
			IF(ISNULL(@ISIva,0) = 0)
			BEGIN
				INSERT INTO [FIN].[LineasCreditos](codigo, nombre, id_ctacredito, id_ctaintcorriente, id_ctamora, id_ctaantFianza , Porcentaje, iva, ivaIncluido, id_ctaiva, porcenIva, id_user)
				VALUES(@codigo, @nombre, @id_ctaantCredito, @id_ctaantIntCorri, @id_ctaantIntMora, @id_ctaantFianza, @porcentaje, 0, @ISIvaIncluido, 0, 0, @id_user)						
			END
			ELSE
			BEGIN
					INSERT INTO [FIN].[LineasCreditos](codigo, nombre, id_ctacredito, id_ctaintcorriente, id_ctamora, id_ctaantFianza, Porcentaje, iva, ivaIncluido, id_ctaiva, porcenIva, id_user)
				  VALUES(@codigo, @nombre, @id_ctaantCredito, @id_ctaantIntCorri, @id_ctaantIntMora, @id_ctaantFianza, @porcentaje, @ISIva, @ISIvaIncluido, @id_iva, @porcenIva,  @id_user)	
			END
			 SET @id_return = SCOPE_IDENTITY();	
		END
	END
	ELSE
	BEGIN
		IF(ISNULL(@ISIva,0) = 0)
		BEGIN
			UPDATE [FIN].[LineasCreditos] SET codigo = @codigo, nombre = @nombre, id_ctacredito = @id_ctaantCredito, id_ctaintcorriente = @id_ctaantIntCorri, 
				id_ctamora = @id_ctaantIntMora, id_ctaantFianza = @id_ctaantFianza, Porcentaje = @porcentaje, iva = 0, ivaIncluido=0, id_ctaiva = 0, porcenIva=0
			WHERE id = @id;
		END
		ELSE
		BEGIN
					UPDATE [FIN].[LineasCreditos] SET codigo = @codigo, nombre = @nombre, id_ctacredito = @id_ctaantCredito, id_ctaintcorriente = @id_ctaantIntCorri, 
				id_ctamora = @id_ctaantIntMora, id_ctaantFianza = @id_ctaantFianza , Porcentaje = @porcentaje, iva = @ISIva, ivaIncluido = @ISIvaIncluido,  id_ctaiva = @id_iva, porcenIva = @porcenIva
			WHERE id = @id;
		END
		
		SET @id_return = @id;	
	END
	

COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);		
	ROLLBACK TRANSACTION;
END CATCH

SELECT @id_return id