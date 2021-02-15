--liquibase formatted sql
--changeset ,CZULBARAN:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MOVRevertirConversion]') and OBJECTPROPERTY(id, N'IsProcedure') = 1) 
DROP PROCEDURE dbo.ST_MOVRevertirConversion
GO
CREATE PROCEDURE [Dbo].ST_MOVRevertirConversion
@id BIGINT = 0,
@id_user BIGINT,
@factura VARCHAR(MAX)

AS
/***************************************
*Nombre:		[Dbo].[ST_MOVRevertirConversion]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		19/06/2015
*Desarrollador:  Jose Luis Tous Pérez (jtous)
*Descripcion:	Se realizan EL PROCESO DE FACTURAR LAS ENTRADAS
***************************************/
Declare @id_return INT, @Contabilizar BIT;
Declare @Mensaje varchar(max), @id_articulo int
BEGIN TRANSACTION
BEGIN TRY		
	
		IF NOT EXISTS (SELECT 1 FROM [dbo].[MOVConversiones] WHERE id = @id AND (estado = Dbo.ST_FnGetIdList('REVER') OR estado =  Dbo.ST_FnGetIdList('REVON')))
		BEGIN
			SELECT TOP 1 @id_articulo = T.id_articulo  FROM Dbo.[MOVConversionesItems] T 
			INNER JOIN Dbo.Existencia E ON T.id_articulo = E.id_articulo AND E.id_bodega = T.id_bodega
			WHERE T.cantidad > E.existencia and T.id_conversion = @id;

			IF(ISNULL(@id_articulo, 0) = 0)
			BEGIN
				 EXEC [dbo].[ST_MOVCargarExistencia] @Opcion = 'ZU', @id = @id, @id_user = @id_user;
				 EXEC [dbo].[ST_MOVCargarExistenciaFac] @opcion = 'Z', @id_factura = @factura, @id=@id, @id_user = @id_user

				INSERT INTO [dbo].[MOVConversiones] (fechadocumen, estado, costo, id_user,id_centrocosto, id_bodegadef)
				SELECT fechadocumen, Dbo.ST_FnGetIdList('REVON'), costo, @id_user, id_centrocosto, id_bodegadef
				FROM [dbo].[MOVConversiones] WHERE id = @id;

				SET @id_return = SCOPE_IDENTITY();
		
				IF ISNULL(@id_return, 0) <> 0
				BEGIN

					UPDATE [dbo].[MOVConversiones] SET id_reversion = @id_return, estado = Dbo.ST_FnGetIdList('REVER') Where id = @id;
				
					SELECT @id_return id, 'REVERSION' estado, @id idrev
				END
				ELSE
				BEGIN
					SET @Mensaje = 'No se genero el documento de reversión';
					RAISERROR(@Mensaje,16,0);
				END
			END
			ELSE
			BEGIN
				SELECT TOP 1 @mensaje = codigo +' - '+presentacion FROM Dbo.Productos WHERE id = @id_articulo; 
				SET  @mensaje = 'El artículo ('+@mensaje+') No tiene suficiente cantidad en existencia, para la reversión.';
				RAISERROR(@mensaje,16,0);
			END
		END
		ELSE
			RAISERROR('Esta conversión ya ha sido revertida, verifique...',16,0);

COMMIT TRANSACTION;
END TRY
BEGIN CATCH	
	ROLLBACK TRANSACTION;
	SET @Mensaje = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@Mensaje,16,0);	
END CATCH
GO
