--liquibase formatted sql
--changeset ,JPAREDES:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
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
DECLARE  @mensaje VARCHAR(max),@opcionEntrada VARCHAR(4),@totalcredito NUMERIC(18,2),@id_tercero BIGINT,@id_ctaant BIGINT,@id_saldo BIGINT,@anticipo NUMERIC(18,2),@id_proveflete BIGINT=NULL,@pago NUMERIC(18,2)=0,@tipodocumento VARCHAR(2),@numfactura VARCHAR(50),@tabla VARCHAR(50),@sql NVARCHAR(MAX),@id_saldonew BIGINT,@nrofactura VARCHAR(50),@id_cuenta BIGINT,@id_entrada BIGINT,@financiero BIGINT,@valorTransaSQL NVARCHAR(MAX),@valorTransa NUMERIC(18,2);
DECLARE @sumatoria TABLE (valortransa NUMERIC(18,2))
BEGIN TRY
BEGIN TRANSACTION


	EXECUTE [Dbo].ST_ValidarPeriodo
	@fecha			= @fecha,
	@anomes			= @anomes,
	@mod			= 'C'	
	
   IF(@nombreView='CNT.VW_TRANSACIONES_DEVFACTURAS')
	BEGIN
		DECLARE @totaldevol NUMERIC(18,2),@valoranticipo NUMERIC(18,2),@totaldevolcredito NUMERIC(18,2),@id_forma BIGINT,@id_factura BIGINT
			
		SELECT @id_forma=F.id,@id_cuenta=F.id_cuenta  from FormaPagos F INNER JOIN ST_Listados S ON F.id_tipo=S.id WHERE S.nombre='Cartera cliente'
			
		SELECT @id_factura=F.id,@totaldevol = D.total-D.valoranticipo,@id_tercero=F.id_tercero,@id_ctaant=D.id_ctaant,@valoranticipo=D.valoranticipo,@anomes= @anomes,@numfactura=CONCAT(F.prefijo,'-',F.consecutivo) FROM MOVDevFactura D Inner Join MOVFactura F on D.id_factura=F.id WHERE D.id=@id
		SET @totaldevolcredito=dbo.FnVlrDescFP(@id_factura,@id_forma,@totaldevol)	

	END
	ELSE IF(@nombreView='CNT.VW_TRANSACIONES_ENTRADAS' or @nombreView='CNT.VW_TRANSACIONES_DEVENTRADAS' )
	BEGIN
		IF(@id_rev IS NULL)
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
						
			IF(@id_proveflete IS NOT NULL)
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
			
			IF(@id_proveflete IS NOT NULL)
				EXEC [CNT].[ST_MOVSaldoProveedor] @Opcion=@opcionEntrada, @id=@id_entrada ,@id_proveedor=@id_proveflete,@tipo='',@pago=@pagoflete,@id_Pagoprov=0,@id_user=@id_user,@anomes=@anomes 
		END
					EXEC [CNT].[ST_MOVRecalculoSaldo] @saldo='PROVEEDOR',@anomes=@anomes;
	END

	IF(@id_rev IS NULL)
	BEGIN
		SELECT @tabla = CASE @nombreView WHEN 'CNT.VW_TRANSACIONES_ENTRADAS' THEN 'dbo.MOVEntradas' 
										 WHEN 'CNT.VW_TRANSACIONES_DEVENTRADAS'  THEN 'MOVDevEntradas' 
										 WHEN 'CNT.VW_TRANSACIONES_AJUSTES'  THEN 'Dbo.MOVAjustes'  
										 WHEN 'CNT.VW_TRANSACIONES_TRASLADOS'  THEN 'Dbo.MOVTraslados' 
										 WHEN 'CNT.VW_TRANSACIONES_FACTURAS'  THEN 'dbo.MOVFactura' 
										 WHEN 'CNT.VW_TRANSACIONES_DEVFACTURAS'  THEN 'dbo.MOVDEVFactura' 
										 WHEN 'CNT.VW_TRANSACIONES_FACTURAS_OBSEQUIOS'  THEN 'dbo.MOVFactura'  END
			
			/*Valido si la transacciones esta cuadrada*/
		SET @valorTransaSQL = 'SELECT SUM(valor) FROM ' + @nombreView+N' WHERE ID=@ide'
		INSERT INTO @sumatoria
		EXEC sp_executesql @valorTransaSQL,N' @ide BIGINT',@ide=@id

		SELECT @valorTransa=valortransa FROM @sumatoria

		IF(@valorTransa=0)
		BEGIN
			
			EXEC CNT.ST_MOVTransacciones @id = @id,@id_user = @id_user,@nombreView=@nombreView;
			EXEC CNT.ST_MOVSaldos  @opcion='I',@id=@id,@id_user=@id_user,@nombreView=@nombreView
			
			--Despues de realizarse las respectivas transacciones se valida si el movmiento es de notacredito factura y se almacena en la tabla MOVdevfacturaformapago las formas de pago afectadas en la devolucion
			IF(@nombreView='CNT.VW_TRANSACIONES_DEVFACTURAS')
			BEGIN
				INSERT INTO dbo.MOVDevFacturaFormaPago (id_devolucion,id_factura,id_formapago,valor)
				SELECT @id,@id_factura,id_formapago,dbo.FnVlrDescFP(@id_factura,id_formapago,@totaldevol) FROM dbo.MOVFacturaFormaPago where id_factura=@id_factura and dbo.FnVlrDescFP(@id_factura,id_formapago,@totaldevol) is not null
				
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
		SELECT @tipodocumento=CASE @nombreView  WHEN 'CNT.VW_TRANSACIONES_ENTRADAS' THEN 'EN' 
												WHEN 'CNT.VW_TRANSACIONES_DEVENTRADAS'  THEN 'DC' 
												WHEN 'CNT.VW_TRANSACIONES_AJUSTES'  THEN 'AJ'  
												WHEN 'CNT.VW_TRANSACIONES_TRASLADOS'  THEN 'TR' ELSE '' END
			
		UPDATE [CNT].[TRANSACCIONES] SET ESTADO=Dbo.ST_FnGetIdList('REVER') WHERE nrodocumento=@id_rev and tipodocumento=@tipodocumento and anomes=@anomes;
		EXEC CNT.ST_MOVSaldos  @opcion='R',@id=@id,@id_user=@id_user,@nombreView=@nombreView, @tipodocumento = @tipodocumento,@anomes=@anomes
		
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
	PRINT @mensaje
	ROLLBACK TRANSACTION;
	EXEC [dbo].[ST_LogSaveContabilizacion] @id=@id,@mensaje=@mensaje,@id_user=@id_user,@nombreView=@nombreView	
			
END CATCH
