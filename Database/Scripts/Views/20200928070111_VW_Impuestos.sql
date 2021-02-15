--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[CNT].[VW_Impuestos]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
	Drop View CNT.VW_Impuestos
END
GO

CREATE VIEW [CNT].[VW_Impuestos]
AS
SELECT      t.id, 
			t.codigo, 
			t.nombre,
			t.valor,
			t.id_ctaventa,
			t.id_ctadevVenta,
			t.id_ctacompra,
			t.id_ctadevCompra,
			A.codigo nomctaventa,
			B.codigo nomctadevVenta,
			C.codigo nomctacompra,
			D.codigo nomctadevcompra,
			t.id_tipoimp,
			E.nombre nomtipoimpuesto, 
			t.estado, 
			t.created, 
			t.updated, 
			t.id_usercreated, 
			t.id_userupdated
FROM	CNT.Impuestos AS t inner join CNTCuentas as A on t.id_ctaventa=A.id inner join
		CNTCuentas as B ON t.id_ctadevVenta = B.id Inner join
		CNTCuentas as C ON t.id_ctacompra   = C.id Inner join
		CNTCuentas as D ON t.id_ctadevCompra= D.id inner join
		ST_Listados as E ON t.id_tipoimp    = E.id 

GO


