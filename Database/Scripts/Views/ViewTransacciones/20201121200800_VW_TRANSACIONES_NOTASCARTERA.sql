--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[CNT].[VW_TRANSACIONES_NOTASCARTERA]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [CNT].[VW_TRANSACIONES_NOTASCARTERA]
END
GO


CREATE VIEW [CNT].[VW_TRANSACIONES_NOTASCARTERA]
AS
/***************************************
*Nombre:		[CNT].[VW_TRANSACIONES_TRASLADOS]
----------------------------------------
*Tipo:			Vista
*creaci�n:		19/02/20
*Desarrollador: (JETEME)
***************************************/ SELECT E.id id,CONVERT(VARCHAR(6), rptfecha, 112) ANOMES, E.id_centrocosto CENTROCOSTO, E.id NRODOCUMENTO, S.nrofactura nrofactura, CONVERT(varchar, E.FECHA, 112) FECHADCTO, S.id_cuenta CUENTA, 
       E.id_tercero IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, (S.saldoActual) *-1  VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP ,0 CANTIDAD, 'NC' TIPODOC, CONCAT (tipotercero,' - ','CUOTA NRO ',s.cuota) DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO,S.vencimiento_cuota FECHAVENCIMIENTO,0 CIERRE  
FROM   [CNT].[Vw_MOVNotascartera]       AS E																		INNER JOIN 
	   CNT.SaldoCliente_Cuotas         AS  S ON S.id_nota=E.id
WHERE  (E.id_estado =Dbo.ST_FnGetIdList('PROCE')) AND S.saldoActual>0  
UNION
 SELECT E.id id,CONVERT(VARCHAR(6), rptfecha, 112) ANOMES, E.id_centrocosto CENTROCOSTO, E.id NRODOCUMENTO, E.nrofactura nrofactura, CONVERT(varchar, E.FECHA, 112) FECHADCTO, IIF(E.id_ctaact is null,E.id_ctaant,E.id_ctaact) CUENTA, 
       E.id_tercero IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, (S.saldoActual)  VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP,0 CANTIDAD, 'NC' TIPODOC, CONCAT (tipotercero,' - ','CUOTA NRO ',s.cuota) DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO,S.vencimiento_cuota FECHAVENCIMIENTO ,0 CIERRE  
FROM   [CNT].[Vw_MOVNotascartera]      AS E								                        INNER JOIN 
	    CNT.SaldoCliente_Cuotas         AS S ON S.id_cliente=E.id_tercero AND S.nrofactura=E.nrofactura AND (S.id_cuenta=E.id_ctaant OR S.id_cuenta=E.id_ctaact ) AND S.id_devolucion IS NULL	AND S.id_nota is NULL and S.anomes=CONVERT(VARCHAR(6), E.rptfecha, 112)	
WHERE  (E.id_estado =Dbo.ST_FnGetIdList('PROCE')) AND  S.saldoActual>0  
UNION
SELECT E.id id,CONVERT(VARCHAR(6), rptfecha, 112) ANOMES, E.id_centrocosto CENTROCOSTO, E.id NRODOCUMENTO, F.nrofactura nrofactura, CONVERT(varchar, E.FECHA, 112) FECHADCTO, F.id_cuenta CUENTA, 
       E.id_tercero IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, G.saldoActual *-1  VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP  ,0 CANTIDAD, 'NC' TIPODOC, CONCAT('NOTA ',tipotercero,' - ', F.nrofactura)  DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO,F.fechavencimiento FECHAVENCIMIENTO ,0 CIERRE  
FROM   [CNT].[Vw_MOVNotascartera]          AS E								    INNER JOIN 
	   [CNT].[SaldoProveedor]		    AS F ON F.id  = E.id_saldo 		INNER JOIN
	   [CNT].[SaldoProveedor]           AS G ON G.id_saldonota  = F.id
WHERE  (E.id_estado =Dbo.ST_FnGetIdList('PROCE'))  
UNION
SELECT E.id id,CONVERT(VARCHAR(6), rptfecha, 112) ANOMES, E.id_centrocosto CENTROCOSTO, E.id NRODOCUMENTO, F.nrofactura nrofactura, CONVERT(varchar, E.FECHA, 112) FECHADCTO, F.id_cuenta CUENTA, 
       E.id_tercero IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, F.saldoActual   VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP  ,0 CANTIDAD, 'NC' TIPODOC, CONCAT('NOTA ',tipotercero,' - ', F.nrofactura)  DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO,F.fechavencimiento FECHAVENCIMIENTO ,0 CIERRE  
FROM   [CNT].[Vw_MOVNotascartera]          AS E								    INNER JOIN 
	   [CNT].[SaldoProveedor]		    AS F ON F.id  = E.id_saldoact 	
WHERE  (E.id_estado =Dbo.ST_FnGetIdList('PROCE'))


GO

