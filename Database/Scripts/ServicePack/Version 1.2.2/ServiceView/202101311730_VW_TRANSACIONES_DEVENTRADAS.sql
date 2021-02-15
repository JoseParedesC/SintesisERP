--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[CNT].[VW_TRANSACIONES_DEVENTRADAS]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [CNT].[VW_TRANSACIONES_DEVENTRADAS]
END
GO



CREATE VIEW [CNT].[VW_TRANSACIONES_DEVENTRADAS]
AS
/***************************************
*Nombre:		[CNT].[VW_TRANSACIONES_DEVENTRADAS]
----------------------------------------
*Tipo:			Vista
*creaci�n:		3/12/19
*Desarrollador: (JETEME)
***************************************/SELECT E.id id, CONVERT(VARCHAR(6), E.fechadocumen, 112) ANOMES, IIF(E.id_centrocostos=0,null,E.Id_centrocostos) CENTROCOSTO, E.id NRODOCUMENTO, M.numfactura nrofactura, CONVERT(varchar, M.rptfechadocumen, 111) FECHADCTO, 
                C.id CUENTA, T.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, E.retefuente-ISNULL(dbo.FnCostoAmbas(E.id, 'R','DV',0),0) VALOR, F.nombre FORMAPAGO,(E.costo-E.descuento)-ISNULL(dbo.FnCostoAmbas(E.id, 'D','DV',0),0) BASEIMP,E.porfuente PORCEIMP, 0 CANTIDAD, 'DC' TIPODOC, 'RETEFUENTE' DESCRIPCION, 
                'AMBAS' CONDICION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE  
FROM            [dbo].[MOVDevEntradas]           AS E                                       INNER JOIN
				[dbo].[VW_MOVEntradas]           AS M ON E.id_entrada    = M.id             INNER JOIN	
			    [CNT].[VW_Terceros]              AS T ON M.id_proveedor  = T.id             INNER JOIN
                [dbo].[CNTCategoriaFiscal]       AS Z ON Z.id            = T.id_catfiscal   INNER JOIN
		        [CNT].[Impuestos]                AS I ON Z.id_retefuente = I.id             INNER JOIN	
                [dbo].[CNTCuentas]               AS C ON C.id            = I.id_ctadevVenta INNER JOIN
                [dbo].[FormaPagos]               AS F ON F.id            = M.id_formaPagos
WHERE        (E.estado = Dbo.ST_FnGetIdList('PROCE'))  AND (E.retefuente-ISNULL(dbo.FnCostoAmbas(E.id, 'R','DV',0),0)) > 0 and E.contabilizado=0
UNION 
SELECT		E.id id, CONVERT(VARCHAR(6), E.fechadocumen, 112) ANOMES, IIF(E.id_centrocostos=0,null,E.Id_centrocostos) CENTROCOSTO, E.id NRODOCUMENTO, D.numfactura nrofactura, CONVERT(varchar, E.fechadocumen, 111) FECHADCTO, 
            C.id CUENTA, T.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO,SUM(IT.retefuente*cantidad), '',SUM((IT.costo-IT.descuentound)*cantidad) BASEIMP,IT.porcerefuente PORCEIMP, 0 CANTIDAD, 'DC' TIPODOC, CONCAT('RETEFUENTE DE ',F.nombre) DESCRIPCION, 
            'AMBAS' CONDICION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE  
FROM        [dbo].[MOVDevEntradas]			 AS E                                       INNER JOIN
			[dbo].[MOVEntradas]				 AS D  ON E.id_entrada     =D.id				INNER JOIN
			[dbo].[MOVDevEntradasItems]		 AS IT ON  IT.id_devolucion  = E.id			INNER JOIN 
            [CNT].[VW_Terceros]              AS T  ON D.id_proveedor  = T.id             INNER JOIN
            [CNT].[Impuestos]				 AS I  ON  I.id           = IT.id_retefuente INNER JOIN
            [dbo].[CNTCuentas]				 AS C  ON  C.id           = I.id_ctacompra  INNER JOIN
            [dbo].[Productos]				 AS F  ON  F.id           = IT.id_articulo
WHERE       (E.estado = Dbo.ST_FnGetIdList('PROCE')) AND  IT.retefuente>0 and E.contabilizado=0
GROUP BY E.id,E.fechadocumen,E.id_centrocostos,D.numfactura,C.id,T.id,F.nombre,IT.porcerefuente
UNION 
SELECT        E.id id, CONVERT(VARCHAR(6), E.fechadocumen, 112) ANOMES, IIF(E.id_centrocostos=0,null,E.Id_centrocostos) CENTROCOSTO, E.id NRODOCUMENTO, M.numfactura nrofactura, CONVERT(varchar, M.rptfechadocumen, 111) FECHADCTO, 
              C.id CUENTA, T.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, E.reteica-ISNULL(dbo.FnCostoAmbas(E.id, 'A','DV',0),0) VALOR, F.nombre FORMAPAGO,(E.costo-E.descuento)-ISNULL(dbo.FnCostoAmbas(E.id, 'D','DV',0),0) BASEIMP,E.porica PORCEIMP  ,0 CANTIDAD, 'DC' TIPODOC, 'RETEICA' DESCRIPCION, 
              'AMBAS' CONDICION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE  
FROM          [dbo].[MOVDevEntradas]  AS E INNER JOIN
			  [dbo].[VW_MOVEntradas]     AS M ON E.id_entrada   = M.id              INNER JOIN	
              [CNT].[VW_Terceros]        AS T ON M.id_proveedor  = T.id             INNER JOIN
              [dbo].[CNTCategoriaFiscal] AS Z ON Z.id           = T.id_catfiscal    INNER JOIN
			  [CNT].[Impuestos]          AS I ON Z.id_reteica   = I.id              INNER JOIN	
              [dbo].[CNTCuentas]         AS C ON C.id           = I.id_ctadevVenta  INNER JOIN
              [dbo].[FormaPagos]         AS F ON F.id           = M.id_formaPagos
WHERE        (E.estado = Dbo.ST_FnGetIdList('PROCE')) AND  (E.reteica-ISNULL(dbo.FnCostoAmbas(E.id, 'A','DV',0),0))> 0 and E.contabilizado=0
UNION 
SELECT		E.id id, CONVERT(VARCHAR(6), E.fechadocumen, 112) ANOMES, IIF(E.id_centrocostos=0,null,E.Id_centrocostos) CENTROCOSTO, E.id NRODOCUMENTO, D.numfactura nrofactura, CONVERT(varchar, E.fechadocumen, 111) FECHADCTO, 
            C.id CUENTA, T.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO,SUM(IT.reteica*cantidad), '',SUM((IT.costo-IT.descuentound)*cantidad) BASEIMP,IT.porcereica PORCEIMP , 0 CANTIDAD, 'DC' TIPODOC, CONCAT('RETEICA DE ',F.nombre) DESCRIPCION, 
            'AMBAS' CONDICION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE  
FROM        [dbo].[MOVDevEntradas]			 AS E                                       INNER JOIN
			[dbo].[MOVEntradas]				 AS D ON E.id_entrada     =D.id				INNER JOIN
			[dbo].[MOVDevEntradasItems]		 AS IT ON  IT.id_devolucion  = E.id			INNER JOIN 
            [CNT].[VW_Terceros]              AS T ON D.id_proveedor  = T.id             INNER JOIN
            [CNT].[Impuestos]			 AS I  ON  I.id           = IT.id_reteica INNER JOIN
            [dbo].[CNTCuentas]			 AS C  ON  C.id           = I.id_ctacompra  INNER JOIN
            [dbo].[Productos]			 AS F  ON  F.id           = IT.id_articulo
WHERE       (E.estado = Dbo.ST_FnGetIdList('PROCE')) AND  IT.reteica>0 and E.contabilizado=0
GROUP BY E.id,E.fechadocumen,E.id_centrocostos,D.numfactura,C.id,T.id,F.nombre,IT.porcereica
UNION 
SELECT        E.id id, CONVERT(VARCHAR(6), E.fechadocumen, 112) ANOMES, IIF(E.id_centrocostos=0,null,E.Id_centrocostos) CENTROCOSTO, E.id NRODOCUMENTO, M.numfactura nrofactura, CONVERT(varchar, M.rptfechadocumen, 111) FECHADCTO, 
              C.id CUENTA, T.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, E.reteiva-ISNULL(dbo.FnCostoAmbas(E.id, 'V','DV',0),0) VALOR, F.nombre FORMAPAGO,(E.iva)-ISNULL(dbo.FnCostoAmbas(E.id, 'I','DV',0),0) BASEIMP,E.poriva PORCEIMP, 0 CANTIDAD, 'DC' TIPODOC, 'RETEIVA' DESCRIPCION, 
              'AMBAS' CONDICION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE  
FROM          [dbo].[MOVDevEntradas]  AS E                                      INNER JOIN
			  [dbo].[VW_MOVEntradas]     AS M ON E.id_entrada   = M.id             INNER JOIN	
              [CNT].[VW_Terceros]              AS T ON M.id_proveedor  = T.id             INNER JOIN
              [dbo].[CNTCategoriaFiscal] AS Z ON Z.id           = T.id_catfiscal   INNER JOIN
			  [CNT].[Impuestos]          AS I ON Z.id_reteiva   = I.id             INNER JOIN	
              [dbo].[CNTCuentas]         AS C ON C.id           = I.id_ctadevVenta INNER JOIN
              [dbo].[FormaPagos]         AS F ON F.id           = M.id_formaPagos
WHERE        (E.estado = Dbo.ST_FnGetIdList('PROCE')) AND (E.reteiva-ISNULL(dbo.FnCostoAmbas(E.id, 'V','DV',0),0)) > 0 and E.contabilizado=0
UNION 
SELECT		E.id id, CONVERT(VARCHAR(6), E.fechadocumen, 112) ANOMES, IIF(E.id_centrocostos=0,null,E.Id_centrocostos) CENTROCOSTO, E.id NRODOCUMENTO, D.numfactura nrofactura, CONVERT(varchar, E.fechadocumen, 111) FECHADCTO, 
            C.id CUENTA, T.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO,SUM(IT.reteiva*cantidad), '',SUM(IT.iva*cantidad) BASEIMP,IT.porcereiva PORCEIMP  ,0 CANTIDAD, 'DC' TIPODOC, CONCAT('RETEIVA DE ',F.nombre) DESCRIPCION, 
            'AMBAS' CONDICION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE  
FROM        [dbo].[MOVDevEntradas]			 AS E                                       INNER JOIN
			[dbo].[MOVEntradas]				AS D ON E.id_entrada     =D.id				INNER JOIN
			[dbo].[MOVDevEntradasItems]	 AS IT ON  IT.id_devolucion  = E.id			INNER JOIN 
              [CNT].[VW_Terceros]              AS T ON D.id_proveedor  = T.id             INNER JOIN
            [CNT].[Impuestos]			 AS I  ON  I.id           = IT.id_reteiva INNER JOIN
            [dbo].[CNTCuentas]			 AS C  ON  C.id           = I.id_ctacompra  INNER JOIN
            [dbo].[Productos]			 AS F  ON  F.id           = IT.id_articulo
WHERE       (E.estado = Dbo.ST_FnGetIdList('PROCE')) AND  IT.reteiva>0 and E.contabilizado=0
GROUP BY E.id,E.fechadocumen,E.id_centrocostos,D.numfactura,C.id,T.id,F.nombre,IT.porcereiva
UNION
SELECT        E.id id, CONVERT(VARCHAR(6), E.fechadocumen, 112) ANOMES,IIF(E.id_centrocostos=0,null,E.Id_centrocostos) CENTROCOSTO, E.id NRODOCUMENTO, M.numfactura nrofactura, CONVERT(varchar, M.rptfechadocumen, 111) FECHADCTO, 
              C.id CUENTA, T.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, E.descuento VALOR, F.nombre FORMAPAGO,0 BASEIMP,0 PORCEIMP ,0 CANTIDAD, 'DC' TIPODOC,'DESCUENTO' DESCRIPCION, 'AMBAS' CONDICION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE  
FROM          [dbo].[MOVDevEntradas] AS E                                     INNER JOIN
			  [dbo].[VW_MOVEntradas]    AS M ON E.id_entrada   = M.id              INNER JOIN	
              [CNT].[VW_Terceros]              AS T ON M.id_proveedor  = T.id             INNER JOIN
              [dbo].[FormaPagos]        AS F ON F.id           = E.id_formaPagos INNER JOIN
              [dbo].[Bodegas]           AS B ON B.id           = E.id_bodega     INNER JOIN
              [dbo].[CNTCuentas]        AS C ON C.id           = B.ctadescuento
WHERE        (E.estado =  Dbo.ST_FnGetIdList('PROCE')) and E.descuento > 0 and E.contabilizado=0
UNION
SELECT        E.id id, CONVERT(VARCHAR(6), E.fechadocumen, 112) ANOMES,IIF(E.id_centrocostos=0,null,E.Id_centrocostos) CENTROCOSTO, E.id NRODOCUMENTO, M.numfactura nrofactura, CONVERT(varchar, M.fechadocumen, 111) FECHADCTO, 
              C.id CUENTA, T.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, E.valor-ISNULL(E.valoranticipo,0)  VALOR, F.nombre FORMAPAGO,0 BASEIMP,0 PORCEIMP ,0 CANTIDAD, 'DC' TIPODOC, 'TOTALDEVOLUCION' DESCRIPCION, 
              'AMBAS' CONDICION,Dbo.ST_FnGetIdList('PROCE') ESTADO,M.fechavence FECHAVENCIMIENTO,0 CIERRE  
FROM          [dbo].[MOVDevEntradas]	 AS E                                     INNER JOIN
			  [dbo].[MOVEntradas]     AS M ON E.id_entrada   = M.id            INNER JOIN	
              [CNT].[VW_Terceros]              AS T ON M.id_proveedor  = T.id             INNER JOIN
              [dbo].[FormaPagos]         AS F ON F.id           = M.id_formaPagos INNER JOIN
              [dbo].[CNTCuentas]         AS C ON C.id           = F.id_cuenta
WHERE        (E.estado = Dbo.ST_FnGetIdList('PROCE'))  and E.contabilizado=0 and (E.valor-ISNULL(E.valoranticipo,0))>0 
UNION
SELECT        E.id id, CONVERT(VARCHAR(6), E.fechadocumen, 112) ANOMES, IIF(E.id_centrocostos=0,null,E.Id_centrocostos) CENTROCOSTO, E.id NRODOCUMENTO, M.numfactura nrofactura, CONVERT(varchar, M.rptfechadocumen, 111) FECHADCTO, 
              B.id_ctadevcompra CUENTA, T.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, SUM(I.iva*I.cantidad)*-1  VALOR, F.nombre FORMAPAGO,SUM((I.costo-I.descuentound)*I.cantidad) BASEIMP ,I.porceniva PORCEIMP ,0 CANTIDAD, 'DC' TIPODOC, 
              'VALOR IVA PRODUCTO' DESCRIPCION, 'AMBAS' CONDICION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE  
FROM          [dbo].[MOVDevEntradas]     AS E INNER JOIN
			  [dbo].[VW_MOVEntradas]        AS M ON E.id_entrada        = M.id              INNER JOIN	
			  [dbo].[VW_MOVDevEntradaItems] AS I ON E.id                = I.id_devolucion   INNER JOIN
              [CNT].[VW_Terceros]              AS T ON M.id_proveedor  = T.id             INNER JOIN
              [dbo].[FormaPagos]            AS F ON F.id                = M.id_formaPagos   INNER JOIN
              [dbo].[Productos]             AS Z on Z.id                = I.id_articulo     INNER JOIN 
			  [dbo].[ST_Listados]           AS S ON Z.tipoproducto      = S.id              INNER JOIN
              [CNT].[Impuestos]             AS B ON B.id                = I.id_iva          
              WHERE        (E.estado = Dbo.ST_FnGetIdList('PROCE'))  AND I.iva > 0 AND s.nombre!='servicio' and E.contabilizado=0
			  GROUP BY E.id,E.fechadocumen,E.id_centrocostos,T.id,F.nombre,M.numfactura,M.rptfechadocumen,B.id_ctadevcompra,I.porceniva
UNION
SELECT        E.id id, CONVERT(VARCHAR(6), E.fechadocumen, 112) ANOMES, IIF(E.id_centrocostos=0,null,E.Id_centrocostos) CENTROCOSTO, E.id NRODOCUMENTO, M.numfactura nrofactura, CONVERT(varchar, M.rptfechadocumen, 111) FECHADCTO, 
              C.id_ctadevcompra CUENTA, T.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, (I.iva*I.cantidad)*-1 VALOR, F.nombre FORMAPAGO, (I.costo-I.descuentound)*cantidad BASEIMP,I.porceniva,0 CANTIDAD, 'DC' TIPODOC, 'VALOR IVA DE ' + D .nombre DESCRIPCION, 
              'AMBAS' CONDICION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE  
FROM		  [dbo].[MOVDevEntradas]     AS E                                      INNER JOIN	
			  [dbo].[VW_MOVEntradas]        AS M ON E.id_entrada    = M.id            INNER JOIN
              [CNT].[VW_Terceros]           AS T ON M.id_proveedor  = T.id             INNER JOIN
              [dbo].[FormaPagos]            AS F ON F.id            = M.id_formaPagos INNER JOIN
              [dbo].[VW_MOVDevEntradaItems] AS I ON I.id_devolucion = E.id            INNER JOIN
              [dbo].[Productos]             AS D ON D .id           = I.id_articulo   INNER JOIN
		      [dbo].[ST_Listados]           AS S ON D.tipoproducto  = S.id            INNER JOIN
              [CNT].[Impuestos]             AS C ON C.id            = I.id_iva
WHERE        (E.estado = Dbo.ST_FnGetIdList('PROCE')) AND I.iva > 0 AND S.nombre='servicio' and E.contabilizado=0
UNION
SELECT        E.id id, CONVERT(VARCHAR(6), E.fechadocumen, 112) ANOMES, IIF(E.id_centrocostos=0,null,E.Id_centrocostos) CENTROCOSTO, E.id NRODOCUMENTO,M.numfactura nrofactura, CONVERT(varchar, M.rptfechadocumen, 111) FECHADCTO, 
              C.id CUENTA, T.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO,(E.costo - ISNULL(dbo.FnCostoAmbas(E.id, 'C', 'DV',0),0))*-1 VALOR, F.nombre FORMAPAGO,0 BASEIMP,0 PORCEIMP ,0 CANTIDAD, 'DC' TIPODOC, 'TOTAL COSTO' DESCRIPCION, 
              'AMBAS' CONDICION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE  
FROM          [dbo].[MOVDevEntradas] AS E                                        INNER JOIN
			  [dbo].[VW_MOVEntradas]    AS M ON E.id_entrada      = M.id            INNER JOIN	
              [CNT].[VW_Terceros]              AS T ON M.id_proveedor  = T.id             INNER JOIN
              [dbo].[FormaPagos]        AS F ON F.id              = M.id_formaPagos INNER JOIN
              [dbo].[Bodegas]           AS B ON B.id              = M.id_bodega     INNER JOIN
			  [dbo].[CNTCuentas]        AS C ON C.id              = B.ctainven
WHERE        (E.estado = Dbo.ST_FnGetIdList('PROCE')) AND (E.costo-ISNULL(dbo.FnCostoAmbas(E.id, 'C', 'DV',0),0))>0 and E.contabilizado=0
UNION
SELECT        E.id id, CONVERT(VARCHAR(6), E.fechadocumen, 112) ANOMES, IIF(E.id_centrocostos=0,null,E.Id_centrocostos) CENTROCOSTO, E.id NRODOCUMENTO, M.numfactura nrofactura, CONVERT(varchar, M.rptfechadocumen, 111) FECHADCTO, 
              C.id CUENTA, T.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, (I.costo * I.cantidad)*-1 VALOR, F.nombre FORMAPAGO,0 BASEIMP,0 PORCEIMP ,0 CANTIDAD, 'DC' TIPODOC, D .nombre DESCRIPCION, 
              'AMBAS' CONDICION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE  
FROM          [dbo].[MOVDevEntradas]     AS E                                      INNER JOIN
			  [dbo].[VW_MOVEntradas]        AS M ON E.id_entrada    = M.id            INNER JOIN	
              [CNT].[VW_Terceros]              AS T ON M.id_proveedor  = T.id             INNER JOIN
              [dbo].[FormaPagos]            AS F ON F.id            = M.id_formaPagos INNER JOIN
              [dbo].[VW_MOVDevEntradaItems] AS I ON I.id_devolucion = E.id            INNER JOIN
              [dbo].[Productos]             AS D ON D.id            = I.id_articulo   INNER JOIN
              [dbo].[CNTCuentas]            AS C ON C.id            = D .id_ctacontable
WHERE        (E.estado = Dbo.ST_FnGetIdList('PROCE')) and E.contabilizado=0
UNION
SELECT        E.id id, CONVERT(VARCHAR(6), E.fechadocumen, 112) ANOMES,IIF(E.id_centrocostos=0,null,E.Id_centrocostos) CENTROCOSTO, E.id NRODOCUMENTO, M.numfactura nrofactura, CONVERT(varchar, M.rptfechadocumen, 111) FECHADCTO, 
              C.id_ctadevcompra CUENTA, T.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, SUM(I.inc*cantidad)*-1 VALOR, F.nombre FORMAPAGO,SUM((I.costo-I.descuentound)*I.cantidad) BASEIMP ,I.porceninc PORCEIMP,0 CANTIDAD, 'DC' TIPODOC, 'IMPUESTO AL CONSUMO ' DESCRIPCION, 
              'AMBAS' CONDICION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE  
FROM         [dbo].[MOVDevEntradas]     AS E                                            INNER JOIN
			 [dbo].[VW_MOVEntradas]        AS M ON E.id_entrada          = M.id            INNER JOIN
			 [dbo].[VW_MOVDevEntradaItems] AS I ON E.id                  = I.id_devolucion INNER JOIN	
             [CNT].[VW_Terceros]              AS T ON M.id_proveedor  = T.id             INNER JOIN
             [dbo].[FormaPagos]            AS F ON F.id                  = M.id_formaPagos INNER JOIN
             [dbo].[Bodegas]               AS B ON B.id                  = M.id_bodega     INNER JOIN
             [CNT].[Impuestos]             AS C ON C.id                  = I.id_inc
WHERE        (E.estado = Dbo.ST_FnGetIdList('PROCE')) AND E.inc > 0 and E.contabilizado=0
GROUP BY E.id,E.fechadocumen,E.id_centrocostos,T.id,F.nombre,M.numfactura,M.rptfechadocumen,C.id_ctadevcompra,I.porceninc
UNION
SELECT      DF.id id, CONVERT(VARCHAR(6), DF.fechadocumen, 112) ANOMES, IIF(DF.id_centrocostos=0,null,DF.Id_centrocostos) CENTROCOSTO, DF.id NRODOCUMENTO, F.numfactura nrofactura, CONVERT(varchar, DF.fechadocumen, 111) FECHADCTO, 
            C.id CUENTA, CL.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, DF.valoranticipo VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP ,0 CANTIDAD, 'DC' TIPODOC, 'CUENTA DE ANTICIPO' DESCRIPCION,'SOLOPROD' CONDICION,Dbo.ST_FnGetIdList('PROCE') ESTADO, 
            NULL FECHAVENCIMIENTO,0 CIERRE 
FROM        [dbo].[MOVDevEntradas]		AS DF				              INNER JOIN	
			[dbo].[MOVEntradas]		AS F  ON DF.id_entrada = F.id     INNER JOIN  
            [CNT].[Terceros]            AS CL ON CL.id        = F.id_proveedor   INNER JOIN
			[dbo].[CNTCuentas]			AS C  ON C.id  = F.id_ctaant      INNER JOIN
			[dbo].[ST_Listados]			AS S  ON S.id  = F.estado
WHERE      DF.estado = dbo.ST_FnGetIdList('PROCE')  AND DF.valoranticipo != 0  and DF.contabilizado=0


GO


