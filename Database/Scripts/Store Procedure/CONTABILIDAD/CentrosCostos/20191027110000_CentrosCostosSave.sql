--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[CentrosCostosSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE CNT.CentrosCostosSave
GO
CREATE PROCEDURE [CNT].[CentrosCostosSave]
@id BIGINT = null,
@codigo [varchar](4),
@nombre [varchar](50),
@idpadre BIGINT=NULL,
@detalle bit,
@id_usercreated BIGINT,
@id_userupdated BIGINT

--WITH ENCRYPTION
AS

/***************************************
*Nombre:		[CNT].[CentroCostoSave]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		22/10/19
*Desarrollador: (Jeteme)

SP para insertar y modificar centro de costos
***************************************/

DECLARE @indice int, @codigopadre VARCHAR(25), @idparent BIGINT

BEGIN TRANSACTION
BEGIN TRY

	DECLARE  @id_return INT, @error VARCHAR(MAX),@codigogeneral varchar(20)=@codigo;
	IF(@idpadre!=0)
	BEGIN
		SET @codigogeneral = ISNULL((SELECT codigo FROM CentroCosto WHERE id = @idpadre),'') + '' + @codigo
	END
	ELSE
	BEGIN
		SET @idpadre = 0;
	END

	
	SELECT @indice = indice + 1, @codigopadre = codigo, @idparent = id FROM [CentroCosto] WHERE id = @idpadre; 

	SET @codigopadre = ISNULL(@codigopadre,'');

	IF(Isnull(@id,0) = 0)	
	BEGIN		
		IF EXISTS(SELECT 1 FROM [CNT].[CentroCosto] WHERE codigo = @codigopadre+@codigo AND id != @id) 
			RAISERROR('Centro de costo ya existe', 16, 0);
								
		INSERT INTO [CNT].[CentroCosto](subcodigo, [codigo], [nombre], [id_padre], [detalle],[id_usercreated],[id_userupdated], indice, idparent)
		VALUES (@codigo, @codigopadre + @codigo, @nombre, ISNULL(@codigopadre, ''), @detalle, @id_usercreated, @id_userupdated, ISNULL(@indice,1), @idparent);
				
		SET @id_return = SCOPE_IDENTITY();
	END
	ELSE
	BEGIN
		
		IF EXISTS (SELECT 1 FROM [CNT].[CentroCosto] WHERE idparent = @id and @detalle != 0)
			RAISERROR('Este centro de costo no puede ser detalle, Tiene dependencia', 16, 0);

		IF EXISTS (SELECT 1 FROM [CNT].[TipoDocumentos] t WHERE id_centrocosto = @id and @detalle = 0)
			RAISERROR('Este centro de costo no puede ser grupo, esta relacionado con tipo de documento', 16, 0);

		IF EXISTS(SELECT 1 FROM CNT.CentroCosto WHERE idparent = @id) AND EXISTS (SELECT 1 FROM CNT.CentroCosto WHERE subcodigo != @codigo AND id = @id)
			RAISERROR('No se puede modificar el código, porque ya tiene centros de costo dependientes.',16,1)


		UPDATE CNT.CentroCosto 
		SET
			subcodigo			= @codigo,
			[codigo]			= @codigopadre+@codigo,
			[nombre]			= @nombre,
			[detalle]			= @detalle,
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