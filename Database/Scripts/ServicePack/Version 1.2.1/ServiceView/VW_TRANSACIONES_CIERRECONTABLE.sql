--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[CNT].[VW_TRANSACIONES_CIERRECONTABLE]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [CNT].[VW_TRANSACIONES_CIERRECONTABLE]
END
GO


CREATE VIEW [CNT].[VW_TRANSACIONES_CIERRECONTABLE]
/***************************************
*Nombre: [CNT].[VW_TRANSACIONES_CIERRECONTABLE]
----------------------------------------
*Tipo: Vista
*creaci�n: 08/01/21
*Descripci�n: 
***************************************/

AS 
SELECT	E.id id,
		E.anomes ANOMES, 
		IIF(E.id_centrocosto=0,null,E.Id_centrocosto) CENTROCOSTO, 
		E.id NRODOCUMENTO, '' nrofactura, 
		CONVERT(varchar, E.FECHA, 112) FECHADCTO, 
		S.id_cuenta CUENTA, 
		S.id_tercero IDEN_TERCERO,
		'' CODPRODUCTO, 
		'' PRESENPRODUCTO, 
		'' NOMPRODUCTO, 
		(S.valor)  VALOR, 
		'' FORMAPAGO,
		0 BASEIMP,
		0 PORCEIMP ,
		0 CANTIDAD, 
		'CR' TIPODOC, 
		CONCAT ('CIERRE CUENTA ',
		c.codigo,' - ',c.nombre) DESCRIPCION,
		Dbo.ST_FnGetIdList('PROCE') ESTADO,
		'' FECHAVENCIMIENTO,
		1 CIERRE 
FROM   [CNT].[MOVCierreContable] AS E INNER JOIN 
	   CNT.[MOVCierreContableItems] AS  S ON S.id_cierrecontable=E.id INNER JOIN
	   CNTCuentas AS C  ON  S.id_cuenta=C.id
WHERE  (E.estado =Dbo.ST_FnGetIdList('PROCE')) 

UNION

SELECT	E.id id,
		E.anomes ANOMES, 
		IIF(E.id_centrocosto=0,null,E.Id_centrocosto) CENTROCOSTO, 
		E.id NRODOCUMENTO, 
		'' nrofactura, 
		CONVERT(varchar, E.FECHA, 112) FECHADCTO, 
		E.id_cuentacancelacion CUENTA, 
		E.id_tercero IDEN_TERCERO, 
		'' CODPRODUCTO, 
		'' PRESENPRODUCTO, 
		'' NOMPRODUCTO, 
		SUM(S.valor)*-1  VALOR, 
		'' FORMAPAGO,
		0 BASEIMP,
		0 PORCEIMP ,
		0 CANTIDAD, 
		'CR' TIPODOC, 
		CONCAT ('CUENTAS ',c.codigo,' - ',c.nombre) DESCRIPCION,
		Dbo.ST_FnGetIdList('PROCE') ESTADO,
		'' FECHAVENCIMIENTO,
		0 CIERRE 
FROM   [CNT].[MOVCierreContable] AS E INNER JOIN 
	   CNT.[MOVCierreContableItems] AS S ON S.id_cierrecontable=E.id INNER JOIN
	   CNTCuentas AS C  ON  E.id_cuentacancelacion=C.id
WHERE  (E.estado =Dbo.ST_FnGetIdList('PROCE')) GROUP BY E.id, e.anomes,E.id_centrocosto,E.FECHA,E.id_cuentacancelacion,E.id_tercero,C.codigo,C.nombre

UNION

SELECT	E.id id,
		E.anomes ANOMES, 
		IIF(E.id_centrocosto=0,null,E.Id_centrocosto) CENTROCOSTO, 
		E.id NRODOCUMENTO, 
		'' nrofactura, 
		CONVERT(varchar, E.FECHA, 112) FECHADCTO, 
		E.id_cuentacancelacion CUENTA, 
		E.id_tercero IDEN_TERCERO, 
		'' CODPRODUCTO, 
		'' PRESENPRODUCTO, 
		'' NOMPRODUCTO, 
		SUM(S.valor)  VALOR, 
		'' FORMAPAGO,
		0 BASEIMP,
		0 PORCEIMP ,
		0 CANTIDAD, 
		'CR' TIPODOC, 
		CONCAT ('CUENTA DE CANCELACION ',c.codigo,' - ',c.nombre) DESCRIPCION,
		Dbo.ST_FnGetIdList('PROCE') ESTADO,
		'' FECHAVENCIMIENTO,
		0 CIERRE
FROM   [CNT].[MOVCierreContable] AS E INNER JOIN 
	   CNT.[MOVCierreContableItems] AS S ON S.id_cierrecontable=E.id INNER JOIN
	   CNTCuentas AS C  ON  E.id_cuentacancelacion=C.id
WHERE  (E.estado =Dbo.ST_FnGetIdList('PROCE')) GROUP BY E.id, e.anomes,E.id_centrocosto,E.FECHA,E.id_cuentacancelacion,E.id_tercero,C.codigo,C.nombre

UNION

SELECT	E.id id,
		E.anomes ANOMES, 
		IIF(E.id_centrocosto=0,null,E.Id_centrocosto) CENTROCOSTO, 
		E.id NRODOCUMENTO, 
		'' nrofactura, 
		CONVERT(varchar, E.FECHA, 112) FECHADCTO, 
		E.id_cuentacierre CUENTA, 
		E.id_tercero IDEN_TERCERO, 
		'' CODPRODUCTO, 
		'' PRESENPRODUCTO, 
		'' NOMPRODUCTO, 
		SUM(S.valor)*-1  VALOR, 
		'' FORMAPAGO,
		0 BASEIMP,
		0 PORCEIMP ,
		0 CANTIDAD, 
		'CR' TIPODOC, 
		CONCAT ('CUENTA DE CIERRE ',c.codigo,' - ',c.nombre) DESCRIPCION,
		Dbo.ST_FnGetIdList('PROCE') ESTADO,
		'' FECHAVENCIMIENTO,
		0 CIERRE 
FROM   [CNT].[MOVCierreContable] AS E INNER JOIN 
	   CNT.[MOVCierreContableItems] AS S ON S.id_cierrecontable=E.id INNER JOIN
	   CNTCuentas AS C  ON  E.id_cuentacierre=C.id
WHERE  (E.estado =Dbo.ST_FnGetIdList('PROCE'))  GROUP BY E.id, e.anomes,E.id_centrocosto,E.FECHA,E.id_cuentacierre,E.id_tercero,C.codigo,C.nombre

GO


