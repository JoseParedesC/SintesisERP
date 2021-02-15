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
	
   IF(@nombreView='CNT.VW_TRANSACIONES_DEVFACTURAS')
	BEGIN
		DECLARE @totaldevol NUMERIC(18,2),@valoranticipo NUMERIC(18,2),@totaldevolcredito NUMERIC(18,2),@id_forma BIGINT,@id_factura BIGINT
			
		SELECT @id_forma=F.id,@id_cuenta=F.id_cuenta  from FormaPagos F inner join ST_Listados S ON F.id_tipo=S.id where S.nombre='Cartera cliente'
			
		SELECT @id_factura=F.id,@totaldevol = D.total-D.valoranticipo,@id_tercero=F.id_tercero,@id_ctaant=D.id_ctaant,@valoranticipo=D.valoranticipo,@anomes= @anomes,@numfactura=CONCAT(F.prefijo,'-',F.consecutivo) FROM MOVDevFactura D Inner Join MOVFactura F on D.id_factura=F.id WHERE D.id=@id
		SET @totaldevolcredito=dbo.FnVlrDescFP(@id_factura,@id_forma,@totaldevol)
	

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
			EXEC CNT.ST_MOVSaldos  @opcion='I',@id=@id,@id_user=@id_user,@nombreView=@nombreView,@anomes=@anomes;
			
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
		SELECT @tipodocumento=CASE @nombreView When 'CNT.VW_TRANSACIONES_ENTRADAS' Then 'EN' When 'CNT.VW_TRANSACIONES_DEVENTRADAS'  Then 'DC' When 'CNT.VW_TRANSACIONES_AJUSTES'  Then 'AJ'  When 'CNT.VW_TRANSACIONES_TRASLADOS'  Then 'TR' ELSE '' END
			
		
		
		UPDATE [CNT].[TRANSACCIONES] SET ESTADO=Dbo.ST_FnGetIdList('REVER') WHERE nrodocumento=@id_rev and tipodocumento=@tipodocumento and anomes=@anomes;
		EXEC CNT.ST_MOVSaldos  @opcion='R',@id=@id_rev,@id_user=@id_user,@nombreView=@nombreView, @tipodocumento = @tipodocumento,@anomes=@anomes

	
		
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
	print @mensaje
	ROLLBACK TRANSACTION;
	EXEC [dbo].[ST_LogSaveContabilizacion] @id=@id,@mensaje=@mensaje,@id_user=@id_user,@nombreView=@nombreView	
			
END CATCH

GO


