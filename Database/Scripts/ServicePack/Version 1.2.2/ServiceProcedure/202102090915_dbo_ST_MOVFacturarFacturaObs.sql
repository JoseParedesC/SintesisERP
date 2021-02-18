--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MOVFacturarFacturaObs]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MOVFacturarFacturaObs]
GO
CREATE PROCEDURE [dbo].[ST_MOVFacturarFacturaObs]
@id_centrocostos	BIGINT,
@fechadoc			SMALLDATETIME,
@id_tercero			BIGINT,
@id_vendedor		BIGINT,
@id_ctaobs			BIGINT,
@totalpago			NUMERIC(18,2),
@idToken			VARCHAR(255),
@id_user			INT,
@id_caja			BIGINT,
@formapago			XML

AS 
/****************************************************************
*Nombre:		[Dbo].[ST_MOVFacturarFacturaObs]
----------------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creacion:		09/02/2021
*Desarrollador:  JPAREDES
*Descripcion:	Se realizan EL PROCESO DE FACTURAR LAS ENTRADAS
****************************************************************/

DECLARE @id_return INT, @idestado INT, @manejador int, @valortotal NUMERIC(18,4), @totalforma NUMERIC(18,4), @id_turno BIGINT, @anomes VARCHAR(6) = '',@fecha VARCHAR(10);
DECLARE @resolucion VARCHAR(50), @id_resolucion bigint, @consefac int, @prefijo varchar(20), @mensaje varchar(max), @id_saldo BIGINT, @id_tipodoc BIGINT = 0, @isFe BIT = 0;
DECLARE @tableforma TABLE (id int identity (1,1), id_forma BIGINT, valor numeric(18,2), voucher varchar(200));
BEGIN TRY
BEGIN TRANSACTION
	
	SET @isFe = (SELECT CASE WHEN valor = 'S' THEN 1 ELSE 0 END FROM Parametros WHERE codigo = 'FACTURAELECTRO');

	SELECT TOP 1 @resolucion = resolucion, @id_resolucion = id_resolucion, @consefac = consecutivo, @prefijo = prefijo 
	FROM Dbo.ST_FnConsecutivoFactura(ISNULL(@id_centrocostos, 0), @isFe);
		
	SET @anomes = CONVERT(VARCHAR(6), @fechadoc, 112);
	SET @fecha = CONVERT(VARCHAR(10), @fechadoc, 120);
	SET @id_tipodoc = (SELECT TOP 1 id FROM CNT.TipoDocumentos WHERE codigo = 'FP');

	SELECT  @id_vendedor = CASE WHEN @id_vendedor = 0 THEN id_vendedor ELSE @id_vendedor END,
			@id_tercero  = CASE WHEN @id_tercero = 0 THEN id_cliente ELSE @id_tercero END
	FROM VW_Cajas WHERE id = @id_caja;
	
	SET @idestado = Dbo.ST_FnGetIdList('PROCE');

	EXECUTE [Dbo].ST_ValidarPeriodo
	@fecha			= @fecha,
	@anomes			= @anomes,
	@mod			= 'I'
	
	
	EXEC sp_xml_preparedocument @manejador OUTPUT, @formapago; 	

	INSERT INTO @tableforma (id_forma, valor, voucher)
	SELECT idforma, SUM(valor) val, vouch
	FROM OPENXML(@manejador, N'Formas/item') 
	WITH (  idforma		[int]			'@idforma',
			valor		[NUMERIC](18,2) '@valor',
			vouch		[varchar](200)	'@vouch'
			) AS P
	INNER JOIN [FormaPagos] FP ON FP.id = P.idforma
	GROUP BY P.idforma, vouch
								
	EXEC sp_xml_removedocument @manejador;

	SET @totalforma = ISNULL((SELECT SUM(valor) FROM @tableforma), 0);	


	EXECUTE [Dbo].[ST_MOVValidarFacturaObsequios]
	@fechadoc		= @fechadoc,
	@id_ccosto		= @id_centrocostos,
	@isfe			= @isFe,
	@id_tercero		= @id_tercero,
	@idToken		= @idToken,
	@valorcredito	= @totalpago,
	@valorformas	= 0,
	@anticipo		= 0,
	@id_user		= @id_user,
	@valortotal		= @valortotal OUTPUT;		

	SET @id_turno = (SELECT TOP 1 id_turno FROM Dbo.Usuarios WHERE id = @id_user);
	
	INSERT INTO Dbo.MOVFactura (id_tipodoc, id_centrocostos, fechafac, estado, id_tercero, iva, inc, descuento, subtotal, total, valorpagado, 
	totalcredito, id_resolucion, resolucion, consecutivo, prefijo, isFe,isPos, id_turno,cuotas, /* cambio,*/ id_ctaobs, veninicial, dias,
	/*id_tipovence,*/ estadoFE, id_user, id_vendedor, isOb)
	SELECT 
	@id_tipodoc				id_tipo,
	@id_centrocostos		id_ccosto,
	@fechadoc				fecha, 
	@idestado				estado,
	@id_tercero				id_terceo, 
	T.iva,
	T.inc,						
	T.descuentoart, 
	T.precioobs, 
	T.totalfacObs,
	@totalpago				vaporpagado,
	0						totalpagado, 
	@id_resolucion			id_resolucion,
	@resolucion				resolucion,
	@consefac				consecutivo,
    @prefijo				prefijo,
	@isFe					isfe,
	0						isPos,
	@id_turno				id_turno,
	0						cuotas,
	CASE WHEN @id_ctaobs = 0 THEN NULL ELSE @id_ctaobs END id_ctaobs,
	0						veninicial,
	0						dias,
	Dbo.ST_FnGetIdList('PREVIA') estadofe,
	@id_user				id_user,
	@id_vendedor			id_vendedor,
	1						isObs
	FROM Dbo.ST_FnCalTotalFactura(@idToken, 0) T

	SET @id_return = SCOPE_IDENTITY();
	
	INSERT INTO [dbo].[MOVFacturaItems] (id_factura, id_producto, id_bodega, serie, lote, cantidad, costo, precio, preciodesc, descuentound, 
					pordescuento, descuento, id_ctaiva, poriva, iva, id_ctainc, porinc, inc, total, formulado, id_user, inventarial, id_itemtemp)
	SELECT  @id_return, 
			T.id_articulo,
			T.id_bodega,
			T.serie,
			T.lote,
			T.cantidad, 
			ISNULL(E.costo, 0) costo,
			T.precio,
			T.preciodes,
			T.descuentound,
			T.pordescuento,
			T.descuento,
			C1.id_ctaventa id_ctaiva,
			T.poriva,
			T.iva,
			C2.id_ctaventa id_ctainc,
			T.porinc,
			T.inc,
			T.total,
			T.formulado,
			@id_user, 
			T.inventarial,
			T.id
	FROM [dbo].[MOVFacturaItemsTemp] T
		LEFT JOIN dbo.Existencia E ON T.id_articulo = E.id_articulo AND E.id_bodega = T.id_bodega
		LEFT JOIN CNT.Impuestos C1 ON  C1.id = T.id_iva
		LEFT JOIN CNT.Impuestos C2 ON C2.id = T.id_inc
	WHERE 
		id_factura = @idToken AND T.id_user = @id_user;
	
	
	INSERT INTO Dbo.MovFacturaSeries (id_items, id_factura, serie)
	SELECT I.id, @id_return, ST.serie
	FROM [dbo].[MovFacturaSeriesTemp] ST INNER JOIN
		Dbo.MovFacturaItemsTemp IT ON ST.id_itemstemp = IT.id INNER JOIN
		Dbo.MovFacturaItems I ON I.id_producto = IT.id_articulo AND I.id_bodega = IT.id_bodega AND IT.id = I.id_itemtemp
	WHERE IT.serie != 0 AND IT.id_factura = @idToken AND IT.id_user = @id_user AND IT.inventarial != 0;
	
	INSERT INTO Dbo.MOVFacturaLotes (id_item, id_lote, id_factura, cantidad)
	SELECT I.id, LT.id_lote, @id_return, LT.cantidad
	FROM [dbo].[MOVFacturaLotesTemp] LT INNER JOIN 
		dbo.MovFacturaItemsTemp IT ON LT.id_itemtemp = IT.id INNER JOIN
		Dbo.MovFacturaItems I ON I.id_producto = IT.id_articulo AND I.id_bodega = IT.id_bodega AND IT.id = I.id_itemtemp
	WHERE IT.lote != 0 AND IT.id_factura = @idToken AND IT.id_user = @id_user AND IT.inventarial != 0;

	EXEC ST_MOVCargarExistenciaFac @Opcion = 'I', @id = 0, @id_factura = @idToken, @id_user = 2;


	UPDATE Dbo.DocumentosTecnicaKey SET consecutivo = @consefac WHERE id = @id_resolucion AND id_ccosto = @id_centrocostos AND isfe = @isFe;
	
	DELETE [dbo].[MOVFacturaLotesTemp] WHERE id_factura			= @idToken;
	DELETE [dbo].[MovFacturaSeriesTemp] WHERE id_facturatemp	= @idToken;
	DELETE [dbo].[MOVFacturaItemsTemp]  WHERE id_factura		= @idToken AND id_user = @id_user;


	SELECT 
		@id_return id, 
		keyid [key], 
		[isfe], 
		'PROCESADO' estado,
		'CNT.VW_TRANSACIONES_FACTURAS_OBSEQUIOS' nombreview,
		@fecha fecha,
		@anomes anomes,
		@id_user id_user
	FROM MOVFactura WHERE id = @id_return;


COMMIT TRANSACTION;
END TRY
BEGIN CATCH	
	ROLLBACK TRANSACTION;
	SET @mensaje = ERROR_MESSAGE();
	RAISERROR(@Mensaje,16,0);	
END CATCH
