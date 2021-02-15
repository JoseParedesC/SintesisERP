--liquibase formatted sql
--changeset ,JPAREDES:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[GSC].[ST_FacturasList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [GSC].[ST_FacturasList]
GO 
CREATE PROCEDURE [GSC].[ST_FacturasList]
@id_tercero BIGINT

AS


BEGIN TRY
/***************************************
*Nombre:		[GSC].[ST_FacturasList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		12/11/2020
*Desarrollador: jparedes
*Descripcion:	Lista las facturas dependiendo
				del tercero que lo solicita
***************************************/

DECLARE @idT BIGINT;
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1,  @anomes VARCHAR(6) = '';
DECLARE @cuotasvencidas INT;
DECLARE @cuota INT, @cancelada INT, @preciomora INT,@mora INT, @diasvenc INT, @saldo INT, @tasainteres DECIMAL(20,6), @morasin INT, @totaldeuda INT, @deudatotal INT, @moracon INT;
	
	DECLARE @porcentaje DECIMAL(18,2);
	SET @anomes = (SELECT TOP 1 valor FROM [dbo].[Parametros] WHERE codigo = 'FECHAGESTION');

	SET @porcentaje = (SELECT TOP 1 valor FROM [dbo].[Parametros] WHERE codigo = 'PORCEINTERESMORA');

	DECLARE @table TABLE (numfactura VARCHAR(30))
		
		INSERT @table (numfactura)
		SELECT  DISTINCT nrofactura
		FROM FIN.SaldoCliente S
		WHERE S.id_cliente = @id_tercero AND S.saldoActual != 0 AND S.anomes = @anomes 


	;WITH CTE (numfactura, mora, saldo, vencida, Total) AS
	(
		SELECT  
				S.nrofactura, 
				CAST((C.saldoActual * (@porcentaje/30) * CASE WHEN DATEDIFF(DD, C.vencimiento_cuota, GETDATE()) > 0 THEN DATEDIFF(DD, C.vencimiento_cuota, GETDATE()) ELSE 0 END)  / 100 AS NUMERIC(18,2)) saldoint,
				CASE WHEN DATEDIFF(DD, C.vencimiento_cuota, GETDATE()) > 0 THEN C.saldoActual ELSE 0 END saldo,
				CASE WHEN DATEDIFF(DD, C.vencimiento_cuota, GETDATE()) <=  0 THEN 0 ELSE 1 END vencida,
				C.saldoActual totalcuota
		FROM cnt.SaldoCliente_Cuotas C
		INNER JOIN CNT.SaldoCliente S ON C.nrofactura = S.nrofactura AND S.anomes = C.anomes
		WHERE S.id_cliente = @id_tercero and S.id_devolucion IS NULL and C.saldoActual != 0 AND S.anomes = @anomes AND C.nrofactura NOT IN (SELECT numfactura FROM @table)
		
		UNION ALL

		SELECT  C.numfactura,
					CASE WHEN DATEDIFF(DD,C.vencimiento_cuota,getdate()) - diasmora < 0 OR C.cancelada > 0
					 THEN 0 
					 ELSE ((((C.CuotaFianza - (C.abono + C.AbonoFianza))* (@porcentaje/100))/30)* (DATEDIFF(DD,C.vencimiento_cuota,getdate()) - C.diasmora))
				END  as INTEVENC,
				CASE WHEN DATEDIFF(DD, C.vencimiento_cuota, GETDATE()) > 0 AND C.cancelada = 0 THEN (C.CuotaFianza  - C.abono) ELSE 0 END saldo,
				CASE WHEN DATEDIFF(DD, C.vencimiento_cuota, GETDATE()) >  0 AND C.cancelada = 0 THEN 1 ELSE 0 END venc,
				C.CuotaFianza totalcuota	
		FROM 
		FIN.SaldoCliente_Cuotas C
		INNER JOIN FIN.SaldoCliente S ON C.numfactura = S.nrofactura AND S.anomes = C.anomes
		WHERE S.id_cliente = @id_tercero AND S.saldoActual != 0 AND S.anomes = @anomes  AND C.estado =  1
	)

	,CTE2 (fechaactual, nrofactura, cance, cuotas, saldofac) AS
	(
		SELECT	S.fechaactual, 
				S.nrofactura, 
				SUM(CASE WHEN C.saldoActual = 0 THEN 1 ELSE 0 END) cance, 
				COUNT(1) cuot, 
				SUM(C.saldoActual) saldofac
		FROM cnt.SaldoCliente_Cuotas C 
		INNER JOIN CNT.SaldoCliente S ON C.nrofactura = S.nrofactura
		WHERE S.id_cliente = @id_tercero and C.id_devolucion IS NULL AND C.id_nota IS NULL AND 
			  S.anomes = @anomes AND C.nrofactura NOT IN (SELECT numfactura FROM @table) 
		GROUP BY S.fechaactual, S.nrofactura
		 
		UNION ALL
		SELECT	S.fechaactual, 
				S.nrofactura, 
				SUM(CASE WHEN C.cancelada > 0 THEN 1 ELSE 0 END) cance, 
				COUNT(1) cuot, 
				SUM(CASE WHEN C.cancelada = 0  THEN C.CuotaFianza ELSE 0 END) saldofac
		FROM FIN.SaldoCliente_Cuotas C 
		INNER JOIN FIN.SaldoCliente S ON C.numfactura = S.nrofactura AND S.anomes = C.anomes
		WHERE S.id_cliente = @id_tercero AND S.anomes = @anomes  AND C.estado = 1
		GROUP BY S.fechaactual, C.numfactura, S.nrofactura 
	)

	SELECT	C.numfactura NUMEFAC, 
			CONVERT(VARCHAR(10),T.fechaactual,120) FECHFAC, 
			T.cuotas NUMCUOTAS, 
			T.cance CUOCANCE,
			SUM(C.vencida) CUOMORA, 
			SUM(C.saldo) DEUDASINM, 
			SUM(C.saldo + C.mora) DEUDACONM, 
			T.saldofac TOTALDEUDA, 
			(T.saldofac+ SUM(C.mora)) DEUDATOTAL
	FROM CTE C 
	INNER JOIN CTE2 T ON C.numfactura = T.nrofactura
	GROUP BY C.numfactura, T.fechaactual, T.cuotas, T.cance, T.saldofac
	END TRY
BEGIN CATCH
	--Getting the error description
	    SELECT @error   =  ERROR_PROCEDURE() + 
					';  ' + CONVERT(VARCHAR,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	    -- save the error in a Log file
	    RAISERROR(@error,16,1)
	    RETURN  
END CATCH
GO