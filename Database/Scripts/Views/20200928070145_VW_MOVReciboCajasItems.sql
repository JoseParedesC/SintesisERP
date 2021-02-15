--liquibase formatted sql
--changeset ,jeteme:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[CNT].[VW_MOVReciboCajasItems]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [CNT].[VW_MOVReciboCajasItems]
END
GO
CREATE VIEW [CNT].[VW_MOVReciboCajasItems]
AS

SELECT	R.id,
		R.id_recibo,
		R.id_factura,
		R.cuota,
		R.valorCuota,
		R.pagoCuota,
		R.pagoInteres,
		R.porceInteres,
	    R.totalpagado,
		R.vencimiento_interes
FROM CNT.MOVReciboCajasItems R  
GO


