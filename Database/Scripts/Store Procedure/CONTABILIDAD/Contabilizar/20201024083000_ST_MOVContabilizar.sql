--liquibase formatted sql
--changeset ,jteheran:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_MOVContabilizar]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_MOVContabilizar]
GO
CREATE PROCEDURE [CNT].[ST_MOVContabilizar] 
	-- Add the parameters for the stored procedure here
	@id BIGINT ,
	@id_user INT,
	@fecha VARCHAR(10),
	@anomes VARCHAR(6),
	@nombreView varchar(50),
	@id_rev BIGINT = NULL
AS
DECLARE  @mensaje varchar(max),@opcionEntrada VARCHAR(4),@totalcredito NUMERIC(18,2),@id_tercero BIGINT,@id_ctaant BIGINT,@id_saldo BIGINT,@anticipo NUMERIC(18,2),@id_proveflete BIGINT=NULL,@pago NUMERIC(18,2)=0,@tipodocumento VARCHAR(2),@numfactura VARCHAR(50),@tabla VARCHAR(50),@sql NVARCHAR(MAX),@id_saldonew BIGINT,@nrofactura VARCHAR(50),@id_cuenta BIGINT,@id_entrada BIGINT,@financiero BIGINT,@valorTransaSQL NVARCHAR(MAX),@valorTransa NUMERIC(18,2);
declare @sumatoria table (valortransa numeric(18,2))
BEGIN TRY
BEGIN TRANSACTION


	EXECUTE [Dbo].ST_ValidarPeriodo
	@fecha			= @fecha,
	@anomes			= @anomes,
	@mod			= 'C'	
	
	IF(@nombreView='CNT.VW_TRANSACIONES_FACTURAS')
	BEGIN
		SELECT @totalcredito=totalcredito,@id_tercero=id_tercero,@id_ctaant=id_ctaant,@anticipo=valoranticipo,@financiero=PagoFinan FROM MOVFactura WHERE id=@id
		
		IF(@totalcredito > 0)
		BEGIn		
			EXEC CNT.ST_MOVSaldoCliente @Opcion='I', @id=@id ,@id_cliente=@id_tercero,@pago=0,@totalcredito=@totalcredito,@id_user=@id_user, @anomes=@anomes , 
			@id_saldocli = @id_saldo OUTPUT,@nroFactura = @nroFactura OUTPUT, @id_cuenta = @id_cuenta OUTPUT
		END

		IF(@totalcredito >0 AND @financiero is null)
		BEGIN
			INSERT INTO [CNT].[SaldoCliente_Cuotas](id_cliente,nrofactura,id_cuenta,anomes ,cuota,saldoAnterior,movdebito, movCredito,saldoActual,vencimiento_cuota, fechapagointeres,id_user)
			SELECT @id_tercero,@nrofactura,@id_cuenta,@anomes ,C.cuota,0 ,C.valorcuota, 0,c.valorcuota,C.vencimiento,C.vencimiento,@id_user 
			FROM MovFacturaCuotas C where id_factura=@id
		END
		ELSE 
		BEGIN
			IF(@financiero is not null)
			BEGIN
				INSERT INTO [CNT].[SaldoCliente_Cuotas](id_cliente,nrofactura,id_cuenta,anomes ,cuota,saldoAnterior,movdebito, movCredito,saldoActual,vencimiento_cuota, fechapagointeres,id_user)
				SELECT @id_tercero, @nrofactura, @id_cuenta, @anomes ,C.cuota,0 ,C.acapital, 0,c.acapital, REPLACE(C.vencimiento, '-',''), REPLACE(C.vencimiento, '-',''), @id_user 
				FROM MovFacturaCuotas C where id_factura = @id
				
			END
		END

		EXEC [CNT].[ST_MOVRecalculoSaldo] @saldo='CLIENTE',@anomes=@anomes;
			
	END
	ELSE IF(@nombreView='CNT.VW_TRANSACIONES_DEVFACTURAS')
	BEGIN
		DECLARE @totaldevol NUMERIC(18,2),@valoranticipo NUMERIC(18,2),@totaldevolcredito NUMERIC(18,2),@id_forma BIGINT,@id_factura BIGINT
			
		SELECT @id_forma=F.id,@id_cuenta=F.id_cuenta  from FormaPagos F inner join ST_Listados S ON F.id_tipo=S.id where S.nombre='Cartera cliente'
			
		SELECT @id_factura=F.id,@totaldevol = D.total-D.valoranticipo,@id_tercero=F.id_tercero,@id_ctaant=D.id_ctaant,@valoranticipo=D.valoranticipo,@anomes= @anomes,@numfactura=CONCAT(F.prefijo,'-',F.consecutivo) FROM MOVDevFactura D Inner Join MOVFactura F on D.id_factura=F.id WHERE D.id=@id
		SET @totaldevolcredito=dbo.FnVlrDescFP(@id_factura,@id_forma,@totaldevol)
			
		SELECT TOP 1 @id_saldo = id FROM [CNT].[SaldoTercero] WHERE id_tercero = @id_tercero AND id_cuenta = @id_ctaant AND anomes = @anomes

		IF( @totaldevolcredito is not NULL)
		BEGIN
						
			UPDATE S
			SET S.movDebito   = 2*S.movDebito+(S.saldoanterior-S.MOVCredito-@totaldevolcredito),
				S.movCredito  = S.movCredito+ S.saldoActual,
				S.saldoActual = 2*(S.saldoanterior-S.movCredito+S.movDebito)-@totaldevolcredito-S.saldoActual,
				S.changed     = 0
			FROM cnt.saldocliente S  where id_cliente=@id_tercero and nrofactura=@numfactura and id_cuenta=@id_cuenta and id_nota is null AND S.anomes=@anomes
			
			EXEC [CNT].[ST_MOVReajusteCuotas] @id_cliente=@id_tercero,@nrofactura=@numfactura,@id_cuenta=@id_cuenta,@id_user=@id_user,@anomes=@anomes,@totaldevolucion=@totaldevolcredito,@id_nota=@id
		END
	END
	ELSE IF(@nombreView='CNT.VW_TRANSACIONES_ENTRADAS' or @nombreView='CNT.VW_TRANSACIONES_DEVENTRADAS' )
	BEGIN
		IF(@id_rev is NULL)
		BEGIN
			IF(@nombreView='CNT.VW_TRANSACIONES_ENTRADAS')
			BEGIN
				SELECT @id_proveflete=id_proveflete,@id_tercero=id_proveedor,@pago=0,@opcionEntrada='I',@numfactura=numfactura FROM dbo.MOVEntradas WHERE id=@id
			END
			ELSE IF(@nombreView='CNT.VW_TRANSACIONES_DEVENTRADAS')
			BEGIN
				SELECT @id_tercero=E.id_proveedor,@pago=D.valor-ISNULL(D.valoranticipo,0),@opcionEntrada='DI',@id_entrada=E.id,@numfactura=numfactura FROM dbo.MOVDEVEntradas D INNER JOIN dbo.MOVEntradas E ON D.id_entrada=E.id WHERE D.id=@id
			END
			SET @id_entrada=IIF(@nombreView='CNT.VW_TRANSACIONES_DEVENTRADAS',@id_entrada,@id)

			EXEC CNT.ST_MOVSaldoProveedor
			@Opcion			= @opcionEntrada, 
			@id				= @id_entrada, 
			@id_proveedor	= @id_tercero, 
			@tipo			= 'E', 
			@pago			= @pago, 
			@id_Pagoprov	= 0, 
			@id_user		= @id_user,
			@anomes			= @anomes,
			@nroFactura		= @numfactura;
						
			IF(@id_proveflete is not null)
			BEGIN
				EXEC CNT.ST_MOVSaldoProveedor
					@Opcion			= 'I', 
					@id				= @id_entrada, 
					@id_proveedor	= @id_proveflete, 
					@tipo			= 'I', 
					@pago			= 0, 
					@id_Pagoprov	= 0, 
					@id_user		= @id_user,
					@anomes			= @anomes,
					@nroFactura		= @numfactura;
			END
			
		END 
		ELSE
		BEGIN
			DECLARE @pagoflete NUMERIC(18,2)		

			IF(@nombreView='CNT.VW_TRANSACIONES_ENTRADAS')
				SELECT @id_proveflete=id_proveflete,@id_tercero=id_proveedor,@pago=IIF(id_proveflete IS NULL,valor,valor-flete),@opcionEntrada='ER',@pagoflete=flete+ivaflete,@id_entrada=@id_rev FROM dbo.MOVEntradas WHERE id=@id
						
			IF(@nombreView='CNT.VW_TRANSACIONES_DEVENTRADAS')
				SELECT @id_tercero=E.id_proveedor,@pago=D.valor,@opcionEntrada='RDI',@id_entrada=E.id FROM dbo.MOVDEVEntradas D INNER JOIN dbo.MOVEntradas E ON D.id_entrada=E.id WHERE D.id=@id
								
			EXEC [CNT].[ST_MOVSaldoProveedor] @Opcion=@opcionEntrada, @id=@id_entrada ,@id_proveedor=@id_tercero,@tipo='',@pago=@pago,@id_Pagoprov=0,@id_user=@id_user,@anomes=@anomes 
			
			IF(@id_proveflete is not NULL)
				EXEC [CNT].[ST_MOVSaldoProveedor] @Opcion=@opcionEntrada, @id=@id_entrada ,@id_proveedor=@id_proveflete,@tipo='',@pago=@pagoflete,@id_Pagoprov=0,@id_user=@id_user,@anomes=@anomes 
		END
					EXEC [CNT].[ST_MOVRecalculoSaldo] @saldo='PROVEEDOR',@anomes=@anomes;
	END

	IF(@id_rev is null)
	BEGIN
		SELECT @tabla = CASE @nombreView When 'CNT.VW_TRANSACIONES_ENTRADAS' Then 'dbo.MOVEntradas' When 'CNT.VW_TRANSACIONES_DEVENTRADAS'  Then 'MOVDevEntradas' When 'CNT.VW_TRANSACIONES_AJUSTES'  Then 'Dbo.MOVAjustes'  When 'CNT.VW_TRANSACIONES_TRASLADOS'  Then 'Dbo.MOVTraslados' When 'CNT.VW_TRANSACIONES_FACTURAS'  Then 'dbo.MOVFactura' When 'CNT.VW_TRANSACIONES_DEVFACTURAS'  Then 'dbo.MOVDEVFactura'  END
			
			/*Valido si la transacciones esta cuadrada*/
		SET @valorTransaSQL = 'SELECT SUM(valor) FROM ' + @nombreView+N' WHERE ID=@ide'
		insert into @sumatoria
		EXEC sp_executesql @valorTransaSQL,N' @ide BIGINT',@ide=@id

		SELECT @valorTransa=valortransa FROM @sumatoria

		IF(@valorTransa=0)
		BEGIN
			
			EXEC CNT.ST_MOVTransacciones @id = @id,@id_user = @id_user,@nombreView=@nombreView;
			
			EXEC CNT.ST_MOVSaldoCuenta @opcion='I',@id=@id,@id_user=@id_user,@nombreView=@nombreView

			EXEC CNT.ST_MOVSaldoTerceronew @opcion='I',@id=@id,@id_user=@id_user,@nombreView=@nombreView
			
					--Despues de realizarse las respectivas transacciones se valida si el movmiento es de notacredito factura y se almacena en la tabla MOVdevfacturaformapago las formas de pago afectadas en la devolucion
			IF(@nombreView='CNT.VW_TRANSACIONES_DEVFACTURAS')
			BEGIN
				INSERT INTO dbo.MOVDevFacturaFormaPago (id_devolucion,id_factura,id_formapago,valor)
				SELECT @id,@id_factura,id_formapago,dbo.FnVlrDescFP(@id_factura,id_formapago,@totaldevol) FROM dbo.MOVFacturaFormaPago where id_factura=@id_factura and dbo.FnVlrDescFP(@id_factura,id_formapago,@totaldevol) is not null
				--Se acredita en cada una de las cuotas el valor de debito para asi cancelar las cuotas anteriores, se identifican con el id de la devolucion
				UPDATE CNT.SaldoCliente_Cuotas SET movCredito=movCredito+movdebito,saldoActual=saldoAnterior+(movdebito)-(movCredito+movdebito),changed=0 where id_devolucion=@id
				--Recalculo de las tablas de SaldoCliente y SaldoclienteCuotas
				EXEC [CNT].[ST_MOVRecalculoSaldo] @saldo='CLIENTE',@anomes=@anomes;
			END
			
			--se actualiza el campo contabilizado de la tabla q se referencie dependiendo de la vista que recibio como parametros
			SET @sql = 'UPDATE ' + @tabla+N' SET contabilizado=1 WHERE ID=@ide'
			EXEC sp_executesql @sql,N' @ide BIGINT',@ide=@id
		END 
		ELSE 
		BEGIN
			RAISERROR('Documento Descuadrado',16,0)

		END
	END 
	ELSE
	BEGIN
		SELECT @tipodocumento=CASE @nombreView When 'CNT.VW_TRANSACIONES_ENTRADAS' Then 'EN' When 'CNT.VW_TRANSACIONES_DEVENTRADAS'  Then 'DC' When 'CNT.VW_TRANSACIONES_AJUSTES'  Then 'AJ'  When 'CNT.VW_TRANSACIONES_TRASLADOS'  Then 'TR' ELSE '' END
			
		UPDATE [CNT].[TRANSACCIONES] SET ESTADO=Dbo.ST_FnGetIdList('REVER') WHERE nrodocumento=@id_rev and tipodocumento=@tipodocumento and anomes=@anomes;
		EXEC CNT.ST_MOVSaldoCuenta      @opcion='R', @id=@id_rev, @id_user=@id_user, @nombreView=@nombreView, @tipodocumento = @tipodocumento,@anomes=@anomes
		EXEC CNT.ST_MOVSaldoTerceronew  @opcion='R', @id=@id_rev, @id_user=@id_user, @nombreView=@nombreView, @tipodocumento = @tipodocumento,@anomes=@anomes
			 
		--Valido si los movimientos que se revirtieron afectan las tablas saldo y si es asi haga el recalculo de saldos
		IF(@tipodocumento='EN' or @tipodocumento='DC')
			EXEC [CNT].[ST_MOVRecalculoSaldo] @saldo='PROVEEDOR',@anomes=@anomes;
		ELSE IF(@nombreview='CNT.VW_TRANSACIONES_DEVFACTURAS' OR @nombreview='VW_TRANSACIONES_FACTURAS' AND ((@totalcredito+@totaldevolcredito>0)))
			EXEC [CNT].[ST_MOVRecalculoSaldo] @saldo='CLIENTE',@anomes=@anomes;
					
	END
COMMIT TRANSACTION;
END TRY
BEGIN CATCH	
	SET @mensaje = 'Error: '+ERROR_MESSAGE();	
	ROLLBACK TRANSACTION;
	EXEC [dbo].[ST_LogSaveContabilizacion] @id=@id,@mensaje=@mensaje,@id_user=@id_user,@nombreView=@nombreView	
			
END CATCH
GO