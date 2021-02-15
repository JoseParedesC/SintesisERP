--liquibase formatted sql
--changeset ,jteheran:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MOVFacturarEntrada]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MOVFacturarEntrada]
GO

CREATE PROCEDURE [dbo].[ST_MOVFacturarEntrada]
@id				BIGINT = 0, 
@id_tipodoc		BIGINT,
@id_centrocosto BIGINT,
@fechadoc		SMALLDATETIME,
@fechafac		VARCHAR(10),
@fechavence		VARCHAR(10),
@numfac			VARCHAR(50),
@dias			NUMERIC (18,0),
@id_bodega		BIGINT,
@id_proveedor	BIGINT,
@id_formaPago	BIGINT,
@flete			NUMERIC(18,2),
@id_entradatemp BIGINT,
@id_user		INT,
@id_proveflete	BIGINT = 0,
@prorratea		BIT,
@tipoprorrat	CHAR (1),
@id_orden		INT = 0,
@id_formaPagoFlete BIGINT,
@id_ctaant			BIGINT,
@anticipo			NUMERIC(18,2)


--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_MOVFacturarEntrada]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		19/06/2015
*Desarrollador:  Jose Luis Tous P�rez (jtous)
*Descripcion:	Se realizan EL PROCESO DE FACTURAR LAS ENTRADAS
***************************************/
Declare @id_return INT, @Contabilizar BIT, @idestado INT, @opsaldopro CHAR(1) = 'E', @calfeltepro NUMERIC(18, 2) = 0,@anomes VARCHAR(6),@fecha VARCHAR(10),@id_catFiscal BIGINT,@id_cat INT, @retiene BIT;
BEGIN TRANSACTION
BEGIN TRY
	SET @anomes = CONVERT(VARCHAR(6), @fechadoc, 112);
	SET @fecha =  CONVERT(VARCHAR(10), @fechadoc, 120);

	EXECUTE [Dbo].ST_ValidarPeriodo
		@fecha			= @fecha,
		@anomes			= @anomes,
		@mod			= 'I'

	EXECUTE [dbo].[ST_MOVValidarEntrada] 
			@fechadoc		= @fechadoc, 
			@id_entrada		= @id_entradatemp, 
			@id_bodega		= @id_bodega,
			@prorratea		= @prorratea, 
			@tipoprorrat	= @tipoprorrat, 
			@numfac			= @numfac, 
			@id_proveedor	= @id_proveedor, 
			@id_user		= @id_user;
	
	SET @id_catFiscal = (SELECT id_catfiscal FROM CNT.Terceros T   WHERE T.id = @id_proveedor);
	SELECT @id_cat = F.id, @retiene =  F.retiene FROM  CNTCategoriaFiscal F WHERE F.id = @id_catFiscal AND F.retiene != 0
		
	IF (@id_orden	=	0) 
		SET @id_orden = NULL 

	IF (@id_formaPagoFlete = 0) 
		SET @id_formaPagoFlete = NULL 
	
	IF (@id_proveflete = 0) 
		SET @id_proveflete = NULL 
	
	IF (@id_centrocosto = 0) 
		SET @id_centrocosto = NULL 			
		
	SELECT TOP 1 @calfeltepro = flete FROM Dbo.ST_FnCalRetenciones(@id_proveedor, @id_entradatemp, @flete, 'EN', 0,  @id_proveflete,@id_catfiscal,@id_cat,@retiene) R

	SET @idestado = Dbo.ST_FnGetIdList('PROCE');
						
	INSERT INTO [dbo].LotesProducto(lote, vencimiento_lote, id_usercreated, id_userupdated)
	SELECT DISTINCT (id_lote),
		vencimientolote,
		@id_user,
		@id_user 
	FROM MOVEntradasItemsTemp M WHERE id_entrada = @id_entradatemp AND REPLACE(id_lote,' ','') != '' AND 
	NOT EXISTS(SELECT 1 FROM Dbo.LotesProducto L WHERE L.lote = M.id_lote AND L.vencimiento_lote = M.vencimientolote)
	
	IF (@prorratea = 1)
		EXEC Dbo.ST_MovEntradaCalcularFlete 
			@id_entrada  = @id_entradatemp, 
			@flete		 = @calfeltepro, 
			@tipoprorrat = @tipoprorrat;

	EXEC Dbo.ST_MOVCargarExistencia 
			@Opcion		= 'I', 
			@id			= @id_entradatemp, 
			@id_user	= @id_user, 
			@id_bodega	= @id_bodega;	
										
	INSERT INTO [dbo].[MOVEntradas] (id_tipodoc, id_centrocostos, fechadocumen, fechafactura, fechavence, numfactura, diasvence, estado, 
									 id_bodega, id_proveedor, id_formaPagos, costo, iva, inc, descuento, ivaflete ,flete, valor, poriva, reteiva, porfuente, retefuente, 
									 porica, reteica, id_user, id_orden, id_proveflete, id_formaPagoFlete,id_ctaant,valoranticipo)
	SELECT	@id_tipodoc,
			@id_centrocosto,
			@fechadoc, 
			@fechafac, 
			@fechavence, 
			@numfac, 
			@dias, 
			@idestado,
			@id_bodega, 
			@id_proveedor, 
			@id_formaPago,
			R.costo, 
			R.iva,
			R.tinc, 
			R.descuento, 
			R.ivaFlete,
			R.flete, 
			R.total,
			R.poriva, 
			R.retiva,
			R.porfuente, 
			R.retfuente,
			R.porica, 
			R.retica, 
			@id_user,
			@id_orden,
			@id_proveflete,
			@id_formaPagoFlete,
			@id_ctaant,
			@anticipo
	FROM Dbo.ST_FnCalRetenciones(@id_proveedor, @id_entradatemp, @flete, 'EN', 0,  @id_proveflete,@id_catfiscal,@id_cat,@retiene) R
					
	SET @id_return = SCOPE_IDENTITY();


	
		
	IF ISNULL(@id_return, 0) <> 0
	BEGIN
		
		INSERT INTO [dbo].[MOVEntradasItems] 
		(id_entrada, id_articulo, serie, lote, id_lote, id_bodega, cantidad, costo, precio, descuentound, pordescuento, descuento, 
		 porceniva, iva, porceninc, inc, id_iva,id_inc,porcerefuente,retefuente,id_retefuente,porcereiva,reteiva,id_reteiva,porcereica,reteica,id_reteica,costototal, fleteund, flete, id_ctaiva, id_ctainc, id_user, inventarial, id_itemtemp)
		SELECT	@id_return, 
				id_articulo,
				T.serie,
				T.lote,
				dbo.ST_FnGetIdLote(T.id_lote, T.vencimientolote),
				@id_bodega, 
				T.cantidad, 
				T.costo, 
				T.precio, 
				T.descuentound,
				T.pordescuento,
				T.descuento,
				T.porceniva,
				T.iva,
				T.porceninc,
				T.inc,
				T.id_iva,
				T.id_inc,
				T.porcerefuente,
				T.retefuente,
				T.id_retefuente,
				T.porcereiva,
				T.reteiva,
				T.id_reteiva,
				T.porcereica,
				T.reteica,
				T.id_reteica,
				T.costototal,
				T.fleteund,
				T.flete,
				I.id_ctacompra id_ctaiva,
				I2.id_ctacompra id_ctainc,
				@id_user,
				T.inventarial,
				T.id
		FROM [dbo].[MOVEntradasItemsTemp] T
		LEFT JOIN CNT.Impuestos I ON T.id_iva = I.id
		LEFT JOIN CNT.Impuestos I2 ON T.id_inc = I2.id
		WHERE id_entrada = @id_entradatemp;
				

		INSERT INTO [dbo].[MovEntradasSeries](id_items,	id_entrada, serie)
		SELECT II.id, @id_return, S.serie 
		FROM [dbo].[MovEntradasSeriesTemp] S
		INNER JOIN [MOVEntradasItemsTemp] I ON I.id = S.id_itemstemp
		INNER JOIN [MOVEntradasItems] II ON I.id_articulo = II.id_articulo AND II.id_itemtemp = I.id
		WHERE I.id_entrada = @id_entradatemp AND II.serie != 0;


		DELETE [dbo].[MovEntradasSeriesTemp] WHERE id_entradatemp	= @id_entradatemp;
		Delete [dbo].[MOVEntradasItemsTemp]	 WHERE id_entrada		= @id_entradatemp;
		Delete [dbo].[MOVEntradasTemp]		 WHERE id				= @id_entradatemp;
										
		UPDATE dbo.MovOrdenCompras SET estado = Dbo.ST_FnGetIdList('UTIL') WHERE id	= @id_orden;

		SELECT @id_return id, 'PROCESADO' estado,'CNT.VW_TRANSACIONES_ENTRADAS' nombreview,@fecha fecha,@anomes anomes,@id_user id_user;
	END
	ELSE
	BEGIN
		RAISERROR('Error al Guardar entrada, No se pudo guardar la cabecera de la factura.', 16,0);
	END				
			
			
COMMIT TRANSACTION;
END TRY
BEGIN CATCH	
	ROLLBACK TRANSACTION;
	Declare @Mensaje varchar(max) = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@Mensaje,16,0);	
END CATCH




GO


