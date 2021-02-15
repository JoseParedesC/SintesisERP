--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_MOVRecibosCajaSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_MOVRecibosCajaSave]
GO

CREATE PROCEDURE [CNT].[ST_MOVRecibosCajaSave]
@id BIGINT = null,
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

--WITH ENCRYPTION
AS

/***************************************
*Nombre:		[CNT].[ST_MOVRecibosCajaSave]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		27/06/20
*Desarrollador: (Jeteme)

SP para Registrar un recibo de caja (pago de conceptos y recaudos)
***************************************/

BEGIN TRANSACTION
BEGIN TRY

	DECLARE  @id_return INT,@numeropagos INT, @error VARCHAR(MAX),@manejador int,@idoc INT,@cdoc INT,@mydoc xml,@valortotal numeric (18,2),@anomes VARCHAR(6),@conxml xml,@valorTransa NUMERIC(18,2),@abonoCuota NUMERIC (18,2),@fechadoc VARCHAR(10),@pagoTotalInteres Bit,@id_reciboitem int,@cuota int;
	DECLARE  @tablafact Table (id_pk int identity, id_fact VARCHAR(50),valor NUMERIC (18,2),totalInteres NUMERIC(18,2),porceInteres NUMERIC(6,2),dias int);
	DECLARE  @rows INT=0,@count INT=1,@id_factura VArchar(50),@id_cuota BIGINT,@valorCuota NUMERIC(18,2),@valorpagado numeric(18,2),@abonoactual numeric(18,2),@totalinteres NUMERIC(18,2),@porceInteres NUMERIC(6,2),@diasvenci int,@interes numeric(18,2);
	DECLARE  @tablacuotas Table (id int identity, nrocuota BIGINT,  cuota numeric(18,4), abono numeric(18,4),interes Numeric(18,2),interesxdia int,dias int);
	DECLARE  @miCTE table (id int,nrocuota int,abono numeric(18,2),tinteres numeric(18,2),saldo numeric(18,2),interes numeric(18,2),interesVlrdia Numeric(18,2),dias int);
	DECLARE @tableforma TABLE (id int identity (1,1), id_forma BIGINT, valor numeric(18,2), voucher varchar(200));
	DECLARE @tableReciboItems TABLE (id int identity(1,1),factura varchar(50),pagoTotalInteres bit,cuota int)

	SET @anomes = CONVERT(VARCHAR(6), @fecha, 112);
	SET @fechadoc = CONVERT(VARCHAR(10), @fecha, 120);

	EXECUTE [Dbo].ST_ValidarPeriodo
					@fecha			= @fechadoc,
					@anomes			= @anomes,
					@mod			= 'C'
	
	
	SET @mydoc=@pagosXml

	IF(Isnull(@id,0) = 0)
	BEGIN		
		INSERT INTO [CNT].[MOVReciboCajas]([id_tipodoc],[id_centrocostos],[fecha],[id_cliente], [valorcliente],[valorconcepto],[id_conceptoDescuento],[valorDescuento],[cambio],[detalle] ,[estado] ,[id_usercreated],[id_userupdated])
		VALUES (@id_tipodoc,@id_centrocosto,@fecha,@id_cliente,@valorclie,@valorconcepto,@id_conceptoDescuento,@valorDescuento,@cambio,@detalle ,Dbo.ST_FnGetIdList('PROCE'),@id_user,@id_user);
		SET @id = SCOPE_IDENTITY();
	 END
	    EXEC sp_xml_preparedocument @idoc OUTPUT, @mydoc
		INSERT INTO @tablafact(id_fact,valor,totalInteres,porceInteres,dias)
		SELECT id_factura,valor,interes,porceInteres,dias FROM OPENXML(@idoc,'/root/pago') WITH (id_factura VARCHAR(50),valor NUMERIC (18,2),interes NUMERIC(18,2),porceInteres NUMERIC(6,2),dias int)
			
		SET @rows = @@ROWCOUNT;

			WHILE(@rows >= @count)
			BEGIN
				SELECT  @id_factura=  id_fact ,@valorpagado=valor,@porceInteres=porceInteres,@diasvenci=dias     FROM @tablafact WHERE id_pk=@count/*Seleccionamos la factura que vamos a consultar */
				delete from @miCTE
				DELETE FROM @tablacuotas
				INSERT INTO @tablacuotas (nrocuota, cuota, abono,interes,dias)
				SELECT F.cuota, (saldoAnterior+movdebito), movCredito,
				ROUND(((saldoActual)*(@porceInteres/100)/30) *( (case when datediff(day,fechapagointeres,getdate())<0 then 0 else datediff(day,fechapagointeres,getdate()) end)-(select ISNULL(sum(diasinterespagados),0) from cnt.MOVReciboCajasItems I INNER JOIN CNT.MOVReciboCajas R ON I.id_recibo=R.id where I.id_factura=F.nrofactura AND cuota=F.cuota and R.estado=Dbo.ST_FnGetIdList('PROCE')))-(((select ISNULL(SUM(pagoInteres),0) from cnt.MOVReciboCajasItems I Inner JOIN cnt.MOVReciboCajas R ON R.id=I.id_recibo  where I.id_factura=F.nrofactura AND cuota=F.cuota  and R.estado=Dbo.ST_FnGetIdList('PROCE') and I.pagototalinteres=0))),0) interes,
				(case when datediff(day,fechapagointeres,getdate())<0 then 0 else datediff(day,fechapagointeres,getdate()) end)-(select ISNULL(sum(diasinterespagados),0) from cnt.MOVReciboCajasItems I INNER JOIN CNT.MOVReciboCajas R ON I.id_recibo=R.id where I.id_factura=F.nrofactura AND cuota=F.cuota and R.estado=Dbo.ST_FnGetIdList('PROCE'))
				FROM CNT.SaldoCliente_Cuotas F  WHERE F.nrofactura = @id_factura AND cancelada =0 and id_devolucion is null AND F.id_nota is null and F.anomes=@anomes
				
				
				;WITH miCTE (id, nrocuota, abono,tinteres ,saldo,interes,dias) AS (
				   SELECT TOP 1 id, 
								nrocuota, 
								CONVERT(NUMERIC(18,4),case when interes>0 then (CASE WHEN @valorpagado > (cuota-abono+interes) THEN (cuota-abono) ELSE (case when @valorpagado<=interes then 0 else @valorpagado-interes end) END) else (CASE WHEN @valorpagado > (cuota-abono) THEN (cuota-abono) ELSE @valorpagado END ) END), 
								CONVERT(NUMERIC(18,4),case when interes>0 then (CASE WHEN @valorpagado > (cuota-abono+interes) THEN (interes) ELSE (CASE WHEN @valorpagado<=interes then @valorpagado else interes END) END) ELSE 0 end ), 
								CONVERT(NUMERIC(18,4),case when interes>0 then (CASE WHEN @valorpagado > (cuota-abono+interes) THEN @valorpagado - (cuota-abono+interes) ELSE 0.0000 END) else (CASE WHEN @valorpagado > (cuota-abono) THEN @valorpagado - (cuota-abono) ELSE 0.0000 END) END),
								interes,dias from @tablacuotas
				   UNION ALL
				    SELECT 
						T.id,
						T.nrocuota, 
						CONVERT(NUMERIC(18,4),case when T.interes>0  then( CASE WHEN saldo > (T.cuota-T.abono+T.interes) THEN (T.cuota-T.abono) ELSE (case when saldo<=T.interes then 0 else saldo-T.interes end) END) else (CASE WHEN saldo > (T.cuota-T.abono) THEN (T.cuota-T.abono) ELSE saldo END) END), 
						CONVERT(NUMERIC(18,4),case when T.interes>0 then (CASE WHEN  saldo > (T.cuota-T.abono+T.interes) THEN (T.interes) ELSE (CASE WHEN saldo<=T.interes then saldo else T.interes END) END) ELSE 0 end ), 
						CONVERT(NUMERIC(18,4),case when T.interes>0  then (CASE WHEN saldo > (T.cuota-T.abono+T.interes) THEN saldo - (T.cuota-T.abono+T.interes) ELSE 0 END) else (CASE WHEN saldo > (T.cuota-T.abono+T.interes) THEN saldo - (T.cuota-T.abono+T.interes) ELSE 0 END) END),
						T.interes,T.dias
				   FROM miCTE M INNER JOIN @tablacuotas T ON T.id = M.id +1
				   WHERE saldo  > 0)
				  
    			   INSERT INTO @miCTE (id, nrocuota, abono,tinteres ,saldo,interes,dias)
				   SELECT * FROM miCTE
				
					
				IF((SELECT TOP 1 SALDO FROM @miCTE ORDER BY ID DESC)>0)
				RAISERROR('El Valor Pagado Es Mayor A La Deuda.',16,0);

				SELECT @abonoCuota= SUM(abono)  from @miCTE;
				
			
			
				INSERT INTO CNT.MOVReciboCajasItems (id_recibo,id_factura,cuota,valorCuota,pagocuota,porceInteres,pagoInteres,totalpagado,vencimiento_interes,diasinterespagados,pagototalinteres,id_user)
				SELECT				@id,
									@id_factura,
									E.nrocuota,
									C.movdebito,
									E.abono,
									@porceInteres,
									E.tinteres,
									E.abono+E.tinteres,
									convert(varchar, CAST(c.fechapagointeres as date), 23),
									iif(E.interes=E.tinteres,E.dias,0),
									iif(E.interes=E.tinteres,1,0),
									 @id_user
									FROM CNT.SaldoCliente_Cuotas C 	INNER JOIN @miCTE AS E ON C.cuota = E.nrocuota AND C.nrofactura = @id_factura AND C.anomes=@anomes and C.id_nota is null;
			
			
				UPDATE C SET 
				C.movCredito	 += E.abono, 
				C.saldoActual     = (C.saldoAnterior+C.movdebito)-(C.movCredito+E.abono),
				C.cancelada		  = CASE WHEN (C.saldoAnterior+C.movdebito) - (C.movCredito + E.abono) = 0 THEN 1 ELSE 0 END,
				c.before          =c.changed,
				c.changed         =0
				FROM CNT.SaldoCliente_Cuotas C 	INNER JOIN @miCTE AS E ON C.cuota = E.nrocuota AND C.nrofactura = @id_factura and C.anomes=@anomes and C.id_nota is null and id_devolucion is null;
					
				EXEC CNT.ST_MOVSaldoCliente @Opcion='I',@id=0,@id_cliente=@id_cliente,@pago=@abonoCuota,@totalcredito=0,@id_user=@id_user,@consecutivo=@id_factura,@anomes=@anomes
							
				SET @count+=1
			END

			
			INSERT INTO @tableReciboItems (factura,pagoTotalInteres,cuota)
			SELECT id_factura,pagototalinteres,cuota FROM CNT.MOVReciboCajasItems WHERE id_recibo=@id
		
			SELECT @rows = @@ROWCOUNT, @count=1

			WHILE (@rows >= @count) 
			BEGIN
				
				SELECT @id_factura=factura,@pagoTotalInteres=pagototalinteres,@cuota=cuota FROM @tableReciboItems WHERE id=@count

				IF(@pagoTotalInteres=1)
				UPDATE CNT.MOVReciboCajasItems SET pagototalinteres=1 WHERE id_factura=@id_factura AND CUOTA=@cuota				

				SET @count+=1
			END

			IF(@conceptosxml!='')
			BEGIN
			 SET @conxml=@conceptosxml
			 EXEC sp_xml_preparedocument @cdoc OUTPUT, @conxml


			 INSERT INTO CNT.MovReciboCajasConcepto(id_recibo,id_concepto,valor,id_usercreated)
			 SELECT @id,id_concepto,valor,@id_user FROM OPENXML(@cdoc,'/items/item') WITH (id_concepto INT,valor NUMERIC (18,2))

			 END

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

			INSERT INTO CNT.MOVReciboCajasFormaPago(id_recibo, id_formapago, voucher, valor, codcuenta, id_user)
			SELECT @id, T.id_forma, T.voucher, T.valor, F.id_cuenta, @id_user
			FROM @tableforma T INNER JOIN FormaPagos F ON F.id = T.id_forma

			 EXEC CNT.ST_MOVTransacciones @id=@id,@id_user=@id_user,@nombreView='CNT.VW_TRANSACIONES_RECIBOCAJA'
			 EXEC CNT.ST_MOVSaldoCuenta @opcion='I',@id=@id,@id_user=@id_user,@nombreView='CNT.VW_TRANSACIONES_RECIBOCAJA'
			 EXEC CNT.ST_MOVSaldoTerceronew @opcion='I',@id=@id,@id_user=@id_user,@nombreView='CNT.VW_TRANSACIONES_RECIBOCAJA'
		
			 SET @valorTransa=(SELECT SUM(VALOR) FROM CNT.Transacciones WHERE tipodocumento='RC' AND nrodocumento=@id)


			 IF(@valorTransa!=0)
			 RAISERROR('Movimiento Descuadrado ',16,0);

			 EXEC [CNT].[ST_MOVRecalculoSaldo] @saldo='CLIENTE',@anomes=@anomes;
			

			select @id id
	
COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);		
	ROLLBACK TRANSACTION;
END CATCH

SELECT @id_return;