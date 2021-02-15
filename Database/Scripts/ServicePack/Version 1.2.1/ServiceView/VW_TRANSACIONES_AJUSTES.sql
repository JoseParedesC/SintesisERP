--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[CNT].[VW_TRANSACIONES_AJUSTES]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [CNT].[VW_TRANSACIONES_AJUSTES]
END
GO


CREATE VIEW [CNT].[VW_TRANSACIONES_AJUSTES]
AS
/***************************************
*Nombre:		[CNT].[VW_TRANSACIONES_AJUSTES]
----------------------------------------
*Tipo:			Vista
*creaci�n:		19/02/20
*Desarrollador: (JETEME)
***************************************/SELECT E.id id, CONVERT(VARCHAR(6), E.fecha, 112) ANOMES, IIF(E.id_centrocosto=0,null,E.Id_centrocosto) CENTROCOSTO, E.id NRODOCUMENTO, '' nrofactura, CONVERT(varchar, E.FECHA, 111) FECHADCTO, C.id CUENTA, 
                 T.id IDEN_TERCERO, F.codigo CODPRODUCTO, F.presentacion PRESENPRODUCTO, F.nombre NOMPRODUCTO, F.costo*F.cantidad  VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP, 0 CANTIDAD, 'AJ' TIPODOC, 'Ajuste de Inventario ' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE  
FROM            [dbo].[MOVAjustes]      AS E INNER JOIN 
				[dbo].[VW_MOVAjustesItems] AS F ON F.id_ajuste = E.id  INNER JOIN
				[dbo].[Bodegas]            AS B ON F.id_bodega = B.id  INNER JOIN  
				[dbo].[CNTCuentas]         AS C ON C.id = B.ctainven   CROSS APPLY
				[dbo].[Empresas]	       AS M	             		   INNER JOIN 
				[CNT].[Terceros]	     AS T ON T.iden=M.nit	 	
WHERE           (E.estado =dbo.ST_FnGetIdList('PROCE')) AND contabilizado=0
UNION
SELECT E.id id,CONVERT(VARCHAR(6), E.fecha, 112) ANOMES,IIf(E.id_centrocosto=0,null,E.Id_centrocosto) CENTROCOSTO, E.id NRODOCUMENTO, '' nrofactura, CONVERT(varchar, E.FECHA, 111) FECHADCTO, A.id_ctacontable CUENTA, 
        T.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, E.costototal*-1  VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP, 0 CANTIDAD, 'AJ' TIPODOC, A.nombre DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE 
FROM    [dbo].[MOVAjustes]         AS E    INNER JOIN 
		[dbo].[VW_Productos]       AS A ON E.id_concepto=A.id CROSS APPLY
		[dbo].[Empresas]	       AS M	             		   INNER JOIN 
		[CNT].[Terceros]		   AS T ON T.iden=M.nit
WHERE   (E.estado =dbo.ST_FnGetIdList('PROCE')) and contabilizado=0

GO


