--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ImpuestosSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE CNT.ImpuestosSave
GO


CREATE PROCEDURE [CNT].[ImpuestosSave]
@id BIGINT = null,
@codigo [varchar](8),
@nombre [varchar](50),
@id_tipoimp BIGINT,
@Valor numeric(18,2),
@id_ctaventa BIGINT,
@id_ctadevventa BIGINT,
@id_ctacompra BIGINT,
@id_ctadevcompra BIGINT,
@id_usercreated BIGINT,
@id_userupdated BIGINT

--WITH ENCRYPTION
AS

/***************************************
*Nombre:		[CNT].[ImpuestosSave]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		22/10/19
*Desarrollador: (Jeteme)

SP para insertar y modificar Tipo de Impuestos
***************************************/

BEGIN TRANSACTION
BEGIN TRY

	DECLARE  @id_return INT, @error VARCHAR(MAX);
	

		IF(Isnull(@id,0) = 0)
		BEGIN		
			IF EXISTS(SELECT 1 FROM [CNT].[Impuestos] WHERE codigo = @codigo) 
				RAISERROR('Tipo de Impuesto ya existe con este mismo codigo', 16, 0);

			INSERT INTO [CNT].[Impuestos]([codigo], [nombre], [id_tipoimp],[valor],[id_ctaventa],[id_ctadevVenta],[id_ctacompra],[id_ctadevcompra],[id_usercreated],[id_userupdated])
			VALUES (@codigo, @nombre,@id_tipoimp,@Valor,@id_ctaventa,@id_ctadevventa,@id_ctacompra,@id_ctadevcompra, @id_usercreated,@id_userupdated);
				
			SET @id_return = SCOPE_IDENTITY();
		END
		ELSE
		BEGIN
			UPDATE CNT.[Impuestos] 
			SET
				[codigo]			= @codigo,
				[nombre]			= @nombre,
				[id_tipoimp]		= @id_tipoimp,
				[valor]				= @Valor,
				[id_ctaventa]		= @id_ctaventa,
				[id_ctadevVenta]	= @id_ctadevventa,
				[id_ctacompra]		= @id_ctacompra,
				[id_ctadevcompra]	= @id_ctadevcompra,
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


