--liquibase formatted sql
--changeset ,kmartinez:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_Rpt_RefinanCuotaAmortizacion]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [CNT].[ST_Rpt_RefinanCuotaAmortizacion]
GO

CREATE PROCEDURE [CNT].[ST_Rpt_RefinanCuotaAmortizacion]
 	@id BIGINT
 
AS
/***************************************
*Nombre:		[CNT].[ST_Rpt_RefinanCuotaAmortizacion]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		25/01/2021
*Desarrollador:  kMARTINEZ
*Descripcion:	  
***************************************/
BEGIN
Declare @error varchar(max)
declare @Conveanomes varchar(6),@cuota int;
BEGIN TRY		
SET LANGUAGE Spanish
 
	  SET @cuota = (select top 1 cuotas from [FIN].[RefinanciacionFact]  where id_factura = @id)

	SELECT  
		A.cuota,
		@cuota cuotas,
		CONVERT(varchar, CAST(A.vencimiento_cuota as date), 23) vencimiento_cuota,
		m.fechafac FechaFactura,
		A.numfactura,
		A.anomes,
		TT.tercero AS cliente,
		TT.iden AS identificacion,
		TT.direccion AS direccion,
		TT.telefono AS telefono,
		A.saldo_anterior,
		A.vlrcuota,
		A.interes,
		A.acapital,
		A.saldo,
		A.Valorfianza,
		A.CuotaFianza,
		A.porcentaje,
		SL.saldoActual movdebito,
		CONVERT(NUMERIC(18,2), (A.interes * (A.porceniva/100))) AS iva, 
		(A.acapital + A.interes + 	CONVERT(NUMERIC(18,2), (A.interes * (A.porceniva/100)))) AS total, 
		A.Tasaanual AS Tasa 
	 FROM FIN.SaldoCliente_Cuotas A
		 INNER JOIN CNT.SaldoCliente AS SL ON A.numfactura = SL.nrofactura AND A.id_tercero=SL.id_cliente AND A.anomes = SL.anomes
		 INNER JOIN	 CNT.VW_Terceros TT 	ON TT.id = A.id_tercero
		 INNER JOIN  [dbo].[MOVFactura] m   ON  concat(m.prefijo,'-',Consecutivo) = A.numfactura AND A.id_tercero =  m.id_tercero
		  WHERE  m.id  = @id  AND A.estado = 1
						ORDER BY  A.cuota  asc
							 
 
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
