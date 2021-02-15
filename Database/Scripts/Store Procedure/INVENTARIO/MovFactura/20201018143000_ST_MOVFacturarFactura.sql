--liquibase formatted sql
--changeset ,JTOUS:5 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MOVFacturarFactura]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MOVFacturarFactura] 
GO

CREATE PROCEDURE [dbo].[ST_MOVFacturarFactura] 
@id_forma			INT,
@valorFianza        NUMERIC(18,2) = NULL,									 
@id_tipodoc			BIGINT,
@id_centrocostos	BIGINT,
@fechadoc			SMALLDATETIME,
@id_tercero			BIGINT,
@id_vendedor		BIGINT,
@id_ctaant			BIGINT,
@anticipo			NUMERIC(18,2),
@formapago			XML,
@idToken			VARCHAR(255),
@totalcredito		NUMERIC(18,2),
@numcuotas			INT,
@dias				INT,
@venini				VARCHAR(10),
@vencimiento		INT,
@id_user			INT,
@id_formacred		BIGINT,
@id_ctadsctoFin		BIGINT=NULL,
@descuentoFin       NUMERIC (18,2)=0


AS
/***************************************
*Nombre:		[Dbo].[ST_MOVFacturarFactura]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		19/06/2015
*Desarrollador:  Jose Luis Tous P�rez (jtous)
*Descripcion:	Se realizan EL PROCESO DE FACTURAR LAS ENTRADAS
***************************************/
Declare @id_return INT,  @id_re INT, @idestado INT, @manejador int, @valortotal NUMERIC(18,4), @totalforma NUMERIC(18,4), @id_turno BIGINT, @anomes VARCHAR(6) = '',@fecha varchar(10),
 @IVA bit = 0, @porcenIva bigint = 0, @Tasaanual NUMERIC(18,2) ;
Declare @resolucion VARCHAR(50), @id_resolucion bigint, @consefac int, @prefijo varchar(20), @mensaje varchar(max), @id_saldo BIGINT,@id_ctaDscto BIGINT;
DECLARE @tableforma TABLE (id int identity (1,1), id_forma BIGINT, valor numeric(18,2), voucher varchar(200))
DECLARE @isfe INT = 0, @fechatemp SMALLDATETIME = @fechadoc, @fechatemp2 VARCHAR(10), @Tipofactu varchar(50), @porcentaj NUMERIC(18, 2), @fechavenci VARCHAR(10), @id_ctafin BIGINT, @porintfin NUMERIC(18,2);
BEGIN TRY
BEGIN TRANSACTION
	
	SET @fechatemp2 = CONVERT(VARCHAR(10), @fechatemp, 120)

	SELECT TOP 1 @id_ctafin = ISNULL(id_ctacredito, 0), @porintfin = ISNULL(Porcentaje, 0), @Tasaanual = Tasaanual  FROM FIN.LineasCreditos WHERE id = @id_formacred;

	SET @isfe = (SELECT CASE WHEN valor = 'S' THEN 1 ELSE 0 END FROM Parametros WHERE codigo = 'FACTURAELECTRO');

	SET @id_ctadsctoFin=iif(@id_ctadsctoFin=0,null,@id_ctadsctoFin)															
	SELECT TOP 1 @resolucion = resolucion, @id_resolucion = id_resolucion, @consefac = consecutivo, @prefijo = prefijo 
	FROM Dbo.ST_FnConsecutivoFactura(ISNULL(@id_centrocostos, 0), @isfe);	
	
	SET @anomes = CONVERT(VARCHAR(6), @fechadoc, 112);
	SET @fecha = CONVERT(VARCHAR(10), @fechadoc, 120);
	EXECUTE [Dbo].ST_ValidarPeriodo
	@fecha			= @fecha,
	@anomes			= @anomes,
	@mod			= 'I'


	SET @idestado = Dbo.ST_FnGetIdList('PROCE');
	
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
		
	EXECUTE [Dbo].ST_MOVValidarFactura
	@fechadoc		= @fechadoc,
	@id_ccosto		= @id_centrocostos,
	@isfe			= @isfe,
	@id_tercero		= @id_tercero,
	@idToken		= @idToken,
	@valorcredito	= @totalcredito,
	@valorformas	= @totalforma,
	@anticipo		= @anticipo,
	@descuentoFin	= @descuentoFin,						   
	@id_user		= @id_user,
	@valortotal		= @valortotal OUTPUT;
	
	IF(@id_forma =  DBO.ST_FnGetIdList('FINAN') AND @totalcredito > 0 AND ISNULL(@id_formacred, 0) = 0)
		RAISERROR('No puede facturar sin linea de credito.', 16, 0);

	SET @id_turno = (SELECT TOP 1 id_turno FROM Dbo.Usuarios WHERE id = @id_user);
	
	INSERT INTO Dbo.MOVFactura (id_tipodoc, id_centrocostos, tipofactura, PagoFinan,  fechafac, estado, id_tercero, iva, inc, descuento, subtotal, total, valorFianza, valorpagado, 
	totalcredito, id_resolucion, resolucion, consecutivo, prefijo, isFe,isPos, id_turno, cambio, id_ctaant, valoranticipo, cuotas, veninicial, dias, 
	id_tipovence, estadoFE, id_user, id_vendedor, fechavence, id_ctafin, porintfin,dsctoFinanciero,ctadescuento)
	SELECT 
	@id_tipodoc				id_tipo,
	@id_centrocostos		id_ccosto,
	@id_forma               tipofactura,
	CASE WHEN @id_forma !=  DBO.ST_FnGetIdList('FINAN') THEN NULL ELSE @id_formacred END  PagoFinan,
	@fechadoc				fecha, 
	@idestado				estado,
	@id_tercero				id_terceo, 
	T.iva,
	T.inc,						
	T.descuentoart, 
	T.precio, 
	(T.total + @anticipo),		
	@valorFianza valorfianza,	  
	(@totalcredito + @totalforma) totalpagado, 
	@totalcredito			totalcre,
	@id_resolucion			id_resolucion,
	@resolucion				resolucion,
	@consefac				consecutivo,
    @prefijo				prefijo,
	@isfe			    	isfe,
	0					    isPos,
	@id_turno				id_turno,
	((@totalcredito + @totalforma+@anticipo) - (T.total +@anticipo-@descuentoFin)) cambio,
	CASE WHEN @id_ctaant = 0 THEN NULL ELSE @id_ctaant END id_ctaant,
	@anticipo				anticipo,
	@numcuotas				cuotas,
	@venini					veninicial,
	@dias					dias,
	CASE WHEN @vencimiento = 0 THEN NULL ELSE @vencimiento END	id_tipovencto,
	Dbo.ST_FnGetIdList('PREVIA') estadofe,
	@id_user				id_user,
	@id_vendedor			id_vendedor,
	@fechadoc,
	CASE WHEN @id_forma !=  DBO.ST_FnGetIdList('FINAN') THEN NULL ELSE @id_ctafin END  ctafin,
	ISNULL(@porintfin, 0)	porintfin,
	@descuentoFin,
	@id_ctadsctoFin		
	FROM Dbo.ST_FnCalTotalFactura(@idToken, @anticipo) T

	SET @id_return = SCOPE_IDENTITY();													
	
	INSERT INTO [dbo].[MOVFacturaItems] (id_factura, id_producto, id_bodega, serie, lote, cantidad, costo, precio, preciodesc, descuentound, 
					pordescuento, descuento, id_ctaiva, poriva, iva, id_ctainc, porinc, inc, total, formulado, id_user, inventarial, id_itemtemp,id_iva,id_inc,descripcion)
	SELECT  @id_return, 
			T.id_articulo,
			CASE WHEN T.id_bodega = 0 THEN NULL ELSE T.id_bodega END id_bodega,
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
			T.id,
			T.id_iva,
			T.id_inc,
			P.nombre
	FROM [dbo].[MOVFacturaItemsTemp] T
		INNER JOIN Productos P ON P.id = T.id_articulo
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
	
	INSERT INTO dbo.MOVFacturaFormaPago(id_factura, id_formapago, voucher, valor, codcuenta, id_user)
	SELECT @id_return, T.id_forma, T.voucher, T.valor, F.id_cuenta, @id_user
	FROM @tableforma T INNER JOIN FormaPagos F ON F.id = T.id_forma

	EXEC ST_MOVCargarExistenciaFac @Opcion = 'I', @id = 0, @id_factura = @idToken, @id_user = @id_user;

	SELECT  @IVA=iva ,@porcenIva = CASE WHEN iva != 0 THEN PorcenIva ELSE 0 END FROM FIN.LineasCreditos Where id = @id_formacred;																																					  
 
	IF(@totalcredito > 0)
	BEGIN
		IF(@id_forma = [dbo].[ST_FnGetIdList]('FINAN'))
		BEGIN			
		  INSERT INTO [dbo].[MOVFacturaCuotas](id_factura, cuota, valorcuota, saldo, saldo_anterior, interes, acapital, porcentaje, fecha_inicial, vencimiento, fecha_pagointeres)
		  SELECT @id_return, cuota, valorcuota, saldo, SaldoAnterior, interes, acapital, porcentaje, FechaInicio, vencimiento, vencimiento
		  FROM [FIN].[ST_FnRecCuotasLineasCreditos] (@id_formacred, @idToken, @totalcredito, @numcuotas, @vencimiento, @venini, @dias)
		  			
		  SELECT TOP 1 @porcentaj = MC.porcentaje, @fechavenci = REPLACE(MC.vencimiento, '-', '') FROM MovFacturaCuotas MC where id_factura = @id_return ORDER BY cuota DESC 
		  
		  UPDATE MOVFactura SET fechavence = CASE WHEN ISNULL(@fechavenci, '') = '' THEN fechafac ELSE @fechavenci END WHERE id = @id_return;

		  INSERT INTO FIN.SaldoCliente (anomes, id_cliente, id_documento, fechaactual, fechavencimiento, nrofactura, saldoanterior, movDebito, movCredito, saldoActual, porcentaje, id_user)
            (SELECT  @anomes,
                     @id_tercero,
                     AT.id,
                     AT.fechafac,
                     AT.fechafac,
                     AT.prefijo + +'-'+ CAST(AT.consecutivo AS VARCHAR),
                     0,
                     AT.totalcredito, 
                     0,
                     AT.totalcredito,
                     @porintfin,
                     @id_user
            FROM [dbo].[MOVFactura] AT WHERE  AT.id = @id_return) ; 

            SET @id_saldo = SCOPE_IDENTITY();

			INSERT INTO [FIN].[SaldoCliente_Cuotas]( id_saldo, numfactura,  anomes, iva, porcenIva, cuota,  vlrcuota,  saldo, saldo_anterior, saldocuota,  interes,  acapital,  porcentaje, Tasaanual, fecha_inicial,  vencimiento_cuota, abono, fechapagointeres, id_user, cuotafianza, id_tercero, Valorfianza)
			SELECT 
			   @id_saldo,
			   @prefijo + '-' + CAST(@consefac AS VARCHAR),
			   @anomes,
			   @IVA,
			   @porcenIva,
			   MC.cuota,
			   MC.valorcuota,
			   MC.saldo,
			   MC.saldo_anterior,
			   0,
			   MC.interes,
			   MC.acapital,
			   MC.porcentaje,
			   @Tasaanual, 
			   REPLACE(mc.fecha_inicial,'-',''),
			   REPLACE(mc.vencimiento,'-',''),
			   0,
			   REPLACE(mc.vencimiento,'-',''),
			   @id_user,
			   @valorFianza,
			   @id_tercero,
			   @valorFianza - (MC.valorcuota + CONVERT(NUMERIC(18,2), (MC.interes * @porcenIva / 100)))
			FROM MovFacturaCuotas MC where id_factura = @id_return 
			
			
			INSERT INTO [dbo].[MOVFacturaFormaPago] (id_factura, id_formapago, valor, voucher, id_user, codcuenta)
			SELECT @id_return, id, @totalcredito, '', @id_user, @id_ctafin
			FROM FormaPagos Where codigo = 'FPC'					
		END
		ELSE IF(@id_forma = [dbo].[ST_FnGetIdList]('CREDI'))
		BEGIN
			INSERT INTO [dbo].[MOVFacturaFormaPago] (id_factura, id_formapago, valor, voucher, id_user, codcuenta)
			SELECT @id_return, @id_formacred, @totalcredito, '', @id_user, id_cuenta
			FROM FormaPagos Where id = @id_formacred;

			INSERT INTO [dbo].[MOVFacturaCuotas](id_factura, cuota, valorcuota, saldo, interes, acapital, porcentaje, fecha_inicial, vencimiento, fecha_pagointeres)
			SELECT @id_return, id, valorcuota, saldo, 0, 0, 0, 0, vencimiento, vencimiento 
			FROM ST_FnMovFacturaRecCuotas (@idToken, @totalcredito, @numcuotas, @vencimiento, @venini, @dias)
		END
	END
					
	UPDATE Dbo.DocumentosTecnicaKey SET consecutivo = @consefac WHERE id = @id_resolucion AND id_ccosto = @id_centrocostos AND isfe = @isfe;
	
	DELETE [dbo].[MOVFacturaLotesTemp] WHERE id_factura			= @idToken;
	DELETE [dbo].[MovFacturaSeriesTemp] WHERE id_facturatemp	= @idToken;
	DELETE [dbo].[MOVFacturaItemsTemp]  WHERE id_factura		= @idToken AND id_user = @id_user;


	SELECT @id_return id, 
		keyid [key], 
		[isfe], 
		'PROCESADO' estado,
		'CNT.VW_TRANSACIONES_FACTURAS' nombreview, 
		@fecha fecha,
		@anomes anomes,
		@id_user id_user,
		CASE WHEN @id_forma !=  DBO.ST_FnGetIdList('FINAN') THEN NULL ELSE @id_formacred END pagoFinan																						
	FROM MOVFactura WHERE id = @id_return;
COMMIT TRANSACTION;
END TRY
BEGIN CATCH	
	ROLLBACK TRANSACTION;
	SET @mensaje = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@Mensaje,16,0);	
END CATCH
