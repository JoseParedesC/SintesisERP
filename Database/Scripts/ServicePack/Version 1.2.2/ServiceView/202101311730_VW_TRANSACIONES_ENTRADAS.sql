--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[CNT].[VW_TRANSACIONES_ENTRADAS]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [CNT].[VW_TRANSACIONES_ENTRADAS]
END
GO


CREATE VIEW [CNT].[VW_TRANSACIONES_ENTRADAS]
AS
/***************************************
*Nombre:		[CNT].[VW_TRANSACIONES_ENTRADAS]
----------------------------------------
*Tipo:			Vista
*creaci�n:		3/12/19
*Desarrollador: (JETEME)
***************************************/
SELECT		E.id id, CONVERT(VARCHAR(6), E.fechadocumen, 112) ANOMES, IIF(E.id_centrocostos=0,null,E.Id_centrocostos) CENTROCOSTO, E.id NRODOCUMENTO, E.numfactura nrofactura, CONVERT(varchar, E.fechadocumen, 111) FECHADCTO, 
            C.id CUENTA, T.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, (E.retefuente-ISNULL(dbo.FnCostoAmbas(E.id, 'R','EN',0),0))*-1 VALOR, F.nombre FORMAPAGO,(E.costo-E.descuento)-ISNULL(dbo.FnCostoAmbas(E.id, 'D','EN',0),0) BASEIMP,E.porfuente PORCEIMP ,0 CANTIDAD, 'EN' TIPODOC, 'RETEFUENTE' DESCRIPCION, 
            'SOLOPROD' CONDICION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE  
FROM        [dbo].[MOVEntradas]     AS E                                     INNER JOIN
		    [CNT].[VW_Terceros]        AS T ON E.id_proveedor   = T.id            INNER JOIN
            [dbo].[CNTCategoriaFiscal] AS Z ON Z.id           = T.id_catfiscal  INNER JOIN
            [CNT].[Impuestos]          AS I ON I.id           = Z.id_retefuente INNER JOIN
            [dbo].[CNTCuentas]         AS C ON C.id           = I.id_ctacompra  INNER JOIN
            [dbo].[FormaPagos]         AS F ON F.id           = E.id_formaPagos
WHERE       (E.estado = Dbo.ST_FnGetIdList('PROCE')) AND  (E.retefuente-ISNULL(dbo.FnCostoAmbas(E.id, 'R','EN',0),0)) > 0 and E.contabilizado=0
UNION ALL 
SELECT		E.id id, CONVERT(VARCHAR(6), E.fechadocumen, 112) ANOMES,IIF(E.id_centrocostos=0,null,E.Id_centrocostos) CENTROCOSTO, E.id NRODOCUMENTO, E.numfactura nrofactura, CONVERT(varchar, E.fechadocumen, 111) FECHADCTO, 
            C.id CUENTA, T.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO,SUM(IT.retefuente*IT.cantidad)*-1, '',SUM((IT.costo-IT.descuentound)*cantidad) BASEIMP,IT.porcerefuente PORCEIMP ,0 CANTIDAD, 'EN' TIPODOC, CONCAT('RETEFUENTE DE ',F.nombre) DESCRIPCION, 
            'SOLOPROD' CONDICION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE  
FROM        [dbo].[MOVEntradas]			 AS E                                       INNER JOIN
			[dbo].[MOVEntradasItems]	 AS IT ON  IT.id_entrada  = E.id			INNER JOIN 
		    [CNT].[VW_Terceros]			 AS T  ON  E.id_proveedor   = T.id            INNER JOIN
            [CNT].[Impuestos]			 AS I  ON  I.id           = IT.id_retefuente INNER JOIN
            [dbo].[CNTCuentas]			 AS C  ON  C.id           = I.id_ctacompra  INNER JOIN
            [dbo].[Productos]			 AS F  ON  F.id           = IT.id_articulo
WHERE       (E.estado = Dbo.ST_FnGetIdList('PROCE')) AND  IT.retefuente>0 AND E.contabilizado=0
GROUP BY E.id,E.fechadocumen,E.id_centrocostos,E.numfactura,C.id,T.id,F.nombre,IT.porcerefuente
UNION ALL
SELECT      E.id id, CONVERT(VARCHAR(6),E.fechadocumen, 112) ANOMES,IIF(E.id_centrocostos=0,null,E.Id_centrocostos) CENTROCOSTO, E.id NRODOCUMENTO, E.numfactura nrofactura, CONVERT(varchar, E.fechadocumen, 111) FECHADCTO, 
            C.id CUENTA, E.id_proveedor IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, E.valoranticipo*-1 VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP, 0 CANTIDAD, 'EN' TIPODOC, 'CUENTA DE ANTICIPO' DESCRIPCION, 
            'SOLOPROD' CONDICION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE 
FROM        [dbo].[MOVEntradas]   AS E                          INNER JOIN  
			[dbo].[CNTCuentas]   AS C  ON C.id  = E.id_ctaant  
WHERE       E.Estado = Dbo.ST_FnGetIdList('PROCE')  AND E.valoranticipo != 0 AND E.contabilizado=0
UNION ALL
SELECT      E.id id, CONVERT(VARCHAR(6), E.fechadocumen, 112) ANOMES, IIF(E.id_centrocostos=0,null,E.Id_centrocostos) CENTROCOSTO, E.id NRODOCUMENTO, E.numfactura nrofactura, CONVERT(varchar, E.fechadocumen, 111) FECHADCTO, 
            C.id CUENTA, T.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, (E.reteica-ISNULL(dbo.FnCostoAmbas(E.id, 'A','EN',0),0))*-1 VALOR, F.nombre FORMAPAGO,(E.costo-E.descuento)-ISNULL(dbo.FnCostoAmbas(E.id, 'D','EN',0),0) BASEIMP,E.porica PORCEIMP , 0 CANTIDAD, 'EN' TIPODOC, 'RETEICA' DESCRIPCION, 
            'SOLOPROD' CONDICION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE  
FROM        [dbo].[MOVEntradas]     AS E                                         INNER JOIN
		    [CNT].[VW_Terceros]        AS T ON E.id_proveedor       = T.id            INNER JOIN
            [dbo].[CNTCategoriaFiscal] AS Z ON Z.id               = T.id_catfiscal  INNER JOIN
            [CNT].[Impuestos]          AS I ON I.id               = Z.id_retefuente INNER JOIN
            [dbo].[CNTCuentas]         AS C ON C.id               = I.id_ctacompra  INNER JOIN
            [dbo].[FormaPagos]         AS F ON F.id               = E.id_formaPagos
WHERE       (E.estado = Dbo.ST_FnGetIdList('PROCE'))  AND (E.reteica-ISNULL(dbo.FnCostoAmbas(E.id, 'A','EN',0),0)) > 0 and E.contabilizado=0
UNION ALL
SELECT		E.id id, CONVERT(VARCHAR(6), E.fechadocumen, 112) ANOMES,IIF(E.id_centrocostos=0,null,E.Id_centrocostos) CENTROCOSTO, E.id NRODOCUMENTO, E.numfactura nrofactura, CONVERT(varchar, E.fechadocumen, 111) FECHADCTO, 
            C.id CUENTA, T.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO,SUM(IT.reteica*IT.cantidad)*-1, '',SUM((IT.costo-IT.descuentound)*cantidad) BASEIMP,IT.porcereica PORCEIMP ,0 CANTIDAD, 'EN' TIPODOC, CONCAT('RETEICA DE ',F.nombre) DESCRIPCION, 
            'SOLOPROD' CONDICION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE  
FROM        [dbo].[MOVEntradas]			 AS E                                       INNER JOIN
			[dbo].[MOVEntradasItems]	 AS IT ON  IT.id_entrada  = E.id			INNER JOIN 
		    [CNT].[VW_Terceros]			 AS T  ON  E.id_proveedor   = T.id            INNER JOIN
            [CNT].[Impuestos]			 AS I  ON  I.id           = IT.id_reteica INNER JOIN
            [dbo].[CNTCuentas]			 AS C  ON  C.id           = I.id_ctacompra  INNER JOIN
            [dbo].[Productos]			 AS F  ON  F.id           = IT.id_articulo
WHERE       (E.estado = Dbo.ST_FnGetIdList('PROCE')) AND  IT.reteica>0 and E.contabilizado=0
GROUP BY E.id,E.fechadocumen,E.id_centrocostos,E.numfactura,C.id,T.id,F.nombre,IT.porcereica
UNION ALL
SELECT     E.id id, CONVERT(VARCHAR(6), E.fechadocumen, 112) ANOMES, IIF(E.id_centrocostos=0,null,E.Id_centrocostos) CENTROCOSTO, E.id NRODOCUMENTO, E.numfactura nrofactura, CONVERT(varchar, E.fechadocumen, 111) FECHADCTO, 
           C.id CUENTA, T.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, (E.reteiva-ISNULL(dbo.FnCostoAmbas(E.id, 'V','EN',0),0))*-1 VALOR, F.nombre FORMAPAGO,(E.iva)-ISNULL(dbo.FnCostoAmbas(E.id, 'I','EN',0),0) BASEIMP,E.poriva PORCEIMP , 0 CANTIDAD, 'EN' TIPODOC, 'RETEIVA' DESCRIPCION, 
           'SOLOPROD' CONDICION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE  
FROM       [dbo].[MOVEntradas]     AS E                                       INNER JOIN
		   [CNT].[VW_Terceros]        AS T ON E.id_proveedor     = T.id            INNER JOIN
           [dbo].[CNTCategoriaFiscal] AS Z ON Z.id             = T.id_catfiscal  INNER JOIN
           [CNT].[Impuestos]          AS I ON I.id             = Z.id_retefuente INNER JOIN
           [dbo].[CNTCuentas]         AS C ON C.id             = I.id_ctacompra  INNER JOIN
           [dbo].[FormaPagos]         AS F ON F.id             = E.id_formaPagos
WHERE      (E.estado = Dbo.ST_FnGetIdList('PROCE'))  AND (E.reteiva-ISNULL(dbo.FnCostoAmbas(E.id, 'V','EN',0),0)) > 0 and E.contabilizado=0
UNION ALL
SELECT		E.id id, CONVERT(VARCHAR(6), E.fechadocumen, 112) ANOMES, IIF(E.id_centrocostos=0,null,E.Id_centrocostos) CENTROCOSTO, E.id NRODOCUMENTO, E.numfactura nrofactura, CONVERT(varchar, E.fechadocumen, 111) FECHADCTO, 
            C.id CUENTA, T.id IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO,SUM(IT.reteIVA*cantidad)*-1, '',SUM(IT.iva*cantidad) BASEIMP,IT.porcereiva PORCEIMP, 0 CANTIDAD, 'EN' TIPODOC, CONCAT('RETEIVA DE ',F.nombre) DESCRIPCION, 
            'SOLOPROD' CONDICION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE  
FROM        [dbo].[MOVEntradas]			 AS E                                       INNER JOIN
			[dbo].[MOVEntradasItems]	 AS IT ON  IT.id_entrada  = E.id			INNER JOIN 
		    [CNT].[VW_Terceros]			 AS T  ON  E.id_proveedor   = T.id            INNER JOIN
            [CNT].[Impuestos]			 AS I  ON  I.id           = IT.id_reteiva INNER JOIN
            [dbo].[CNTCuentas]			 AS C  ON  C.id           = I.id_ctacompra  INNER JOIN
            [dbo].[Productos]			 AS F  ON  F.id           = IT.id_articulo
WHERE       (E.estado = Dbo.ST_FnGetIdList('PROCE')) AND  IT.reteiva>0 and E.contabilizado=0
GROUP BY E.id,E.fechadocumen,E.id_centrocostos,E.numfactura,C.id,T.id,F.nombre,IT.porcereiva 
UNION ALL
SELECT     E.id id, CONVERT(VARCHAR(6), E.fechadocumen, 112) ANOMES, IIF(E.id_centrocostos=0,null,E.Id_centrocostos) CENTROCOSTO, E.id NRODOCUMENTO, E.numfactura nrofactura, CONVERT(varchar, E.fechadocumen, 111) FECHADCTO, 
           C.id CUENTA, E.id_proveedor IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, E.descuento *-1 VALOR, F.nombre FORMAPAGO,0 BASEIMP,0 PORCEIMP, 0 CANTIDAD, 'EN' TIPODOC,'DESCUENTO' DESCRIPCION, 'SOLOPROD' CONDICION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE  
FROM       [dbo].[MOVEntradas]   AS E                                     INNER JOIN
           [dbo].[FormaPagos]       AS F ON F.id           = E.id_formaPagos INNER JOIN
           [dbo].[Bodegas]          AS B ON B.id           = E.id_bodega     INNER JOIN
           [dbo].[CNTCuentas]       AS C ON C.id           = B.ctadescuento
WHERE        (E.estado = Dbo.ST_FnGetIdList('PROCE')) and E.descuento > 0 and E.contabilizado=0
UNION ALL
--Registro de Total compras 
SELECT     E.id id, CONVERT(VARCHAR(6), E.fechadocumen, 112) ANOMES, IIF(E.id_centrocostos=0,null,E.Id_centrocostos) CENTROCOSTO, E.id NRODOCUMENTO, E.numfactura nrofactura, CONVERT(varchar, E.fechadocumen, 111) FECHADCTO, 
           C.id CUENTA, E.id_proveedor IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, ((E.valor - iif(E.id_proveflete is NOT NULL,E.flete,0) -E.valoranticipo) * - 1) VALOR, F.nombre FORMAPAGO, 0 BASEIMP,0 PORCEIMP,0 CANTIDAD, 'EN' TIPODOC, 'TOTALCOMPRA' DESCRIPCION, 
          'SOLOPROD' CONDICION,Dbo.ST_FnGetIdList('PROCE') ESTADO,E.fechavence FECHAVENCIMIENTO,0 CIERRE -- Actualizado 08/02/2021  
FROM       [dbo].[MOVEntradas]    AS E                                     INNER JOIN
           [dbo].[FormaPagos]        AS F ON F.id           = E.id_formaPagos INNER JOIN
           [dbo].[CNTCuentas]        AS C ON C.id           = f.id_cuenta
WHERE      (E.estado = Dbo.ST_FnGetIdList('PROCE'))  and E.contabilizado=0 and ((E.valor - iif(E.id_proveflete is NOT NULL,E.flete,0)-E.valoranticipo))>0
UNION ALL
SELECT     E.id id, CONVERT(VARCHAR(6), E.fechadocumen, 112) ANOMES, IIF(E.id_centrocostos=0,null,E.Id_centrocostos) CENTROCOSTO, E.id NRODOCUMENTO, E.numfactura nrofactura, CONVERT(varchar, E.fechadocumen, 111) FECHADCTO, 
           C.id CUENTA, E.id_proveflete IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, ((E.flete) * - 1) VALOR, F.nombre FORMAPAGO,0 BASEIMP,0 PORCEIMP, 0 CANTIDAD, 'EN' TIPODOC, 'TOTALFLETE' DESCRIPCION, 
           'SOLOPROD' CONDICION,Dbo.ST_FnGetIdList('PROCE') ESTADO,E.fechavence FECHAVENCIMIENTO,0 CIERRE  
FROM       [dbo].[MOVEntradas]  AS E                                          INNER JOIN
           [dbo].[FormaPagos]      AS F ON F.id            = E.id_formapagoflete INNER JOIN
           [dbo].[CNTCuentas]      AS C ON C.id            = f.id_cuenta
WHERE      (E.estado = Dbo.ST_FnGetIdList('PROCE'))  AND E.id_proveflete IS NOT NULL and E.contabilizado=0
UNION ALL
SELECT     E.id id, CONVERT(VARCHAR(6), E.fechadocumen, 112) ANOMES,IIF(E.id_centrocostos=0,null,E.Id_centrocostos) CENTROCOSTO, E.id NRODOCUMENTO, E.numfactura nrofactura, CONVERT(varchar, E.fechadocumen, 111) FECHADCTO, 
           B.ctaivaflete CUENTA, E.id_proveedor IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, (E.ivaflete) VALOR, '' FORMAPAGO,E.flete BASEIMP,[dbo].[GETParametrosValor]('PORIVAGEN') PORCEIMP ,0 CANTIDAD,'EN' TIPODOC, 'IVA FLETE' DESCRIPCION, 
           'SOLOPROD' CONDICION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE  
FROM       [dbo].[MOVEntradas]  AS E                                          LEFT JOIN
		   [dbo].[Bodegas]  	AS B ON E.id_bodega			= B.id			  
WHERE      (E.estado = Dbo.ST_FnGetIdList('PROCE'))  AND E.ivaflete>0 and E.contabilizado=0
UNION ALL
SELECT    E.id id, CONVERT(VARCHAR(6), E.fechadocumen, 112) ANOMES, IIF(E.id_centrocostos=0,null,E.Id_centrocostos) CENTROCOSTO, E.id NRODOCUMENTO, E.numfactura nrofactura, CONVERT(varchar, E.fechadocumen, 111) FECHADCTO, 
          C.id CUENTA, E.id_proveedor IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, SUM(I.iva*I.cantidad) VALOR, F.nombre FORMAPAGO,SUM((I.costo-I.descuentound)*I.cantidad) BASEIMP ,I.porceniva PORCEIMP,0 CANTIDAD, 'EN' TIPODOC, 'VALOR IVA PRODUCTO' DESCRIPCION, 
         'SOLOPROD' CONDICION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE  
FROM      [dbo].[MOVEntradas]      AS E                                     INNER JOIN
          [dbo].[FormaPagos]          AS F ON F.id           = E.id_formaPagos INNER JOIN
          [dbo].[VW_MOVEntradasItems] AS I ON I.id_entrada   = E.id            INNER JOIN
          [dbo].[Productos]           AS D ON D .id          = I.id_articulo   INNER JOIN
		  [dbo].[ST_Listados]         AS S ON D.tipoproducto = s.id            INNER JOIN
          [dbo].[CNTCuentas]          AS C ON C.id           = i.id_ctaiva
WHERE        (E.estado = Dbo.ST_FnGetIdList('PROCE'))  AND I.iva > 0 and s.nombre='PRODUCTO'and E.contabilizado=0
GROUP BY e.id,c.id,e.fechadocumen,E.id_proveedor,e.numfactura,E.fechadocumen,e.iva,f.nombre,E.id_centrocostos,S.nombre,I.porceniva
UNION ALL
--Registro de valor de Iva por servicio
SELECT    E.id id, CONVERT(VARCHAR(6), E.fechadocumen, 112) ANOMES,IIF(E.id_centrocostos=0,null,E.Id_centrocostos) CENTROCOSTO, E.id NRODOCUMENTO, E.numfactura nrofactura, CONVERT(varchar, E.fechadocumen, 111) FECHADCTO, 
          C.id CUENTA, E.id_proveedor IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, I.iva*I.cantidad VALOR, F.nombre FORMAPAGO,((I.costo-I.descuentound)*I.cantidad) BASEIMP,I.porceniva PORCEIMP, 0 CANTIDAD, 'EN' TIPODOC, 'VALOR IVA DE ' + D .nombre DESCRIPCION, 
         'SOLOPROD' CONDICION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE  
FROM      [dbo].[MOVEntradas]      AS E                                     INNER JOIN
          [dbo].[FormaPagos]          AS F ON F.id           = E.id_formaPagos INNER JOIN
          [dbo].[VW_MOVEntradasItems] AS I ON I.id_entrada   = E.id            INNER JOIN
          [dbo].[Productos]           AS D ON D .id          = I.id_articulo   INNER JOIN
		  [dbo].[ST_Listados]         AS S ON D.tipoproducto = s.id            INNER JOIN
          [dbo].[CNTCuentas]          AS C ON C.id           = i.id_ctaiva
WHERE        (E.estado = Dbo.ST_FnGetIdList('PROCE'))  AND I.iva > 0 and (s.nombre='SERVICIO' or S.nombre='De consumo') and E.contabilizado=0
UNION ALL
--Registro de total costo restandole los servicios cuando el flete no tiene proveedor diferente
SELECT    E.id id, CONVERT(VARCHAR(6), E.fechadocumen, 112) ANOMES, IIF(E.id_centrocostos=0,null,E.Id_centrocostos) CENTROCOSTO, E.id NRODOCUMENTO, E.numfactura nrofactura, CONVERT(varchar, E.fechadocumen, 111) FECHADCTO, 
          C.id CUENTA, E.id_proveedor IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, (E.costo + E.flete) - ISNULL(dbo.FnCostoAmbas(E.id, 'C','EN',0),0) VALOR, F.nombre FORMAPAGO,0 BASEIMP,0 PORCEIMP, 0 CANTIDAD, 'EN' TIPODOC, 
          'TOTAL COSTO' DESCRIPCION, 'SOLOPROD' CONDICION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE  
FROM      [dbo].[MOVEntradas]   AS E                                     INNER JOIN
          [dbo].[FormaPagos]       AS F ON F.id           = E.id_formaPagos INNER JOIN
          [dbo].[Bodegas]          AS B ON B.id           = E.id_bodega     INNER JOIN
          [dbo].[CNTCuentas]       AS C ON C.id           = B.ctainven
WHERE     (E.estado = Dbo.ST_FnGetIdList('PROCE'))  AND (E.costo + E.flete) - ISNULL(dbo.FnCostoAmbas(E.id, 'C', 'EN',0),0)>0 and E.contabilizado=0
UNION ALL
--Total costo por servicio 
SELECT    E.id id, CONVERT(VARCHAR(6), E.fechadocumen, 112) ANOMES,IIF(E.id_centrocostos=0,null,E.Id_centrocostos) CENTROCOSTO, E.id NRODOCUMENTO, E.numfactura nrofactura, CONVERT(varchar, E.fechadocumen, 111) FECHADCTO, 
          C.id CUENTA, E.id_proveedor IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, (I.costo * I.cantidad) VALOR, F.nombre FORMAPAGO,0 BASEIMP,0 PORCEIMP, 0 CANTIDAD, 'EN' TIPODOC, D .nombre DESCRIPCION, 
          'SOLOPROD' CONDICION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE  
FROM      [dbo].[MOVEntradas]      AS E                                     INNER JOIN
          [dbo].[FormaPagos]          AS F ON F.id           = E.id_formaPagos INNER JOIN
          [dbo].[VW_MOVEntradasItems] AS I ON I.id_entrada   = E.id            INNER JOIN
          [dbo].[Productos]           AS D ON D .id          = I.id_articulo   INNER JOIN
          [dbo].[CNTCuentas]          AS C ON C.id           = D.id_ctacontable
WHERE     (E.estado = Dbo.ST_FnGetIdList('PROCE')) and E.contabilizado=0
UNION ALL
--Registro de impuesto consumo
SELECT    E.id id, CONVERT(VARCHAR(6), E.fechadocumen, 112) ANOMES, IIF(E.id_centrocostos=0,null,E.Id_centrocostos) CENTROCOSTO, E.id NRODOCUMENTO, E.numfactura nrofactura, CONVERT(varchar, E.fechadocumen, 111) FECHADCTO, 
          C.id  CUENTA, E.id_proveedor IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, sum(i.inc*i.cantidad) VALOR, F.nombre FORMAPAGO,SUM((I.costo-I.descuentound)*I.cantidad) BASEIMP,I.porceninc PORCEIMP, 0 CANTIDAD, 'EN' TIPODOC, 'IMPUESTO AL CONSUMO ' DESCRIPCION, 
          'SOLOPROD' CONDICION,Dbo.ST_FnGetIdList('PROCE') ESTADO,NULL FECHAVENCIMIENTO,0 CIERRE  
FROM      [dbo].[MOVEntradas]      AS E                                      INNER JOIN
		  [dbo].[VW_MOVEntradasItems] AS I ON I.id_entrada   = E.id             INNER JOIN
          [dbo].[FormaPagos]          AS F ON F.id           = E.id_formaPagos  INNER JOIN
          [dbo].[CNTCuentas]          AS C ON C.id           = i.id_ctainc
WHERE        (E.estado = Dbo.ST_FnGetIdList('PROCE')) and E.contabilizado=0
GROUP BY e.id,c.id,e.fechadocumen,E.id_proveedor,e.numfactura,E.fechadocumen,e.iva,f.nombre,E.id_centrocostos,I.porceninc



GO


