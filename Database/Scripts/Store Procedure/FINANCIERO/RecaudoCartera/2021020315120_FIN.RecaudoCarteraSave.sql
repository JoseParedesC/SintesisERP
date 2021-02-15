--liquibase formatted sql
--changeset ,kmartinez:4 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FIN].[RecaudoCarteraSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [FIN].[RecaudoCarteraSave]
GO

CREATE PROCEDURE [FIN].[RecaudoCarteraSave]
@id            INT,
@id_tipodoc		BIGINT,
@id_centrocosto BIGINT,
@fecha smalldatetime,
@id_cliente BIGINT,
@formapago XML,
@valorclie NUMERIC(18,2),
@valorconcepto NUMERIC(18,2),
@id_conceptoDescuento BIGINT,
@valorDescuento NUMERIC(18,2),
@cambio NUMERIC (18,2),
@detalle VARCHAR(MAX),
@pagosXml VARCHAR(MAX),
@conceptosxml VARCHAR(MAX),
@id_user BIGINT
 
AS

/***************************************
*Nombre:		[FIN].[RecaudoCarteraSave]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		26/11/2020
*Desarrollador: (Kmartinez)

SP para Registrar un recibo de caja (pago de conceptos y recaudos)
***************************************/
DECLARE @pagoTotalInteres bit, @pagoTotalCorriente bit, @cuota bigint, @idcuota int, @id_CuotaFac int, @anomes VARCHAR(6), @fechadoc VARCHAR(10) ;
DECLARE  @id_return INT, @numeropagos INT, @error VARCHAR(MAX), @manejador int, @idoc INT, @cdoc INT, @mydoc xml, @valortotal numeric (18,2), @conxml xml, @valorTransa NUMERIC(18,2),
@abonoCuota NUMERIC(18,2), @id_DocumenSaldo INT, @id_factura bigint;
DECLARE  @rows INT=0, @count INT=1, @numfactura VARCHAR(30), @capital BIT, @valorCuota NUMERIC(18,2), @valorpagado numeric(18,2), @abonoactual NUMERIC(18,2), 
@totalinteres NUMERIC(18,2), @porceInteres NUMERIC(18,2), @diasvenci int, @interes numeric(18,2), @id_factu INT,@interescorriente VARCHAR(50);
DECLARE  @portopemax NUMERIC(18,2) = 0
DECLARE  @tablacuotas Table (id int identity, id_cuota BIGINT,  porcen numeric(18,2), saldo numeric(18,2), capital numeric(18,2), interescorriente numeric(18,2), Iva numeric(18,2), interesmora numeric(18,2),  saldofianza numeric(18,2), diasinteresM NUMERIC(18,2), valorcartera NUMERIC(18,2), interescausado numeric(18,2), cuota INT, saldocuota NUMERIC(18,2));
DECLARE  @miCTE table (id int, id_cuota int, abonoCapital NUMERIC(18,2), interesM numeric(18,2),  interesC numeric(18,2), saldo numeric(18,2), interes numeric(18,2), Iva Numeric(18,2), interesCorriente Numeric(18,2),diasinteresM NUMERIC(18,2), abonofianza numeric(18,2), interescausado NUMERIC(18,2), cuota INT);
DECLARE  @tableforma TABLE (id int identity (1,1), id_forma BIGINT, valor numeric(18,2), voucher varchar(200));
DECLARE  @tablafact Table (id_pk int identity, id_fact VARCHAR(50), valor NUMERIC(18,2), porceInteres NUMERIC(18,2), capital BIT)
	
DECLARE  @tablaItems Table (id_pk int identity, id VARCHAR(50), InteresCorriente NUMERIC(18,2), interesMora NUMERIC(18,2));
DECLARE @tableReciboItems TABLE (id int identity(1,1),factura varchar(50),pagoTotalInteres bit, pagoTotalCorriente bit, cuota int)
	
BEGIN TRANSACTION
BEGIN TRY 
	SET @anomes = CONVERT(VARCHAR(6), @fecha, 112);
	SET @fechadoc = CONVERT(VARCHAR(10), @fecha, 120);
			
	IF EXISTS(SELECT 1 FROM [CNT].[Periodos] WHERE anomes = @anomes AND contabilidad = 0 )
				   RAISERROR('No es posible hacer recaudo cartera, el periodo no esta habilitado', 16,2)

	EXECUTE [Dbo].ST_ValidarPeriodo
		@fecha			= @fechadoc,
		@anomes			= @anomes,
		@mod			= 'C'
	
		SET @mydoc = @pagosXml
		
	EXEC sp_xml_preparedocument @idoc OUTPUT, @mydoc

	INSERT INTO @tablafact(id_fact, valor, porceInteres, capital)
	SELECT id_factura, valor, porceInteres, capital
	FROM OPENXML(@idoc,'/root/pago') 
	WITH (id_factura VARCHAR(30), valor NUMERIC(18,2), porceInteres NUMERIC(18,2), capital BIT)
	
	SET @rows = @@ROWCOUNT;
	EXEC sp_xml_removedocument @idoc;

	SELECT TOP 1 @numfactura = C.numfactura 
	FROM FIN.SaldoCliente_Cuotas C INNER JOIN @tablafact T ON T.id_fact = C.numfactura AND C.anomes = @anomes AND C.id_tercero = @id_cliente 
	WHERE DATEDIFF(DD, vencimiento_cuota, @fecha) > 0 AND T.capital != 0 AND estado != 0 AND cancelada = 0 
	
	IF (ISNULL(@numfactura, '') != '')
	BEGIN
		SET @error = 'La factura N° '+@numfactura+' tiene cuotas vencidas'
		RAISERROR(@error,16,0)
	END

	IF(@rows <= 0)
		RAISERROR('No hay facturas para recaudar. Verifique...',16,0)
	
	SET @portopemax = DBO.GETParametrosValor('PORCENTOPEMAX');
	
	INSERT INTO [FIN].[Recaudocartera](id_tipodoc, id_centrocostos, fecha, id_cliente, valorcliente, valorconcepto, id_conceptoDescuento, valorDescuento, cambio, detalle , estado , id_usercreated, id_userupdated)
	VALUES (@id_tipodoc, 
			@id_centrocosto, 
			@fecha, 
			@id_cliente, 
			@valorclie, 
			@valorconcepto, 
			@id_conceptoDescuento, 
			@valorDescuento, 
			@cambio, 
			@detalle, 
			Dbo.ST_FnGetIdList('PROCE'), 
			@id_user, 
			@id_user);
	
	SET @id_return = SCOPE_IDENTITY();

	WHILE(@rows >= @count)
	BEGIN
		/*Seleccionamos la factura que vamos a consultar */
		SELECT TOP 1 @numfactura = id_fact, @valorpagado = valor , @porceInteres = porceInteres, @capital = capital
		FROM @tablafact WHERE id_pk = @count; 			
		SET @id_factu = @count

		IF (@capital = 0)
		BEGIN
			INSERT INTO @tablacuotas (id_cuota,  porcen, saldo, capital, interescorriente, Iva, diasinteresM, interesmora,  saldofianza, valorcartera, interescausado, cuota, saldocuota)
			SELECT	F.id id_cuota, 
					F.porcentaje porcredito, 
					CuotaFianza - (AbonoFianza + abono) saldo, 
					F.acapital, 
					CONVERT(NUMERIC(18,2),CASE WHEN InteresCausado != 0 THEN InteresCausado - AbonoInteres ELSE (interes * (1+ (F.porcenIva /100))) - AbonoInteres END) interescorriente,	
					CONVERT(NUMERIC(18,2), (CONVERT(NUMERIC(18,2),CASE WHEN InteresCausado != 0 THEN InteresCausado - AbonoInteres ELSE (interes * (1+ (F.porcenIva /100))) - AbonoInteres END)) - (CONVERT(NUMERIC(18,2), CASE WHEN InteresCausado != 0 THEN InteresCausado - AbonoInteres ELSE (interes * (1+ (F.porcenIva /100))) - AbonoInteres END) / (1+(porcenIva/100))))   iva,				
					CASE WHEN DATEDIFF(DD,vencimiento_cuota, @fecha) <= 0 THEN 0 ELSE (DATEDIFF(DD,vencimiento_cuota,@fecha) - F.diasmora) END diasmora,
					CONVERT(NUMERIC(18,2), CASE WHEN DATEDIFF(DD,vencimiento_cuota, @fecha) <= 0 THEN 0 ELSE ((DATEDIFF(DD,vencimiento_cuota,@fecha) - F.diasmora) * (CASE WHEN F.cancelada ! = 0 THEN 0 ELSE (F.acapital- (F.abono - F.AbonoInteres)) END  *((@porceInteres/100)/30))) END) interesmora,											
					(valorfianza - AbonoFianza) saldofianza,
					CONVERT(NUMERIC(18,2),(acapital + CONVERT(NUMERIC(18,2),CASE WHEN InteresCausado != 0 THEN InteresCausado - AbonoInteres ELSE (interes * (1+ (F.porcenIva /100))) - AbonoInteres END)	- (abono+AbonoInteres))) valorcartera,
					CONVERT(NUMERIC(18,2),CASE WHEN InteresCausado != 0 THEN InteresCausado - AbonoInteres ELSE (interes * (1+ (F.porcenIva /100))) END) interescausado,
					F.cuota,
					CASE WHEN F.cancelada ! = 0 THEN 0 ELSE (F.acapital- (F.abono - F.AbonoInteres)) END saldocuota
			FROM FIN.SaldoCliente_Cuotas F WHERE F.anomes = @anomes AND cancelada = 0 AND F.id_tercero = @id_cliente ANd numfactura = @numfactura AND estado != 0
		END
		ELSE
		BEGIN
			INSERT INTO @tablacuotas (id_cuota,  porcen, saldo, capital, interescorriente, Iva, diasinteresM, interesmora,  saldofianza, valorcartera, interescausado, cuota, saldocuota)
			SELECT	F.id id_cuota, 
					F.porcentaje porcredito,
					CASE WHEN interescausado != 0 THEN CuotaFianza - (AbonoFianza + abono) ELSE F.acapital END saldo, 
					F.acapital, 
					CONVERT(NUMERIC(18,2),CASE WHEN InteresCausado != 0 THEN InteresCausado - AbonoInteres ELSE (interes * (1+ (F.porcenIva /100))) - AbonoInteres END) interescorriente,	
					CONVERT(NUMERIC(18,2), (CONVERT(NUMERIC(18,2),CASE WHEN InteresCausado != 0 THEN InteresCausado - AbonoInteres ELSE (interes * (1+ (F.porcenIva /100))) - AbonoInteres END)) - (CONVERT(NUMERIC(18,2), CASE WHEN InteresCausado != 0 THEN InteresCausado - AbonoInteres ELSE (interes * (1+ (F.porcenIva /100))) - AbonoInteres END) / (1+(porcenIva/100))))   iva,				
					CASE WHEN DATEDIFF(DD,vencimiento_cuota, @fecha) <= 0 THEN 0 ELSE (DATEDIFF(DD,vencimiento_cuota,@fecha) - F.diasmora) END diasmora,
					CONVERT(NUMERIC(18,2), CASE WHEN DATEDIFF(DD,vencimiento_cuota, @fecha) <= 0 THEN 0 ELSE ((DATEDIFF(DD,vencimiento_cuota,@fecha) - F.diasmora) * ((F.CuotaFianza-F.abono)  *((@porceInteres/100)/30))) END) interesmora,											
					(valorfianza - AbonoFianza) saldofianza,
					CONVERT(NUMERIC(18,2),(acapital + CONVERT(NUMERIC(18,2),CASE WHEN InteresCausado != 0 THEN InteresCausado - AbonoInteres ELSE (interes * (1+ (F.porcenIva /100))) - AbonoInteres END)	- (abono+AbonoInteres))) valorcartera,
					interescausado,
					F.cuota,
					(F.acapital- (F.abono - F.AbonoInteres)) saldocuota
			FROM FIN.SaldoCliente_Cuotas F WHERE F.anomes = @anomes AND cancelada = 0 AND F.id_tercero = @id_cliente ANd numfactura = @numfactura	
		END
		
		IF(@capital = 0)
		BEGIN
			;WITH miCTE (id, id_cuota, abonoCapital, interesM , saldo, interes, Iva, interescorriente, diasinteresC, diasinteresM, abonofianza, interescausado, cuota) AS (
					SELECT TOP 1 id, 
						id_cuota, 
						CONVERT(NUMERIC(18,8), CASE WHEN @valorpagado >= (C.saldo + interesmora) THEN C.saldo 
							 WHEN @valorpagado >= interesmora THEN @valorpagado - interesmora
							 ELSE 0 END) abonoCapital,

						CONVERT(NUMERIC(18,8), CASE WHEN @valorpagado >= interesmora THEN interesmora ELSE @valorpagado END) interesM,
						CONVERT(NUMERIC(18,8), CASE WHEN @valorpagado >= (C.saldo + interesmora) THEN @valorpagado - (C.saldo +interesmora) ELSE 0 END) saldo,
						C.interesmora interes,
						Iva,
						interescorriente,
						0 diasinteresC,
						CONVERT(NUMERIC(18,2), CASE WHEN @valorpagado >= interesmora THEN diasinteresM ELSE (@valorpagado / (saldocuota * ((@porceInteres/100)/30)))END) diasinteresM,
						CONVERT(NUMERIC(18,8),CASE WHEN @valorpagado >= (C.saldo + interesmora) THEN C.saldofianza 
							 WHEN (@valorpagado - C.interesmora) <= 0 THEN 0
							 ELSE (@valorpagado - C.interesmora) - (((@valorpagado - C.interesmora) / C.saldo ) * C.valorcartera) END) abonofianza,
						C.interescausado,
						C.cuota
						FROM @tablacuotas C
					UNION ALL
					SELECT T.id, 
						T.id_cuota, 
						CONVERT(NUMERIC(18,8), CASE WHEN M.saldo >= (T.saldo + T.interesmora) THEN T.saldo 
							 WHEN M.saldo >= T.interesmora THEN M.saldo - T.interesmora
							 ELSE 0 END) abonoCapital,
						CONVERT(NUMERIC(18,8), CASE WHEN M.saldo >= T.interesmora THEN T.interesmora ELSE M.saldo END) interesM,
						CONVERT(NUMERIC(18,8), CASE WHEN M.saldo >= (T.saldo + T.interesmora) THEN M.saldo - (T.saldo +interesmora) ELSE 0 END) saldo,
						T.interesmora interes,
						T.Iva,
						T.interescorriente,
						0 diasinteresC,
						CONVERT(NUMERIC(18,2), CASE WHEN M.saldo >= T.interesmora THEN T.diasinteresM ELSE (M.saldo / (T.saldocuota * ((@porceInteres/100)/30)))END )  diasinteresM,						
						CONVERT(NUMERIC(18,8),CASE WHEN M.saldo >= (T.saldo + T.interesmora) THEN t.saldofianza 
							 WHEN (M.saldo - T.interesmora) <= 0 THEN 0
							 ELSE (M.saldo -T.interesmora)- (((M.saldo - T.interesmora) / T.saldo) * T.valorcartera) END) abonofianza,
						T.interescausado,
						T.cuota
					FROM miCTE M INNER JOIN @tablacuotas T ON T.id = M.id +1
					WHERE M.saldo  > 0
			)
	
    		INSERT INTO @miCTE (id, id_cuota, abonoCapital, interesM, interesC, saldo, interes, Iva, interesCorriente, diasinteresM, abonofianza, interescausado, cuota)
			SELECT id, id_cuota, abonoCapital, interesM, 0, saldo, interes, Iva, interesCorriente, diasinteresM, abonofianza, interescausado, cuota FROM miCTE 
		END
		ELSE
		BEGIN
			;WITH miCTE (id, id_cuota, abonoCapital, interesM , saldo, interes, Iva, interescorriente, diasinteresC, diasinteresM, abonofianza, interescausado, cuota) AS (
					SELECT TOP 1 id, 
						id_cuota, 
						CONVERT(NUMERIC(18,8), CASE WHEN @valorpagado >= (C.saldo + interesmora) THEN C.saldo 
							 WHEN @valorpagado >= interesmora THEN @valorpagado - interesmora
							 ELSE 0 END) abonoCapital,

						CONVERT(NUMERIC(18,8), CASE WHEN @valorpagado >= interesmora THEN interesmora ELSE @valorpagado END) interesM,
						CONVERT(NUMERIC(18,8), CASE WHEN @valorpagado >= (C.saldo + interesmora) THEN @valorpagado - (C.saldo +interesmora) ELSE 0 END) saldo,
						C.interesmora interes,
						Iva,
						interescorriente,
						0 diasinteresC,
						diasinteresM,
						CASE WHEN C.interescausado != 0 THEN CONVERT(NUMERIC(18,8),CASE WHEN @valorpagado >= (C.saldo + interesmora) THEN C.saldofianza 
							 WHEN (@valorpagado - C.interesmora) = 0 THEN 0
							 ELSE (@valorpagado - C.interesmora) - (((@valorpagado - C.interesmora) / C.saldo ) * C.valorcartera) END) ELSE 0 END abonofianza,
						C.interescausado,
						C.cuota
						FROM @tablacuotas C order by id DESC
					UNION ALL
					SELECT T.id, 
						T.id_cuota, 
						CONVERT(NUMERIC(18,8), CASE WHEN M.saldo >= (T.saldo + T.interesmora) THEN T.saldo 
							 WHEN M.saldo >= T.interesmora THEN M.saldo - T.interesmora
							 ELSE 0 END) abonoCapital,
						CONVERT(NUMERIC(18,8), CASE WHEN M.saldo >= T.interesmora THEN T.interesmora ELSE M.saldo END) interesM,
						CONVERT(NUMERIC(18,8), CASE WHEN M.saldo >= (T.saldo + T.interesmora) THEN M.saldo - (T.saldo +interesmora) ELSE 0 END) saldo,
						T.interesmora interes,
						T.Iva,
						T.interescorriente,
						0 diasinteresC,
						T.diasinteresM,
						CASE WHEN T.interescausado != 0 THEN CONVERT(NUMERIC(18,8),CASE WHEN M.saldo >= (T.saldo + T.interesmora) THEN t.saldofianza 
							 WHEN (M.saldo - T.interesmora) = 0 THEN 0
							 ELSE (M.saldo -T.interesmora)- (((M.saldo - T.interesmora) / T.saldo) * T.valorcartera) END) ELSE 0 END abonofianza,
						T.interescausado,
						T.cuota
					FROM miCTE M INNER JOIN @tablacuotas T ON T.id = M.id -1
					WHERE M.saldo  > 0
			)
	
    		INSERT INTO @miCTE (id, id_cuota, abonoCapital, interesM, interesC, saldo, interes, Iva, interesCorriente, diasinteresM, abonofianza, interescausado, cuota)
			SELECT id, id_cuota, abonoCapital, interesM, 0, saldo, interes, Iva, interesCorriente, diasinteresM, abonofianza, interescausado, cuota FROM miCTE 
		END	

		INSERT INTO [FIN].[RecaudocarteraItems](id_recibo, id_factura, cuota, valorCuota, porcenInCorriente, valorIva, valorServicios, interesCorriente, diasInCorrientePagado ,pagoTotal_InCorriente, pagocuota, porceInMora, InteresMora, dias_interes_pagadoMora, pagoTotal_InMora, totalpagado, vencimiento_interes, id_user, cuotaVencimiento)
		SELECT	@id_return,
			@numfactura,
			E.cuota,
			C.CuotaFianza,
			C.porcentaje,
			CASE WHEN E.abonoCapital > 0 THEN CONVERT(NUMERIC(18,2), 	((E.abonoCapital - E.abonofianza)  * (100 - (C.acapital * 100 / (C.acapital + E.interescausado))) / 100) - (((E.abonoCapital - E.abonofianza)  * (100 - (C.acapital * 100 / (C.acapital + E.interescausado))) / 100) / (1+(C.porceniva / 100)))) ELSE 0 END,
		    CASE WHEN E.abonoCapital > 0 THEN E.abonofianza ELSE 0 END,					
			CASE WHEN E.abonoCapital > 0 THEN CONVERT(NUMERIC(18,2),(E.abonoCapital - E.abonofianza)  * (100 - (C.acapital * 100 / (C.acapital + E.interescausado))) / 100) ELSE 0 END,
			0,
			0,
			E.abonoCapital,
			@porceInteres,
			E.interesM,
			E.diasinteresM,
			0,
			E.abonoCapital + E.interesM ,
			convert(varchar, CAST(c.fechapagointeres as date), 112),
			@id_user,
			CONVERT(varchar, CAST(C.vencimiento_cuota as date), 112)
		FROM [FIN].SaldoCliente_Cuotas C 
		INNER JOIN @miCTE AS E ON C.id = E.id_cuota AND C.anomes = @anomes AND C.id_tercero = @id_cliente
		LEFT JOIN @tablaItems i on E.id_cuota=i.id 
		
		UPDATE C SET 
				C.abono = C.abono +( E.pagoCuota - E.valorServicios),
				C.cancelada = CASE WHEN @capital != 0 THEN 
								CASE WHEN E.interesCorriente = 0 AND C.acapital - E.pagoCuota = 0 THEN 1
									 ELSE 
										CASE WHEN(CuotaFianza - (AbonoFianza + abono + E.pagoCuota)) = 0 THEN 1 
										ELSE 0 END 
									 END
							  ELSE
								CASE WHEN (CuotaFianza - (AbonoFianza + abono + E.pagoCuota)) = 0 THEN 1 ELSE 0 END
							  END,
				C.diasmora = C.diasmora + E.dias_interes_pagadoMora, 
				C.diasintcorpagados = 0,
				C.AbonoInteres = C.AbonoInteres + E.interesCorriente,
				C.AbonoIntMora = ISNULL(C.AbonoIntMora, 0) + E.InteresMora,
				C.AbonoFianza = C.AbonoFianza + E.valorServicios
		FROM [FIN].SaldoCliente_Cuotas C INNER JOIN 
		[FIN].[RecaudocarteraItems] AS E ON E.id_factura = C.numfactura AND C.anomes = @anomes AND C.id_tercero = @id_cliente AND C.cuota = E.cuota AND C.estado != 0
		WHERE E.id_recibo = @id_return;
					
		UPDATE C SET 
				C.movCredito = C.movCredito + (E.pagoCuota - E.valorServicios),
				updated		 = GETDATE(),
				C.saldoActual= C.saldoAnterior + C.movdebito - (C.movCredito + (E.pagoCuota - E.valorServicios))
		FROM [CNT].SaldoCliente_Cuotas C INNER JOIN [FIN].[RecaudocarteraItems] AS E ON E.id_factura = C.nrofactura AND C.anomes = @anomes AND C.id_cliente = @id_cliente AND C.cuota = E.cuota
		WHERE E.id_recibo = @id_return;		
				
		SELECT @abonoCuota = ISNULL(SUM(pagocuota - valorServicios), 0), @abonoactual = ISNULL(SUM(pagocuota), 0)  FROM [FIN].[RecaudocarteraItems] WHERE id_recibo = @id_return AND id_factura = @numfactura;

		SET @id_DocumenSaldo = (SELECT TOP 1 C.id_documento FROM [FIN].SaldoCliente C  WHERE C.id = @id_factu);

		EXEC [FIN].[SaldoClientes]	@Opcion = 'I',	@anomes = @anomes,	@numfactura = @numfactura,	@id_cliente = @id_cliente,	@pago = @abonocuota, @id_user = @id_user, @pagofin = @abonoactual;
				
		DELETE FROM @tablacuotas
		DELETE FROM @miCTE
	
		SET @count+=1
	END
		
	SELECT @rows = @@ROWCOUNT, @count=1
	
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
	
	INSERT INTO [FIN].[RecaudoCarteraFormaPago](id_recibo, id_formapago, voucher, valor, codcuenta, id_user)
	SELECT @id_return, T.id_forma, T.voucher, T.valor, F.id_cuenta, @id_user
	FROM @tableforma T INNER JOIN FormaPagos F ON F.id = T.id_forma
				
	EXEC CNT.ST_MOVTransacciones @id = @id_return,@id_user = @id_user,@nombreView='[CNT].[VW_TRANSACIONES_RECAUDOCARTERA]';
				 
	EXEC CNT.ST_MOVSaldoCuenta @opcion='I',@id=@id_return,@id_user=@id_user,@nombreView='[CNT].[VW_TRANSACIONES_RECAUDOCARTERA]'
	
	EXEC CNT.ST_MOVSaldoTerceronew @opcion='I',@id=@id_return,@id_user=@id_user,@nombreView='[CNT].[VW_TRANSACIONES_RECAUDOCARTERA]'
						
COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);		
END CATCH

SELECT @id_return id;
