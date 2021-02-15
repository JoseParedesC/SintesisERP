--liquibase formatted sql
--changeset ,kmartinez:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (select 1 from dbo.sysobjects where id = object_id(N'[FIN].[VW_RecaudoReciboCarteraItems]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
	Drop View [FIN].[VW_RecaudoReciboCarteraItems]
END
GO

CREATE VIEW [FIN].[VW_RecaudoReciboCarteraItems]
AS

SELECT 
	   CONVERT(VARCHAR(6), RC.fecha, 112) anomes,
	   R.id,
	   ISNULL(P.nombre, '') as concepto,
       rc.valorDescuento, 
	   R.id_recibo, 
	   R.id_factura, 
	   R.cuota cuotarec, 
	   R.valorCuota,
	   R.valorServicios,
	   R.pagoCuota,
	   R.valorIva,
	   R.InteresMora,
	   R.porcenInCorriente,
	   R.totalpagado,
	   R.vencimiento_interes, 
	   R.porceInMora,
	   R.interesCorriente,
	   R.cuotavencimiento vencimiento_cuota,
	   R.cuota
	FROM [FIN].[RecaudocarteraItems] R  INNER JOIN
	[FIN].[Recaudocartera] rc ON  rc.id = R.id_recibo  LEFT JOIN
	dbo.productos p ON rc.id_conceptoDescuento = p.id
 
GO






