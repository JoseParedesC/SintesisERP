--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[CNT].[VW_TRANSACIONES_COMPROBANTESCONTABLE]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [CNT].[VW_TRANSACIONES_COMPROBANTESCONTABLE]
END
GO


CREATE VIEW [CNT].[VW_TRANSACIONES_COMPROBANTESCONTABLE]
AS
		SELECT        C.id,  CONVERT(VARCHAR(6), C.fecha, 112) ANOMES, IIF(i.id_centrocosto=0,null,i.Id_centrocosto) AS CENTROCOSTO, C.id AS NRODOCUMENTO, ISNULL(I.factura,'') AS nrofactura, CONVERT(varchar, C.fecha, 111) AS FECHADCTO, U.id AS CUENTA, 
							 I.id_tercero AS IDEN_TERCERO, '' AS CODPRODUCTO, '' AS PRESENPRODUCTO, '' AS NOMPRODUCTO, I.valor, '' AS FORMAPAGO,0 BASEIMP,0 PORCEIMP, 0 AS CANTIDAD, 'CC' AS TIPODOC, ISNULL(I.detalle, '') + ' ' + U.nombre AS DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO,i.fechavencimiento FECHAVENCIMIENTO,0 CIERRE  
	FROM			  CNT.MOVComprobantesContables AS C INNER JOIN
							 CNT.MOVComprobantesContablesItems AS I ON C.id = I.id_comprobante INNER JOIN
							 dbo.CNTCuentas AS U ON I.id_cuenta = U.id LEFT JOIN
							 CNT.TipoDocumentos AS D ON C.id_documento = D.id inner join
							 dbo.ST_Listados		AS L ON L.id				= C.estado
	WHERE        (L.nombre = 'PROCESADO')

GO


