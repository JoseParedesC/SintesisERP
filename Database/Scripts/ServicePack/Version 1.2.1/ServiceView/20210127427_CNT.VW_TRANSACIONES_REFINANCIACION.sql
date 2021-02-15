--liquibase formatted sql
--changeset ,kmartinez:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[CNT].[VW_TRANSACIONES_REFINANCIACION]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [CNT].[VW_TRANSACIONES_REFINANCIACION]
END
GO

CREATE VIEW [CNT].[VW_TRANSACIONES_REFINANCIACION]
AS
/***************************************
*Nombre:		[CNT].[VW_TRANSACIONES_REFINANCIACION]
----------------------------------------
*Tipo:			Vista
*creaci�n:		27/01/21
*Desarrollador: (Kmartinez)
***************************************/ 

SELECT      RF.id id, CONVERT(VARCHAR(6),RF.fechadoc, 112) ANOMES, RF.id_centrocostos CENTROCOSTO, RF.id NRODOCUMENTO, CONCAT(F.prefijo,'-',F.consecutivo) nrofactura, CONVERT(varchar, RF.fechadoc, 111) FECHADCTO, 
            L.id_ctacredito  CUENTA, CL.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, CU.acapital*-1 VALOR, 'REFINANCIACION' FORMAPAGO,0 BASEIMP,0 PORCEIMP, 0 CANTIDAD, 'FF' TIPODOC, CONCAT ('CUOTA NO.',CU.cuota) DESCRIPCION, Dbo.ST_FnGetIdList('PROCE') ESTADO,
            'SOLOPROD' CONDICION,convert(smalldatetime,CU.vencimiento,120) FECHAVENCIMIENTO, 0 CIERRE
FROM        [dbo].[MOVFactura]				AS F INNER JOIN
			[FIN].[RefinanciacionItems]  AS CU ON CU.id_factura  = F.id      INNER JOIN
			[FIN].[RefinanciacionFact]      AS RF ON CU.id_refinan = RF.id         INNER JOIN
            [CNT].[Terceros]				AS CL ON  RF.id_cliente = CL.id    INNER JOIN
			[FIN].[LineasCreditos]			AS L  ON L.id = RF.formapago      
WHERE       F.Estado = Dbo.ST_FnGetIdList('PROCE')  AND CU.new = 1  
UNION ALL
SELECT      RF.id id, CONVERT(VARCHAR(6),RF.fechadoc, 112) ANOMES, RF.id_centrocostos CENTROCOSTO, RF.id NRODOCUMENTO, CONCAT(F.prefijo,'-',F.consecutivo) nrofactura, CONVERT(varchar, RF.fechadoc, 111) FECHADCTO, 
            L.id_ctacredito  CUENTA, CL.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, CU.acapital VALOR, 'REFINANCIACION' FORMAPAGO,0 BASEIMP,0 PORCEIMP, 0 CANTIDAD, 'FF' TIPODOC, CONCAT ('CUOTA NO.',CU.cuota) DESCRIPCION, Dbo.ST_FnGetIdList('PROCE') ESTADO,
            'SOLOPROD' CONDICION,convert(smalldatetime,cu.vencimiento,120) FECHAVENCIMIENTO, 0 CIERRE
FROM        [dbo].[MOVFactura]				AS F INNER JOIN
			[FIN].[RefinanciacionItems]  AS CU ON CU.id_factura  = F.id      INNER JOIN
			[FIN].[RefinanciacionFact]      AS RF ON CU.id_refinan = RF.id         INNER JOIN
            [CNT].[Terceros]				AS CL ON  RF.id_cliente = CL.id    INNER JOIN
			[FIN].[LineasCreditos]			AS L  ON L.id = RF.formapago      
WHERE       F.Estado = Dbo.ST_FnGetIdList('PROCE')  AND CU.new = 0 
UNION ALL
SELECT      RF.id id, CONVERT(VARCHAR(6),RF.fechadoc, 112) ANOMES, RF.id_centrocostos CENTROCOSTO, RF.id NRODOCUMENTO, CONCAT(F.prefijo,'-',F.consecutivo) nrofactura, CONVERT(varchar, RF.fechadoc, 111) FECHADCTO, 
            RF.id_cuenta  CUENTA, CL.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, (ISNULL(RF.valorintmora, 0) *-1) VALOR, 'REFINANCIACION MORA' FORMAPAGO,0 BASEIMP,0 PORCEIMP, 0 CANTIDAD, 'FF' TIPODOC, 'REFINANCIACION CUOTA' DESCRIPCION, Dbo.ST_FnGetIdList('PROCE') ESTADO,
            'SOLOPROD' CONDICION, NULL FECHAVENCIMIENTO, 0 CIERRE
FROM        [dbo].[MOVFactura]				AS F INNER JOIN
			[FIN].[RefinanciacionFact]      AS RF ON F.id = RF.id_factura         INNER JOIN
            [CNT].[Terceros]				AS CL ON  RF.id_cliente = CL.id   
WHERE       F.Estado = Dbo.ST_FnGetIdList('PROCE') 
GO
