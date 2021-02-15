--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_CNTCategoriaFiscalSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_CNTCategoriaFiscalSave]
GO
CREATE PROCEDURE [dbo].[ST_CNTCategoriaFiscalSave]
@id BIGINT = null,
@codigo VARCHAR(10),
@descripcion VARCHAR(100),
@id_retefuente BIGINT = null,
@id_reteiva  BIGINT = null,
@id_reteica BIGINT = null,
@fuentebase  decimal(18,2),
@ivabase  decimal(18,2),
@icabase  decimal(18,2),
@retiene  bit = 0,
@id_user int

--WITH ENCRYPTION
AS

/***************************************
*Nombre:		[dbo].[ST_CNTCategoriaFiscalSave]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		02/04/17
*Desarrollador: (JTOUS)
***************************************/

BEGIN TRANSACTION
BEGIN TRY
	
	DECLARE @id_return INT, @error VARCHAR(MAX);

	IF(Isnull(@id,0) = 0)
	BEGIN
		IF EXISTS (SELECT 1 FROM Dbo.CNTCategoriaFiscal A WHERE A.codigo = @codigo AND id != ISNULL(@id,0))
		BEGIN
			RAISERROR('Ya existe Categor�a con este c�digo...', 16,0);
		END
		ELSE
		BEGIN
			IF(ISNULL(@retiene,0) = 0)
			BEGIN
				INSERT INTO Dbo.CNTCategoriaFiscal (codigo, descripcion, id_retefuente, id_reteica, id_reteiva, valorfuente, valorica, valoriva, retiene, id_user)
				VALUES(@codigo, @descripcion, NULL,NULL, NULL, 0, 0, 0, 0, @id_user)						
			END
			ELSE
			BEGIN
				INSERT INTO Dbo.CNTCategoriaFiscal (codigo, descripcion, id_retefuente, id_reteica, id_reteiva, valorfuente, valorica, valoriva, retiene, id_user)
				VALUES(@codigo, @descripcion, @id_retefuente, @id_reteica, @id_reteiva, @fuentebase, @icabase, @ivabase, 1, @id_user)
			END
				
			SET @id_return = SCOPE_IDENTITY();	
		END
	END
	ELSE
	BEGIN
		IF(ISNULL(@retiene,0) = 0)
		BEGIN
			UPDATE Dbo.CNTCategoriaFiscal SET id_retefuente = NULL, id_reteica = NULL, id_reteiva = NULL, valorfuente = 0, 
				valorica = 0, valoriva = 0,retiene = 0
			WHERE id = @id;
		END
		ELSE
		BEGIN
			UPDATE Dbo.CNTCategoriaFiscal SET descripcion = @descripcion, id_retefuente = @id_retefuente, id_reteica = @id_reteica, id_reteiva = @id_reteiva, valorfuente = @fuentebase, 
				valorica = @icabase, valoriva = @ivabase, retiene = 1
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

SELECT @id_return;
