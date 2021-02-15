--liquibase formatted sql
--changeset ,CZULBARAN:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_MOVCotizaciones]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [dbo].[VW_MOVCotizaciones]
END
GO

CREATE VIEW [dbo].[VW_MOVCotizaciones]
AS
		SELECT 
			P.id,
			Convert(VARCHAR(10), P.fechacot, 120) fechacot,
			L.nombre estado,
			P.iva,
			P.inc,
			P.descuento,
			P.subtotal,
			P.total,
			V.nombre vendedor,
			P.id_bodega,
			B.nombre Bodega,
			C.razonsocial cliente,
			P.id_caja,
			CA.nombre caja,
			ISNULL(T.horainicio + ' - ' + T.horafin,'') turno,
			U.username,
			C.id id_cliente,
			P.cuota_ini,
			P.financiero,
			P.lineacredit lineacredit,
			P.numcuotas num_cuot,
			P.cuotamen valor_cuot
		FROM   
			dbo.MOVCotizacion	AS P
		LEFT JOIN Dbo.ST_Listados L ON L.id = P.estado
		LEFT JOIN CNT.Terceros C ON P.id_cliente = C.id
		LEFT JOIN dbo.Vendedores V ON P.id_vendedor=V.id
		LEFT JOIN Dbo.Cajas Ca ON P.id_caja = Ca.id
		LEFT JOIN Dbo.Turnos T ON P.id_turno = T.id
		LEFT JOIN Dbo.Usuarios U ON P.id_user = U.id
		LEFT JOIN dbo.Bodegas B ON P.id_bodega =B.id

GO


