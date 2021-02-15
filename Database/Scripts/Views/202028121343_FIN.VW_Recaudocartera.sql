--liquibase formatted sql
--changeset ,kmartinez:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[FIN].[VW_Recaudocartera]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [FIN].[VW_Recaudocartera]
END
GO

CREATE VIEW [FIN].[VW_Recaudocartera]
AS
SELECT 	c.id ,
		c.fecha,
		R.razonsocial AS cliente,
		c.id_cliente,						 
		c.valorcliente,
		c.valorconcepto,
		l.nombre estado,
		c.id_conceptoDescuento,
		c.valorDescuento,
		p.nombre conceptoDescuento,
		c.cambio,
		c.id_tipodoc,
		c.id_centrocostos,
		CN.nombre Centrocostos,
		id_reversion
FROM	[FIN].[Recaudocartera] c 
		INNER JOIN cnt.VW_Terceros R	ON C.id_cliente = R.id		
		INNER JOIN dbo.ST_Listados AS L ON L.id = c.estado
		LEFT JOIN dbo.Productos P		ON P.id=c.id_conceptoDescuento 
		LEFT JOIN CNT.CentroCosto CN	ON CN.id=C.id_centrocostos



GO



