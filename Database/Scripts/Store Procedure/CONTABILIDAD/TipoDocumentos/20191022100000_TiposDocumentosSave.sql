--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[TiposDocumentosSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE CNT.TiposDocumentosSave
GO
CREATE PROCEDURE [CNT].[TiposDocumentosSave]
@id BIGINT = null,
@codigo [varchar](2),
@nombre [varchar](50),
@id_tipo Int,
@isccosto bit,
@id_centrocosto BIGINT,
@id_usercreated BIGINT,
@id_userupdated BIGINT

--WITH ENCRYPTION
AS

/***************************************
*Nombre:		[CNT].[TiposDocumentosSave]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		22/10/19
*Desarrollador: (Jeteme)

SP para insertar y modificar centro de costos
***************************************/

BEGIN TRANSACTION
BEGIN TRY

	DECLARE  @id_return INT, @error VARCHAR(MAX);
	
	IF(Isnull(@id,0) = 0)
	BEGIN		
		IF EXISTS(SELECT 1 FROM [CNT].[TipoDocumentos] WHERE codigo = @codigo) 
			RAISERROR('Tipo de Documento ya existe con este mismo codigo', 16, 0);

		INSERT INTO [CNT].[TipoDocumentos]([codigo], [nombre],[isccosto],[id_tipo], [id_centrocosto], [id_usercreated],[id_userupdated])
		VALUES (@codigo, @nombre,@isccosto,@id_tipo,CASE WHEN @id_centrocosto = 0 THEN NULL ELSE @id_centrocosto END, @id_usercreated,@id_userupdated);
				
		SET @id_return = SCOPE_IDENTITY();
	END
	ELSE
	BEGIN
		UPDATE CNT.TipoDocumentos 
		SET
			[codigo]			= @codigo,
			[nombre]			= @nombre,
			[isccosto]			= @isccosto,
			[id_tipo]			= @id_tipo,
			[id_centrocosto]	= CASE WHEN @id_centrocosto = 0 THEN NULL ELSE @id_centrocosto END,
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
