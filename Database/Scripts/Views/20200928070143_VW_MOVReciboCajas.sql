--liquibase formatted sql
--changeset ,jeteme:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[CNT].[VW_MOVReciboCajas]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [CNT].[VW_MOVReciboCajas]
END
GO
CREATE VIEW [CNT].[VW_MOVReciboCajas]
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
FROM	cnt.MOVReciboCajas c 
		INNER JOIN cnt.VW_Terceros R	ON C.id_cliente = R.id
		INNER JOIN dbo.ST_Listados AS L ON L.id = c.estado
		LEFT JOIN dbo.Productos P		ON P.id=c.id_conceptoDescuento 
		LEFT JOIN CNT.CentroCosto CN	ON CN.id=C.id_centrocostos
GO


