--liquibase formatted sql
--changeset ,kmartinez:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_Rpt_CarteraCliente]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_Rpt_CarteraCliente]
GO
CREATE  PROCEDURE [CNT].[ST_Rpt_CarteraCliente]
	@op varchar(10),
	@anomes VARCHAR(7),
	@idTercero BIGINT = null
 
AS
/***************************************
*Nombre:		[CNT].[ST_Rpt_CarteraCliente]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		28/11/2020
*Desarrollador:  kMARTINEZ
*Descripcion:	 ESTE PROCEDIMIENTO ALMACENADO TIENE COMO FUNCIONALIDAD GENERAR DOS REPORTES COMO CARTERA CLIENTE Y PROVEEDOR 
***************************************/
BEGIN
Declare @error varchar(max)
declare @Conveanomes varchar(6);
BEGIN TRY		
SET LANGUAGE Spanish
	
	SET @anomes = CAST(REPLACE(@anomes, '-','') AS VARCHAR(6))
	
	SET @Conveanomes = convert(varchar(6), @anomes, 112)
	if(@op = 'C')
	BEGIN
		SELECT  
			A.cuota,
			m.fechafac,
			A.factura,
			Cn.codigo,
			A.anomes,
				TT.tercero AS cliente,
			convert(varchar, CAST(vencimiento_cuota as date), 23) vencimiento_cuota,
			CASE WHEN datediff(day,A.vencimiento_cuota,getdate()) < 0 then 0 else datediff(day,A.vencimiento_cuota,getdate()) END dias,
 			CASE WHEN datediff(day,A.vencimiento_cuota,getdate()) <= 0 THEN A.saldoAnterior + A.movdebito else 0 END AS PorVencer,
			CASE WHEN datediff(day,A.vencimiento_cuota,getdate()) > 0 AND datediff(day,A.vencimiento_cuota,getdate()) <= 30 THEN A.saldoAnterior + A.movdebito else 0 END AS Treinta_Dias,
			CASE WHEN datediff(day,A.vencimiento_cuota,getdate()) > 30 AND datediff(day,A.vencimiento_cuota,getdate()) <= 60 THEN A.saldoAnterior + A.movdebito else 0 END AS sesenta_Dias,
			CASE WHEN datediff(day,A.vencimiento_cuota,getdate()) > 60 AND datediff(day,A.vencimiento_cuota,getdate()) <= 90 THEN A.saldoAnterior + A.movdebito else 0 END AS noventa_Dias,
			CASE WHEN datediff(day,A.vencimiento_cuota,getdate()) > 90 THEN A.saldoAnterior + A.movdebito else 0 END AS Mas_de_Noventa
		FROM CNT.VW_MOVSaldoCliente_Cuotas A 
				INNER JOIN	CNT.VW_Terceros TT 	ON TT.id = A.id_cliente 
				INNER JOIN  [dbo].[MOVFactura] m on  concat(m.prefijo,'-',Consecutivo) = A.factura
				INNER JOIN CNTCuentas Cn on A.id_cuenta = Cn.id  WHERE A.anomes = @anomes  AND a.id_nota is null and A.id_devolucion is null AND A.saldoActual != 0 
				AND ( ISNULL(@idTercero, 0) = 0 OR  A.id_cliente = @idTercero)  order by A.factura, m.fechafac
			
	END
	ELSE IF(@op = 'P')
	BEGIN
		SELECT  
			A.nrofactura AS factura,
			Cn.codigo,
			A.anomes,
			TT.tercero AS cliente,
			convert(varchar, CAST(A.fechavencimiento as date), 23) AS vencimiento_cuota,
			case when datediff(day,A.fechavencimiento,getdate())<0 then 0 else datediff(day,A.fechavencimiento, getdate()) END dias,
			CASE WHEN datediff(day,A.fechavencimiento,getdate()) <= 0 THEN A.saldoActual else 0 END AS PorVencer,
			CASE WHEN datediff(day,A.fechavencimiento,getdate()) > 0 AND datediff(day,A.fechavencimiento,getdate()) <= 30 THEN A.saldoActual else 0 END AS Treinta_Dias,
			CASE WHEN datediff(day,A.fechavencimiento,getdate()) > 30 AND datediff(day,A.fechavencimiento,getdate()) <= 60 THEN A.saldoActual else 0 END AS sesenta_Dias,
			CASE WHEN datediff(day,A.fechavencimiento,getdate()) > 60 AND datediff(day,A.fechavencimiento,getdate()) <= 90 THEN A.saldoActual else 0 END AS noventa_Dias,
			CASE WHEN datediff(day,A.fechavencimiento,getdate()) > 90  THEN A.saldoAnterior + A.movdebito else 0 END AS Mas_de_Noventa
			FROM CNT.SaldoProveedor A INNER JOIN 
				CNT.VW_Terceros TT ON TT.id=A.id_proveedor INNER JOIN  
				CNTCuentas Cn on A.id_cuenta = Cn.id     
						WHERE a.id_nota is null and A.anomes = @anomes  AND
						(ISNULL(@idTercero, 0) = 0 OR A.id_proveedor = @idTercero)  AND A.saldoActual != 0   ORDER BY A.nrofactura
			
	END 
	ELSE IF(@op = 'S')
	BEGIN
		SELECT  
			A.cuota,
			m.fechafac,
			A.numfactura,
			A.anomes,
			TT.tercero AS cliente,
			convert(varchar, CAST(vencimiento_cuota as date), 23) vencimiento_cuota,
			CASE WHEN datediff(day,A.vencimiento_cuota,getdate()) < 0 then 0 else datediff(day,A.vencimiento_cuota,getdate()) END dias,
 			CASE WHEN datediff(day,A.vencimiento_cuota,getdate()) <= 0 THEN A.CuotaFianza else 0 END AS PorVencer,
			CASE WHEN datediff(day,A.vencimiento_cuota,getdate()) > 0 AND datediff(day,A.vencimiento_cuota,getdate()) <= 30 THEN A.CuotaFianza else 0 END AS Treinta_Dias,
			CASE WHEN datediff(day,A.vencimiento_cuota,getdate()) > 30 AND datediff(day,A.vencimiento_cuota,getdate()) <= 60 THEN A.CuotaFianza else 0 END AS sesenta_Dias,
			CASE WHEN datediff(day,A.vencimiento_cuota,getdate()) > 60 AND datediff(day,A.vencimiento_cuota,getdate()) <= 90 THEN A.CuotaFianza else 0 END AS noventa_Dias,
			CASE WHEN datediff(day,A.vencimiento_cuota,getdate()) > 90 THEN A.CuotaFianza else 0 END AS Mas_de_Noventa
		FROM FIN.SaldoCliente_Cuotas A 
			   	INNER JOIN	CNT.VW_Terceros TT 	ON TT.id = A.id_tercero
				INNER JOIN  [dbo].[MOVFactura] m on  concat(m.prefijo,'-',Consecutivo) = A.numfactura
				WHERE A.anomes = @anomes
						AND ( ISNULL(@idTercero, 0) = 0 OR  A.id_tercero = @idTercero)  order by A.numfactura, m.fechafac
			
	END
	

END TRY
BEGIN Catch
	    --Getting the error description
	    Select @error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	    -- save the error in a Log file
	    RaisError(@error,16,1)
	    Return  
	End Catch
END
GO