--liquibase formatted sql
--changeset ,JTOUS:4 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FIN].[ST_MOVFacturasCausacionInteres]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [FIN].[ST_MOVFacturasCausacionInteres] 
GO

CREATE PROCEDURE [FIN].[ST_MOVFacturasCausacionInteres] 
	@numfactura VARCHAR(30) = '',
	@id_tercero BIGINT = 0,
	@fecha VARCHAR (10) = '20210228',
	@cuota	INT = 0,
	@id_user  BIGINT

AS
/***************************************
*Nombre:		[Dbo].[ST_MOVFacturasCausacionInteres]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creacion:		11/01/2021
*Desarrollador:  Jose Luis Tous Perez (jtous)
*Descripcion:	Se realizan EL PROCESO DE FACTURAR Los intereses Causados de las Facturas Financiadas.
***************************************/
DECLARE @id_centrocostos	BIGINT = 0, @id_factura BIGINT = 0,  @mensaje varchar(max);
DECLARE  @id_return INT, @anomes VARCHAR(6) = @fecha, @tipofactura BIGINT = 0, @id_servicio BIGINT = 0, @id_ctaivalc BIGINT = 0, @porivaint NUMERIC(18,2) = 0;
DECLARE @isfe INT = 0, @resolucion VARCHAR(50), @id_resolucion bigint, @consefac int, @lineacredito BIGINT = 0, @prefijo varchar(20), @id_saldocli BIGINT = 0, @valor NUMERIC(18,2) = 0;
DECLARE @id_forma BIGINT, @id_ctafin BIGINT;

BEGIN TRANSACTION
BEGIN TRY
	IF NOT EXISTS (SELECT TOP 1 1 FROM CNT.SaldoCliente_Cuotas WHERE nrofactura = @numfactura AND anomes = @anomes AND id_cliente = @id_tercero AND cuota = @cuota)
		RAISERROR('No se pueden causar los intereses, ya que la factura no esta contabilizada. .', 16,0)

	IF EXISTS (SELECT TOP 1 1 FROM FIN.SaldoCliente_Cuotas WHERE numfactura = @numfactura AND anomes = @anomes AND id_tercero = @id_tercero AND cuota < @cuota AND InteresCausado = 0 AND AbonoInteres = 0) AND (@cuota-1) > 0
		RAISERROR('No puede causar el interes ya que tiene cuotas anteriores sin causar.', 16,0)
		
	IF EXISTS (SELECT TOP 1 1 FROM FIN.SaldoCliente_Cuotas WHERE numfactura = @numfactura AND anomes = @anomes AND id_tercero = @id_tercero AND cuota = @cuota AND InteresCausado > 0)
		RAISERROR('Esta cuota ya esta causada.', 16,0)
	
	SET @anomes = CAST(@fecha AS VARCHAR(6));

	SET @id_servicio = (SELECT TOP 1 id FROM Productos WHERE Codigo = 'INTCOR');
	SET @tipofactura = (SELECT TOP 1 id FROM ST_Listados WHERE Codigo = 'FORMACREDI' AND iden = 'CREDI');
	SET @id_factura = (SELECT TOP 1 id_documento FROM FIN.SaldoCliente WHERE nrofactura = @numfactura AND id_cliente = @id_tercero AND anomes = @anomes);
	SET @isfe = (SELECT CASE WHEN valor = 'S' THEN 1 ELSE 0 END FROM Parametros WHERE codigo = 'FACTURAELECTRO');	
	
	SELECT TOP 1 @lineacredito = PagoFinan, @id_centrocostos = id_centrocostos FROM MovFactura WHERE id = @id_factura;

	EXECUTE [FIN].[ST_MOVValidarFacturaCaucacion]
	@id_ccosto	= @id_centrocostos,
	@isfe		= @isfe,
	@id_tercero = @id_tercero;

	SELECT TOP 1  @id_ctaivalc = id_ctaiva, @porivaint = porcenIva FROM FIN.LineasCreditos WHERE id = @lineacredito;

	SELECT TOP 1 @resolucion = resolucion, @id_resolucion = id_resolucion, @consefac = consecutivo, @prefijo = prefijo 
	FROM Dbo.ST_FnConsecutivoFactura(ISNULL(@id_centrocostos, 0), @isfe);

	INSERT INTO Dbo.MOVFactura (id_tipodoc, id_centrocostos, tipofactura, PagoFinan,  fechafac, estado, id_tercero, iva, inc, descuento, subtotal, total, valorFianza, valorpagado, 
	totalcredito, id_resolucion, resolucion, consecutivo, prefijo, isFe,isPos, id_turno, cambio, id_ctaant, valoranticipo, cuotas, veninicial, dias, 
	id_tipovence, estadoFE, id_user, id_vendedor, iscausacion, id_ctafin, fechavence, nrofactura, id_faccau)
	SELECT 
	id_tipodoc,
	id_centrocostos,
	@tipofactura															tipofactura,
	F.PagoFinan																PagoFinan,
	@fecha																	fecha, 
	Dbo.ST_FnGetIdList('PROCE')												estado,
	id_cliente,
	CONVERT(NUMERIC(18,2), (C.interes * C.porcenIva / 100))					iva,
	0																		inc,						
	0																		descuentoart, 
	C.interes																subtotal, 
	CONVERT(NUMERIC(18,2), (C.interes * C.porcenIva / 100)) + interes		total,		
	0																		valorfianza,	  
	CONVERT(NUMERIC(18,2), (C.interes * C.porcenIva / 100)) + interes		totalpagado, 
	0																		totalcre,
	@id_resolucion															id_resolucion,
	@resolucion																resolucion,
	@consefac																consecutivo,
    @prefijo																prefijo,
	@isfe																	isfe,
	0																		isPos,
	F.id_turno																id_turno,
	0																		cambio,
	NULL																	id_ctaant,
	0																		anticipo,
	1																		cuotas,
	@fecha																	veninicial,
	1																		dias,
	NULL																	id_tipovence,
	Dbo.ST_FnGetIdList('PREVIA')											estadofe,
	@id_user																id_user,
	id_vendedor																id_vendedor,
	1																		iscausacion,
	F.id_ctafin																id_ctafin,
	@fecha																	fechavence,
	@numfactura																nrofactura,
	@id_factura																id_faccau
	FROM VW_Movfacturas F
	INNER JOIN FIN.SaldoCliente_Cuotas C ON C.numfactura = F.rptconsecutivo AND C.anomes = @anomes AND F.id_cliente = C.id_tercero
	WHERE F.id = @id_factura AND F.id_cliente = @id_tercero AND C.cuota = @cuota;	
	
	SET @id_return = SCOPE_IDENTITY();	
	
	IF(ISNULL(@id_return, 0) = 0)		
	BEGIN
		SET @mensaje = 'No se inserto cabecera de factura: ' + @numfactura;
		RAISERROR(@mensaje, 16,0)
	END
	INSERT INTO [dbo].[MOVFacturaItems] (id_factura, id_producto, id_bodega, serie, lote, cantidad, costo, precio, preciodesc, descuentound, 
					pordescuento, descuento, id_ctaiva, poriva, iva, id_ctainc, porinc, inc, total, formulado, id_user, inventarial, id_itemtemp,
					id_iva,id_inc, descripcion, id_faccau, cuota)
	SELECT  @id_return, 
			@id_servicio id_articulo,
			NULL  id_bodega,
			0 serie,
			0 lote,
			1 cantidad, 
			0 costo,
			T.subtotal,
			T.subtotal,
			0 descuentound,
			0 pordescuento,
			0 descuento,
			@id_ctaivalc id_ctaiva,
			@porivaint poriva,
			T.iva iva,
			NULL id_ctainc,
			0 porinc,
			0 inc,
			T.total total,
			0 formulado,
			@id_user, 
			0 inventarial,
			0 id,
			null id_iva,
			null id_inc,
			'INTERESES PAGADOS N° Factura :' + @numfactura +' N° cuota:'+ CAST(@cuota AS VARCHAR),
			@id_factura,
			@cuota
	FROM [dbo].[MOVFactura] T WHERE id = @id_return;

	SELECT @id_forma = id_formapago, @id_ctafin = codcuenta 
	FROM MOVFacturaFormaPago WHERE id_factura = @id_factura AND id_formapago = (SELECT TOP 1 id FROM FormaPagos Where codigo = 'FPC')

	INSERT INTO [dbo].[MOVFacturaFormaPago] (id_factura, id_formapago, valor, voucher, id_user, codcuenta)
	SELECT id, @id_forma, total, '', @id_user, @id_ctafin
	FROM [dbo].[MOVFactura] WHERE id = @id_return
	
	SELECT @valor = total FROM MOVFactura WHERE id = @id_return;

	UPDATE FIN.SaldoCliente_Cuotas SET InteresCausado = @valor WHERE numfactura = @numfactura AND cuota = @cuota AND id_tercero = @id_tercero	

	UPDATE Dbo.DocumentosTecnicaKey SET consecutivo = @consefac WHERE id = @id_resolucion AND id_ccosto = @id_centrocostos AND isfe = @isfe;

	EXECUTE [CNT].[ST_MOVTransacciones] @id = @id_return, @id_user = @id_user, @nombreView = 'CNT.VW_TRANSACIONES_FACTURAS';
	
	EXEC CNT.ST_MOVSaldoCuenta @opcion='I', @id = @id_return, @id_user = @id_user, @nombreView = 'CNT.VW_TRANSACIONES_FACTURAS'
	
	EXEC CNT.ST_MOVSaldoTerceronew @opcion='I', @id = @id_return, @id_user = @id_user, @nombreView = 'CNT.VW_TRANSACIONES_FACTURAS'

	UPDATE MOVFactura SET contabilizado = 1 WHERE id = @id_return;
	

	UPDATE E SET
				E.updated	= GETDATE(),
				E.saldoActual= ((E.saldoAnterior + E.movdebito + @valor)-(E.movCredito)),
				E.movDebito = (E.movDebito + @valor),
				E.id_user	=  @id_user,
				E.before	= 0,
				E.changed   = 0
	FROM CNT.SaldoCliente E 
	WHERE nrofactura = @numfactura and id_cliente = @id_tercero AND anomes = @anomes AND id_nota IS NULL AND saldoActual !=0

	UPDATE E SET
				E.updated		= GETDATE(),
				E.saldoActual	= ((E.saldoAnterior + E.movDebito + C.InteresCausado + C.Valorfianza) - (E.movCredito)),
				E.movDebito		= (E.movDebito + C.InteresCausado + C.Valorfianza),
				E.id_user		=  @id_user
	FROM FIN.SaldoCliente E INNER JOIN FIN.SaldoCliente_Cuotas AS C ON E.nrofactura = C.numfactura and E.id_cliente = C.id_tercero AND E.anomes = C.anomes AND C.cuota = @cuota
	WHERE nrofactura = @numfactura and id_cliente = @id_tercero AND E.anomes = @anomes AND saldoActual !=0 AND C.cuota = @cuota

	UPDATE E SET
				E.updated	= GETDATE(),
				E.saldoActual= ((E.saldoAnterior + E.movdebito + @valor)-(E.movCredito)),
				E.movDebito = (E.movDebito + @valor),
				E.id_user	=  @id_user,
				E.before	= 0,
				E.changed   = 0
	FROM CNT.SaldoCliente_Cuotas E 
	WHERE nrofactura = @numfactura and id_cliente = @id_tercero AND anomes = @anomes AND cuota = @cuota;

COMMIT TRANSACTION;
END TRY
BEGIN CATCH	
	SET @mensaje = ERROR_MESSAGE();
	ROLLBACK TRANSACTION;	
	RAISERROR(@Mensaje,16,0);
END CATCH


GO


