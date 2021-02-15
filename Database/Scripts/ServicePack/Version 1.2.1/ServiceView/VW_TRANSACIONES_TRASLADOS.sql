--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[CNT].[VW_TRANSACIONES_TRASLADOS]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [CNT].[VW_TRANSACIONES_TRASLADOS]
END
GO


CREATE VIEW [CNT].[VW_TRANSACIONES_TRASLADOS]
AS
/***************************************
*Nombre:		[CNT].[VW_TRANSACIONES_TRASLADOS]
----------------------------------------
*Tipo:			Vista
*creaci�n:		19/02/20
*Desarrollador: (JETEME)
***************************************/ SELECT E.id id,CONVERT(VARCHAR(6), E.fecha, 112) ANOMES, IIF(E.id_centrocosto=0,null,E.Id_centrocosto) CENTROCOSTO, E.id NRODOCUMENTO, '' nrofactura, CONVERT(varchar, E.FECHA, 111) FECHADCTO, c.id CUENTA, 
       T.id IDEN_TERCERO, F.codigo CODPRODUCTO, F.presentacion PRESENPRODUCTO, F.nombre NOMPRODUCTO, (F.costo*F.CANTIDAD)*-1  VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP  ,0 CANTIDAD, 'TR' TIPODOC, 'Salida de Inventario ' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE  
FROM   [dbo].[MOVTraslados]       AS E                                   INNER JOIN 
	   [dbo].[VW_MOVTrasladosItems]  AS F ON F.id_traslado  = E.id       INNER JOIN
	   [dbo].[Bodegas]               AS B ON F.id_bodega    = B.id       INNER JOIN
	   [dbo].[CNTCuentas]            AS C ON C.id           = B.ctainven CROSS APPLY
	   [dbo].[Empresas]	        	 AS M								 INNER JOIN 
	   [CNT].[VW_Terceros]	     AS T ON T.iden=M.nit	 	
WHERE  (E.estado =Dbo.ST_FnGetIdList('PROCE')) AND E.contabilizado=0
UNION
 SELECT E.id id,CONVERT(VARCHAR(6), E.fecha, 112) ANOMES, IIF(E.id_centrocosto=0,null,E.Id_centrocosto) CENTROCOSTO, E.id NRODOCUMENTO, '' nrofactura, CONVERT(varchar, E.FECHA, 111) FECHADCTO, C.id CUENTA, 
        T.id IDEN_TERCERO, F.codigo CODPRODUCTO, F.presentacion PRESENPRODUCTO, F.nombre NOMPRODUCTO, (F.costo*f.CANTIDAD)  VALOR, '' FORMAPAGO, 0 BASEIMP,0 PORCEIMP ,0 CANTIDAD, 'TR' TIPODOC, 'Entrada de Inventario ' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE  
FROM    [dbo].[MOVTraslados]      AS E                              INNER JOIN 
		[dbo].[VW_MOVTrasladosItems] AS F ON F.id_traslado    = E.id      INNER JOIN
		[dbo].[Bodegas]              AS B ON F.id_bodegades   = B.id      INNER JOIN
		[dbo].[CNTCuentas]           AS C ON C.id             = B.ctainven CROSS APPLY
	    [dbo].[Empresas]	        	 AS M								 INNER JOIN 
	    [CNT].[VW_Terceros]	     AS T ON T.iden=M.nit	 	
WHERE   (E.estado =Dbo.ST_FnGetIdList('PROCE'))  AND E.contabilizado=0

GO


