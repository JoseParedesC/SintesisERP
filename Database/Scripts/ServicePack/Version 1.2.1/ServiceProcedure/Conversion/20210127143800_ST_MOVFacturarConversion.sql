--liquibase formatted sql
--changeset ,CZULBARAN:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MOVFacturarConversion]') and OBJECTPROPERTY(id, N'IsProcedure') = 1) 
DROP PROCEDURE dbo.ST_MOVFacturarConversion
GO
CREATE PROCEDURE [dbo].[ST_MOVFacturarConversion]
@fechadoc  VARCHAR(10), 
@id_entradatemp BIGINT,
@id_user INT,
@factura VARCHAR(255),
@bodegadef BIGINT,
@centrocosto BIGINT,
@id_tipodoc BIGINT
AS
/***************************************
*Nombre:		[Dbo].[ST_MOVFacturarConversion]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		19/06/2015
*Desarrollador:  Jose Luis Tous Pérez (jtous)
*Descripcion:	Se realizan EL PROCESO DE FACTURAR LAS ENTRADAS
***************************************/
Declare @id_return INT, @Contabilizar BIT, @idestado INT, @mensaje varchar(max), @id_articulo BIGINT,@id_return2 INT;
BEGIN TRANSACTION
BEGIN TRY

		SET @idestado = Dbo.ST_FnGetIdList('PROCE');

		IF EXISTS (SELECT 1 FROM Dbo.DiasFac F WHERE F.fecha = @fechadoc AND F.estado = 1)
		BEGIN 
		
			IF NOT EXISTS(SELECT 1 FROM [MOVEntradasItemsTemp] where id_bodega = @bodegadef AND id_entrada =@id_entradatemp)			
				RAISERROR('No puede Escoger Una Bodega Distinta a la que ya seleccionó',16,0)
			
			;WITH CTE (id_articulo, id_bodega, cantidad) AS (
				SELECT A.id_producto, T.id_bodega, SUM(T.cantidad * A.cantidad)
				FROM [MOVEntradasItemsTemp] T 
				INNER JOIN [Productos_Formulados] A ON A.id_producto = T.id_articulo
				WHERE T.id_entrada = @id_entradatemp
				GROUP BY A.id_producto, T.id_bodega
			)
			SELECT TOP 1 @id_articulo = T.id_articulo
			FROM CTE T

			IF (ISNULL(@id_articulo, 0) != 0)
			BEGIN
			
				INSERT INTO [dbo].[MOVConversiones] (fechadocumen, estado, costo, id_user, id_centrocosto, id_bodegadef,id_tipodoc)
				SELECT @fechadoc, @idestado, R.total, @id_user, @centrocosto,@bodegadef,@id_tipodoc
				FROM Dbo.ST_FnCalRetenciones(0, @id_entradatemp, 0, 'EN',@id_entradatemp,0,0,0,0) R

				SET @id_return = SCOPE_IDENTITY();

				IF ISNULL(@id_return, 0) <> 0
				BEGIN
					
					INSERT INTO [dbo].[MOVConversionesItems](id_conversion, id_articulo, id_bodega, cantidad, costo, costototal, id_user,serie)
					SELECT @id_return, id_articulo, id_bodega, SUM(cantidad), costo, SUM(costototal), @id_user, serie
					FROM [dbo].[MOVEntradasItemsTemp] WHERE id_entrada = @id_entradatemp
					GROUP BY id_articulo, id_bodega, costo, serie;
					
					INSERT INTO [dbo].[MOVConversionesItemsForm] (id_conversion, id_articulofac, id_articulo, id_bodega,cantidad,costo,id_user,serie)
					SELECT @id_return,
					T.id,
					I.id_articulo,
					I.id_bodega,
					I.cantidad,
					I.costo,
					@id_user,
					I.serie
					FROM [MOVFacturaItemsTemp]  I INNER JOIN [MOVConversionesItems] T ON T.id_articulo = I.id_itemfac
					WHERE I.id_factura = @factura AND T.id_conversion = @id_return
					 
					SET @id_articulo = NULL;
					--Validar series de articulos temporales
					;WITH CTESERIE (id, id_articulo, cantidad, [count])
					AS(
						SELECT I.id, I.id_articulo, I.cantidad, SUM(CASE WHEN S.serie IS NULL THEN 0 ELSE 1 END) [count]
						FROM Dbo.MOVEntradasItemsTemp I LEFT JOIN 
								Dbo.MovEntradasSeriesTemp S ON S.[id_itemstemp] = I.id 
						WHERE I.serie != 0 AND I.id_entrada = @id_entradatemp 
						GROUP BY I.id, I.id_articulo, I.cantidad
					) 
					SELECT TOP 1 @id_articulo = id_articulo FROM CTESERIE WHERE cantidad != [count]
 
					IF(ISNULL(@id_articulo, 0 ) != 0)
					BEGIN
						SELECT TOP 1 @mensaje = 'El producto ' + nombre +' no ha configurado todas las series' 
						FROM Dbo.Productos WHERE id = @id_articulo; 
						RAISERROR(@mensaje, 16, 0)
					END 
					
					--Validar series de articulos dependientes
					SET @id_articulo = NULL;
					;WITH  tableSL (id_item, id_articulo, id_bodega, cantidad, serie, lote, id_lote, cantidadorg) AS(
						SELECT	T.id,
								T.id_itemfac, 
								T.id_bodega, 
								CASE WHEN ISNULL(S.serie, '') != '' THEN 
														CASE WHEN ISNULL(S.serie, '') = '' THEN 0 ELSE 1 END
									WHEN T.lote != 0 THEN ISNULL(L.cantidad, 0)
									ELSE 0 END  cantidad, 
								ISNULL(S.serie,'') serie,
								T.lote,
								ISNULL(L.id_lote, 0) id_lote,
								T.cantidad
						FROM Dbo.MOVFacturaItemsTemp T
						LEFT JOIN Dbo.MovFacturaSeriesTemp S ON T.id = S.id_itemstemp
						LEFT JOIN Dbo.MOVFacturaLotesTemp  L ON T.id = L.id_itemtemp
						WHERE T.id_factura = @factura AND T.formulado = 0 AND T.inventarial != 0 AND (T.serie != 0 OR T.lote != 0) 
					),
					 series(id_item, cantidad) AS (
						SELECT id_item, SUM(cantidad) FROM tableSL GROUP BY id_item
					)
					SELECT TOP 1 @id_articulo = T.id_articulo FROM tableSL T INNER JOIN series S ON S.id_item = T.id_item
					WHERE S.cantidad <> T.cantidadorg
					IF ISNULL(@id_articulo, 0) > 0
					BEGIN
						SELECT TOP 1 @mensaje = 'El producto ' + nombre +' no ha configurado todas las series, de sus dependientes' 
						FROM Dbo.Productos WHERE id = @id_articulo; 						

						RAISERROR(@mensaje,16,0);			
					END
					
					INSERT INTO [dbo].[MOVConversionesItemsSeries] (id_conversion,id_producto,serie, id_user)
					SELECT @id_return, II.id, S.serie, @id_user
					FROM [dbo].[MovEntradasSeriesTemp] S
					INNER JOIN [MOVEntradasItemsTemp] I ON I.id = S.id_itemstemp
					INNER JOIN [MOVConversionesItems] II ON I.id_articulo = II.id_articulo
					WHERE I.id_entrada = @id_entradatemp AND II.id_conversion = @id_return;
									 
					IF EXISTS (SELECT TOP 1 1 FROM MOVFacturaItemsTemp I LEFT JOIN MovFacturaSeriesTemp S  ON I.id_factura = S.id_facturatemp  WHERE id_facturatemp = @factura AND S.serie IS NULL)
					BEGIN
						RAISERROR('No se puede guardar ningun producto con configuraciones vacias ',16,0)
					END							
				
					INSERT INTO [dbo].[MOVConversionesItemsSeriesForm] (id_conversion,id_producto, serie, id_user)
					SELECT @id_return, II.id, S.serie, @id_user
					FROM MovFacturaSeriesTemp S INNER JOIN 
					MOVFacturaItemsTemp I ON I.id = S.id_itemstemp INNER JOIN
					MOVEntradasItemsTemp EI ON EI.id_articulo = I.id_itemfac INNER JOIN
					[MOVConversionesItemsForm] II ON II.id_articulo = I.id_articulo
					WHERE I.id_factura = @factura AND EI.id_entrada = @id_entradatemp
					
					EXEC [dbo].[ST_MOVCargarExistencia] @Opcion = 'I', @id = @id_entradatemp, @id_user = @id_user, @id_bodega=@bodegadef;
					EXEC [dbo].[ST_MOVCargarExistenciaFac] @opcion ='I', @id_factura = @factura, @id = @id_return2, @id_user = @id_user;
					
					DELETE [dbo].[MovEntradasSeriesTemp] WHERE id_entradatemp = @id_entradatemp
					DELETE [dbo].[MOVEntradasItemsTemp] WHERE id_entrada = @id_entradatemp;
					DELETE [dbo].[MovFacturaSeriesTemp] WHERE id_facturatemp = @factura;
					DELETE [dbo].[MOVFacturaItemsTemp] WHERE id_factura = @factura
					DELETE [Dbo].[MovEntradasTemp] WHERE id = @id_entradatemp
						
					SELECT @id_return id, 'PROCESADO' estado
				END
				ELSE 
				BEGIN
					RAISERROR('Error al Guardar Converción, No se pudo guardar la cabecera.', 16,0);
				END
			END
			ELSE
			BEGIN
				SELECT TOP 1 @mensaje = codigo +' - '+presentacion FROM Dbo.Productos WHERE id = @id_articulo; 
				SET  @mensaje = 'El artículo ('+@mensaje+') No tiene suficiente cantidad en existencia.';
				RAISERROR(@mensaje,16,0);
			END
		END
		ELSE
			RAISERROR ('No puede facturar, la fecha del documento no esta abierta... ',16,0);	
			
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH	
		ROLLBACK TRANSACTION;
		SET @Mensaje = 'Error: '+ERROR_MESSAGE();
		RAISERROR(@Mensaje,16,0);	
	END CATCH
