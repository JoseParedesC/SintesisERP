--liquibase formatted sql
--changeset ,JTOUS:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[FE].[VW_DocumentosFacturados]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
	DROP VIEW [FE].[VW_DocumentosFacturados]
END
GO

CREATE VIEW [FE].[VW_DocumentosFacturados]
AS
	/*FACTURAS*/
	 SELECT 
			 F.id												consecutivo
			,F.prefijo											prefijo
			,F.resolucion										resolucion		
			,F.prefijo + CAST(F.consecutivo AS VARCHAR)		factura
			,CONVERT(VARCHAR(10), F.fechavence, 120)			fechavencimiento
			,C.iden	+ '-' + C.razonsocial						cliente		
			,1													tipoDocumento
			,F.cufe												cufe										
			,F.estadoFE											estadoFE
			,CONVERT(VARCHAR(10), F.fechafac, 120)				fecha
			,R.tecnicakey										clavetec
			,F.keyid											keyid
			,'FACTURA'											origen
	 FROM MovFactura F
	 INNER JOIN [dbo].[VW_Resoluciones] R ON R.id = F.id_resolucion
	 INNER JOIN CNT.VW_Terceros C ON C.id = F.id_tercero
	 WHERE F.isFe != 0 AND F.estado = Dbo.ST_FnGetIdList('PROCE') AND F.isFe != 0
 
	 UNION ALL

	/*DEVOLUCIONES*/
	
	SELECT 
		 F.id									consecutivo
		,'DV'									prefijo
		,''										resolucion
		,'DV'+F.preconfac						factura
		,CONVERT(VARCHAR(10), DATEADD(month, 1, REPLACE(F.fecha,'-','')), 120) fechavencimiento
		,C.iden	+ '-' + C.razonsocial			cliente	
		,3										tipoDocumento
		,F.cufe									cufe
		,F.estadoFE								estadoFE
		,F.fecha								fecha
		,''										clavetec
		,F.keyid								keyid
		,'DEVOLUCION'							origen		
	FROM   dbo.VW_MOVDevFacturas	F 
	INNER JOIN CNT.VW_terceros C ON C.id = F.id_cliente
	WHERE F.isFe != 0 AND F.id_estado = Dbo.ST_FnGetIdList('PROCE') AND F.isfe != 0
GO

