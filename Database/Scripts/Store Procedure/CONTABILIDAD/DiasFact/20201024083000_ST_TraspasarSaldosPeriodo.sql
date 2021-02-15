--liquibase formatted sql
--changeset ,jtous:6 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_TranspasarSaldosPeriodo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [dbo].[ST_TranspasarSaldosPeriodo]
GO


CREATE PROCEDURE [dbo].[ST_TranspasarSaldosPeriodo]
	@periodoant		VARCHAR(10),
	@periodoactual	VARCHAR(10),
	@modulo			CHAR(1),
	@id_user		BIGINT
AS
/***************************************
*Nombre:		[Dbo].[ST_TranspasarSaldosPeriodo]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		02/10/20
*Desarrollador: (JTOUS)
--JTOUS: Agrego el traspaso de saldos del financiero.
***************************************/
Declare @ds_error Varchar(Max)
DECLARE @table TABLE (id int identity(1,1), id_existencia bigint, id_existenciaLote bigint)
BEGIN TRANSACTION
BEGIN TRY 
	
	DECLARE @cortegestion VARCHAR(6) = (SELECT MAX(anomes) FROM [CNT].[Periodos])	

	IF (@modulo = 'C')
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM CNT.SaldoCuenta WHERE anomes = @periodoactual)
		BEGIN
			INSERT INTO [CNT].[SaldoCuenta](anomes, id_cuenta, saldoanterior, movDebito, movCredito, saldoActual, id_user)
			SELECT @periodoactual, id_cuenta, saldoActual, 0 debito, 0 credito, saldoActual, @id_user id_user
			FROM CNT.VW_SaldoCuenta  WHERE anomes = @periodoant and ((cierre=0 and SUBSTRING(codigocuenta,1,1)not in(4,5,6)) or (SUBSTRING(codigocuenta,1,1)in(4,5,6) and cierre=1))
			
			INSERT INTO [CNT].[SaldoCliente] (anomes, id_cliente, id_documento, nrofactura, id_cuenta,fechaactual, fechavencimiento, saldoanterior, movDebito, movCredito, saldoActual, id_user)
			SELECT @periodoactual, id_cliente, id_documento, nrofactura,id_cuenta ,fechaactual, fechavencimiento, saldoActual, 0 movDebito, 0 movCredito, saldoActual, @id_user 
			FROM [CNT].[SaldoCliente] WHERE anomes = @periodoant

			INSERT INTO [CNT].[SaldoCliente_Cuotas] (anomes, id_cliente,nrofactura,id_cuenta, cuota, saldoAnterior,movdebito, movCredito, saldoActual,vencimiento_cuota, fechapagointeres,  cancelada, id_user)
			SELECT @periodoactual, id_cliente,nrofactura,id_cuenta, cuota, saldoAnterior,movdebito, movCredito,saldoActual, vencimiento_cuota, fechapagointeres,  cancelada, @id_user
			FROM [CNT].[SaldoCliente_Cuotas] WHERE anomes = @periodoant

			INSERT INTO [CNT].[SaldoProveedor] (anomes, id_proveedor, id_documento, nrofactura, id_cuenta,fechaactual, fechavencimiento, saldoanterior, movDebito, movCredito, saldoActual, id_user)
			SELECT @periodoactual, id_proveedor, id_documento, nrofactura,id_cuenta ,fechaactual, fechavencimiento, saldoActual, 0 movDebito, 0 movCredito, saldoActual, id_user
			FROM [CNT].[SaldoProveedor] WHERE anomes = @periodoant

			INSERT INTO [CNT].[SaldoTercero] (anomes, id_tercero, id_cuenta,fechaactual,  saldoanterior, movDebito, movCredito, saldoActual, id_user)
			SELECT @periodoactual, id_tercero, id_cuenta,fechaactual,  saldoActual, 0 movDebito, 0 movCredito, saldoActual, id_user
			FROM [CNT].[VW_SaldoTercero] S WHERE anomes = @periodoant and ((cierre=0 and SUBSTRING(S.codigocuenta,1,1)not in(4,5,6)) or (SUBSTRING(S.codigocuenta,1,1)in(4,5,6) and S.cierre=1))

			INSERT INTO [CNT].[SaldoCentroCosto] (anomes, id_centrocosto, id_cuenta,  saldoanterior, movDebito, movCredito, saldoActual, id_user)
			SELECT @periodoactual, id_centrocosto, id_cuenta,  saldoActual, 0 movDebito, 0 movCredito, saldoActual, id_user
			FROM [CNT].[VW_SaldoCentroCosto] S WHERE anomes = @periodoant and ((cierre=0 and SUBSTRING(S.codigocuenta,1,1)not in(4,5,6)) or (SUBSTRING(S.codigocuenta,1,1)in(4,5,6) and S.cierre=1))
			
			INSERT INTO [FIN].[saldocliente] (anomes, id_cliente, id_documento, nrofactura, fechaactual, fechavencimiento, saldoanterior, movDebito, movCredito, saldoActual, porcentaje, id_user)
			SELECT @periodoactual, id_cliente, id_documento, nrofactura, fechaactual, fechavencimiento, saldoActual, 0 movDebito, 0 movCredito, saldoActual, porcentaje, @id_user
			FROM [FIN].[saldocliente] WHERE anomes = @periodoant
			
			INSERT INTO [FIN].[SaldoCliente_Cuotas](anomes, iva, porcenIva, id_saldo, cuota, vlrcuota, saldo, saldo_anterior, saldocuota, interes, acapital, porcentaje, fecha_inicial, vencimiento_cuota, fechapagointeres, abono, cancelada, devolucion, id_user, [create], [update], numfactura, CuotaFianza, Valorfianza, AbonoFianza, InteresCausado, AbonoInteres, id_tercero, diasmora, diasintcorpagados, AbonoIntMora, id_refinanciado, Tasaanual, estado)
			SELECT  @periodoactual, iva, porcenIva, id_saldo, cuota, vlrcuota, saldo, saldo_anterior, saldocuota, interes, acapital, porcentaje, fecha_inicial, vencimiento_cuota, fechapagointeres, abono, cancelada, devolucion, id_user, GETDATE(), GETDATE(), numfactura, CuotaFianza, Valorfianza, AbonoFianza, InteresCausado, AbonoInteres, id_tercero, diasmora, diasintcorpagados, ISNULL(AbonoIntMora, 0), id_refinanciado, Tasaanual, estado
			FROM [FIN].[SaldoCliente_Cuotas] WHERE anomes = @periodoant
		END
		
		UPDATE [dbo].[Parametros] SET [valor] = @cortegestion WHERE codigo = 'FECHAGESTION';
	END
	ELSE IF (@modulo = 'I')
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM Dbo.SaldoExistencia WHERE anomes = @periodoant)
		BEGIN
			INSERT INTO Dbo.SaldoExistencia(anomes, id_articulo, id_bodega, SaldoExistencia, disponibilidad, costo, id_user)
			SELECT @periodoant, id_articulo, id_bodega, existencia, disponibilidad, costo, @id_user
			FROM Dbo.Existencia

			INSERT INTO [dbo].[SaldoExistenciaLoteSerie] (anomes, id_lote, serie, existencia, id_existencia, id_user)
			SELECT @periodoant, id_lote, serie, SL.existencia, SE.id, @id_user
			FROM ExistenciaLoteSerie SL INNER JOIN Existencia E ON SL.id_existencia = E.id
			INNER JOIN SaldoExistencia SE ON SE.id_articulo = E.id_articulo AND SE.id_bodega = E.id_bodega
			WHERE SE.anomes = @periodoant
		END
	END

COMMIT TRANSACTION;
END TRY
BEGIN CATCH
		ROLLBACK TRANSACTION;
	    SELECT @ds_error = ERROR_MESSAGE()
	    RAISERROR(@ds_error,16,1)
	    RETURN
END CATCH

