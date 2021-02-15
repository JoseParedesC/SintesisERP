--liquibase formatted sql
--changeset ,jteheran:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MOVFacturarDevEntrada]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [dbo].[ST_MOVFacturarDevEntrada]
GO

CREATE PROCEDURE [dbo].[ST_MOVFacturarDevEntrada]
@id_entrada			BIGINT, 
@fechadoc			SMALLDATETIME,
@id_devoluciontemp	BIGINT,
@id_user INT
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_MOVFacturarDevEntrada]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		23/10/2020
*Desarrollador:  Jose Luis Tous Pérez (jtous)
*Descripcion:	Se realizan EL PROCESO DE FACTURAR LAS ENTRADAS
***************************************/
Declare @id_return INT, @idestado INT,@id_proveedor BIGINT,@pago NUMERIC(18,2), @id_articulo BIGINT, @mensaje VARCHAR(MAX),@anomes VARCHAR(6),@fecha VARCHAR(10),@id_catFiscal BIGINT,@id_cat INT, @retiene BIT,@valoranticipodevant numeric(18,2),@totaldevant numeric(18,2);
Declare @table TABLE(id int identity(1,1), id_articulo int, id_bodega int,id_lote Bigint,serie VARCHAR(50));
BEGIN TRANSACTION
BEGIN TRY

		SET @idestado = Dbo.ST_FnGetIdList('PROCE');
		SET @anomes = CONVERT(VARCHAR(6), @fechadoc, 112);
		SET @fecha = CONVERT(VARCHAR(10), @fechadoc, 120);
		
		SET @id_catFiscal = (SELECT id_catfiscal FROM CNT.Terceros T   WHERE T.id = @id_proveedor);
		SELECT @id_cat = F.id, @retiene =  F.retiene FROM  CNTCategoriaFiscal F WHERE F.id = @id_catFiscal AND F.retiene != 0

		EXECUTE [Dbo].ST_ValidarPeriodo
			@fecha			= @fecha,
			@anomes			= @anomes,
			@mod			= 'I'
		

		IF EXISTS (SELECT 1 FROM Dbo.MOVEntradas WHERE id = @id_entrada AND estado != @idestado)
			RAISERROR('No puede realizar devolución de una entrada revertida, verifique..!', 16, 0);

		
		IF NOT EXISTS (SELECT 1 FROM MOVEntradasItemsTemp WHERE id_entrada = @id_devoluciontemp AND selected != 0)
			RAISERROR ('No tiene productos seleccionados para devolver',16,0);


		--Validar series de articulos temporales
		;WITH CTESERIE (id, id_articulo, cantidad, [count])
		AS(
			SELECT I.id, I.id_articulo, I.cantidaddev, SUM(CASE WHEN S.selected != 0 THEN 1 ELSE 0 END) [count]
			FROM Dbo.MOVEntradasItemsTemp I LEFT JOIN 
				 Dbo.MovEntradasSeriesTemp S ON S.[id_itemstemp] = I.id 
			WHERE I.serie != 0 AND I.id_entrada = @id_devoluciontemp
			GROUP BY I.id, I.id_articulo, I.cantidaddev
		) 
		SELECT TOP 1 @id_articulo = id_articulo FROM CTESERIE WHERE cantidad != ISNULL([count], 0)

		IF(ISNULL(@id_articulo, 0 ) != 0)
		BEGIN
			SELECT TOP 1 @mensaje = 'El producto ' + nombre +' no ha seleccionado las series a devolver.' 
			FROM Dbo.Productos WHERE id = @id_articulo; 
			RAISERROR(@mensaje, 16, 0)
		END	

		IF (ISNULL(@id_articulo, 0) = 0)
		BEGIN
			SELECT   @id_articulo = I.id_articulo
			FROM ExistenciaLoteSerie EL INNER JOIN 
				MovEntradasSeriesTemp ES ON ES.serie = EL.serie INNER JOIN
				MOVEntradasItemsTemp I ON I.id = ES.id_itemstemp
			WHERE ES.id_entradatemp = @id_devoluciontemp AND EL.existencia = 0 AND ES.selected != 0; 
		END

		IF (ISNULL(@id_articulo, 0) = 0)
		BEGIN
			;WITH CTE (id_articulo, id_bodega, cantidad, id_lote) AS
			(
				SELECT id_articulo, id_bodega, SUM(AT.cantidaddev) cantidad, DBO.ST_FNGetIdLote(AT.id_lote, AT.vencimientolote)
				FROM [dbo].[MOVEntradasItemsTemp] AT
				WHERE AT.id_entrada = @id_devoluciontemp AND AT.serie = 0
				GROUP BY id_articulo, id_bodega,  id_lote, vencimientolote
			)
			SELECT @id_articulo = E.id_articulo FROM [dbo].[ExistenciaLoteSerie] S
			INNER JOIN Dbo.Existencia E  ON S.id_existencia = E.id 
			INNER JOIN CTE C ON C.id_articulo = E.id_articulo AND E.id_bodega = C.id_bodega AND C.id_lote = S.id_lote
			WHERE (S.existencia - C.cantidad) < 0;
		END	
		
		IF (ISNULL(@id_articulo, 0) != 0)
		BEGIN
			SELECT TOP 1 @mensaje = 'El producto ' + nombre +' no tiene existencias para devolver.' 
			FROM Dbo.Productos WHERE id = @id_articulo; 
			RAISERROR(@mensaje, 16, 0)
		END	
		
		EXEC Dbo.ST_MOVCargarExistencia @Opcion = 'DI', @id = @id_devoluciontemp, @id_user = @id_user, @id_bodega = 0;
		
		SELECT @valoranticipodevant=ISNULL(SUM(D.valoranticipo),0 ),@totaldevant=ISNULL(SUM(D.valor),0)from MOVDevEntradas D join MOVEntradas F on D.id_entrada=F.id where id_entrada= @id_entrada and D.id_ctaant=F.id_ctaant  and D.estado=dbo.ST_FnGetIdList('PROCE')
		
		
		INSERT INTO [dbo].[MOVDevEntradas] (id_entrada, id_tipodoc, id_centrocostos, fechadocumen, id_formaPagos, id_bodega, estado, costo, iva, inc, 
		descuento, valor, poriva, reteiva, porfuente, retefuente, porica, reteica, id_formapagoflete,id_ctaant,valoranticipo ,id_user)
		SELECT TOP 1	
				@id_entrada id_entrada, 
				E.id_tipodoc, 
				E.id_centrocostos, 
				@fechadoc fecha, 
				E.id_formaPagos, 
				E.id_bodega, 
				@idestado, 
				R.costo, 
				R.iva,
				R.tinc, 
				R.descuento,				 
				R.total, 
				R.poriva,
				R.retiva,
				R.porfuente,
				R.retfuente,
				R.porica,
				R.retica,
				E.id_formapagoflete,
				E.id_ctaant,
				IIF(R.total+@totaldevant>=E.valor-E.valoranticipo-@valoranticipodevant,R.total+@totaldevant-E.valor+E.valoranticipo-@valoranticipodevant,0),
				@id_user
		FROM MOVEntradas E CROSS APPLY Dbo.ST_FnCalRetenciones(0, @id_devoluciontemp, 0,'DEV', @id_entrada,0,@id_catfiscal,@id_cat,@retiene) R where E.id=@id_entrada
					
		SET @id_return = SCOPE_IDENTITY();
		
		
		IF ISNULL(@id_return, 0) <> 0
		BEGIN
			INSERT INTO [dbo].[MOVDevEntradasItems] (id_devolucion, id_articulo, id_itementra, serie, id_lote, id_bodega, cantidad, costo, pordescuento, 
			descuentound, descuento, porceniva, iva, porceninc, inc, costototal, id_ctaiva, id_ctainc, id_user, lote,id_iva,id_inc,id_retefuente,porcerefuente,retefuente,id_reteiva,porcereiva,reteiva,id_reteica,porcereica,reteica)
			SELECT 
				@id_return id_dev, 
				T.id_articulo,
				I.id id_item,
				T.serie,
				I.id_lote,
				T.id_bodega,
				T.cantidaddev,
				T.costo,
				T.pordescuento,
				T.descuentound,
				T.descuento,
				T.porceniva,
				T.iva,
				T.porceninc,
				T.inc,
				T.costototal,
				I.id_ctaiva,
				I.id_ctainc,
				@id_user,
				T.lote,
				T.id_iva,
				T.id_inc,
				T.id_retefuente,
				T.porcerefuente,
				T.retefuente,
				T.id_reteiva,
				T.porcereiva,
				T.reteiva,
				T.id_reteica,
				T.porcereica,
				T.reteica
			FROM [dbo].[MOVEntradasItemsTemp] T 
			INNER JOIN [MOVEntradasItems] I ON T.id_itementra = I.id
			WHERE T.id_entrada = @id_devoluciontemp AND T.selected != 0;					

			INSERT INTO MOVDevEntradasSeries(id_items, id_devolucion, serie)
			SELECT II.id, @id_return, S.serie 
			FROM [dbo].[MovEntradasSeriesTemp] S
			INNER JOIN [MOVEntradasItemsTemp] I ON I.id = S.id_itemstemp AND S.id_entradatemp = I.id_entrada
			INNER JOIN [MOVDevEntradasItems] II ON I.id_articulo = II.id_articulo AND I.costo = II.costo 
											AND I.descuento = II.descuento AND Dbo.ST_FNGetIdLote(I.id_lote, I.vencimientolote) = II.id_lote 
											AND I.serie = II.serie 
			WHERE I.id_entrada = @id_devoluciontemp AND S.selected != 0;
			
			

			DELETE [dbo].[MovEntradasSeriesTemp] WHERE id_entradatemp = @id_devoluciontemp
			Delete [dbo].[MOVEntradasItemsTemp] WHERE id_entrada = @id_devoluciontemp;
			Delete [dbo].[MOVEntradasTemp] Where id = @id_devoluciontemp;
			
			SELECT @id_return id, 'PROCESADO' estado,'CNT.VW_TRANSACIONES_DEVENTRADAS' nombreview,@fecha fecha,@anomes anomes,@id_user id_user;


		END
		ELSE
		BEGIN
			RAISERROR('Error al Guardar devolución de mercancia, No se pudo guardar la cabecera de la Devolución.', 16,0);
		END			
		
		
COMMIT TRANSACTION;
END TRY
BEGIN CATCH	
	ROLLBACK TRANSACTION;
	SET @Mensaje = 'Error: ' + ERROR_MESSAGE();
	RAISERROR(@Mensaje, 16, 0);	
END CATCH

GO


