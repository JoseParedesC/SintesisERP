--liquibase formatted sql
--changeset ,kmartinez:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FIN].[ST_RefinanciacionFactura]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [FIN].[ST_RefinanciacionFactura] 	
GO

CREATE PROCEDURE [FIN].[ST_RefinanciacionFactura] 								 
@id_tipodoc			BIGINT,
@id_ccostos			BIGINT,
@fechadoc			SMALLDATETIME,
@id_tercero			BIGINT,
@cd_factu			VARCHAR(30),
@totalcredito		NUMERIC(18,2),
@numcuotas			INT,
@venini 			VARCHAR(10),
@id_formacred		BIGINT,
@vrlfianza          NUMERIC(18,2) = NULL,
@id_user			INT,
@id_ctaintmora		BIGINT
AS
/***************************************
*Nombre:		[FIN].[ST_RefinanciacionFactura] 
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		23/01/2021
*Desarrollador:  (KMARTINEZ)
*Descripcion:	SE realiza la refinanciacion de factura financieras
***************************************/
Declare @id_return INT,  @idestado INT, @anomes VARCHAR(6) = '',@fecha varchar(10), @numfactura varchar(30), @id_sald int, @IVA bit = 0, @porcenIva bigint = 0, @Tasaanual NUMERIC(18,2), @mensaje varchar(max), @id_saldo BIGINT;
DECLARE  @porcentaje NUMERIC(18, 2),  @id_ctafin BIGINT, @porintfin NUMERIC(18,2), @id_factura BIGINT, @valormora NUMERIC(18,0) = 0;
BEGIN TRY
BEGIN TRANSACTION
		
		SET @anomes = CONVERT(VARCHAR(6), @fechadoc, 112);
		SET @fecha = CONVERT(VARCHAR(10), @fechadoc, 120);

		SET @porcentaje = (SELECT TOP 1 valor FROM [dbo].[Parametros] WHERE codigo = 'PORCEINTERESMORA');

		SET @valormora = (SELECT 
		SUM(CASE WHEN DATEDIFF(DD,SC.vencimiento_cuota,getdate()) - diasmora < 0 OR SC.cancelada != 0
					 THEN 0 
					 ELSE ((((SC.CuotaFianza - (SC.abono + SC.AbonoFianza))* (@porcentaje/100))/30)* (DATEDIFF(DD,SC.vencimiento_cuota,getdate()) - SC.diasmora))
				END)
		FROM [FIN].[SaldoCliente_Cuotas] SC  
		WHERE SC.numfactura = @cd_factu AND SC.anomes = @anomes AND estado = 1 AND id_tercero = @id_tercero);
	
		SET @id_factura = (SELECT TOP 1 id FROM VW_MOVFacturas WHERE rptconsecutivo = @cd_factu);
		
		SELECT TOP 1 @id_ctafin = id_ctacredito, @porintfin = Porcentaje, @Tasaanual = Tasaanual,  @IVA = iva ,@porcenIva = CASE WHEN iva != 0 THEN PorcenIva ELSE 0 END  
		FROM FIN.LineasCreditos WHERE id = @id_formacred;

		SELECT TOP 1 @numfactura = @cd_factu, @id_sald = id FROM [SaldoCliente] WHERE id_cliente = @id_tercero AND nrofactura = @cd_factu AND anomes = @anomes
	
		EXECUTE [Dbo].ST_ValidarPeriodo
		@fecha			= @fecha,
		@anomes			= @anomes,
		@mod			= 'C'
		
		INSERT INTO [FIN].[RefinanciacionFact] (id_tipodoc, id_centrocostos, fechadoc, id_cliente,  id_factura, numfactura, totalcredito, cuotas, formapago, estado, id_user, id_cuenta, valorintmora) 
		VALUES(
				@id_tipodoc,
				@id_ccostos,
				REPLACE(@fechadoc,'-',''),
				@id_tercero,
				@id_factura,
				@numfactura,
				@totalcredito,
				@numcuotas,
				@id_formacred,
				Dbo.ST_FnGetIdList('PROCE'),
				@id_user,
				@id_ctaintmora,
				ISNULL(@valormora,0) );
 
		SET @id_return = SCOPE_IDENTITY();																																		  
 	
		IF(@totalcredito > 0)
		BEGIN
  			INSERT INTO [FIN].[RefinanciacionItems](id_refinan, id_cliente, id_factura,  numfactura, new, cuota, valorcuota, saldo, saldo_anterior, interes, acapital, valorFianza, tasaanual, porcentaje, fecha_inicial, vencimiento, fecha_pagointeres)
			SELECT @id_return, @id_tercero, @id_factura, @numfactura, 0, cuota, valorcuota, saldo, SaldoAnterior, interes, acapital, @vrlfianza, @Tasaanual, porcentaje, FechaInicio, vencimiento, vencimiento
					FROM [FIN].[ST_FnRecCuotasLineasCreditos] (@id_formacred, '', @totalcredito + ISNULL(@valormora,0), @numcuotas, 0, @venini, 0)
			UNION ALL
			SELECT  @id_return, @id_tercero, @id_factura, @numfactura, 1, cuota, vlrcuota, saldo, saldo_anterior, interes, acapital, CuotaFianza, Tasaanual, porcentaje, CONVERT(VARCHAR(10), fecha_inicial, 120) ,  CONVERT(VARCHAR(10), vencimiento_cuota, 120), CONVERT(VARCHAR(10), fechapagointeres, 120)
					FROM [FIN].[SaldoCliente_Cuotas]  WHERE  cancelada = 0 AND numfactura = @numfactura AND id_tercero = @id_tercero AND anomes = @anomes
			 		 
			UPDATE [FIN].[SaldoCliente_Cuotas] SET cancelada = 1 , estado = 0 WHERE anomes = @anomes and id_tercero=@id_tercero and numfactura = @numfactura;

 			INSERT INTO [FIN].[SaldoCliente_Cuotas](id_refinanciado, id_saldo, numfactura,  anomes, iva, porcenIva, cuota,  vlrcuota,  saldo, saldo_anterior, saldocuota,  interes,  acapital,  porcentaje, Tasaanual, fecha_inicial,  vencimiento_cuota, abono, fechapagointeres, id_user, cuotafianza, id_tercero, Valorfianza, estado)
			SELECT
				CASE WHEN MC.new = 0 THEN @id_return else 0 END,
				@id_sald,
				@numfactura,
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
				MC.tasaanual,
				REPLACE(mc.fecha_inicial,'-',''),
				REPLACE(mc.vencimiento,'-',''),
				0,
				REPLACE(mc.vencimiento,'-',''),
				@id_user,
				@vrlfianza,
				@id_tercero,
				@vrlfianza - (MC.valorcuota + CONVERT(NUMERIC(18,2), (MC.interes * @porcenIva / 100))),
				1
			FROM [FIN].[RefinanciacionItems] MC WHERE id_cliente = @id_tercero AND numfactura = @cd_factu AND MC.id_refinan = @id_return AND new = 0  

				UPDATE E SET
				E.updated			=   GETDATE(),
				E.fechavencimiento	=   GETDATE(),
				E.movCredito		=	E.movCredito + @totalcredito,
				E.movDebito			=	E.saldoActual + @totalcredito,
				E.id_user=@id_user FROM FIN.SaldoCliente E  WHERE id=@id_sald

	END
	 EXEC CNT.ST_MOVTransacciones @id = @id_return, @id_user = @id_user, @nombreView='[CNT].[VW_TRANSACIONES_REFINANCIACION]';
	 EXEC CNT.ST_MOVSaldos    @opcion='I',@id=@id_return,@id_user=@id_user,@nombreView='[CNT].[VW_TRANSACIONES_REFINANCIACION]'
			
 
	SELECT @id_return id, @id_factura id_factura
COMMIT TRANSACTION;
END TRY
BEGIN CATCH	
	ROLLBACK TRANSACTION;
	SET @mensaje = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@Mensaje,16,0);	
END CATCH
