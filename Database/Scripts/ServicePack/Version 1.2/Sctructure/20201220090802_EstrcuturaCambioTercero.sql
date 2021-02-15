--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
/*ACTUALIZACION Y MIGRACION DE COMPROBANTE CONTABLE*/

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS  WHERE CONSTRAINT_NAME = 'FK_MOVComprobantesContablesItems_Terceros'  )
BEGIN
ALTER TABLE [CNT].[MOVComprobantesContablesItems]
DROP CONSTRAINT [FK_MOVComprobantesContablesItems_Terceros];   
END

UPDATE C SET C.ID_TERCERO=T.id
FROM CNT.MOVComprobantesContablesItems C INNER JOIN CNT.TipoTerceros TT ON C.id_tercero=TT.id INNER JOIN
CNT.Terceros T ON TT.id_tercero=T.id 


 
ALTER TABLE [CNT].[MOVComprobantesContablesItems] WITH CHECK ADD  CONSTRAINT [FK_MOVComprobantesContablesItems_Terceros] FOREIGN KEY([id_tercero])
REFERENCES [CNT].[Terceros] ([id])

ALTER TABLE [CNT].[MOVComprobantesContablesItems] CHECK CONSTRAINT [FK_MOVComprobantesContablesItems_Terceros]


/*[CNT].[MOVComprobantesEgresos]

*/

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS  WHERE CONSTRAINT_NAME = 'FK_ComprobanteEgre_Terceros'  )
BEGIN
ALTER TABLE [CNT].[MOVComprobantesEgresos]
DROP CONSTRAINT [FK_ComprobanteEgre_Terceros];   
END

UPDATE C SET C.id_proveedor=T.id
FROM CNT.MOVComprobantesEgresos C INNER JOIN CNT.TipoTerceros TT ON C.id_proveedor=TT.id INNER JOIN
CNT.Terceros T ON TT.id_tercero=T.id 


 
ALTER TABLE [CNT].[MOVComprobantesEgresos]  WITH CHECK ADD  CONSTRAINT [FK_ComprobanteEgre_Terceros] FOREIGN KEY([id_proveedor])
REFERENCES [CNT].[Terceros] ([id])

ALTER TABLE [CNT].[MOVComprobantesEgresos] CHECK CONSTRAINT [FK_ComprobanteEgre_Terceros]


/*
[CNT].[MOVNotasCartera]

*/

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS  WHERE CONSTRAINT_NAME = 'FK_MOVNotasCartera_TipoTerceros'  )
BEGIN
ALTER TABLE [CNT].[MOVNotasCartera]
DROP CONSTRAINT [FK_MOVNotasCartera_TipoTerceros];   
END

UPDATE C SET C.id_tercero=T.id
FROM [CNT].[MOVNotasCartera] C INNER JOIN CNT.TipoTerceros TT ON C.id_tercero=TT.id INNER JOIN
CNT.Terceros T ON TT.id_tercero=T.id 


 
ALTER TABLE [CNT].[MOVNotasCartera]  WITH CHECK ADD  CONSTRAINT [FK_MOVNotasCartera_Terceros] FOREIGN KEY([id_tercero])
REFERENCES [CNT].[Terceros] ([id])


ALTER TABLE [CNT].[MOVNotasCartera] CHECK CONSTRAINT [FK_MOVNotasCartera_Terceros]



/*

[CNT].[MOVReciboCajas]
 AQUI SE CREO LA RELACION YA QUE NO LA TENIA
*/
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS  WHERE CONSTRAINT_NAME = 'FK_ReciboCajas_Terceros'  )
BEGIN
ALTER TABLE [CNT].[MOVReciboCajas]
DROP CONSTRAINT [FK_ReciboCajas_Terceros];   
END
UPDATE C SET C.id_cliente=T.id
FROM [CNT].[MOVReciboCajas] C INNER JOIN CNT.TipoTerceros TT ON C.id_cliente=TT.id INNER JOIN
CNT.Terceros T ON TT.id_tercero=T.id 


 
ALTER TABLE [CNT].[MOVReciboCajas]  WITH CHECK ADD  CONSTRAINT [FK_ReciboCajas_Terceros] FOREIGN KEY([id_cliente])
REFERENCES [CNT].[Terceros] ([id])

ALTER TABLE [CNT].[MOVReciboCajas] CHECK CONSTRAINT [FK_ReciboCajas_Terceros]

/*
[CNT].[SaldoCliente]

*/


IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS  WHERE CONSTRAINT_NAME = 'FK_SaldoCliente_Terceros'  )
BEGIN
ALTER TABLE [CNT].[SaldoCliente]
DROP CONSTRAINT [FK_SaldoCliente_Terceros];   
END

UPDATE C SET C.id_cliente=T.id
FROM [CNT].[SaldoCliente] C INNER JOIN CNT.TipoTerceros TT ON C.id_cliente=TT.id INNER JOIN
CNT.Terceros T ON TT.id_tercero=T.id 


 
ALTER TABLE [CNT].[SaldoCliente]  WITH CHECK ADD  CONSTRAINT [FK_SaldoCliente_Terceros] FOREIGN KEY([id_cliente])
REFERENCES [CNT].[Terceros] ([id])


ALTER TABLE [CNT].[SaldoCliente] CHECK CONSTRAINT [FK_SaldoCliente_Terceros]


/*

[CNT].[SaldoCliente_Cuotas]


*/

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS  WHERE CONSTRAINT_NAME = 'FK_SaldoClienteCuotas_Terceros'  )
BEGIN
ALTER TABLE [CNT].[SaldoCliente_Cuotas]
DROP CONSTRAINT [FK_SaldoClienteCuotas_Terceros];   
END

UPDATE C SET C.id_cliente=T.id
FROM [CNT].[SaldoCliente_Cuotas] C INNER JOIN CNT.TipoTerceros TT ON C.id_cliente=TT.id INNER JOIN
CNT.Terceros T ON TT.id_tercero=T.id 


 
ALTER TABLE [CNT].[SaldoCliente_Cuotas]  WITH CHECK ADD  CONSTRAINT [FK_SaldoClienteCuotas_Terceros] FOREIGN KEY([id_cliente])
REFERENCES [CNT].[Terceros] ([id])


ALTER TABLE [CNT].[SaldoCliente_Cuotas] CHECK CONSTRAINT [FK_SaldoClienteCuotas_Terceros]

/*
[CNT].[SaldoProveedor]


*/



IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS  WHERE CONSTRAINT_NAME = 'FK_SaldoProveedor_Terceros'  )
BEGIN
ALTER TABLE [CNT].[SaldoProveedor]
DROP CONSTRAINT [FK_SaldoProveedor_Terceros];   
END

UPDATE C SET C.id_proveedor=T.id
FROM [CNT].[SaldoProveedor] C INNER JOIN CNT.TipoTerceros TT ON C.id_proveedor=TT.id INNER JOIN
CNT.Terceros T ON TT.id_tercero=T.id 


 
ALTER TABLE [CNT].[SaldoProveedor]  WITH CHECK ADD  CONSTRAINT [FK_SaldoProveedor_Terceros] FOREIGN KEY([id_proveedor])
REFERENCES [CNT].[Terceros] ([id])


ALTER TABLE [CNT].[SaldoProveedor] CHECK CONSTRAINT [FK_SaldoProveedor_Terceros]


/*
[CNT].[SaldoAnticipos]


*/



IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS  WHERE CONSTRAINT_NAME = 'FK_SaldoAnticipos_Terceros'  )
BEGIN
ALTER TABLE [CNT].[SaldoAnticipos]
DROP CONSTRAINT [FK_SaldoAnticipos_Terceros];   
END

UPDATE C SET C.id_tercero=T.id
FROM [CNT].[SaldoAnticipos] C INNER JOIN CNT.TipoTerceros TT ON C.id_tercero=TT.id INNER JOIN
CNT.Terceros T ON TT.id_tercero=T.id 


 
ALTER TABLE [CNT].[SaldoAnticipos]  WITH CHECK ADD  CONSTRAINT [FK_SaldoAnticipos_Terceros] FOREIGN KEY([id_tercero])
REFERENCES [CNT].[Terceros] ([id])


ALTER TABLE [CNT].[SaldoAnticipos] CHECK CONSTRAINT [FK_SaldoAnticipos_Terceros]



/*

[CNT].[SaldoTercero]

*/

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS  WHERE CONSTRAINT_NAME = 'FK_SaldoTercero_TipoTerceros'  )
BEGIN
ALTER TABLE [CNT].[SaldoTercero]
DROP CONSTRAINT [FK_SaldoTercero_TipoTerceros];   
END

UPDATE C SET C.id_tercero=T.id
FROM [CNT].[SaldoTercero] C INNER JOIN CNT.TipoTerceros TT ON C.id_tercero=TT.id INNER JOIN
CNT.Terceros T ON TT.id_tercero=T.id 


 
ALTER TABLE [CNT].[SaldoTercero]  WITH CHECK ADD  CONSTRAINT [FK_SaldoTercero_Terceros] FOREIGN KEY([id_tercero])
REFERENCES [CNT].[Terceros] ([id])
GO

ALTER TABLE [CNT].[SaldoTercero] CHECK CONSTRAINT [FK_SaldoTercero_Terceros]
GO


/*

[CNT].[TerceroAdicionales]

*/

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS  WHERE CONSTRAINT_NAME = 'FK_Terceroadicionales_Terceros'  )
BEGIN
ALTER TABLE [CNT].[TerceroAdicionales]
DROP CONSTRAINT [FK_Terceroadicionales_Terceros];   
END

UPDATE C SET C.id_tercero=T.id
FROM [CNT].[TerceroAdicionales] C INNER JOIN CNT.TipoTerceros TT ON C.id_tercero=TT.id INNER JOIN
CNT.Terceros T ON TT.id_tercero=T.id 


 
ALTER TABLE [CNT].[TerceroAdicionales]  WITH CHECK ADD  CONSTRAINT [FK_Terceroadicionales_Terceros] FOREIGN KEY([id_tercero])
REFERENCES [CNT].[Terceros] ([id])
GO

ALTER TABLE [CNT].[TerceroAdicionales] CHECK CONSTRAINT [FK_Terceroadicionales_Terceros]
GO


/*

[CNT].[Transacciones]

*/

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS  WHERE CONSTRAINT_NAME = 'FK_Transacciones_Terceros'  )
BEGIN
ALTER TABLE [CNT].[Transacciones]
DROP CONSTRAINT [FK_Transacciones_Terceros];   
END

UPDATE C SET C.id_tercero=T.id
FROM [CNT].[Transacciones] C INNER JOIN CNT.TipoTerceros TT ON C.id_tercero=TT.id INNER JOIN
CNT.Terceros T ON TT.id_tercero=T.id 


 
ALTER TABLE [CNT].[Transacciones]  WITH CHECK ADD  CONSTRAINT [FK_Transacciones_Terceros] FOREIGN KEY([id_tercero])
REFERENCES [CNT].[Terceros] ([id])
GO

ALTER TABLE [CNT].[Transacciones] CHECK CONSTRAINT [FK_Transacciones_Terceros]
GO




/*

[dbo].[Cajas]

*/

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS  WHERE CONSTRAINT_NAME = 'FK_Cajas_Terceros'  )
BEGIN
ALTER TABLE [dbo].[Cajas]
DROP CONSTRAINT [FK_Cajas_Terceros];   
END

UPDATE C SET C.id_cliente=T.id
FROM [dbo].[Cajas] C INNER JOIN CNT.TipoTerceros TT ON C.id_cliente=TT.id INNER JOIN
CNT.Terceros T ON TT.id_tercero=T.id 


 
ALTER TABLE [dbo].[Cajas]  WITH CHECK ADD  CONSTRAINT [FK_Cajas_Terceros] FOREIGN KEY([id_cliente])
REFERENCES [CNT].[Terceros] ([id])
GO

ALTER TABLE [dbo].[Cajas] CHECK CONSTRAINT [FK_Cajas_Terceros]
GO



/*

[dbo].[MOVCotizacion]
*/


IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS  WHERE CONSTRAINT_NAME = 'FK_MOVCotizacion_Terceros'  )
BEGIN
ALTER TABLE [dbo].[MOVCotizacion]
DROP CONSTRAINT [FK_MOVCotizacion_Terceros];   
END

UPDATE C SET C.id_cliente=T.id
FROM [dbo].[MOVCotizacion] C INNER JOIN CNT.TipoTerceros TT ON C.id_cliente=TT.id INNER JOIN
CNT.Terceros T ON TT.id_tercero=T.id 


ALTER TABLE [dbo].[MOVCotizacion]  WITH CHECK ADD  CONSTRAINT [FK_MOVCotizacion_Terceros] FOREIGN KEY([id_cliente])
REFERENCES [CNT].[Terceros] ([id])
GO

ALTER TABLE [dbo].[MOVCotizacion] CHECK CONSTRAINT [FK_MOVCotizacion_Terceros]
GO


/*

[dbo].[MOVDocumentosCajas]
*/


IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS  WHERE CONSTRAINT_NAME = 'FK_MOVDocumentosCajas_Terceros'  )
BEGIN
ALTER TABLE [dbo].[MOVDocumentosCajas]
DROP CONSTRAINT [FK_MOVDocumentosCajas_Terceros];   
END

UPDATE C SET C.id_tercero=T.id
FROM [dbo].[MOVDocumentosCajas] C INNER JOIN CNT.TipoTerceros TT ON C.id_tercero=TT.id INNER JOIN
CNT.Terceros T ON TT.id_tercero=T.id 


ALTER TABLE [dbo].[MOVDocumentosCajas]  WITH CHECK ADD  CONSTRAINT [FK_MOVDocumentosCajas_Terceros] FOREIGN KEY([id_tercero])
REFERENCES [CNT].[Terceros] ([id])
GO

ALTER TABLE [dbo].[MOVDocumentosCajas] CHECK CONSTRAINT [FK_MOVDocumentosCajas_Terceros]
GO

/*

[dbo].[MOVEntradas]
*/


IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS  WHERE CONSTRAINT_NAME = 'FK_MOVEntradas_Proveedores'  )
BEGIN
ALTER TABLE [dbo].[MOVEntradas]
DROP CONSTRAINT [FK_MOVEntradas_Proveedores];   
END
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS  WHERE CONSTRAINT_NAME = 'FK_MOVEntradas_ProveedoresFlete'  )
BEGIN
ALTER TABLE [dbo].[MOVEntradas]
DROP CONSTRAINT [FK_MOVEntradas_ProveedoresFlete];   
END

UPDATE C SET C.id_proveedor=T.id
FROM [dbo].[MOVEntradas] C INNER JOIN CNT.TipoTerceros TT ON C.id_proveedor=TT.id INNER JOIN
CNT.Terceros T ON TT.id_tercero=T.id 

UPDATE C SET C.id_proveflete=T.id
FROM [dbo].[MOVEntradas] C INNER JOIN CNT.TipoTerceros TT ON C.id_proveflete=TT.id INNER JOIN
CNT.Terceros T ON TT.id_tercero=T.id 

ALTER TABLE [dbo].[MOVEntradas]  WITH CHECK ADD  CONSTRAINT [FK_MOVEntradas_Proveedores] FOREIGN KEY([id_proveedor])
REFERENCES [CNT].[Terceros] ([id])
GO

ALTER TABLE [dbo].[MOVEntradas] CHECK CONSTRAINT [FK_MOVEntradas_Proveedores]
GO

ALTER TABLE [dbo].[MOVEntradas]  WITH CHECK ADD  CONSTRAINT [FK_MOVEntradas_ProveedoresFlete] FOREIGN KEY([id_proveflete])
REFERENCES [CNT].[Terceros] ([id])
GO

ALTER TABLE [dbo].[MOVEntradas] CHECK CONSTRAINT [FK_MOVEntradas_ProveedoresFlete]
GO

/*
[dbo].[MOVFactura]

*/


IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS  WHERE CONSTRAINT_NAME = 'FK_MOVFactura_Tercero'  )
BEGIN
ALTER TABLE [dbo].[MOVFactura]
DROP CONSTRAINT [FK_MOVFactura_Tercero];   
END

UPDATE C SET C.id_tercero=T.id
FROM [dbo].[MOVFactura] C INNER JOIN CNT.TipoTerceros TT ON C.id_tercero=TT.id INNER JOIN
CNT.Terceros T ON TT.id_tercero=T.id 


ALTER TABLE [dbo].[MOVFactura]  WITH CHECK ADD  CONSTRAINT [FK_MOVFactura_Tercero] FOREIGN KEY([id_tercero])
REFERENCES [CNT].[Terceros] ([id])
GO

ALTER TABLE [dbo].[MOVFactura] CHECK CONSTRAINT [FK_MOVFactura_Tercero]
GO

/*
[dbo].[MOVFacturasRecurrentes]

*/


IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS  WHERE CONSTRAINT_NAME = 'FK_MOVFacturaRecurrentes_Tercero'  )
BEGIN
ALTER TABLE [dbo].[MOVFacturasRecurrentes]
DROP CONSTRAINT [FK_MOVFacturaRecurrentes_Tercero];   
END

UPDATE C SET C.id_tercero=T.id
FROM [dbo].[MOVFacturasRecurrentes] C INNER JOIN CNT.TipoTerceros TT ON C.id_tercero=TT.id INNER JOIN
CNT.Terceros T ON TT.id_tercero=T.id 


ALTER TABLE [dbo].[MOVFacturasRecurrentes]  WITH CHECK ADD  CONSTRAINT [FK_MOVFacturaRecurrentes_Tercero] FOREIGN KEY([id_tercero])
REFERENCES [CNT].[Terceros] ([id])
GO

ALTER TABLE [dbo].[MOVFacturasRecurrentes] CHECK CONSTRAINT [FK_MOVFacturaRecurrentes_Tercero]
GO


/*

[dbo].[MovOrdenCompras]
*/


IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS  WHERE CONSTRAINT_NAME = 'FK_MovOrdenCompras_Terceros1'  )
BEGIN
ALTER TABLE [dbo].[MovOrdenCompras]
DROP CONSTRAINT [FK_MovOrdenCompras_Terceros1];   
END

UPDATE C SET C.id_proveedor=T.id
FROM [dbo].[MovOrdenCompras] C INNER JOIN CNT.TipoTerceros TT ON C.id_proveedor=TT.id INNER JOIN
CNT.Terceros T ON TT.id_tercero=T.id 

ALTER TABLE [dbo].[MovOrdenCompras]  WITH CHECK ADD  CONSTRAINT [FK_MovOrdenCompras_Terceros1] FOREIGN KEY([id_proveedor])
REFERENCES [CNT].[Terceros] ([id])
GO

ALTER TABLE [dbo].[MovOrdenCompras] CHECK CONSTRAINT [FK_MovOrdenCompras_Terceros1]
GO


/*
[dbo].[MOVPagoCajas]

*/


IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS  WHERE CONSTRAINT_NAME = 'FK_MOVPagoCajas_Terceros'  )
BEGIN
ALTER TABLE [dbo].[MOVPagoCajas]
DROP CONSTRAINT [FK_MOVPagoCajas_Terceros];   
END

UPDATE C SET C.id_tercero=T.id
FROM [dbo].[MOVPagoCajas] C INNER JOIN CNT.TipoTerceros TT ON C.id_tercero=TT.id INNER JOIN
CNT.Terceros T ON TT.id_tercero=T.id 

ALTER TABLE [dbo].[MOVPagoCajas] WITH CHECK ADD  CONSTRAINT [FK_MOVPagoCajas_Terceros] FOREIGN KEY([id_tercero])
REFERENCES [CNT].[Terceros] ([id])
GO

ALTER TABLE [dbo].[MOVPagoCajas] CHECK CONSTRAINT [FK_MOVPagoCajas_Terceros]
GO




/*

[dbo].[MOVPedidos]
*/


IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS  WHERE CONSTRAINT_NAME = 'FK_MOVPedidos_Terceros'  )
BEGIN
ALTER TABLE [dbo].[MOVPedidos]
DROP CONSTRAINT [FK_MOVPedidos_Terceros];   
END

UPDATE C SET C.id_proveedor=T.id
FROM [dbo].[MOVPedidos] C INNER JOIN CNT.TipoTerceros TT ON C.id_proveedor=TT.id INNER JOIN
CNT.Terceros T ON TT.id_tercero=T.id 

ALTER TABLE [dbo].[MOVPedidos] WITH CHECK ADD  CONSTRAINT [FK_MOVPedidos_Terceros] FOREIGN KEY([id_proveedor])
REFERENCES [CNT].[Terceros] ([id])
GO

ALTER TABLE [dbo].[MOVPedidos] CHECK CONSTRAINT [FK_MOVPedidos_Terceros]
GO

/*
[dbo].[MOVEntradasTemp]

*/


IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS  WHERE CONSTRAINT_NAME = 'FK_MOVEntradasTemp_Proveedores'  )
BEGIN
ALTER TABLE [dbo].[MOVEntradasTemp]
DROP CONSTRAINT [FK_MOVEntradasTemp_Proveedores];   
END

UPDATE C SET C.id_proveedor=T.id
FROM [dbo].[MOVEntradasTemp] C INNER JOIN CNT.TipoTerceros TT ON C.id_proveedor=TT.id INNER JOIN
CNT.Terceros T ON TT.id_tercero=T.id 


 
ALTER TABLE [dbo].[MOVEntradasTemp]  WITH CHECK ADD  CONSTRAINT [FK_MOVEntradasTemp_Proveedores] FOREIGN KEY([id_proveedor])
REFERENCES [CNT].[Terceros] ([id])

ALTER TABLE [dbo].[MOVEntradasTemp] CHECK CONSTRAINT [FK_MOVEntradasTemp_Proveedores]


/*
Agregar campo de id_tipoanticipos el cual hace referencia a la tabla de st_listados y 
me determina si es una anticipo de tipo cliente o proveedor
*/
IF COL_LENGTH('[dbo].[MOVANTICIPOS]', 'id_tipoanticipo') IS NULL
BEGIN
     Alter Table
         [dbo].[MOVANTICIPOS]
     Add
         [id_tipoanticipo] BIGINT;
END
GO
/*
Antes de hacer cambio de referencia de terceros realizar este procedimiento
en donde teniendo en cuenta e tipo de tercero que estaba definido se determina el tipo de anticipo
*/
UPDATE A  SET A.id_tipoanticipo=T.id_tipoter   from  dbo.MOVAnticipos A JOIN CNT.VW_TercerosTipo T ON A.id_tercero = T.id


/*
MOVDEVANTICIPOS
Agregar campo de id_tipoanticipos el cual hace referencia a la tabla de st_listados y 
me determina si es una anticipo de tipo cliente o proveedor
*/
IF COL_LENGTH('[dbo].[MOVDEVANTICIPOS]', 'id_tipoanticipo') IS NULL
BEGIN
     Alter Table
         [dbo].[MOVDEVANTICIPOS]
     Add
         [id_tipoanticipo] BIGINT;
END
GO
/*
Antes de hacer cambio de referencia de terceros realizar este procedimiento
en donde teniendo en cuenta e tipo de tercero que estaba definido se determina el tipo de anticipo
*/
UPDATE A  SET A.id_tipoanticipo=T.id_tipoter   from  dbo.MOVDevAnticipos A JOIN CNT.VW_TercerosTipo T ON A.id_cliente = T.id

/*CAMBIO DE RELACION
MOVANTICIPO
*/

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS  WHERE CONSTRAINT_NAME = 'FK_MOVAnticipos_Terceros'  )
BEGIN
ALTER TABLE [dbo].[MOVAnticipos]
DROP CONSTRAINT [FK_MOVAnticipos_Terceros];   
END

UPDATE C SET C.id_tercero=T.id
FROM [dbo].[MOVAnticipos] C INNER JOIN CNT.TipoTerceros TT ON C.id_tercero=TT.id INNER JOIN
CNT.Terceros T ON TT.id_tercero=T.id 


ALTER TABLE [dbo].[MOVAnticipos]  WITH CHECK ADD  CONSTRAINT [FK_MOVAnticipos_Terceros] FOREIGN KEY([id_tercero])
REFERENCES [CNT].[Terceros] ([id])
GO

ALTER TABLE [dbo].[MOVAnticipos] CHECK CONSTRAINT [FK_MOVAnticipos_Terceros]
GO

/*MOVDEVANTICIPO*/
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS  WHERE CONSTRAINT_NAME = 'FK_MOVDEVAnticipos_Terceros'  )
BEGIN
ALTER TABLE [dbo].[MOVDEVAnticipos]
DROP CONSTRAINT [FK_MOVDEVAnticipos_Terceros];   
END

UPDATE C SET C.id_cliente=T.id
FROM [dbo].[MOVDEVAnticipos] C INNER JOIN CNT.TipoTerceros TT ON C.id_cliente=TT.id INNER JOIN
CNT.Terceros T ON TT.id_tercero=T.id 


ALTER TABLE [dbo].[MOVDEVAnticipos]  WITH CHECK ADD  CONSTRAINT [FK_MOVDEVAnticipos_Terceros] FOREIGN KEY([id_cliente])
REFERENCES [CNT].[Terceros] ([id])
GO

ALTER TABLE [dbo].[MOVDEVAnticipos] CHECK CONSTRAINT [FK_MOVDEVAnticipos_Terceros]
GO


/*Eliminamos la relacion de recibo de caja con la tabla saldocliente_cuota si existe*/
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS  WHERE CONSTRAINT_NAME = 'FK_MOVReciboCajasItems_SaldoClientes'  )
BEGIN
ALTER TABLE [CNT].[MOVReciboCajasItems]
DROP CONSTRAINT [FK_MOVReciboCajasItems_SaldoClientes];   
END

/*Se hace la actualizacion al campo nuevo de cuota el numero que seria referenciado teniendo encuenta el idsaldo*/
UPDATE C SET C.id_cuota=S.cuota
FROM CNT.MOVReciboCajasItems C INNER JOIN CNT.SaldoCliente_Cuotas S ON C.id_cuota=S.id 

/*Cambio de nombre de columna*/
EXEC sp_RENAME '[CNT].[MOVReciboCajasItems].[id_cuota]' , 'cuota', 'COLUMN'
GO

update c set c.parametro='cuentaini',nombre='Cuenta Inicial',seleccion='2,2',ancho=2 from ST_Reportes r join ST_CamposReporte c on r.id=c.id_reporte where r.codigo='AUXILIARCONTABLE' and parametro='cuenta'
update c set c.parametro='cuentaini',nombre='Cuenta Inicial',seleccion='2,2',ancho=2 from ST_Reportes r join ST_CamposReporte c on r.id=c.id_reporte where r.codigo='AUXILIARIMPUESTOS' and parametro='cuenta'
update c set c.requerido=0 from ST_Reportes r join ST_CamposReporte c on r.id=c.id_reporte where r.codigo='AUXILIARIMPUESTOS' and parametro='impuesto'

/*Agrego campos de reportes*/
INSERT [dbo].[ST_CamposReporte] ( [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [id_user], [params]) VALUES ( N'cuentaFin', N'CUENTAFINAL', N'Cuenta Final', N'search', N'CNTCuentas', 2, 3, N'CNTCuentasDetalle', N'id,codigo,nombre', N'2,2', (select id from ST_Reportes where codigo='AUXILIARIMPUESTOS' ), 1, 0, 1, N'impuesto;2|')
INSERT [dbo].[ST_CamposReporte] ( [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [id_user], [params]) VALUES ( N'cuentaFin', N'CUENTAFINAL', N'Cuenta Final', N'search', N'CNTCuentas', 2, 3, N'CNTCuentasDetalle', N'id,codigo,nombre', N'2,2', (select id from ST_Reportes where codigo='AUXILIARCONTABLE' ), 1, 0, 1, N'')