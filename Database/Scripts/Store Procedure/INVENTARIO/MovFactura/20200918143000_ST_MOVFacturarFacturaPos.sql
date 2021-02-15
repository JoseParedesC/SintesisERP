--liquibase formatted sql
--changeset ,jtous:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MOVFacturarFacturaPos]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	DROP PROCEDURE  [dbo].[ST_MOVFacturarFacturaPos]
GO
CREATE PROCEDURE [dbo].[ST_MOVFacturarFacturaPos] 
@id_centrocostos	BIGINT,
@fechadoc			SMALLDATETIME,
@id_tercero			BIGINT,
@isFe				BIT,
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
@id_caja			BIGINT

--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_MOVFacturarFactura]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		19/06/2015
*Desarrollador:  Jose Luis Tous P�rez (jtous)
*Descripcion:	Se realizan EL PROCESO DE FACTURAR LAS ENTRADAS
***************************************/
Declare @id_return INT, @idestado INT, @manejador int, @valortotal NUMERIC(18,4), @totalforma NUMERIC(18,4), @id_turno BIGINT, @anomes VARCHAR(6) = '',@fecha VARCHAR(10);
Declare @resolucion VARCHAR(50), @id_resolucion bigint, @consefac int, @prefijo varchar(20), @mensaje varchar(max), @id_saldo BIGINT, @id_tipodoc BIGINT = 0;
DECLARE @tableforma TABLE (id int identity (1,1), id_forma BIGINT, valor numeric(18,2), voucher varchar(200));
BEGIN TRY
BEGIN TRANSACTION
	
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
		
	EXECUTE [Dbo].ST_MOVValidarFactura
	@fechadoc		= @fechadoc,
	@id_ccosto		= @id_centrocostos,
	@isfe			= @isFe,
	@id_tercero		= @id_tercero,
	@idToken		= @idToken,
	@valorcredito	= @totalcredito,
	@valorformas	= @totalforma,
	@anticipo		= @anticipo,
	@id_user		= @id_user,
	@valortotal		= @valortotal OUTPUT;		

	SET @id_turno = (SELECT TOP 1 id_turno FROM Dbo.Usuarios WHERE id = @id_user);
	
	INSERT INTO Dbo.MOVFactura (id_tipodoc, id_centrocostos, fechafac, estado, id_tercero, iva, inc, descuento, subtotal, total, valorpagado, 
	totalcredito, id_resolucion, resolucion, consecutivo, prefijo, isFe,isPos, id_turno, cambio, id_ctaant, valoranticipo, cuotas, veninicial, dias, 
	id_tipovence, estadoFE, id_user, id_vendedor)
	SELECT 
	@id_tipodoc				id_tipo,
	@id_centrocostos		id_ccosto,
	@fechadoc				fecha, 
	@idestado				estado,
	@id_tercero				id_terceo, 
	T.iva,
	T.inc,						
	T.descuentoart, 
	T.precio, 
	T.total,
	(@totalcredito + @totalforma) totalpagado, 
	@totalcredito			totalcre,
	@id_resolucion			id_resolucion,
	@resolucion				resolucion,
	@consefac				consecutivo,
    @prefijo				prefijo,
	@isFe					isfe,
	1						isPos,
	@id_turno				id_turno,
	((@totalcredito + @totalforma) - T.total) cambio,
	CASE WHEN @id_ctaant = 0 THEN NULL ELSE @id_ctaant END id_ctaant,
	@anticipo				anticipo,
	@numcuotas				cuotas,
	@venini					veninicial,
	@dias					dias,
	CASE WHEN @vencimiento = 0 THEN NULL ELSE @vencimiento END	id_tipovencto,
	Dbo.ST_FnGetIdList('PREVIA') estadofe,
	@id_user				id_user,
	@id_vendedor			id_vendedor
	FROM Dbo.ST_FnCalTotalFactura(@idToken, @anticipo) T

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
	
	INSERT INTO dbo.MOVFacturaFormaPago(id_factura, id_formapago, voucher, valor, codcuenta, id_user)
	SELECT @id_return, T.id_forma, T.voucher, T.valor, F.id_cuenta, @id_user
	FROM @tableforma T INNER JOIN FormaPagos F ON F.id = T.id_forma

	EXEC ST_MOVCargarExistenciaFac @Opcion = 'I', @id = 0, @id_factura = @idToken, @id_user = @id_user;

	IF(@totalcredito > 0)
	BEGIN
		INSERT INTO [dbo].[MOVFacturaFormaPago] (id_factura, id_formapago, valor, voucher, id_user, codcuenta)
		SELECT @id_return, @id_formacred, @totalcredito, '', @id_user, id_cuenta
		FROM FormaPagos Where id = @id_formacred;


		INSERT INTO [dbo].[MOVFacturaCuotas](id_factura, cuota, valorcuota, saldo, vencimiento, fecha_pagointeres)
	    SELECT @id_return, id, valorcuota, saldo, vencimiento,vencimiento 
		FROM ST_FnMovFacturaRecCuotas (@idToken, @totalcredito, @numcuotas, @vencimiento, @venini, @dias)


	END

	UPDATE Dbo.DocumentosTecnicaKey SET consecutivo = @consefac WHERE id = @id_resolucion AND id_ccosto = @id_centrocostos AND isfe = @isFe;
	
	DELETE [dbo].[MOVFacturaLotesTemp] WHERE id_factura			= @idToken;
	DELETE [dbo].[MovFacturaSeriesTemp] WHERE id_facturatemp	= @idToken;
	DELETE [dbo].[MOVFacturaItemsTemp]  WHERE id_factura		= @idToken AND id_user = @id_user;


	SELECT 
		@id_return id, 
		keyid [key], 
		[isfe], 
		'PROCESADO' estado,
		'CNT.VW_TRANSACIONES_FACTURAS' nombreview,
		@fecha fecha,
		@anomes anomes,
		@id_user id_user
	FROM MOVFactura WHERE id = @id_return;


COMMIT TRANSACTION;
END TRY
BEGIN CATCH	
	ROLLBACK TRANSACTION;
	SET @mensaje = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@Mensaje,16,0);	
END CATCH
GO


