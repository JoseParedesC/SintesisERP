--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[CNT].[VW_TRANSACIONES_DEVANTICIPOS]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [CNT].[VW_TRANSACIONES_DEVANTICIPOS]
END
GO

CREATE VIEW [CNT].[VW_TRANSACIONES_DEVANTICIPOS]
AS
/***************************************
*Nombre:		[CNT].[VW_TRANSACIONES_DEVANTICIPOS]
----------------------------------------
*Tipo:			Vista
*creaci�n:		3/06/20
*Desarrollador: (JTOUS)
***************************************/ 
SELECT 
			E.id ID, 
            CONVERT(VARCHAR(6), E.fecha, 112) ANOMES,
			IIF(E.id_centrocostos=0,null,E.Id_centrocostos) CENTROCOSTO, 
			E.id NRODOCUMENTO, 
			CAST(E.id AS VARCHAR) nrofactura, 
			CONVERT(varchar, E.FECHA, 111) FECHADCTO, 
			E.id_cta CUENTA, 
            E.id_cliente IDEN_TERCERO, 
			'' CODPRODUCTO, 
			'' PRESENPRODUCTO, 
			'' NOMPRODUCTO, 
			iif(E.id_tipoanticipo=dbo.ST_FnGetIdList('CL'),E.valor,E.valor*-1)  VALOR, 
			F.nombre FORMAPAGO,
			0 BASEIMP,
			0 PORCEIMP, 
			0 CANTIDAD, 
			'DA' TIPODOC, 
			CONCAT(UPPER(E.descripcion),' ','CTA ANTICIPO' ) DESCRIPCION,
			Dbo.ST_FnGetIdList('PROCE') ESTADO,
			NULL FECHAVENCIMIENTO,0 CIERRE 
FROM    MOVDevAnticipos AS E INNER JOIN FormaPagos AS F ON F.id = E.id_formaPago
WHERE   (E.estado = Dbo.ST_FnGetIdList('PROCE')) 
UNION ALL
SELECT		E.id id, 
			CONVERT(VARCHAR(6), E.fecha, 112) ANOMES, 
			IIF(E.id_centrocostos=0,null,E.Id_centrocostos) CENTROCOSTO, 
			E.id NRODOCUMENTO, 
			CAST(E.id AS VARCHAR) nrofactura, 
			CONVERT(varchar, E.FECHA, 111) FECHADCTO, 
			F.id_cuenta CUENTA, 
            E.id_cliente IDEN_TERCERO, 
			'' CODPRODUCTO, 
			'' PRESENPRODUCTO, 
			'' NOMPRODUCTO, 
			iif(E.id_tipoanticipo=dbo.ST_FnGetIdList('CL'),E.valor*-1,E.valor)  VALOR, 
			F.nombre FORMAPAGO, 
			0 BASEIMP,
			0 PORCEIMP,
			0 CANTIDAD, 
			'DA' TIPODOC, 
			'MOVIMIENTO DE FORMA PAGO' DESCRIPCION,
			Dbo.ST_FnGetIdList('PROCE') ESTADO,
			NULL FECHAVENCIMIENTO,0 CIERRE 
FROM    MOVDevAnticipos AS E INNER JOIN FormaPagos AS F ON F.id = E.id_formaPago		
WHERE   (E.estado = Dbo.ST_FnGetIdList('PROCE'))

GO


