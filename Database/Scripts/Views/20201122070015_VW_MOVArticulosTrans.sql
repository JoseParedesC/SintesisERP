--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'dbo.VW_MOVArticulosTrans') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View dbo.VW_MOVArticulosTrans
END
GO
CREATE VIEW dbo.VW_MOVArticulosTrans
WITH ENCRYPTION
AS
		
		SELECT 	id, id_articulo, id_bodega, id_entrada id_factura, codigo, presentacion, nombre, cantidad, costo, 0 precio, 'ENTRADAS' op, idestado estado, created, fechaentra fechamov
		FROM   
			VW_MOVEntradasItems

		UNION ALL

		SELECT id, id_producto, id_bodega, id_factura, codigo, presentacion, nombre, cantidad, costo, precio, 'FACTURA' op, estado, created, fechafac
		FROM   
			VW_MOVFacturaItems

		UNION ALL

		SELECT 	id, id_articulo, id_bodega, id_devolucion, codigo, presentacion, nombre, cantidad, 0, precio, 'DEV. FACTURA' op, estado, created, fechadev
		FROM   
			VW_MOVDevFacturaItems
		
		UNION ALL
		
		SELECT 	id, id_articulo, id_bodega, id_devolucion, codigo, presentacion, nombre, cantidad*-1, costo, 0, 'DEV. ENTRADA' op, estado, created, fechadev
		FROM   
			VW_MOVDevEntradaItems

		UNION ALL

		SELECT 	iditem, id_articulo, id_bodega, id_ajuste, codigo, presentacion, nombre, cantidad, costo, 0, 'AJUSTE' op, estado, created, fecha
		FROM   
			VW_MOVAJustesItems
			
		UNION ALL

		SELECT 	iditem, id_articulo, id_bodega, id, codigo, presentacion, nombre, cantidad *-1, costo, 0, 'TRASLADO ENV' op, estado, created, fecha
		FROM   
			VW_MOVTrasladosItems

		UNION ALL

		SELECT 	iditem, id_articulo, id_bodegades, id, codigo, presentacion, nombre, cantidad, costo, 0, 'TRASLADO DES' op, estado, created, fecha
		FROM   
			VW_MOVTrasladosItems	

GO