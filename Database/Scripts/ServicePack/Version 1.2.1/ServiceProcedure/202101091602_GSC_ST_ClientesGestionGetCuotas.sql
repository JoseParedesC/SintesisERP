--liquibase formatted sql
--changeset ,JPAREDES:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[GSC].[ST_ClientesGestionGetCuotas]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [GSC].[ST_ClientesGestionGetCuotas]
GO 
CREATE PROCEDURE [GSC].[ST_ClientesGestionGetCuotas]

@id_user BIGINT = 0,
@idC BIGINT = 0,
@numefac VARCHAR(20) = ''

AS
/***************************************
*Nombre:		[GSC].[ST_ClientesGestionGetCuotas]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		20/11/2020
*Desarrollador: jparedes
*Descripcion:	Lista la factura calculando 
				la cantidad de cuotas, las 
				pagadas, las debidas, las 
				que tienen mora y su valor, 
				incluyendo también los intereses
***************************************/
BEGIN TRY
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;

		--LLENAR TABLA DE ESTADO CLIENTE

		DECLARE @porcentaje DECIMAL(18,2) = (SELECT TOP 1 valor FROM [dbo].[Parametros] WHERE codigo = 'PORCEINTERESMORA');
		DECLARE @anomes VARCHAR(6) = (SELECT TOP 1 valor FROM [dbo].[Parametros] WHERE codigo = 'FECHAGESTION');
		DECLARE @table TABLE (numfactura VARCHAR(30))
		
		INSERT @table (numfactura)
		SELECT  DISTINCT nrofactura
		FROM FIN.SaldoCliente S
		WHERE S.id_cliente = @idC AND S.saldoActual != 0 AND S.anomes = @anomes AND S.nrofactura = @numefac
	 
		;WITH CTE (CUOTA, VENCFAC, VALCUOTA, SANTFAC, DIASVEN, INTEVENC, ESTADO, id_refinan) AS
		(
			SELECT SC.cuota,
				CONVERT(VARCHAR(10),SC.vencimiento_cuota,120) VENCFAC,
				SC.saldoAnterior +SC.movdebito VALCUOTA,
				SC.saldoActual SANTFAC,
				CASE WHEN DATEDIFF(DD,SC.vencimiento_cuota,getdate()) > 0 
						THEN DATEDIFF(DD,SC.vencimiento_cuota,getdate())
						ELSE '' 
				END DIASVEN,
				CASE WHEN (((SC.saldoActual* (@porcentaje/100))/30)* (DATEDIFF(DD,SC.vencimiento_cuota,getdate()))) < 0 
						THEN 0 
						ELSE (((SC.saldoActual* (@porcentaje/100))/30)* (DATEDIFF(DD,SC.vencimiento_cuota,getdate())))
				END  as INTEVENC,
				1 estado,
				0
			FROM [CNT].[SaldoCliente_Cuotas] SC  
			WHERE  SC.anomes = @anomes AND
					SC.id_cliente = @idC AND 
					SC.id_nota is  NULL AND 
					SC.id_devolucion is  NULL AND
					SC.saldoActual != 0 AND SC.nrofactura = @numefac AND  SC.nrofactura NOT IN (SELECT numfactura FROM @table)

			UNION ALL

			SELECT SC.cuota,
				CONVERT(VARCHAR(10),SC.vencimiento_cuota,120) VENCFAC,
				SC.CuotaFianza VALCUOTA,
				CASE WHEN SC.cancelada != 0 AND SC.estado != 0 THEN 0 ELSE (SC.CuotaFianza - (SC.abono + SC.AbonoFianza)) END SANTFAC,
				CASE WHEN DATEDIFF(DD, SC.vencimiento_cuota, getdate()) > 0 AND SC.cancelada = 0
						THEN DATEDIFF(DD,SC.vencimiento_cuota,getdate()) - SC.diasmora
						ELSE '' 
				END DIASVEN,
				CASE WHEN DATEDIFF(DD,SC.vencimiento_cuota,getdate()) - diasmora < 0 OR SC.cancelada != 0
					 THEN 0 
					 ELSE ((((SC.CuotaFianza - (SC.abono + SC.AbonoFianza))* (@porcentaje/100))/30)* (DATEDIFF(DD,SC.vencimiento_cuota,getdate()) - SC.diasmora))
				END  as INTEVENC,
				SC.estado,
				ISNULL(SC.id_refinanciado, 0)
			FROM [FIN].[SaldoCliente_Cuotas] SC  
			WHERE SC.numfactura = @numefac AND SC.anomes=@anomes  

		 ) 
		 SELECT CUOTA, VENCFAC,	VALCUOTA, SANTFAC,	DIASVEN, INTEVENC,	(SANTFAC + INTEVENC) SALTOTAL, 
		 CASE WHEN estado = 0 THEN 1 
			  WHEN estado != 0 AND DIASVEN > 0 THEN 2 ELSE 0 END estado
		 FROM CTE ORDER BY CTE.estado DESC, id_refinan DESC, cuota ASC

		--LLENAR TABLA DE EXTRACTO		
		; WITH CTE (NUMDOCTRA, IDCENCOSTO, VENCEFAC, FECHATRA, DESCRITRA, VALORTRA) AS (
			
			SELECT 'RC-'+CAST(T.nrodocumento AS VARCHAR) NUMDOCTRA,
                 R.Centrocostos IDCENCOSTO,
                 CONVERT(VARCHAR(10), S.vencimiento_cuota,120) VENCEFAC,
                 CONVERT(VARCHAR(10), R.fecha,120) FECHATRA,
                 'Avance cuota N° '+ CAST(I.cuota AS VARCHAR) DESCRITRA,
                 I.totalpagado VALORTRA
			 FROM cnt.transacciones T INNER JOIN
			 CNT.VW_MOVReciboCajas R ON R.id = T.nrodocumento AND T.tipodocumento IN ('RC') INNER JOIN
			 CNT.VW_MOVReciboCajasItems I ON I.id_recibo = R.id INNER JOIN 
			 CNT.SaldoCliente_Cuotas  S ON I.id_factura = S.nrofactura AND S.id_cliente = r.id_cliente AND S.cuota = i.cuota AND S.id_nota IS NULL AND id_devolucion IS NULL AND s.anomes=convert(VARCHAR(6),GETDATE(),112)
			 WHERE T.estado = dbo.ST_FnGetIdList('PROCE') and 
				   t.valor > 0 AND 
				   T.id_tercero = @idC and 
				   I.id_factura = @numefac AND 
				   T.nrofactura NOT IN (SELECT numfactura FROM @table)

			 UNION ALL

			 SELECT 'RF-'+CAST(R.id AS VARCHAR) NUMDOCTRA,
                 R.Centrocostos IDCENCOSTO,
                 CONVERT(VARCHAR(10), I.vencimiento_cuota,120) VENCEFAC,
                 CONVERT(VARCHAR(10), R.fecha,120) FECHATRA,
                 'Avance cuota N° '+ CAST(I.cuota AS VARCHAR) DESCRITRA,
                 I.totalpagado VALORTRA
			 FROM FIN.VW_Recaudocartera R INNER JOIN
			 [FIN].[VW_RecaudoReciboCarteraItems] I ON I.id_recibo = R.id
			 WHERE R.estado = 'PROCESADO' AND R.id_cliente = @idC AND I.id_factura = @numefac
			 
			 UNION ALL 

			 SELECT 'FF' + CAST(id AS VARCHAR) NUMDOCTRA,
					centrocosto IDCENCOSTO,
					'' VENCEFAC,
					CONVERT(VARCHAR(10), fechadoc, 120) FECHATRA,
					'REFINANCIACIÓN N° FACTURA: ' + @numefac +' A ' +CAST(cuotas AS VARCHAR) + ' CUOTAS' DESCRITRA,
					totalcredito VALORTRA
			  FROM FIN.VW_MOVRefinanciacionFianan WHERE numfactura = @numefac AND id_cliente = @idC	 
			
		)

		SELECT NUMDOCTRA, IDCENCOSTO, VENCEFAC, FECHATRA, DESCRITRA, VALORTRA FROM CTE	
		ORDER BY FECHATRA ASC

		--LLENAR TABLA PRODUCTO
		SELECT 
				fi.nombre NOMBRE, 
				S.serie SERIE,
				ISNULL(O.lote + ' - ' + CONVERT(VARCHAR(10), O.vencimiento_lote, 120),'') LOTE, 
				fi.cantidad CANTIDAD,
				fi.precio PRECIO, 
				fi.presentacion PRESENTACION 
		FROM [dbo].[VW_MOVFacturaItems] fi INNER JOIN 
			[dbo].[VW_MOVFacturas] f ON fi.id_factura = f.id LEFT JOIN 
			Dbo.MovFacturaSeries S ON fi.id = S.id_items LEFT JOIN 
			Dbo.MOVFacturaLotes L ON L.id_item = FI.id LEFT JOIN
			LotesProducto O ON O.id = L.id_lote
		WHERE f.id_cliente = @idC AND F.rptconsecutivo = @numefac		
		

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