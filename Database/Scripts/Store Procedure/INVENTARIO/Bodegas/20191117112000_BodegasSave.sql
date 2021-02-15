--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[BodegasSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE Dbo.[BodegasSave]
GO
CREATE PROCEDURE [dbo].[BodegasSave]
@id BIGINT = null,
@codigo VARCHAR(10),
@nombre VARCHAR(100),
@ctainven varchar(50),
@ctacosto  varchar(50),
@ctadescuento  varchar(50),
@ctaingreso  varchar(50),
@ctaingresoexc  varchar(50),
@ctaivaflete varchar(50),
@id_user int

--WITH ENCRYPTION
AS

/***************************************
*Nombre:		[dbo].[BodegasSave]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		17/11/19
*Desarrollador: (JETEHERAN)
***************************************/

BEGIN TRANSACTION
BEGIN TRY
	
	DECLARE @id_return INT, @error VARCHAR(MAX);
	IF EXISTS (SELECT 1 FROM Dbo.Bodegas A WHERE A.codigo = @codigo AND id != ISNULL(@id,0))
	BEGIN
		RAISERROR('Ya existe Bodega con este código...', 16,0);
	END

	IF(Isnull(@id,0) = 0)
	BEGIN	
		INSERT INTO Dbo.Bodegas ([codigo], [nombre], [ctainven], [ctacosto],[ctadescuento], [ctaingreso], id_user, [ctaingresoexc], ctaivaflete)
		VALUES(@codigo, @nombre, @ctainven, @ctacosto,@ctadescuento, @ctaingreso, @id_user, @ctaingresoexc, @ctaivaflete)						
				
		SET @id_return = SCOPE_IDENTITY();			
	END
	ELSE
	BEGIN
		UPDATE Dbo.Bodegas 
		SET
			codigo			= @codigo,
			nombre			= @nombre,
			ctainven		= @ctainven, 
			ctacosto		= @ctacosto, 
			ctadescuento	= @ctadescuento, 
			ctaingreso		= @ctaingreso,
			ctaingresoexc	= @ctaingresoexc,
			ctaivaflete		= @ctaivaflete,
			updated			= GETDATE(),
			id_user			= @id_user
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