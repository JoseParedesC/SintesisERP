--liquibase formatted sql
--changeset ,apuello:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
UPDATE dbo.ST_Reportes
	set nombreproce		=	'[dbo].[ST_Rpt_EntradasasTotal]'
	WHERE nombre = 'Entradas Totales'

UPDATE dbo.ST_Reportes
	SET
		nombreproce		=	'[CNT].[ST_Rpt_EstadoClientes]'
	WHERE nombre = 'Estado de Cliente'

UPDATE dbo.ST_Reportes
	set nombreproce		=	'[dbo].[ST_Rpt_ComprasxProveedor]'
	where nombre = 'Compras por Proveedor'

UPDATE dbo.ST_Reportes
	set nombreproce		=	'[dbo].[ST_Rpt_VentasxProductos]'
	where nombre = 'Ventas por Productos'

UPDATE dbo.ST_Reportes
	set nombreproce		=	'[dbo].[ST_Rpt_VentasxCliente]'
	where nombre = 'Ventas por Cliente'

UPDATE dbo.ST_Reportes
	set nombreproce		=	'[CNT].[ST_Rpt_ExtractoCuentaCliente]'
	where nombre = 'Extracto de Cliente'

UPDATE dbo.ST_Reportes
	set nombreproce		=	'[CNT].[ST_Rpt_AuxiliaresContable]'
	where nombre = 'Contabilidad - Auxiliar Contable'

UPDATE dbo.ST_Reportes
	set 
		nombreproce			=	'[CNT].[ST_Rpt_AuxiliaresImpuestos]'
	where nombre = 'Contabilidad - Auxiliar Impuestos'

UPDATE dbo.ST_Reportes
	set nombreproce		=	'[CNT].[ST_Rpt_SaldoCuenta]'
	where nombre = 'Saldo de cuentas'

UPDATE dbo.ST_Reportes
	set 
		nombreproce			=	'[dbo].[ST_Rpt_MovAjuste]',
		paramadicionales	=	';op|B'
	where nombre = 'Ajuste de Inventario'

UPDATE dbo.ST_Reportes
	set 
		nombreproce			=	'[CNT].[ST_Rpt_BalanceGeneral]',
		paramadicionales	=	';op|T'
	where nombre = 'Balance general'

UPDATE dbo.ST_Reportes
	set nombreproce		=	'[CNT].[ST_Rpt_EstadoClientes]'
	where nombre = 'Estado de Cliente'

UPDATE dbo.ST_Reportes
	set nombreproce		=	'ST_Rpt_ComprasxProductos'
	where nombre = 'Compras por Producto'

--Empiezan los Scripts de la tabla CamposReporte
UPDATE dbo.ST_CamposReporte
	set
		parametro = 'fechafinal'
	WHERE id_reporte = (SELECT id FROM dbo.ST_Reportes WHERE frx = 'ComprasProductos.frx') AND parametro = 'fechafin'

UPDATE dbo.ST_CamposReporte
	set 
		parametro	=	'id_proveedor'
	where id_reporte = (SELECT id FROM dbo.ST_Reportes WHERE frx = 'ComprasProveedorNew.frx') AND parametro = 'idproveedor'

UPDATE dbo.ST_CamposReporte
	set 
		parametro	=	'fechafinal'
	where id_reporte = (SELECT id FROM dbo.ST_Reportes WHERE frx = 'ComprasProveedorNew.frx') AND parametro = 'fechafin'

UPDATE dbo.ST_CamposReporte
	set 
		parametro	=	'fechafinal'
	where id_reporte = (SELECT id FROM dbo.ST_Reportes WHERE frx = 'VentasClientes.frx') AND parametro = 'fechafin'

UPDATE dbo.ST_CamposReporte
	set 
		parametro	=	'id_user'
	where id_reporte = (SELECT id FROM dbo.ST_Reportes WHERE frx = 'VentasClientes.frx') AND parametro = 'idcliente'

UPDATE dbo.ST_CamposReporte
	set 
		parametro	=	'id_cliente'
	where id_reporte = (SELECT id FROM dbo.ST_Reportes WHERE frx = 'EstadoClientes.frx') AND parametro = 'idcliente'

UPDATE dbo.ST_CamposReporte
	set 
		parametro	=	'Impuesto'
	where id_reporte = (SELECT id FROM dbo.ST_Reportes WHERE frx = 'AuxiliarImpuestos.frx') AND parametro = 'impuesto'

UPDATE dbo.ST_CamposReporte
	set 
		parametro	=	'fechafinal'
	where id_reporte = (SELECT id FROM dbo.ST_Reportes WHERE frx = 'AuxiliarImpuestos.frx') AND parametro = 'fechafin'
GO

DECLARE @id_reporte BIGINT = (SELECT id FROM dbo.ST_Reportes WHERE frx = 'ExistenciaGeneral.frx')
INSERT INTO dbo.ST_CamposReporte 
(parametro, codigo, nombre, tipo, fuente, ancho, orden, metadata, campos, seleccion, id_reporte, estado, requerido, id_user)
VALUES 
('id_articulo', 'ARTICULO', 'Producto', 'search', 'Productos', 3, 2, 'ProductosList', 'id,codigo,presentacion,nombre', '1,4', @id_reporte, 1, 0, 1)

DECLARE @id BIGINT = (SELECT id FROM dbo.ST_Reportes WHERE frx = 'VentasProductos.frx')
INSERT INTO dbo.ST_CamposReporte 
(parametro, codigo, nombre, tipo, fuente, ancho, orden, metadata, campos, seleccion, id_reporte, estado, requerido, id_user)
VALUES 
('fechaini', 'FECHAINI', 'fecha inicial', 'date', '', 2, 1, '', '', '', @id, 1, 1, 1),
('fechafinal', 'FECHAFINAL', 'fecha final', 'date', '', 2, 2, '', '', '', @id, 1, 1, 1),
('id_producto', 'IDPRODUCTO', 'Producto', 'search', 'Productos', 4, 1, 'ProductosList', 'id,codigo,presentacion,nombre', '1,4', @id, 1, 1, 1)

UPDATE dbo.ST_Reportes
	SET
		nombreproce = '[CNT].[ST_Rpt_ExtractoCuentaCliente]'
	WHERE nombre = 'Extracto de cliente'


UPDATE dbo.ST_Reportes
	SET
		paramadicionales = ';op|B'
	WHERE nombre = 'Existencia General'

UPDATE dbo.ST_CamposReporte
	SET
		parametro = 'id_cliente'
	WHERE id_reporte = (SELECT id FROM dbo.ST_Reportes WHERE frx = 'ExistenciaGeneral.frx' AND parametro = 'idcliente')

UPDATE dbo.ST_CamposReporte
	SET
		parametro = 'codigoini'
	WHERE id_reporte = (SELECT id FROM dbo.ST_Reportes WHERE frx = 'AuxiliarImpuestos.frx') AND codigo = 'CUENTA'

UPDATE dbo.ST_CamposReporte
	SET 
		parametro = 'codigoFin'
	WHERE id_reporte = (SELECT id FROM dbo.ST_reportes WHERE frx = 'AuxiliarImpuestos.frx') AND codigo = 'CUENTAFINAL'

UPDATE dbo.ST_CamposReporte
	SET
		parametro = 'fecha'
	WHERE id_reporte = (SELECT id FROM dbo.ST_reportes WHERE frx = 'EstadoClientes.frx') AND parametro = 'fechaini'

UPDATE dbo.ST_reportes
	SET
		paramadicionales = ''
	WHERE paramadicionales = ';tipoter|PR' AND id = (SELECT id FROM dbo.ST_reportes WHERE frx = 'ComprasProveedorNew.frx')

UPDATE dbo.ST_reportes
	SET
		paramadicionales = ';opcion|D'
	WHERE frx = 'AuxiliaresContable.frx'

UPDATE dbo.ST_CamposReporte
	SET	
		parametro = 'fechafinal'
	WHERE id_reporte = (SELECT id FROM dbo.ST_reportes WHERE frx = 'AuxiliaresContable.frx') AND parametro = 'fechafin'


UPDATE dbo.ST_CamposReporte
	SET
		parametro = 'cuenta'
	WHERE id_reporte = (SELECT id FROM dbo.ST_reportes WHERE frx = 'AuxiliaresContable.frx') AND parametro = 'cuentaini'

UPDATE dbo.ST_CamposReporte
	SET
		parametro = 'codigoFin'
	WHERE id_reporte = (SELECT id FROM dbo.ST_reportes WHERE frx = 'AuxiliaresContable.frx') AND parametro = 'cuentaFin'
GO
	
DECLARE @id BIGINT = (SELECT id FROM dbo.ST_Reportes WHERE frx = 'ExtractoClientes.frx')
INSERT INTO dbo.ST_CamposReporte
(parametro, codigo, nombre, tipo, fuente, ancho, orden, metadata, campos, seleccion, id_reporte, estado, requerido, id_user, params) 
VALUES 
('fechaini', 'FECHAINI', 'Fecha inicial', 'date', '', 2, 1, '', '', '', @id, 1, 0, 1, ''),
('fechafinal', 'FECHAFINAL', 'fecha final', 'date', '', 2, 2, '', '', '', @id, 1, 0, 1, ''),
('factura', 'FACTURA', 'Factura', 'search', 'Facturas', 4, 4, 'FacturasList', 'id,consecutivo,total', '2,2', @id, 1, 0, 1, '')

UPDATE dbo.ST_CamposReporte
	SET
		orden = 3,
		parametro = 'id_cliente'
	WHERE id_reporte = (SELECT id FROM dbo.ST_Reportes WHERE frx = 'ExtractoClientes.frx') AND parametro = 'idcliente'
	
UPDATE dbo.ST_CamposReporte
	SET
		parametro = 'fechafin'
	WHERE id_reporte = (SELECT id FROM dbo.ST_Reportes WHERE frx = 'VentasProductos.frx') AND parametro = 'fechafinal'

UPDATE dbo.ST_CamposReporte
	SET
		orden = 2
	WHERE id_reporte = (SELECT id FROM dbo.ST_Reportes WHERE frx = 'VentasProductos.frx') AND parametro = 'fechafin'

UPDATE dbo.ST_CamposReporte
	SET
		orden = 3
	WHERE id_reporte = (SELECT id FROM dbo.ST_Reportes WHERE frx = 'VentasProductos.frx') AND parametro = 'id_producto'

GO

DECLARE @id BIGINT

INSERT [dbo].[ST_Reportes] 
([codigo], [nombre], [frx], [listado], [estado], [id_user], [nombreproce], [paramadicionales]) 
VALUES (N'VENTASDETALLE', N'Ventas detallada', N'VentasDiariasDetalle.frx', 1, 1, 1, N'[dbo].[ST_Rpt_VentasxItems]', N'')

SET @id=SCOPE_IDENTITY()

INSERT [dbo].[ST_CamposReporte] ( [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido],  [id_user], [params]) 
VALUES ( N'fechaini', N'FECHAINI', N'Fecha inicial', N'date', N'', 2, 1, N'', N'', N'', @id, 1, 1, 1, N'')
INSERT [dbo].[ST_CamposReporte] ( [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [id_user], [params]) 
VALUES ( N'fechafin', N'FECHAFIN', N'Fecha final', N'date', N'', 2, 2, N'', N'', N'', @id, 1, 1,  1, N'')
INSERT [dbo].[ST_CamposReporte] ( [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido],  [id_user], [params])
VALUES ( N'idcaja', N'CCOSTO', N'Centro Costo', N'search', N'CNTCentrosCostos', 3, 3, N'CNTCentroCostosListEsDetalle', N'id,nombre', N'1,2', @id, 1, 0,  1, N'')
GO

DECLARE @id_reporte BIGINT = (SELECT id FROM dbo.ST_reportes WHERE frx = 'RentabilidadProducto.frx')
INSERT INTO dbo.ST_CamposReporte 
(parametro, codigo, nombre, tipo, fuente, ancho, orden, metadata, campos, seleccion, id_reporte, estado, requerido, id_user) 
VALUES 
('id_producto', 'IDPRODUCTO', 'Producto', 'search', 'Productos', 4, 3, 'ProductosList', 'id,codigo,presentacion,nombre', '1,4', @id_reporte, 1, 0, 1)
GO


UPDATE dbo.ST_Reportes
	SET
		nombreproce = '[dbo].[ST_Rpt_RentabilidadProducto]'
	WHERE id = (SELECT id FROM dbo.ST_Reportes WHERE frx = 'RentabilidadProducto.frx')
GO
UPDATE dbo.ST_CamposReporte
	SET
		parametro = 'fechafinal'
	WHERE id_reporte = (SELECT id FROM dbo.ST_Reportes WHERE frx = 'RentabilidadProducto.frx') AND parametro = 'fechafin'
GO