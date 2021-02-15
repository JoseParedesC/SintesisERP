--liquibase formatted sql
--changeset jtous:1 dbms:mssql endDelimiter:GO

INSERT [dbo].[aspnet_Applications] ([ApplicationName], [LoweredApplicationName], [ApplicationId], [Description]) VALUES (N'SINTESIS ERP', N'sintesis erp', N'D59391A3-D085-4653-9B45-B71B407E49AD', N'')
GO

SET IDENTITY_INSERT [dbo].[aspnet_Users] ON 
GO
INSERT [dbo].[aspnet_Users] ([idUser], [ApplicationId], [UserId], [UserName], [LoweredUserName], [MobileAlias], [IsAnonymous], [LastActivityDate]) VALUES (1, N'D59391A3-D085-4653-9B45-B71B407E49AD', N'f0021429-46d2-46df-9ada-6ef41ceb971a', N'administrador', N'administrador', NULL, 0, CAST(N'2019-09-02 18:07:28.487' AS DateTime))
GO
INSERT [dbo].[aspnet_Users] ([idUser], [ApplicationId], [UserId], [UserName], [LoweredUserName], [MobileAlias], [IsAnonymous], [LastActivityDate]) VALUES (2, N'd59391a3-d085-4653-9b45-b71b407e49ad', N'1dcc6080-cec4-4b67-b9bc-a2af739fb17a', N'admin', N'admin', NULL, 0, CAST(N'2020-12-07 14:58:58.263' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[aspnet_Users] OFF
GO

INSERT [dbo].[aspnet_Membership] ([ApplicationId], [UserId], [Password], [PasswordFormat], [PasswordSalt], [MobilePIN], [Email], [LoweredEmail], [PasswordQuestion], [PasswordAnswer], [IsApproved], [IsLockedOut], [CreateDate], [LastLoginDate], [LastPasswordChangedDate], [LastLockoutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowStart], [Comment]) VALUES (N'D59391A3-D085-4653-9B45-B71B407E49AD', N'f0021429-46d2-46df-9ada-6ef41ceb971a', N'qUYrBx/nDPHAQxFKPOHrcv4Cdujp7mq2nXvcYV2xCi0=', 0, N'cKokqLMLd+7B0XvgT8uzOA==', NULL, N'adminsintesis@gmail.com', N'adminsintesis@gmail.com', N' ', N' ', 1, 0, CAST(N'2019-09-02 18:07:28.487' AS DateTime), CAST(N'2019-09-02 18:07:28.487' AS DateTime), CAST(N'2019-09-02 18:07:28.487' AS DateTime), CAST(N'2019-09-02 18:07:28.487' AS DateTime), 0, CAST(N'2019-09-02 18:07:28.487' AS DateTime), 0, CAST(N'2019-09-02 18:07:28.487' AS DateTime), NULL)
GO
INSERT [dbo].[aspnet_Membership] ([ApplicationId], [UserId], [Password], [PasswordFormat], [PasswordSalt], [MobilePIN], [Email], [LoweredEmail], [PasswordQuestion], [PasswordAnswer], [IsApproved], [IsLockedOut], [CreateDate], [LastLoginDate], [LastPasswordChangedDate], [LastLockoutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowStart], [Comment]) VALUES (N'd59391a3-d085-4653-9b45-b71b407e49ad', N'1dcc6080-cec4-4b67-b9bc-a2af739fb17a', N'iGvhc1pmFQh5dUYKn8gKr08R1eFXgMHfxBJYyEjm498=', 0, N'y3HuqhjZ8W1e89XCE/CnfQ==', NULL, N'admin@gmail.com', N'admin@gmail.com', N' ', N' ', 1, 0, CAST(N'2020-12-07 09:45:00.000' AS DateTime), CAST(N'2020-12-07 15:35:00.427' AS DateTime), CAST(N'2020-12-07 09:45:00.000' AS DateTime), CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), 0, CAST(N'1754-01-01 00:00:00.000' AS DateTime), NULL)
GO

SET IDENTITY_INSERT [dbo].[aspnet_Roles] ON 
GO
INSERT [dbo].[aspnet_Roles] ([id], [ApplicationId], [RoleId], [RoleName], [LoweredRoleName], [Description]) VALUES (1, N'D59391A3-D085-4653-9B45-B71B407E49AD', N'd5045227-6517-465a-9487-779694df5745', N'Super Administrador', N'Super Administrador', NULL)
GO
INSERT [dbo].[aspnet_Roles] ([id], [ApplicationId], [RoleId], [RoleName], [LoweredRoleName], [Description]) VALUES (2, N'D59391A3-D085-4653-9B45-B71B407E49AD', N'97480504-81ed-4e23-b38d-a262287612be', N'Administrador', N'Administrator', NULL)
GO
INSERT [dbo].[aspnet_Roles] ([id], [ApplicationId], [RoleId], [RoleName], [LoweredRoleName], [Description]) VALUES (3, N'D59391A3-D085-4653-9B45-B71B407E49AD', N'7d155e28-de51-4b70-b6f3-554e9368001d', N'Vendedor', N'Vendedor', NULL)
GO
INSERT [dbo].[aspnet_Roles] ([id], [ApplicationId], [RoleId], [RoleName], [LoweredRoleName], [Description]) VALUES (4, N'D59391A3-D085-4653-9B45-B71B407E49AD', N'e30a1f44-59d1-4cbe-86f6-6c7356e484a3', N'Auxiliar', N'Auxiliar', NULL)
GO
SET IDENTITY_INSERT [dbo].[aspnet_Roles] OFF
GO

SET IDENTITY_INSERT [dbo].[Turnos] ON 
GO
INSERT [dbo].[Turnos] ([id], [horainicio], [horafin], [estado], [created], [updated], [id_user]) VALUES (1, N'08:00', N'18:00', 1, CAST(N'20201207 09:44:00' AS SmallDateTime), CAST(N'20201207 09:44:00' AS SmallDateTime), 1)
GO
SET IDENTITY_INSERT [dbo].[Turnos] OFF
GO

SET IDENTITY_INSERT [dbo].[Usuarios] ON 
GO
INSERT [dbo].[Usuarios] ([id], [username], [nombre], [identificacion], [id_turno], [telefono], [email], [id_perfil], [userid], [estado], [created], [updated], [id_user], [apptoken]) VALUES (1, N'administrador', N'Admin Sintesis', NULL, 1, N'000000000', N'', 1, N'f0021429-46d2-46df-9ada-6ef41ceb971a', 1, CAST(N'20170109 00:15:00' AS SmallDateTime), CAST(N'20171226 20:27:00' AS SmallDateTime), 1, N'120131c1-c09d-4372-bec0-8f581fb63abc')
GO
INSERT [dbo].[Usuarios] ([id], [username], [nombre], [identificacion], [id_turno], [telefono], [email], [id_perfil], [userid], [estado], [created], [updated], [id_user], [apptoken]) VALUES (2, N'admin', N'Administrador', N'00000000000', 1, N'00000000', N'admin@gmail.com', 2, N'1dcc6080-cec4-4b67-b9bc-a2af739fb17a', 1, CAST(N'20201207 09:45:00' AS SmallDateTime), CAST(N'20201207 09:45:00' AS SmallDateTime), 1, N'41df1dcc-01cd-47d8-be41-6317f6be2a60')
GO
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
GO

SET IDENTITY_INSERT [dbo].[ST_Reportes] ON 
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (1, N'MOVENTRADA', N'Entrada de  Mercancia', N'MOVCompras.frx', 0, 1, CAST(N'20171125 13:28:00' AS SmallDateTime), CAST(N'20171125 13:28:00' AS SmallDateTime), 1, NULL, N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (2, N'MOVTRASLADO', N'Entrada de  Mercancia', N'MOVTraslado.frx', 0, 1, CAST(N'20171125 13:28:00' AS SmallDateTime), CAST(N'20171125 13:28:00' AS SmallDateTime), 1, NULL, N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (3, N'DOCCAJATIR', N'Entrada de  Mercancia', N'DocumentoCaja.frx', 0, 0, CAST(N'20171125 13:28:00' AS SmallDateTime), CAST(N'20171125 13:28:00' AS SmallDateTime), 1, NULL, N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (4, N'EXISGEN', N'Existencia General', N'ExistenciaGeneral.frx', 1, 1, CAST(N'20171125 13:30:00' AS SmallDateTime), CAST(N'20171125 13:30:00' AS SmallDateTime), 1, N'ST_Rpt_ExistenciaGeneral', N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (5, N'RETFUENTE', N'Retención en la Fuente', N'ReteFuente.frx', 1, 1, CAST(N'20171125 23:39:00' AS SmallDateTime), CAST(N'20171125 23:39:00' AS SmallDateTime), 1, N'ST_Rpt_Retenciones', N';op|FUENTE')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (6, N'RETICA', N'Retención de Ica', N'ReteIca.frx', 1, 1, CAST(N'20171125 23:39:00' AS SmallDateTime), CAST(N'20171125 23:39:00' AS SmallDateTime), 1, N'ST_Rpt_Retenciones', N';op|ICA')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (7, N'RETIVA', N'Retención de Iva', N'ReteIva.frx', 1, 1, CAST(N'20171125 23:39:00' AS SmallDateTime), CAST(N'20171125 23:39:00' AS SmallDateTime), 1, N'ST_Rpt_Retenciones', N';op|IVA')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (8, N'MOVFACTURA', N'Facturación', N'FacturaTirilla.frx', 0, 1, CAST(N'20171125 13:28:00' AS SmallDateTime), CAST(N'20171125 13:28:00' AS SmallDateTime), 1, NULL, N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (9, N'CUACAJAUSU', N'Cuadre de Caja', N'CuadreCaja.frx', 1, 0, CAST(N'20171125 13:28:00' AS SmallDateTime), CAST(N'20171125 13:28:00' AS SmallDateTime), 1, NULL, N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (10, N'MOVAJUSTE', N'Ajuste de Inventario', N'MOVAjuste.frx', 1, 1, CAST(N'20171125 13:28:00' AS SmallDateTime), CAST(N'20171125 13:28:00' AS SmallDateTime), 1, NULL, N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (11, N'VENTASDIARIAS', N'Ventas Diarias', N'VentasDiarias.frx', 1, 1, CAST(N'20171125 11:50:00' AS SmallDateTime), CAST(N'20171125 11:50:00' AS SmallDateTime), 1, N'ST_Rpt_VentasDiarias', N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (12, N'DEVOLFACTURA', N'Devolucion de Factura', N'MOVDevFactura.frx', 0, 1, CAST(N'20171125 13:28:00' AS SmallDateTime), CAST(N'20171125 13:28:00' AS SmallDateTime), 1, NULL, N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (13, N'ARTFACTURADOS', N'Artículos Facturados', N'ArtFacturados.frx', 1, 1, CAST(N'20171125 13:28:00' AS SmallDateTime), CAST(N'20171125 13:28:00' AS SmallDateTime), 1, N'ST_Rpt_ArtFacturados', N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (14, N'IVAGENERADO', N'Iva Generado', N'IvaGenerado.frx', 1, 1, CAST(N'20171125 13:28:00' AS SmallDateTime), CAST(N'20171125 13:28:00' AS SmallDateTime), 1, N'ST_Rpt_IvaGenerado', N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (15, N'IVADESCONTABLE', N'Iva Descontable', N'IvaDescontable.frx', 1, 1, CAST(N'20171125 13:28:00' AS SmallDateTime), CAST(N'20171125 13:28:00' AS SmallDateTime), 1, N'ST_Rpt_IvaDescontable', N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (16, N'RENTABILIDADART', N'Rentabilidad por Producto', N'RentabilidadProducto.frx', 1, 1, CAST(N'20171125 11:50:00' AS SmallDateTime), CAST(N'20171125 11:50:00' AS SmallDateTime), 1, N'ST_Rpt_RentabilidadArti', N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (17, N'MOVANTICIPO', N'Anticipo', N'MOVAnticipo.frx', 0, 1, CAST(N'20171125 13:28:00' AS SmallDateTime), CAST(N'20171125 13:28:00' AS SmallDateTime), 1, NULL, N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (18, N'MOVCOTIZACION', N'Cotizacion', N'MOVCotizacion.frx', 0, 1, CAST(N'20171125 13:28:00' AS SmallDateTime), CAST(N'20171125 13:28:00' AS SmallDateTime), 1, NULL, N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (19, N'CUACAJAADMIN', N'Cuadre de Caja', N'CuadreCajaAdmin.frx', 1, 0, CAST(N'20171125 13:28:00' AS SmallDateTime), CAST(N'20171125 13:28:00' AS SmallDateTime), 1, NULL, N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (20, N'VENTASDIARIASTOTALES', N'Ventas Diarias Totales', N'VentasDiariasTotal.frx', 1, 1, CAST(N'20171125 11:50:00' AS SmallDateTime), CAST(N'20171125 11:50:00' AS SmallDateTime), 1, N'ST_Rpt_VentasDiariasTotal', N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (21, N'ENTRADASTOTALES', N'Entradas Totales', N'EntradasDiarias.frx', 1, 1, CAST(N'20171125 11:50:00' AS SmallDateTime), CAST(N'20171125 11:50:00' AS SmallDateTime), 1, N'ST_Rpt_EntradasTotal', N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (22, N'VENUSUARIOS', N'Ventas por Usuarios', N'VentasUsuarios.frx', 1, 1, CAST(N'20171125 15:41:00' AS SmallDateTime), CAST(N'20171125 15:41:00' AS SmallDateTime), 1, N'ST_Rpt_VentasUsuario', N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (23, N'VENTERCEROS', N'Ventas por Terceros', N'VentasTerceros.frx', 1, 0, CAST(N'20171125 15:41:00' AS SmallDateTime), CAST(N'20171125 15:41:00' AS SmallDateTime), 1, N'ST_Rpt_VentasTerceros', N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (24, N'MOVDEVENTRADA', N'Devolución de  Mercancia', N'MOVDevEntrada.frx', 0, 1, CAST(N'20171125 13:28:00' AS SmallDateTime), CAST(N'20171125 13:28:00' AS SmallDateTime), 1, NULL, N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (25, N'MOVARTICULOS', N'Movimientos de Articulo', N'MovimientoArticulos.frx', 1, 1, CAST(N'20171125 11:50:00' AS SmallDateTime), CAST(N'20171125 11:50:00' AS SmallDateTime), 1, N'ST_Rpt_MovimientoArticulos', N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (26, N'MOVDEVANTICIPO', N'Devolución de Anticipo', N'MOVDevAnticipo.frx', 0, 1, CAST(N'20171125 13:28:00' AS SmallDateTime), CAST(N'20171125 13:28:00' AS SmallDateTime), 1, NULL, N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (27, N'ENTRADASBODEGAS', N'Entradas por Bodegas', N'EntradasBodegas.frx', 1, 1, CAST(N'20171125 11:50:00' AS SmallDateTime), CAST(N'20171125 11:50:00' AS SmallDateTime), 1, N'ST_Rpt_EntradasBodegas', N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (28, N'DOCUMENTOSDIARIAS', N'Documentos Caja Diario', N'DocumentosDiariosCaja.frx', 1, 0, CAST(N'20171125 11:50:00' AS SmallDateTime), CAST(N'20171125 11:50:00' AS SmallDateTime), 1, N'ST_Rpt_DocumentosCajaDiarios', N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (29, N'SALDOCLIENTE', N'Saldo de Clientes', N'SaldoClientes.frx', 1, 0, CAST(N'20171125 15:08:00' AS SmallDateTime), CAST(N'20171125 15:08:00' AS SmallDateTime), 1, N'ST_Rpt_SaldoCliente', N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (30, N'MOVRECAUDO', N'Recaudo de Saldo', N'RecaudoTirilla.frx', 0, 0, CAST(N'20171125 13:28:00' AS SmallDateTime), CAST(N'20171125 13:28:00' AS SmallDateTime), 1, NULL, N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (31, N'MOVORDENCOMPRA', N'Orden de Compra', N'MOVOrdenCompra.frx', 0, 1, CAST(N'20171125 16:23:00' AS SmallDateTime), CAST(N'20171125 16:23:00' AS SmallDateTime), 1, NULL, N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (32, N'PAGOPROVE', N'Pago a Proveedor', N'MOVComprobanteEgresos.frx', 0, 1, CAST(N'20171125 10:45:00' AS SmallDateTime), CAST(N'20171125 10:45:00' AS SmallDateTime), 1, NULL, N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (33, N'MOVFACTURASFE', N'Facturación', N'FacturaElectronicaSin.frx', 0, 1, CAST(N'20171125 13:28:00' AS SmallDateTime), CAST(N'20171125 13:28:00' AS SmallDateTime), 1, NULL, N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (34, N'MOVRECIBO', N'Recibo de Cajas', N'MOVRecibo.frx', 0, 1, CAST(N'20171125 11:06:00' AS SmallDateTime), CAST(N'20171125 11:06:00' AS SmallDateTime), 1, NULL, N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (35, N'MOVCOMPROCONTA', N'Comprobante Contable', N'MOVComprobanteContable.frx', 0, 1, CAST(N'20171125 09:27:00' AS SmallDateTime), CAST(N'20171125 09:27:00' AS SmallDateTime), 1, NULL, N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (36, N'COMPRASPRODUCTO', N'Compras por Producto', N'ComprasProductos.frx', 1, 1, CAST(N'20171125 10:01:00' AS SmallDateTime), CAST(N'20171125 10:01:00' AS SmallDateTime), 1, N'ST_Rpt_ComprasxProductos', N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (37, N'COMPRASPROVEEDOR', N'Compras por Proveedor', N'ComprasProveedorNew.frx', 1, 1, CAST(N'20171125 10:07:00' AS SmallDateTime), CAST(N'20171125 10:07:00' AS SmallDateTime), 1, N'ST_Rpt_ComprasxProveedor', N';tipoter|PR')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (38, N'RENTABILIDADPRODUCTO', N'Rentabilidad por Producto', N'RentabilidadProducto_No.frx', 1, 0, CAST(N'20171125 10:09:00' AS SmallDateTime), CAST(N'20171125 10:09:00' AS SmallDateTime), 1, NULL, N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (39, N'VENTASPRODUCTO', N'Ventas por Productos', N'VentasProductos.frx', 1, 1, CAST(N'20171125 07:24:00' AS SmallDateTime), CAST(N'20171125 07:24:00' AS SmallDateTime), 1, N'ST_Rpt_VentasxProductos', N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (40, N'VENTASCLIENTE', N'Ventas por Cliente', N'VentasClientes.frx', 1, 1, CAST(N'20171125 07:26:00' AS SmallDateTime), CAST(N'20171125 07:26:00' AS SmallDateTime), 1, N'ST_Rpt_VentasxCliente', N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (41, N'EXTRACTOCLIENTE', N'Extracto de Cliente', N'ExtractoClientes.frx', 1, 1, CAST(N'20171125 10:43:00' AS SmallDateTime), CAST(N'20171125 10:43:00' AS SmallDateTime), 1, NULL, N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (42, N'SALDOCUENTA', N'Saldo de cuentas', N'SaldoCuentas.frx', 1, 1, CAST(N'20171125 10:43:00' AS SmallDateTime), CAST(N'20171125 10:43:00' AS SmallDateTime), 1, NULL, N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (43, N'BALANCEGENERAL', N'Balance general', N'BalanceGeneral.frx', 1, 1, CAST(N'20171125 10:44:00' AS SmallDateTime), CAST(N'20171125 10:44:00' AS SmallDateTime), 1, NULL, N'')
GO
INSERT [dbo].[ST_Reportes] ([id], [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (44, N'ESTADOCLIENTE', N'Estado de Cliente', N'EstadoClientes.frx', 1, 1, CAST(N'20171125 11:19:00' AS SmallDateTime), CAST(N'20171125 11:19:00' AS SmallDateTime), 1, NULL, N'')
GO
SET IDENTITY_INSERT [dbo].[ST_Reportes] OFF
GO
SET IDENTITY_INSERT [dbo].[aspnet_RolesInReports] OFF
GO
INSERT [dbo].[aspnet_UsersInRoles] ([UserId], [RoleId]) VALUES (N'f0021429-46d2-46df-9ada-6ef41ceb971a', N'd5045227-6517-465a-9487-779694df5745')
GO
SET IDENTITY_INSERT [dbo].[ST_CamposReporte] ON 

GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (1, N'fechaini', N'FECHAINI', N'Fecha Inicio', N'date', N'', 2, 1, N'', N'', N'', 5, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (2, N'fechafin', N'FECHAFIN', N'Fecha Final', N'date', N'', 2, 2, N'', N'', N'', 5, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (3, N'id_proveedor', N'PROVEEDOR', N'Proveedor', N'search', N'Provedores', 4, 4, N'ProveedoresList', N'id,nit,razonsocial', N'1,3', 5, 1, 0, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (4, N'fechaini', N'FECHAINI', N'Fecha Inicio', N'date', N'', 2, 1, N'', N'', N'', 6, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (5, N'fechafin', N'FECHAFIN', N'Fecha Final', N'date', N'', 2, 2, N'', N'', N'', 6, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (6, N'id_proveedor', N'PROVEEDOR', N'Proveedor', N'search', N'Provedores', 4, 4, N'ProveedoresList', N'id,nit,razonsocial', N'1,3', 6, 1, 0, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (7, N'fechaini', N'FECHAINI', N'Fecha Inicio', N'date', N'', 2, 1, N'', N'', N'', 7, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (8, N'fechafin', N'FECHAFIN', N'Fecha Final', N'date', N'', 2, 2, N'', N'', N'', 7, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (9, N'id_proveedor', N'PROVEEDOR', N'Proveedor', N'search', N'Provedores', 4, 4, N'ProveedoresList', N'id,nit,razonsocial', N'1,3', 7, 1, 0, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (12, N'fechaini', N'FECHAINI', N'Fecha Inicio', N'date', N'', 2, 1, N'', N'', N'', 11, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (13, N'fechafin', N'FECHAFIN', N'Fecha Final', N'date', N'', 2, 2, N'', N'', N'', 11, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (14, N'idcaja', N'CCOSTO', N'Centro Costo', N'search', N'CNTCentrosCostos', 3, 3, N'CNTCentroCostosListEsDetalle', N'id,nombre', N'1,2', 11, 1, 0, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (15, N'fechaini', N'FECHAINI', N'Fecha Inicio', N'date', N'', 2, 1, N'', N'', N'', 13, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (16, N'fechafin', N'FECHAFIN', N'Fecha Final', N'date', N'', 2, 2, N'', N'', N'', 13, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (17, N'idcaja', N'CAJAS', N'Caja', N'search', N'Cajas', 3, 3, N'CajasList', N'id,nombre', N'1,2', 13, 1, 0, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (18, N'fechaini', N'FECHAINI', N'Fecha Inicio', N'date', N'', 2, 1, N'', N'', N'', 14, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (19, N'fechafin', N'FECHAFIN', N'Fecha Final', N'date', N'', 2, 2, N'', N'', N'', 14, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (20, N'idcaja', N'CCOSTO', N'Centro de Costo', N'search', N'CNTCentrosCostos', 3, 3, N'CNTCentroCostosListEsDetalle', N'id,nombre', N'1,2', 14, 1, 0, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (21, N'fechaini', N'FECHAINI', N'Fecha Inicio', N'date', N'', 2, 1, N'', N'', N'', 15, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (22, N'fechafin', N'FECHAFIN', N'Fecha Final', N'date', N'', 2, 2, N'', N'', N'', 15, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (23, N'idprove', N'PROVEEDOR', N'Proveedor', N'search', N'Provedores', 4, 4, N'ProveedoresList', N'id,nit,razonsocial', N'1,3', 15, 1, 0, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (24, N'fecha', N'FECHA', N'Fecha', N'date', N'', 2, 1, N'', N'', N'', 9, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (25, N'id_bodega', N'BODEGAS', N'Bodega', N'search', N'Bodegas', 3, 1, N'BodegasList', N'id,nombre', N'1,2', 4, 1, 0, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (26, N'fechaini', N'FECHAINI', N'Fecha Inicio', N'date', N'', 2, 1, N'', N'', N'', 16, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (27, N'fechafin', N'FECHAFIN', N'Fecha Final', N'date', N'', 2, 2, N'', N'', N'', 16, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (28, N'fecha', N'FECHA', N'Fecha', N'date', N'', 2, 1, N'', N'', N'', 19, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (29, N'idcaja', N'CAJAS', N'Caja', N'search', N'Cajas', 3, 3, N'CajasList', N'id,nombre', N'1,2', 19, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (30, N'fechaini', N'FECHAINI', N'Fecha Inicio', N'date', N'', 2, 1, N'', N'', N'', 20, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (31, N'fechafin', N'FECHAFIN', N'Fecha Final', N'date', N'', 2, 2, N'', N'', N'', 20, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (32, N'idcaja', N'CCOSTO', N'Centro Costo', N'search', N'CNTCentrosCostos', 3, 3, N'CNTCentroCostosListEsDetalle', N'id,nombre', N'1,2', 20, 1, 0, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (33, N'fechaini', N'FECHAINI', N'Fecha Inicio', N'date', N'', 2, 1, N'', N'', N'', 21, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (34, N'fechafin', N'FECHAFIN', N'Fecha Final', N'date', N'', 2, 2, N'', N'', N'', 21, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (35, N'fechaini', N'FECHAINI', N'Fecha Inicio', N'date', N'', 2, 1, N'', N'', N'', 22, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (36, N'fechafin', N'FECHAFIN', N'Fecha Final', N'date', N'', 2, 2, N'', N'', N'', 22, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (37, N'idusuario', N'USUARIO', N'Usuario', N'search', N'Usuarios', 3, 3, N'UsuariosList', N'id,nombre', N'1,2', 22, 1, 0, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (38, N'fechaini', N'FECHAINI', N'Fecha Inicio', N'date', N'', 2, 1, N'', N'', N'', 23, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (39, N'fechafin', N'FECHAFIN', N'Fecha Final', N'date', N'', 2, 2, N'', N'', N'', 23, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (40, N'fechaini', N'FECHAINI', N'Fecha Inicio', N'date', N'', 2, 1, N'', N'', N'', 25, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (41, N'fechafin', N'FECHAFIN', N'Fecha Final', N'date', N'', 2, 2, N'', N'', N'', 25, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (42, N'idarticulo', N'ARTICULO', N'Producto', N'search', N'Productos', 3, 3, N'ProductosList', N'id,codigo,presentacion,nombre', N'1,4', 25, 1, 0, CAST(N'20180730 16:26:00' AS SmallDateTime), CAST(N'20180730 16:26:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (43, N'idbodega', N'BODEGAS', N'Bodega', N'search', N'Bodegas', 3, 4, N'BodegasList', N'id,nombre', N'1,2', 25, 1, 0, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (44, N'fechaini', N'FECHAINI', N'Fecha Inicio', N'date', N'', 2, 1, N'', N'', N'', 27, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (45, N'fechafin', N'FECHAFIN', N'Fecha Final', N'date', N'', 2, 2, N'', N'', N'', 27, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (46, N'id_bodega', N'BODEGAS', N'Bodega', N'search', N'Bodegas', 3, 3, N'BodegasList', N'id,nombre', N'1,2', 27, 1, 0, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (47, N'fechaini', N'FECHAINI', N'Fecha Inicio', N'date', N'', 2, 1, N'', N'', N'', 28, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (48, N'fechafin', N'FECHAFIN', N'Fecha Final', N'date', N'', 2, 2, N'', N'', N'', 28, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (49, N'idcaja', N'CAJAS', N'Caja', N'search', N'Cajas', 3, 3, N'CajasList', N'id,nombre', N'1,2', 28, 1, 0, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (50, N'idcliente', N'CLIENTE', N'Cliente', N'search', N'CNTTerceros', 4, 4, N'CNTTercerosListTipo', N'id,tercompleto', N'1,2', 29, 1, 0, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'tipoter;CL|')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (51, N'idproveedor', N'PROVEEDOR', N'Proveedor', N'search', N'CNTTerceros', 4, 4, N'CNTTercerosListTipo', N'id,tercompleto', N'1,2', 37, 1, 0, CAST(N'20200811 15:07:00' AS SmallDateTime), CAST(N'20200811 15:07:00' AS SmallDateTime), 1, N'tipoter;PR|')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (52, N'idcliente', N'CLIENTE', N'Cliente', N'search', N'CNTTerceros', 4, 4, N'CNTTercerosListTipo', N'id,tercompleto', N'1,2', 40, 1, 0, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'tipoter;CL|')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (53, N'idcliente', N'CLIENTE', N'Cliente', N'search', N'CNTTerceros', 4, 4, N'CNTTercerosListTipo', N'id,tercompleto', N'1,2', 41, 1, 0, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'tipoter;CL|')
GO

INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (54, N'fechaini', N'FECHAINI', N'Fecha Inicio', N'date', N'', 2, 1, N'', N'', N'', 36, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (55, N'fechafin', N'FECHAFIN', N'Fecha Final', N'date', N'', 2, 2, N'', N'', N'', 36, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO

INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (56, N'fechaini', N'FECHAINI', N'Fecha Inicio', N'date', N'', 2, 1, N'', N'', N'', 37, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (57, N'fechafin', N'FECHAFIN', N'Fecha Final', N'date', N'', 2, 2, N'', N'', N'', 37, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO

INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (58, N'fechaini', N'FECHAINI', N'Fecha', N'date', N'', 2, 1, N'', N'', N'', 44, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (59, N'idcliente', N'CLIENTE', N'Cliente', N'search', N'CNTTerceros', 4, 4, N'CNTTercerosListTipo', N'id,tercompleto', N'1,2', 44, 1, 0, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'tipoter;CL|')
GO

INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (60, N'fechaini', N'FECHAINI', N'Fecha Inicio', N'date', N'', 2, 1, N'', N'', N'', 40, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO
INSERT [dbo].[ST_CamposReporte] ([id], [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES (61, N'fechafin', N'FECHAFIN', N'Fecha Final', N'date', N'', 2, 2, N'', N'', N'', 40, 1, 1, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'')
GO

SET IDENTITY_INSERT [dbo].[ST_CamposReporte] OFF
GO
INSERT [dbo].[aspnet_SchemaVersions] ([Feature], [CompatibleSchemaVersion], [IsCurrentVersion]) VALUES (N'common', N'1', 1)
GO
INSERT [dbo].[aspnet_SchemaVersions] ([Feature], [CompatibleSchemaVersion], [IsCurrentVersion]) VALUES (N'membership', N'1', 1)
GO
INSERT [dbo].[aspnet_SchemaVersions] ([Feature], [CompatibleSchemaVersion], [IsCurrentVersion]) VALUES (N'role manager', N'1', 1)
GO
SET IDENTITY_INSERT [dbo].[DivPolitica] ON 

GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1, N'57', N'COLOMBIA', N'57', 1, N'57', N'COLOMBIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (3, N'05001', N'MEDELLIN', N'05001', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (4, N'05002', N'ABEJORRAL', N'05002', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (5, N'05004', N'ABRIAQUI', N'05004', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (6, N'05021', N'ALEJANDRIA ', N'05021', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (7, N'05030', N'AMAGA', N'05030', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (8, N'05031', N'AMALFI', N'05031', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (9, N'05034', N'ANDES', N'05034', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (10, N'05036', N'ANGELOPOLIS', N'05036', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (11, N'05038', N'ANGOSTURA', N'05038', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (12, N'05040', N'ANORI', N'05040', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (13, N'05042', N'SANTAFE DE ANTIOQUIA', N'05042', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (14, N'05044', N'ANZA ', N'05044', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (15, N'05045', N'APARTADO', N'05045', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (16, N'05051', N'ARBOLETES', N'05051', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (17, N'05055', N'ARGELIA ', N'05055', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (18, N'05059', N'ARMENIA ', N'05059', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (19, N'05079', N'BARBOSA ', N'05079', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (20, N'05086', N'BELMIRA ', N'05086', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (21, N'05088', N'BELLO', N'05088', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (22, N'05091', N'BETANIA ', N'05091', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (23, N'05093', N'BETULIA ', N'05093', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (24, N'05101', N'CIUDAD BOLIVAR', N'05101', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (25, N'05107', N'BRICEÑO ', N'05107', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (26, N'05113', N'BURITICA', N'05113', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (27, N'05120', N'CACERES ', N'05120', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (28, N'05125', N'CAICEDO ', N'05125', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (29, N'05129', N'CALDAS', N'05129', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (30, N'05134', N'CAMPAMENTO ', N'05134', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (31, N'05138', N'CAÑASGORDAS', N'05138', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (32, N'05142', N'CARACOLI', N'05142', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (33, N'05145', N'CARAMANTA', N'05145', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (34, N'05147', N'CAREPA', N'05147', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (35, N'05148', N'EL CARMEN DE VIBORAL', N'05148', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (36, N'05150', N'CAROLINA', N'05150', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (37, N'05154', N'CAUCASIA', N'05154', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (38, N'05172', N'CHIGORODO', N'05172', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (39, N'05190', N'CISNEROS', N'05190', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (40, N'05197', N'COCORNA ', N'05197', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (41, N'05206', N'CONCEPCION ', N'05206', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (42, N'05209', N'CONCORDIA', N'05209', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (43, N'05212', N'COPACABANA ', N'05212', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (44, N'05234', N'DABEIBA ', N'05234', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (45, N'05237', N'DON MATIAS ', N'05237', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (46, N'05240', N'EBEJICO ', N'05240', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (47, N'05250', N'EL BAGRE', N'05250', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (48, N'05264', N'ENTRERRIOS ', N'05264', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (49, N'05266', N'ENVIGADO', N'05266', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (50, N'05282', N'FREDONIA', N'05282', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (51, N'05284', N'FRONTINO', N'05284', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (52, N'05306', N'GIRALDO ', N'05306', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (53, N'05308', N'GIRARDOTA', N'05308', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (54, N'05310', N'GOMEZ PLATA', N'05310', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (55, N'05313', N'GRANADA ', N'05313', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (56, N'05315', N'GUADALUPE', N'05315', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (57, N'05318', N'GUARNE', N'05318', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (58, N'05321', N'GUATAPE ', N'05321', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (59, N'05347', N'HELICONIA', N'05347', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (60, N'05353', N'HISPANIA', N'05353', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (61, N'05360', N'ITAGUI', N'05360', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (62, N'05361', N'ITUANGO ', N'05361', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (63, N'05364', N'JARDIN', N'05364', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (64, N'05368', N'JERICO', N'05368', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (65, N'05376', N'LA CEJA ', N'05376', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (66, N'05380', N'LA ESTRELLA', N'05380', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (67, N'05390', N'LA PINTADA ', N'05390', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (68, N'05400', N'LA UNION', N'05400', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (69, N'05411', N'LIBORINA', N'05411', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (70, N'05425', N'MACEO', N'05425', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (71, N'05440', N'MARINILLA', N'05440', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (72, N'05467', N'MONTEBELLO ', N'05467', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (73, N'05475', N'MURINDO ', N'05475', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (74, N'05480', N'MUTATA', N'05480', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (75, N'05483', N'NARIÑO', N'05483', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (76, N'05490', N'NECOCLI ', N'05490', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (77, N'05495', N'NECHI', N'05495', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (78, N'05501', N'OLAYA', N'05501', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (79, N'05541', N'PEÑOL', N'05541', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (80, N'05543', N'PEQUE', N'05543', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (81, N'056', N'PUEBLORRICO', N'05576', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (82, N'059', N'PUERTO BERRIO ', N'05579', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (83, N'05585', N'PUERTO NARE', N'05585', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (84, N'05591', N'PUERTO TRIUNFO', N'05591', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (85, N'05604', N'REMEDIOS', N'05604', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (86, N'05607', N'RETIRO', N'05607', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (87, N'05615', N'RIONEGRO', N'05615', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (88, N'05628', N'SABANALARGA', N'05628', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (89, N'05631', N'SABANETA', N'05631', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (90, N'05642', N'SALGAR', N'05642', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (91, N'05647', N'SAN ANDRES ', N'05647', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (92, N'05649', N'SAN CARLOS ', N'05649', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (93, N'05652', N'SAN FRANCISCO ', N'05652', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (94, N'05656', N'SAN JERONIMO', N'05656', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (95, N'05658', N'SAN JOSE DE LA MONTAÑA ', N'05658', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (96, N'05659', N'SAN JUAN DE URABA', N'05659', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (97, N'05660', N'SAN LUIS', N'05660', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (98, N'05664', N'SAN PEDRO', N'05664', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (99, N'05665', N'SAN PEDRO DE URABA', N'05665', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (100, N'05667', N'SAN RAFAEL ', N'05667', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (101, N'05670', N'SAN ROQUE', N'05670', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (102, N'05674', N'SAN VICENTE', N'05674', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (103, N'05679', N'SANTA BARBARA ', N'05679', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (104, N'05686', N'SANTA ROSA DE OSOS', N'05686', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (105, N'05690', N'SANTO DOMINGO ', N'05690', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (106, N'05697', N'EL SANTUARIO', N'05697', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (107, N'036', N'SEGOVIA ', N'05736', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (108, N'056', N'SONSON', N'05756', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (109, N'061', N'SOPETRAN', N'05761', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (110, N'089', N'TAMESIS ', N'05789', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (111, N'090', N'TARAZA', N'05790', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (112, N'092', N'TARSO', N'05792', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (113, N'05809', N'TITIRIBI', N'05809', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (114, N'05819', N'TOLEDO', N'05819', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (115, N'05837', N'TURBO', N'05837', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (116, N'05842', N'URAMITA ', N'05842', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (117, N'05847', N'URRAO', N'05847', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (118, N'05854', N'VALDIVIA', N'05854', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (119, N'05856', N'VALPARAISO ', N'05856', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (120, N'05858', N'VEGACHI ', N'05858', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (121, N'05861', N'VENECIA ', N'05861', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (122, N'05873', N'VIGIA DEL FUERTE ', N'05873', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (123, N'05885', N'YALI ', N'05885', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (124, N'05887', N'YARUMAL ', N'05887', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (125, N'05890', N'YOLOMBO ', N'05890', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (126, N'05893', N'YONDO', N'05893', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (127, N'05895', N'ZARAGOZA', N'05895', 3, N'05', N'ANTIOQUIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (129, N'08001', N'BARRANQUILLA', N'08001', 3, N'08', N'ATLÁNTICO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (130, N'08078', N'BARANOA ', N'08078', 3, N'08', N'ATLÁNTICO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (131, N'08137', N'CAMPO DE LA CRUZ ', N'08137', 3, N'08', N'ATLÁNTICO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (132, N'08141', N'CANDELARIA ', N'08141', 3, N'08', N'ATLÁNTICO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (133, N'08296', N'GALAPA', N'08296', 3, N'08', N'ATLÁNTICO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (134, N'08372', N'JUAN DE ACOSTA', N'08372', 3, N'08', N'ATLÁNTICO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (135, N'08421', N'LURUACO ', N'08421', 3, N'08', N'ATLÁNTICO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (136, N'08433', N'MALAMBO ', N'08433', 3, N'08', N'ATLÁNTICO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (137, N'08436', N'MANATI', N'08436', 3, N'08', N'ATLÁNTICO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (138, N'08520', N'PALMAR DE VARELA ', N'08520', 3, N'08', N'ATLÁNTICO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (139, N'08549', N'PIOJO', N'08549', 3, N'08', N'ATLÁNTICO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (140, N'08558', N'POLONUEVO', N'08558', 3, N'08', N'ATLÁNTICO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (141, N'08560', N'PONEDERA', N'08560', 3, N'08', N'ATLÁNTICO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (142, N'083', N'PUERTO COLOMBIA', N'08573', 3, N'08', N'ATLÁNTICO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (143, N'08606', N'REPELON ', N'08606', 3, N'08', N'ATLÁNTICO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (144, N'08634', N'SABANAGRANDE', N'08634', 3, N'08', N'ATLÁNTICO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (145, N'08638', N'SABANALARGA ATLANTICO', N'08638', 3, N'08', N'ATLÁNTICO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (146, N'08675', N'SANTA LUCIA', N'08675', 3, N'08', N'ATLÁNTICO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (147, N'08685', N'SANTO TOMAS', N'08685', 3, N'08', N'ATLÁNTICO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (148, N'08758', N'SOLEDAD ', N'08758', 3, N'08', N'ATLÁNTICO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (149, N'08770', N'SUAN ', N'08770', 3, N'08', N'ATLÁNTICO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (150, N'08832', N'TUBARA', N'08832', 3, N'08', N'ATLÁNTICO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (151, N'08849', N'USIACURI', N'08849', 3, N'08', N'ATLÁNTICO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (153, N'11001', N'BOGOTA', N'11001', 3, N'11', N'BOGOTÁ D.C ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (155, N'13001', N'CARTAGENA', N'13001', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (156, N'13006', N'ACHI ', N'13006', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (157, N'13030', N'ALTOS DEL ROSARIO', N'13030', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (158, N'13042', N'ARENAL', N'13042', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (159, N'13052', N'ARJONA', N'13052', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (160, N'13062', N'ARROYOHONDO', N'13062', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (161, N'13074', N'BARRANCO DE LOBA ', N'13074', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (162, N'13140', N'CALAMAR ', N'13140', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (163, N'13160', N'CANTAGALLO ', N'13160', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (164, N'13188', N'CICUCO', N'13188', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (165, N'13212', N'CORDOBA ', N'13212', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (166, N'13222', N'CLEMENCIA', N'13222', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (167, N'13244', N'EL CARMEN DE BOLIVAR', N'13244', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (168, N'13248', N'EL GUAMO', N'13248', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (169, N'13268', N'EL PEÑON', N'13268', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (170, N'13300', N'HATILLO DE LOBA', N'13300', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (171, N'13430', N'MAGANGUE', N'13430', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (172, N'13433', N'MAHATES ', N'13433', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (173, N'13440', N'MARGARITA', N'13440', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (174, N'13442', N'MARIA LA BAJA ', N'13442', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (175, N'13458', N'MONTECRISTO', N'13458', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (176, N'13468', N'MOMPOS', N'13468', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (177, N'13473', N'MORALES ', N'13473', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (178, N'13549', N'PINILLOS', N'13549', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (179, N'13580', N'REGIDOR ', N'13580', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (180, N'13600', N'RIO VIEJO', N'13600', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (181, N'13620', N'SAN CRISTOBAL ', N'13620', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (182, N'13647', N'SAN ESTANISLAO', N'13647', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (183, N'13650', N'SAN FERNANDO', N'13650', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (184, N'13654', N'SAN JACINTO', N'13654', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (185, N'13655', N'SAN JACINTO DEL CAUCA', N'13655', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (186, N'136', N'SAN JUAN NEPOMUCENO ', N'13657', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (187, N'13667', N'SAN MARTIN DE LOBA', N'13667', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (188, N'13670', N'SAN PABLO', N'13670', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (189, N'13673', N'SANTA CATALINA', N'13673', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (190, N'13683', N'SANTA ROSA ', N'13683', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (191, N'13688', N'SANTA ROSA DEL SUR', N'13688', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (192, N'13744', N'SIMITI', N'13744', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (193, N'13760', N'SOPLAVIENTO', N'13760', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (194, N'13780', N'TALAIGUA NUEVO', N'13780', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (195, N'13810', N'TIQUISIO', N'13810', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (196, N'13836', N'TURBACO ', N'13836', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (197, N'13838', N'TURBANA ', N'13838', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (198, N'13873', N'VILLANUEVA ', N'13873', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (199, N'13894', N'ZAMBRANO', N'13894', 3, N'13', N'BOLIVAR ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (201, N'15001', N'TUNJA', N'15001', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (202, N'15022', N'ALMEIDA ', N'15022', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (203, N'15047', N'AQUITANIA', N'15047', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (204, N'15051', N'ARCABUCO', N'15051', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (205, N'15087', N'BELEN', N'15087', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (206, N'15090', N'BERBEO', N'15090', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (207, N'15092', N'BETEITIVA', N'15092', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (208, N'15097', N'BOAVITA ', N'15097', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (209, N'15104', N'BOYACA', N'15104', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (210, N'15106', N'BRICEÑO ', N'15106', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (211, N'15109', N'BUENAVISTA ', N'15109', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (212, N'15114', N'BUSBANZA', N'15114', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (213, N'15131', N'CALDAS', N'15131', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (214, N'15135', N'CAMPOHERMOSO', N'15135', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (215, N'15162', N'CERINZA ', N'15162', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (216, N'15172', N'CHINAVITA', N'15172', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (217, N'15176', N'CHIQUINQUIRA', N'15176', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (218, N'15180', N'CHISCAS ', N'15180', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (219, N'15183', N'CHITA', N'15183', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (220, N'15185', N'CHITARAQUE ', N'15185', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (221, N'15187', N'CHIVATA ', N'15187', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (222, N'15189', N'CIENEGA ', N'15189', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (223, N'15204', N'COMBITA ', N'15204', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (224, N'15212', N'COPER', N'15212', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (225, N'15215', N'CORRALES', N'15215', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (226, N'15218', N'COVARACHIA ', N'15218', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (227, N'15223', N'CUBARA', N'15223', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (228, N'15224', N'CUCAITA ', N'15224', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (229, N'15226', N'CUITIVA ', N'15226', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (230, N'15232', N'CHIQUIZA', N'15232', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (231, N'15236', N'CHIVOR', N'15236', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (232, N'15238', N'DUITAMA ', N'15238', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (233, N'15244', N'EL COCUY', N'15244', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (234, N'15248', N'EL ESPINO', N'15248', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (235, N'15272', N'FIRAVITOBA ', N'15272', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (236, N'15276', N'FLORESTA', N'15276', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (237, N'15293', N'GACHANTIVA ', N'15293', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (238, N'15296', N'GAMEZA', N'15296', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (239, N'15299', N'GARAGOA ', N'15299', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (240, N'15317', N'GUACAMAYAS ', N'15317', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (241, N'15322', N'GUATEQUE', N'15322', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (242, N'15325', N'GUAYATA ', N'15325', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (243, N'15332', N'GÜICAN', N'15332', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (244, N'15362', N'IZA', N'15362', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (245, N'15367', N'JENESANO', N'15367', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (246, N'15368', N'JERICO', N'15368', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (247, N'15377', N'LABRANZAGRANDE', N'15377', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (248, N'15380', N'LA CAPILLA ', N'15380', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (249, N'15401', N'LA VICTORIA', N'15401', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (250, N'15403', N'LA UVITA', N'15403', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (251, N'15407', N'VILLA DE LEYVA', N'15407', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (252, N'15425', N'MACANAL ', N'15425', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (253, N'15442', N'MARIPI', N'15442', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (254, N'15455', N'MIRAFLORES ', N'15455', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (255, N'15464', N'MONGUA', N'15464', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (256, N'15466', N'MONGUI', N'15466', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (257, N'15469', N'MONIQUIRA', N'15469', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (258, N'15476', N'MOTAVITA', N'15476', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (259, N'15480', N'MUZO ', N'15480', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (260, N'15491', N'NOBSA', N'15491', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (261, N'15494', N'NUEVO COLON', N'15494', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (262, N'15500', N'OICATA', N'15500', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (263, N'15507', N'OTANCHE ', N'15507', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (264, N'15511', N'PACHAVITA', N'15511', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (265, N'15514', N'PAEZ ', N'15514', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (266, N'15516', N'PAIPA', N'15516', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (267, N'15518', N'PAJARITO', N'15518', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (268, N'15522', N'PANQUEBA', N'15522', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (269, N'15531', N'PAUNA', N'15531', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (270, N'15533', N'PAYA ', N'15533', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (271, N'15537', N'PAZ DE RIO ', N'15537', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (272, N'15542', N'PESCA', N'15542', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (273, N'15550', N'PISBA', N'15550', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (274, N'152', N'PUERTO BOYACA ', N'15572', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (275, N'15580', N'QUIPAMA ', N'15580', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (276, N'15599', N'RAMIRIQUI', N'15599', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (277, N'15600', N'RAQUIRA ', N'15600', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (278, N'15621', N'RONDON', N'15621', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (279, N'15632', N'SABOYA', N'15632', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (280, N'15638', N'SACHICA ', N'15638', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (281, N'15646', N'SAMACA', N'15646', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (282, N'15660', N'SAN EDUARDO', N'15660', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (283, N'15664', N'SAN JOSE DE PARE ', N'15664', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (284, N'15667', N'SAN LUIS DE GACENO', N'15667', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (285, N'15673', N'SAN MATEO', N'15673', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (286, N'15676', N'SAN MIGUEL DE SEMA', N'15676', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (287, N'15681', N'SAN PABLO DE BORBUR ', N'15681', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (288, N'15686', N'SANTANA ', N'15686', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (289, N'15690', N'SANTA MARIA', N'15690', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (290, N'15693', N'SANTA ROSA DE VITERBO', N'15693', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (291, N'15696', N'SANTA SOFIA', N'15696', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (292, N'120', N'SATIVANORTE', N'15720', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (293, N'123', N'SATIVASUR', N'15723', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (294, N'140', N'SIACHOQUE', N'15740', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (295, N'153', N'SOATA', N'15753', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (296, N'155', N'SOCOTA', N'15755', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (297, N'1', N'SOCHA', N'15757', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (298, N'159', N'SOGAMOSO', N'15759', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (299, N'161', N'SOMONDOCO', N'15761', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (300, N'162', N'SORA ', N'15762', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (301, N'163', N'SOTAQUIRA', N'15763', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (302, N'164', N'SORACA', N'15764', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (303, N'174', N'SUSACON ', N'15774', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (304, N'176', N'SUTAMARCHAN', N'15776', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (305, N'178', N'SUTATENZA', N'15778', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (306, N'190', N'TASCO', N'15790', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (307, N'198', N'TENZA', N'15798', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (308, N'15804', N'TIBANA', N'15804', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (309, N'15806', N'TIBASOSA', N'15806', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (310, N'15808', N'TINJACA ', N'15808', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (311, N'15810', N'TIPACOQUE', N'15810', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (312, N'15814', N'TOCA ', N'15814', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (313, N'15816', N'TOGÜI', N'15816', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (314, N'15820', N'TOPAGA', N'15820', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (315, N'15822', N'TOTA ', N'15822', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (316, N'15832', N'TUNUNGUA', N'15832', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (317, N'15835', N'TURMEQUE', N'15835', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (318, N'15837', N'TUTA ', N'15837', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (319, N'15839', N'TUTAZA', N'15839', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (320, N'15842', N'UMBITA', N'15842', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (321, N'15861', N'VENTAQUEMADA', N'15861', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (322, N'15879', N'VIRACACHA', N'15879', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (323, N'15897', N'ZETAQUIRA', N'15897', 3, N'15', N'BOYACÁ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (325, N'17001', N'MANIZALES', N'17001', 3, N'17', N'CALDAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (326, N'17013', N'AGUADAS ', N'17013', 3, N'17', N'CALDAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (327, N'17042', N'ANSERMA ', N'17042', 3, N'17', N'CALDAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (328, N'17050', N'ARANZAZU', N'17050', 3, N'17', N'CALDAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (329, N'17088', N'BELALCAZAR ', N'17088', 3, N'17', N'CALDAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (330, N'17174', N'CHINCHINA', N'17174', 3, N'17', N'CALDAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (331, N'17272', N'FILADELFIA ', N'17272', 3, N'17', N'CALDAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (332, N'17380', N'LA DORADA', N'17380', 3, N'17', N'CALDAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (333, N'17388', N'LA MERCED', N'17388', 3, N'17', N'CALDAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (334, N'17433', N'MANZANARES ', N'17433', 3, N'17', N'CALDAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (335, N'17442', N'MARMATO ', N'17442', 3, N'17', N'CALDAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (336, N'17444', N'MARQUETALIA', N'17444', 3, N'17', N'CALDAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (337, N'17446', N'MARULANDA', N'17446', 3, N'17', N'CALDAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (338, N'17486', N'NEIRA', N'17486', 3, N'17', N'CALDAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (339, N'17495', N'NORCASIA', N'17495', 3, N'17', N'CALDAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (340, N'17513', N'PACORA', N'17513', 3, N'17', N'CALDAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (341, N'17524', N'PALESTINA', N'17524', 3, N'17', N'CALDAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (342, N'17541', N'PENSILVANIA', N'17541', 3, N'17', N'CALDAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (343, N'17614', N'RIOSUCIO', N'17614', 3, N'17', N'CALDAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (344, N'17616', N'RISARALDA', N'17616', 3, N'17', N'CALDAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (345, N'17653', N'SALAMINA', N'17653', 3, N'17', N'CALDAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (346, N'17662', N'SAMANA', N'17662', 3, N'17', N'CALDAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (347, N'17665', N'SAN JOSE', N'17665', 3, N'17', N'CALDAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (348, N'17777', N'SUPIA', N'17777', 3, N'17', N'CALDAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (349, N'17867', N'VICTORIA', N'17867', 3, N'17', N'CALDAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (350, N'17873', N'VILLAMARIA ', N'17873', 3, N'17', N'CALDAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (351, N'17877', N'VITERBO ', N'17877', 3, N'17', N'CALDAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (353, N'18001', N'FLORENCIA', N'18001', 3, N'18', N'CAQUETÁ ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (354, N'18029', N'ALBANIA ', N'18029', 3, N'18', N'CAQUETÁ ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (355, N'18094', N'BELEN DE LOS ANDAQUIES ', N'18094', 3, N'18', N'CAQUETÁ ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (356, N'18150', N'CARTAGENA DEL CHAIRA', N'18150', 3, N'18', N'CAQUETÁ ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (357, N'18205', N'CURILLO ', N'18205', 3, N'18', N'CAQUETÁ ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (358, N'18247', N'EL DONCELLO', N'18247', 3, N'18', N'CAQUETÁ ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (359, N'18256', N'EL PAUJIL', N'18256', 3, N'18', N'CAQUETÁ ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (360, N'18410', N'LA MONTAÑITA', N'18410', 3, N'18', N'CAQUETÁ ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (361, N'18460', N'MILAN', N'18460', 3, N'18', N'CAQUETÁ ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (362, N'18479', N'MORELIA ', N'18479', 3, N'18', N'CAQUETÁ ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (363, N'18592', N'PUERTO RICO', N'18592', 3, N'18', N'CAQUETÁ ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (364, N'18610', N'SAN JOSE DEL FRAGUA ', N'18610', 3, N'18', N'CAQUETÁ ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (365, N'18753', N'SAN VICENTE DEL CAGUAN ', N'18753', 3, N'18', N'CAQUETÁ ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (366, N'18756', N'SOLANO', N'18756', 3, N'18', N'CAQUETÁ ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (367, N'18785', N'SOLITA', N'18785', 3, N'18', N'CAQUETÁ ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (368, N'18860', N'VALPARAISO ', N'18860', 3, N'18', N'CAQUETÁ ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (370, N'19001', N'POPAYAN ', N'19001', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (371, N'19022', N'ALMAGUER', N'19022', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (372, N'19050', N'ARGELIA ', N'19050', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (373, N'19075', N'BALBOA', N'19075', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (374, N'19100', N'BOLIVAR ', N'19100', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (375, N'19110', N'BUENOS AIRES', N'19110', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (376, N'19130', N'CAJIBIO ', N'19130', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (377, N'19137', N'CALDONO ', N'19137', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (378, N'19142', N'CALOTO', N'19142', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (379, N'19212', N'CORINTO ', N'19212', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (380, N'19256', N'EL TAMBO', N'19256', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (381, N'19290', N'FLORENCIA', N'19290', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (382, N'19318', N'GUAPI', N'19318', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (383, N'19355', N'INZA ', N'19355', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (384, N'19364', N'JAMBALO ', N'19364', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (385, N'19392', N'LA SIERRA', N'19392', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (386, N'19397', N'LA VEGA ', N'19397', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (387, N'19418', N'LOPEZ', N'19418', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (388, N'19450', N'MERCADERES ', N'19450', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (389, N'19455', N'MIRANDA ', N'19455', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (390, N'19473', N'MORALES ', N'19473', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (391, N'19513', N'PADILLA ', N'19513', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (392, N'19517', N'PAEZ ', N'19517', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (393, N'19532', N'PATIA', N'19532', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (394, N'19533', N'PIAMONTE', N'19533', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (395, N'19548', N'PIENDAMO', N'19548', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (396, N'193', N'PUERTO TEJADA ', N'19573', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (397, N'19585', N'PURACE', N'19585', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (398, N'19622', N'ROSAS', N'19622', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (399, N'19693', N'SAN SEBASTIAN ', N'19693', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (400, N'19698', N'SANTANDER DE QUILICHAO ', N'19698', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (401, N'19701', N'SANTA ROSA ', N'19701', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (402, N'19743', N'SILVIA', N'19743', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (403, N'19760', N'SOTARA', N'19760', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (404, N'19780', N'SUAREZ', N'19780', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (405, N'19785', N'SUCRE', N'19785', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (406, N'19807', N'TIMBIO', N'19807', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (407, N'19809', N'TIMBIQUI', N'19809', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (408, N'19821', N'TORIBIO ', N'19821', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (409, N'19824', N'TOTORO', N'19824', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (410, N'19845', N'VILLA RICA ', N'19845', 3, N'19', N'CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (412, N'20001', N'VALLEDUPAR ', N'20001', 3, N'20', N'CESAR', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (413, N'20011', N'AGUACHICA', N'20011', 3, N'20', N'CESAR', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (414, N'20013', N'AGUSTIN CODAZZI', N'20013', 3, N'20', N'CESAR', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (415, N'20032', N'ASTREA', N'20032', 3, N'20', N'CESAR', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (416, N'20045', N'BECERRIL', N'20045', 3, N'20', N'CESAR', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (417, N'20060', N'BOSCONIA', N'20060', 3, N'20', N'CESAR', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (418, N'20175', N'CHIMICHAGUA', N'20175', 3, N'20', N'CESAR', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (419, N'20178', N'CHIRIGUANA ', N'20178', 3, N'20', N'CESAR', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (420, N'20228', N'CURUMANI', N'20228', 3, N'20', N'CESAR', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (421, N'20238', N'EL COPEY', N'20238', 3, N'20', N'CESAR', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (422, N'20250', N'EL PASO ', N'20250', 3, N'20', N'CESAR', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (423, N'20295', N'GAMARRA ', N'20295', 3, N'20', N'CESAR', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (424, N'20310', N'GONZALEZ', N'20310', 3, N'20', N'CESAR', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (425, N'20383', N'LA GLORIA', N'20383', 3, N'20', N'CESAR', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (426, N'20400', N'LA JAGUA DE IBIRICO ', N'20400', 3, N'20', N'CESAR', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (427, N'20443', N'MANAURE ', N'20443', 3, N'20', N'CESAR', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (428, N'20517', N'PAILITAS', N'20517', 3, N'20', N'CESAR', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (429, N'20550', N'PELAYA', N'20550', 3, N'20', N'CESAR', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (430, N'200', N'PUEBLO BELLO', N'20570', 3, N'20', N'CESAR', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (431, N'20614', N'RIO DE ORO ', N'20614', 3, N'20', N'CESAR', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (432, N'20621', N'LA PAZ', N'20621', 3, N'20', N'CESAR', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (433, N'20710', N'SAN ALBERTO', N'20710', 3, N'20', N'CESAR', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (434, N'20750', N'SAN DIEGO', N'20750', 3, N'20', N'CESAR', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (435, N'20770', N'SAN MARTIN ', N'20770', 3, N'20', N'CESAR', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (436, N'20787', N'TAMALAMEQUE', N'20787', 3, N'20', N'CESAR', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (438, N'23001', N'MONTERIA', N'23001', 3, N'23', N'CÓRDOBA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (439, N'23068', N'AYAPEL', N'23068', 3, N'23', N'CÓRDOBA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (440, N'23079', N'BUENAVISTA ', N'23079', 3, N'23', N'CÓRDOBA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (441, N'23090', N'CANALETE', N'23090', 3, N'23', N'CÓRDOBA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (442, N'23162', N'CERETE', N'23162', 3, N'23', N'CÓRDOBA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (443, N'23168', N'CHIMA', N'23168', 3, N'23', N'CÓRDOBA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (444, N'23182', N'CHINU', N'23182', 3, N'23', N'CÓRDOBA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (445, N'23189', N'CIENAGA DE ORO', N'23189', 3, N'23', N'CÓRDOBA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (446, N'23300', N'COTORRA ', N'23300', 3, N'23', N'CÓRDOBA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (447, N'23350', N'LA APARTADA', N'23350', 3, N'23', N'CÓRDOBA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (448, N'23417', N'LORICA', N'23417', 3, N'23', N'CÓRDOBA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (449, N'23419', N'LOS CORDOBAS', N'23419', 3, N'23', N'CÓRDOBA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (450, N'23464', N'MOMIL', N'23464', 3, N'23', N'CÓRDOBA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (451, N'23466', N'MONTELIBANO', N'23466', 3, N'23', N'CÓRDOBA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (452, N'23500', N'MOÑITOS ', N'23500', 3, N'23', N'CÓRDOBA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (453, N'23555', N'PLANETA RICA', N'23555', 3, N'23', N'CÓRDOBA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (454, N'230', N'PUEBLO NUEVO', N'23570', 3, N'23', N'CÓRDOBA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (455, N'234', N'PUERTO ESCONDIDO ', N'23574', 3, N'23', N'CÓRDOBA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (456, N'23580', N'PUERTO LIBERTADOR', N'23580', 3, N'23', N'CÓRDOBA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (457, N'23586', N'PURISIMA', N'23586', 3, N'23', N'CÓRDOBA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (458, N'23660', N'SAHAG/N ', N'23660', 3, N'23', N'CÓRDOBA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (459, N'23670', N'SAN ANDRES SOTAVENTO', N'23670', 3, N'23', N'CÓRDOBA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (460, N'23672', N'SAN ANTERO ', N'23672', 3, N'23', N'CÓRDOBA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (461, N'23675', N'SAN BERNARDO DEL VIENTO', N'23675', 3, N'23', N'CÓRDOBA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (462, N'23678', N'SAN CARLOS ', N'23678', 3, N'23', N'CÓRDOBA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (463, N'23686', N'SAN PELAYO ', N'23686', 3, N'23', N'CÓRDOBA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (464, N'23807', N'TIERRALTA', N'23807', 3, N'23', N'CÓRDOBA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (465, N'23855', N'VALENCIA', N'23855', 3, N'23', N'CÓRDOBA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (467, N'25001', N'AGUA DE DIOS', N'25001', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (468, N'25019', N'ALBAN', N'25019', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (469, N'25035', N'ANAPOIMA', N'25035', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (470, N'25040', N'ANOLAIMA', N'25040', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (471, N'25053', N'ARBELAEZ', N'25053', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (472, N'25086', N'BELTRAN ', N'25086', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (473, N'25095', N'BITUIMA ', N'25095', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (474, N'25099', N'BOJACA', N'25099', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (475, N'25120', N'CABRERA ', N'25120', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (476, N'25123', N'CACHIPAY', N'25123', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (477, N'25126', N'CAJICA', N'25126', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (478, N'25148', N'CAPARRAPI', N'25148', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (479, N'25151', N'CAQUEZA ', N'25151', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (480, N'25154', N'CARMEN DE CARUPA ', N'25154', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (481, N'25168', N'CHAGUANI', N'25168', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (482, N'25175', N'CHIA ', N'25175', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (483, N'25178', N'CHIPAQUE', N'25178', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (484, N'25181', N'CHOACHI ', N'25181', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (485, N'25183', N'CHOCONTA', N'25183', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (486, N'25200', N'COGUA', N'25200', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (487, N'25214', N'COTA ', N'25214', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (488, N'25224', N'CUCUNUBA', N'25224', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (489, N'25245', N'EL COLEGIO ', N'25245', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (490, N'25258', N'EL PEÑON', N'25258', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (491, N'25260', N'EL ROSAL', N'25260', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (492, N'25269', N'FACATATIVA ', N'25269', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (493, N'25279', N'FOMEQUE ', N'25279', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (494, N'25281', N'FOSCA', N'25281', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (495, N'25286', N'FUNZA', N'25286', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (496, N'25288', N'F/QUENE ', N'25288', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (497, N'25290', N'FUSAGASUGA ', N'25290', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (498, N'25293', N'GACHALA ', N'25293', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (499, N'25295', N'GACHANCIPA ', N'25295', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (500, N'25297', N'GACHETA ', N'25297', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (501, N'25299', N'GAMA ', N'25299', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (502, N'25307', N'GIRARDOT', N'25307', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (503, N'25312', N'GRANADA ', N'25312', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (504, N'25317', N'GUACHETA', N'25317', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (505, N'25320', N'GUADUAS ', N'25320', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (506, N'25322', N'GUASCA', N'25322', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (507, N'25324', N'GUATAQUI', N'25324', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (508, N'25326', N'GUATAVITA', N'25326', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (509, N'25328', N'GUAYABAL DE SIQUIMA ', N'25328', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (510, N'25335', N'GUAYABETAL ', N'25335', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (511, N'25339', N'GUTIERREZ', N'25339', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (512, N'25368', N'JERUSALEN', N'25368', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (513, N'25372', N'JUNIN', N'25372', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (514, N'25377', N'LA CALERA', N'25377', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (515, N'25386', N'LA MESA ', N'25386', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (516, N'25394', N'LA PALMA', N'25394', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (517, N'25398', N'LA PEÑA ', N'25398', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (518, N'25402', N'LA VEGA ', N'25402', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (519, N'25407', N'LENGUAZAQUE', N'25407', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (520, N'25426', N'MACHETA ', N'25426', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (521, N'25430', N'MADRID', N'25430', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (522, N'25436', N'MANTA', N'25436', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (523, N'25438', N'MEDINA', N'25438', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (524, N'25473', N'MOSQUERA', N'25473', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (525, N'25483', N'NARIÑO', N'25483', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (526, N'25486', N'NEMOCON ', N'25486', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (527, N'25488', N'NILO ', N'25488', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (528, N'25489', N'NIMAIMA ', N'25489', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (529, N'25491', N'NOCAIMA ', N'25491', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (530, N'25506', N'VENECIA ', N'25506', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (531, N'25513', N'PACHO', N'25513', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (532, N'25518', N'PAIME', N'25518', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (533, N'25524', N'PANDI', N'25524', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (534, N'25530', N'PARATEBUENO', N'25530', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (535, N'25535', N'PASCA', N'25535', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (536, N'252', N'PUERTO SALGAR ', N'25572', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (537, N'25580', N'PULI ', N'25580', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (538, N'25592', N'QUEBRADANEGRA ', N'25592', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (539, N'25594', N'QUETAME ', N'25594', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (540, N'25596', N'QUIPILE ', N'25596', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (541, N'25599', N'APULO', N'25599', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (542, N'25612', N'RICAURTE', N'25612', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (543, N'25645', N'SAN ANTONIO', N'25645', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (544, N'25646', N'DEL TEQUENDAMA', N'25646', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (545, N'25649', N'SAN BERNARDO', N'25649', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (546, N'25653', N'SAN CAYETANO', N'25653', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (547, N'25658', N'SAN FRANCISCO ', N'25658', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (548, N'25662', N'SAN JUAN DE RIO SECO', N'25662', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (549, N'218', N'SASAIMA ', N'25718', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (550, N'236', N'SESQUILE', N'25736', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (551, N'240', N'SIBATE', N'25740', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (552, N'243', N'SILVANIA', N'25743', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (553, N'245', N'SIMIJACA', N'25745', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (554, N'254', N'SOACHA', N'25754', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (555, N'258', N'SOPO ', N'25758', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (556, N'269', N'SUBACHOQUE ', N'25769', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (557, N'272', N'SUESCA', N'25772', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (558, N'277', N'SUPATA', N'25777', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (559, N'279', N'SUSA ', N'25779', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (560, N'281', N'SUTATAUSA', N'25781', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (561, N'285', N'TABIO', N'25785', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (562, N'293', N'TAUSA', N'25793', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (563, N'297', N'TENA ', N'25797', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (564, N'299', N'TENJO', N'25799', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (565, N'25805', N'TIBACUY ', N'25805', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (566, N'25807', N'TIBIRITA', N'25807', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (567, N'25815', N'TOCAIMA ', N'25815', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (568, N'25817', N'TOCANCIPA', N'25817', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (569, N'25823', N'TOPAIPI ', N'25823', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (570, N'25839', N'UBALA', N'25839', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (571, N'25841', N'UBAQUE', N'25841', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (572, N'25843', N'VILLA DE SAN DIEGO DE UBATE', N'25843', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (573, N'25845', N'UNE', N'25845', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (574, N'25851', N'UTICA', N'25851', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (575, N'25862', N'VERGARA ', N'25862', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (576, N'25867', N'VIANI', N'25867', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (577, N'25871', N'VILLAGOMEZ ', N'25871', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (578, N'25873', N'VILLAPINZON', N'25873', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (579, N'25875', N'VILLETA ', N'25875', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (580, N'25878', N'VIOTA', N'25878', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (581, N'25885', N'YACOPI', N'25885', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (582, N'25898', N'ZIPACON ', N'25898', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (583, N'25899', N'ZIPAQUIRA', N'25899', 3, N'25', N'CUNDINAMARCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (585, N'27001', N'QUIBDO', N'27001', 3, N'27', N'CHOCÓ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (586, N'27006', N'ACANDI', N'27006', 3, N'27', N'CHOCÓ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (587, N'27025', N'ALTO BAUDO ', N'27025', 3, N'27', N'CHOCÓ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (588, N'27050', N'ATRATO', N'27050', 3, N'27', N'CHOCÓ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (589, N'27073', N'BAGADO', N'27073', 3, N'27', N'CHOCÓ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (590, N'27075', N'BAHIA SOLANO', N'27075', 3, N'27', N'CHOCÓ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (591, N'27077', N'BAJO BAUDO ', N'27077', 3, N'27', N'CHOCÓ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (592, N'27086', N'BELEN DE BAJIRA', N'27086', 3, N'27', N'CHOCÓ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (593, N'27099', N'BOJAYA', N'27099', 3, N'27', N'CHOCÓ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (594, N'27135', N'EL CANTON DEL SAN PABLO', N'27135', 3, N'27', N'CHOCÓ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (595, N'27150', N'CARMEN DEL DARIEN', N'27150', 3, N'27', N'CHOCÓ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (596, N'27160', N'CERTEGUI', N'27160', 3, N'27', N'CHOCÓ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (597, N'27205', N'CONDOTO ', N'27205', 3, N'27', N'CHOCÓ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (598, N'27245', N'EL CARMEN DE ATRATO ', N'27245', 3, N'27', N'CHOCÓ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (599, N'27250', N'EL LITORAL DEL SAN JUAN', N'27250', 3, N'27', N'CHOCÓ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (600, N'27361', N'ISTMINA ', N'27361', 3, N'27', N'CHOCÓ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (601, N'27372', N'JURADO', N'27372', 3, N'27', N'CHOCÓ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (602, N'27413', N'LLORO', N'27413', 3, N'27', N'CHOCÓ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (603, N'27425', N'MEDIO ATRATO', N'27425', 3, N'27', N'CHOCÓ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (604, N'27430', N'MEDIO BAUDO', N'27430', 3, N'27', N'CHOCÓ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (605, N'27450', N'MEDIO SAN JUAN', N'27450', 3, N'27', N'CHOCÓ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (606, N'27491', N'NOVITA', N'27491', 3, N'27', N'CHOCÓ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (607, N'27495', N'NUQUI', N'27495', 3, N'27', N'CHOCÓ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (608, N'27580', N'RIO IRO ', N'27580', 3, N'27', N'CHOCÓ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (609, N'27600', N'RIO QUITO', N'27600', 3, N'27', N'CHOCÓ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (610, N'27615', N'RIOSUCIO', N'27615', 3, N'27', N'CHOCÓ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (611, N'27660', N'SAN JOSE DEL PALMAR ', N'27660', 3, N'27', N'CHOCÓ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (612, N'27745', N'SIPI ', N'27745', 3, N'27', N'CHOCÓ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (613, N'27787', N'TADO ', N'27787', 3, N'27', N'CHOCÓ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (614, N'27800', N'UNGUIA', N'27800', 3, N'27', N'CHOCÓ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (615, N'27810', N'UNION PANAMERICANA', N'27810', 3, N'27', N'CHOCÓ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (617, N'41001', N'NEIVA', N'41001', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (618, N'41006', N'ACEVEDO ', N'41006', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (619, N'41013', N'AGRADO', N'41013', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (620, N'41016', N'AIPE ', N'41016', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (621, N'41020', N'ALGECIRAS', N'41020', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (622, N'41026', N'ALTAMIRA', N'41026', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (623, N'41078', N'BARAYA', N'41078', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (624, N'41132', N'CAMPOALEGRE', N'41132', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (625, N'41206', N'COLOMBIA', N'41206', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (626, N'41244', N'ELIAS', N'41244', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (627, N'41298', N'GARZON', N'41298', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (628, N'41306', N'GIGANTE ', N'41306', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (629, N'41319', N'GUADALUPE', N'41319', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (630, N'41349', N'HOBO ', N'41349', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (631, N'413', N'IQUIRA', N'41357', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (632, N'41359', N'ISNOS', N'41359', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (633, N'41378', N'LA ARGENTINA', N'41378', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (634, N'41396', N'LA PLATA', N'41396', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (635, N'41483', N'NATAGA', N'41483', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (636, N'41503', N'OPORAPA ', N'41503', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (637, N'41518', N'PAICOL', N'41518', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (638, N'41524', N'PALERMO ', N'41524', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (639, N'41530', N'PALESTINA', N'41530', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (640, N'41548', N'PITAL', N'41548', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (641, N'41551', N'PITALITO', N'41551', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (642, N'41615', N'RIVERA', N'41615', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (643, N'41660', N'SALADOBLANCO', N'41660', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (644, N'41668', N'SAN AGUSTIN', N'41668', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (645, N'41676', N'SANTA MARIA', N'41676', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (646, N'41770', N'SUAZA', N'41770', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (647, N'41791', N'TARQUI', N'41791', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (648, N'41797', N'TESALIA ', N'41797', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (649, N'41799', N'TELLO', N'41799', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (650, N'41801', N'TERUEL', N'41801', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (651, N'41807', N'TIMANA', N'41807', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (652, N'41872', N'VILLAVIEJA ', N'41872', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (653, N'41885', N'YAGUARA ', N'41885', 3, N'41', N'HUILA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (655, N'44001', N'RIOHACHA', N'44001', 3, N'44', N'LA GUAJIRA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (656, N'44035', N'ALBANIA ', N'44035', 3, N'44', N'LA GUAJIRA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (657, N'44078', N'BARRANCAS', N'44078', 3, N'44', N'LA GUAJIRA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (658, N'44090', N'DIBULLA ', N'44090', 3, N'44', N'LA GUAJIRA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (659, N'44098', N'DISTRACCION', N'44098', 3, N'44', N'LA GUAJIRA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (660, N'44110', N'EL MOLINO', N'44110', 3, N'44', N'LA GUAJIRA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (661, N'44279', N'FONSECA ', N'44279', 3, N'44', N'LA GUAJIRA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (662, N'44378', N'HATONUEVO', N'44378', 3, N'44', N'LA GUAJIRA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (663, N'44420', N'LA JAGUA DEL PILAR', N'44420', 3, N'44', N'LA GUAJIRA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (664, N'44430', N'MAICAO', N'44430', 3, N'44', N'LA GUAJIRA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (665, N'44560', N'MANAURE ', N'44560', 3, N'44', N'LA GUAJIRA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (666, N'44650', N'SAN JUAN DEL CESAR', N'44650', 3, N'44', N'LA GUAJIRA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (667, N'44847', N'URIBIA', N'44847', 3, N'44', N'LA GUAJIRA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (668, N'44855', N'URUMITA ', N'44855', 3, N'44', N'LA GUAJIRA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (669, N'44874', N'VILLANUEVA ', N'44874', 3, N'44', N'LA GUAJIRA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (671, N'47001', N'SANTA MARTA', N'47001', 3, N'47', N'MAGDALENA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (672, N'47030', N'ALGARROBO', N'47030', 3, N'47', N'MAGDALENA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (673, N'47053', N'ARACATACA', N'47053', 3, N'47', N'MAGDALENA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (674, N'47058', N'ARIGUANI', N'47058', 3, N'47', N'MAGDALENA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (675, N'47161', N'CERRO SAN ANTONIO', N'47161', 3, N'47', N'MAGDALENA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (676, N'47170', N'CHIBOLO ', N'47170', 3, N'47', N'MAGDALENA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (677, N'47189', N'CIENAGA ', N'47189', 3, N'47', N'MAGDALENA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (678, N'47205', N'CONCORDIA', N'47205', 3, N'47', N'MAGDALENA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (679, N'47245', N'EL BANCO', N'47245', 3, N'47', N'MAGDALENA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (680, N'47258', N'EL PIÑON', N'47258', 3, N'47', N'MAGDALENA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (681, N'47268', N'EL RETEN', N'47268', 3, N'47', N'MAGDALENA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (682, N'47288', N'FUNDACION', N'47288', 3, N'47', N'MAGDALENA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (683, N'47318', N'GUAMAL', N'47318', 3, N'47', N'MAGDALENA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (684, N'47460', N'NUEVA GRANADA ', N'47460', 3, N'47', N'MAGDALENA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (685, N'47541', N'PEDRAZA ', N'47541', 3, N'47', N'MAGDALENA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (686, N'47545', N'PIJIÑO DEL CARMEN', N'47545', 3, N'47', N'MAGDALENA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (687, N'47551', N'PIVIJAY ', N'47551', 3, N'47', N'MAGDALENA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (688, N'47555', N'PLATO', N'47555', 3, N'47', N'MAGDALENA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (689, N'470', N'PUEBLOVIEJO', N'47570', 3, N'47', N'MAGDALENA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (690, N'47605', N'REMOLINO', N'47605', 3, N'47', N'MAGDALENA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (691, N'47660', N'SABANAS DE SAN ANGEL', N'47660', 3, N'47', N'MAGDALENA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (692, N'47675', N'SALAMINA', N'47675', 3, N'47', N'MAGDALENA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (693, N'47692', N'SAN SEBASTIAN DE BUENAVISTA', N'47692', 3, N'47', N'MAGDALENA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (694, N'47703', N'SAN ZENON', N'47703', 3, N'47', N'MAGDALENA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (695, N'47707', N'SANTA ANA', N'47707', 3, N'47', N'MAGDALENA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (696, N'47720', N'SANTA BARBARA DE PINTO ', N'47720', 3, N'47', N'MAGDALENA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (697, N'47745', N'SITIONUEVO ', N'47745', 3, N'47', N'MAGDALENA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (698, N'47798', N'TENERIFE', N'47798', 3, N'47', N'MAGDALENA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (699, N'47960', N'ZAPAYAN ', N'47960', 3, N'47', N'MAGDALENA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (700, N'47980', N'ZONA BANANERA ', N'47980', 3, N'47', N'MAGDALENA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (702, N'50001', N'VILLAVICENCIO ', N'50001', 3, N'50', N'META ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (703, N'50006', N'ACACIAS ', N'50006', 3, N'50', N'META ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (704, N'50110', N'BARRANCA DE UPIA ', N'50110', 3, N'50', N'META ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (705, N'50124', N'CABUYARO', N'50124', 3, N'50', N'META ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (706, N'50150', N'CASTILLA LA NUEVA', N'50150', 3, N'50', N'META ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (707, N'50223', N'CUBARRAL', N'50223', 3, N'50', N'META ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (708, N'50226', N'CUMARAL ', N'50226', 3, N'50', N'META ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (709, N'50245', N'EL CALVARIO', N'50245', 3, N'50', N'META ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (710, N'50251', N'EL CASTILLO', N'50251', 3, N'50', N'META ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (711, N'50270', N'EL DORADO', N'50270', 3, N'50', N'META ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (712, N'50287', N'FUENTE DE ORO ', N'50287', 3, N'50', N'META ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (713, N'50313', N'GRANADA ', N'50313', 3, N'50', N'META ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (714, N'50318', N'GUAMAL', N'50318', 3, N'50', N'META ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (715, N'50325', N'MAPIRIPAN', N'50325', 3, N'50', N'META ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (716, N'50330', N'MESETAS ', N'50330', 3, N'50', N'META ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (717, N'50350', N'LA MACARENA', N'50350', 3, N'50', N'META ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (718, N'50370', N'URIBE', N'50370', 3, N'50', N'META ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (719, N'50400', N'LEJANIAS', N'50400', 3, N'50', N'META ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (720, N'50450', N'PUERTO CONCORDIA ', N'50450', 3, N'50', N'META ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (721, N'50568', N'PUERTO GAITAN ', N'50568', 3, N'50', N'META ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (722, N'503', N'PUERTO LOPEZ', N'50573', 3, N'50', N'META ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (723, N'507', N'PUERTO LLERAS ', N'50577', 3, N'50', N'META ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (724, N'50590', N'PUERTO RICO', N'50590', 3, N'50', N'META ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (725, N'50606', N'RESTREPO', N'50606', 3, N'50', N'META ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (726, N'50680', N'SAN CARLOS DE GUAROA', N'50680', 3, N'50', N'META ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (727, N'50683', N'SAN JUAN DE ARAMA', N'50683', 3, N'50', N'META ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (728, N'50686', N'SAN JUANITO', N'50686', 3, N'50', N'META ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (729, N'50689', N'SAN MARTIN ', N'50689', 3, N'50', N'META ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (730, N'50711', N'VISTAHERMOSA', N'50711', 3, N'50', N'META ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (732, N'52001', N'PASTO', N'52001', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (733, N'52019', N'ALBAN', N'52019', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (734, N'52022', N'ALDANA', N'52022', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (735, N'52036', N'ANCUYA', N'52036', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (736, N'52051', N'ARBOLEDA', N'52051', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (737, N'52079', N'BARBACOAS', N'52079', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (738, N'52083', N'BELEN', N'52083', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (739, N'52110', N'BUESACO ', N'52110', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (740, N'52203', N'COLON', N'52203', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (741, N'52207', N'CONSACA ', N'52207', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (742, N'52210', N'CONTADERO', N'52210', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (743, N'52215', N'CORDOBA ', N'52215', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (744, N'52224', N'CUASPUD ', N'52224', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (745, N'52227', N'CUMBAL', N'52227', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (746, N'52233', N'CUMBITARA', N'52233', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (747, N'52240', N'CHACHAGÜI', N'52240', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (748, N'52250', N'EL CHARCO', N'52250', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (749, N'52254', N'EL PEÑOL', N'52254', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (750, N'52256', N'EL ROSARIO ', N'52256', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (751, N'52258', N'EL TABLON DE GOMEZ', N'52258', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (752, N'52260', N'EL TAMBO', N'52260', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (753, N'52287', N'FUNES', N'52287', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (754, N'52317', N'GUACHUCAL', N'52317', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (755, N'52320', N'GUAITARILLA', N'52320', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (756, N'52323', N'GUALMATAN', N'52323', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (757, N'52352', N'ILES ', N'52352', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (758, N'52354', N'IMUES', N'52354', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (759, N'52356', N'IPIALES ', N'52356', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (760, N'52378', N'LA CRUZ ', N'52378', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (761, N'52381', N'LA FLORIDA ', N'52381', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (762, N'52385', N'LA LLANADA ', N'52385', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (763, N'52390', N'LA TOLA ', N'52390', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (764, N'52399', N'LA UNION', N'52399', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (765, N'52405', N'LEIVA', N'52405', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (766, N'52411', N'LINARES ', N'52411', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (767, N'52418', N'LOS ANDES', N'52418', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (768, N'52427', N'MAGÜI', N'52427', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (769, N'52435', N'MALLAMA ', N'52435', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (770, N'52473', N'MOSQUERA', N'52473', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (771, N'52480', N'NARIÑO', N'52480', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (772, N'52490', N'OLAYA HERRERA ', N'52490', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (773, N'52506', N'OSPINA', N'52506', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (774, N'52520', N'FRANCISCO PIZARRO', N'52520', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (775, N'52540', N'POLICARPA', N'52540', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (776, N'52560', N'POTOSI', N'52560', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (777, N'52565', N'PROVIDENCIA', N'52565', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (778, N'523', N'PUERRES ', N'52573', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (779, N'52585', N'PUPIALES', N'52585', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (780, N'52612', N'RICAURTE', N'52612', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (781, N'52621', N'ROBERTO PAYAN ', N'52621', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (782, N'52678', N'SAMANIEGO', N'52678', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (783, N'52683', N'SANDONA ', N'52683', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (784, N'52685', N'SAN BERNARDO', N'52685', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (785, N'52687', N'SAN LORENZO', N'52687', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (786, N'52693', N'SAN PABLO', N'52693', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (787, N'52694', N'SAN PEDRO DE CARTAGO', N'52694', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (788, N'52696', N'SANTA BARBARA ', N'52696', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (789, N'52699', N'SANTACRUZ', N'52699', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (790, N'52720', N'SAPUYES ', N'52720', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (791, N'52786', N'TAMINANGO', N'52786', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (792, N'52788', N'TANGUA', N'52788', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (793, N'52835', N'TUMACO', N'52835', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (794, N'52838', N'TUQUERRES', N'52838', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (795, N'52885', N'YACUANQUER ', N'52885', 3, N'52', N'NARIÑO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (797, N'54001', N'C/CUTA', N'54001', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (798, N'54003', N'ABREGO', N'54003', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (799, N'54051', N'ARBOLEDAS', N'54051', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (800, N'54099', N'BOCHALEMA', N'54099', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (801, N'54109', N'BUCARASICA ', N'54109', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (802, N'54125', N'CACOTA', N'54125', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (803, N'54128', N'CACHIRA ', N'54128', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (804, N'54172', N'CHINACOTA', N'54172', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (805, N'54174', N'CHITAGA ', N'54174', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (806, N'54206', N'CONVENCION ', N'54206', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (807, N'54223', N'CUCUTILLA', N'54223', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (808, N'54239', N'DURANIA ', N'54239', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (809, N'54245', N'EL CARMEN', N'54245', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (810, N'54250', N'EL TARRA', N'54250', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (811, N'54261', N'EL ZULIA', N'54261', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (812, N'54313', N'GRAMALOTE', N'54313', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (813, N'54344', N'HACARI', N'54344', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (814, N'54347', N'HERRAN', N'54347', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (815, N'54377', N'LABATECA', N'54377', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (816, N'54385', N'LA ESPERANZA', N'54385', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (817, N'54398', N'LA PLAYA', N'54398', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (818, N'54405', N'LOS PATIOS ', N'54405', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (819, N'54418', N'LOURDES ', N'54418', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (820, N'54480', N'MUTISCUA', N'54480', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (821, N'54498', N'OCAÑA', N'54498', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (822, N'54518', N'PAMPLONA', N'54518', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (823, N'54520', N'PAMPLONITA ', N'54520', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (824, N'54553', N'PUERTO SANTANDER ', N'54553', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (825, N'54599', N'RAGONVALIA ', N'54599', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (826, N'54660', N'SALAZAR ', N'54660', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (827, N'54670', N'SAN CALIXTO', N'54670', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (828, N'54673', N'SAN CAYETANO', N'54673', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (829, N'54680', N'SANTIAGO', N'54680', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (830, N'54720', N'SARDINATA', N'54720', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (831, N'54743', N'SILOS', N'54743', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (832, N'54800', N'TEORAMA ', N'54800', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (833, N'54810', N'TIBU ', N'54810', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (834, N'54820', N'TOLEDO', N'54820', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (835, N'54871', N'VILLA CARO ', N'54871', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (836, N'54874', N'VILLA DEL ROSARIO', N'54874', 3, N'54', N'NORTE DE SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (838, N'63001', N'ARMENIA ', N'63001', 3, N'63', N'QUINDIO ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (839, N'63111', N'BUENAVISTA ', N'63111', 3, N'63', N'QUINDIO ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (840, N'63130', N'CALARCA ', N'63130', 3, N'63', N'QUINDIO ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (841, N'63190', N'CIRCASIA', N'63190', 3, N'63', N'QUINDIO ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (842, N'63212', N'CORDOBA ', N'63212', 3, N'63', N'QUINDIO ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (843, N'63272', N'FILANDIA', N'63272', 3, N'63', N'QUINDIO ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (844, N'63302', N'GENOVA', N'63302', 3, N'63', N'QUINDIO ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (845, N'63401', N'LA TEBAIDA ', N'63401', 3, N'63', N'QUINDIO ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (846, N'63470', N'MONTENEGRO ', N'63470', 3, N'63', N'QUINDIO ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (847, N'63548', N'PIJAO', N'63548', 3, N'63', N'QUINDIO ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (848, N'63594', N'QUIMBAYA', N'63594', 3, N'63', N'QUINDIO ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (849, N'63690', N'SALENTO ', N'63690', 3, N'63', N'QUINDIO ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (851, N'66001', N'PEREIRA ', N'66001', 3, N'66', N'RISARALDA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (852, N'66045', N'APIA ', N'66045', 3, N'66', N'RISARALDA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (853, N'66075', N'BALBOA', N'66075', 3, N'66', N'RISARALDA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (854, N'66088', N'BELEN DE UMBRIA', N'66088', 3, N'66', N'RISARALDA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (855, N'66170', N'DOSQUEBRADAS', N'66170', 3, N'66', N'RISARALDA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (856, N'66318', N'GUATICA ', N'66318', 3, N'66', N'RISARALDA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (857, N'66383', N'LA CELIA', N'66383', 3, N'66', N'RISARALDA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (858, N'66400', N'LA VIRGINIA', N'66400', 3, N'66', N'RISARALDA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (859, N'66440', N'MARSELLA', N'66440', 3, N'66', N'RISARALDA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (860, N'66456', N'MISTRATO', N'66456', 3, N'66', N'RISARALDA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (861, N'662', N'PUEBLO RICO', N'66572', 3, N'66', N'RISARALDA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (862, N'66594', N'QUINCHIA', N'66594', 3, N'66', N'RISARALDA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (863, N'66682', N'SANTA ROSA DE CABAL ', N'66682', 3, N'66', N'RISARALDA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (864, N'66687', N'SANTUARIO', N'66687', 3, N'66', N'RISARALDA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (866, N'68001', N'BUCARAMANGA', N'68001', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (867, N'68013', N'AGUADA', N'68013', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (868, N'68020', N'ALBANIA ', N'68020', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (869, N'68051', N'ARATOCA ', N'68051', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (870, N'68077', N'BARBOSA ', N'68077', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (871, N'68079', N'BARICHARA', N'68079', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (872, N'68081', N'BARRANCABERMEJA', N'68081', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (873, N'68092', N'BETULIA ', N'68092', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (874, N'68101', N'BOLIVAR ', N'68101', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (875, N'68121', N'CABRERA ', N'68121', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (876, N'68132', N'CALIFORNIA ', N'68132', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (877, N'68147', N'CAPITANEJO ', N'68147', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (878, N'68152', N'CARCASI ', N'68152', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (879, N'68160', N'CEPITA', N'68160', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (880, N'68162', N'CERRITO ', N'68162', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (881, N'68167', N'CHARALA ', N'68167', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (882, N'68169', N'CHARTA', N'68169', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (883, N'68176', N'CHIMA', N'68176', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (884, N'68179', N'CHIPATA ', N'68179', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (885, N'68190', N'CIMITARRA', N'68190', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (886, N'68207', N'CONCEPCION ', N'68207', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (887, N'68209', N'CONFINES', N'68209', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (888, N'68211', N'CONTRATACION', N'68211', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (889, N'68217', N'COROMORO', N'68217', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (890, N'68229', N'CURITI', N'68229', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (891, N'68235', N'EL CARMEN DE CHUCURI', N'68235', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (892, N'68245', N'EL GUACAMAYO', N'68245', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (893, N'68250', N'EL PEÑON', N'68250', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (894, N'68255', N'EL PLAYON', N'68255', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (895, N'68264', N'ENCINO', N'68264', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (896, N'68266', N'ENCISO', N'68266', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (897, N'68271', N'FLORIAN ', N'68271', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (898, N'68276', N'FLORIDABLANCA ', N'68276', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (899, N'68296', N'GALAN', N'68296', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (900, N'68298', N'GAMBITA ', N'68298', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (901, N'68307', N'GIRON', N'68307', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (902, N'68318', N'GUACA', N'68318', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (903, N'68320', N'GUADALUPE', N'68320', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (904, N'68322', N'GUAPOTA ', N'68322', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (905, N'68324', N'GUAVATA ', N'68324', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (906, N'68327', N'GÜEPSA', N'68327', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (907, N'68344', N'HATO ', N'68344', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (908, N'68368', N'JES/S MARIA', N'68368', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (909, N'68370', N'JORDAN', N'68370', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (910, N'68377', N'LA BELLEZA ', N'68377', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (911, N'68385', N'LANDAZURI', N'68385', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (912, N'68397', N'LA PAZ', N'68397', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (913, N'68406', N'LEBRIJA ', N'68406', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (914, N'68418', N'LOS SANTOS ', N'68418', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (915, N'68425', N'MACARAVITA ', N'68425', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (916, N'68432', N'MALAGA', N'68432', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (917, N'68444', N'MATANZA ', N'68444', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (918, N'68464', N'MOGOTES ', N'68464', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (919, N'68468', N'MOLAGAVITA ', N'68468', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (920, N'68498', N'OCAMONTE', N'68498', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (921, N'68500', N'OIBA ', N'68500', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (922, N'68502', N'ONZAGA', N'68502', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (923, N'68522', N'PALMAR', N'68522', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (924, N'68524', N'PALMAS DEL SOCORRO', N'68524', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (925, N'68533', N'PARAMO', N'68533', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (926, N'68547', N'PIEDECUESTA', N'68547', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (927, N'68549', N'PINCHOTE', N'68549', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (928, N'682', N'PUENTE NACIONAL', N'68572', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (929, N'683', N'PUERTO PARRA', N'68573', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (930, N'685', N'PUERTO WILCHES', N'68575', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (931, N'68615', N'RIONEGRO', N'68615', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (932, N'68655', N'SABANA DE TORRES ', N'68655', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (933, N'68669', N'SAN ANDRES ', N'68669', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (934, N'68673', N'SAN BENITO ', N'68673', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (935, N'68679', N'SAN GIL ', N'68679', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (936, N'68682', N'SAN JOAQUIN', N'68682', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (937, N'68684', N'SAN JOSE DE MIRANDA ', N'68684', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (938, N'68686', N'SAN MIGUEL ', N'68686', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (939, N'68689', N'SAN VICENTE DE CHUCURI ', N'68689', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (940, N'68705', N'SANTA BARBARA ', N'68705', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (941, N'68720', N'SANTA HELENA DEL OPON', N'68720', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (942, N'68745', N'SIMACOTA', N'68745', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (943, N'68755', N'SOCORRO ', N'68755', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (944, N'68770', N'SUAITA', N'68770', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (945, N'68773', N'SUCRE', N'68773', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (946, N'68780', N'SURATA', N'68780', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (947, N'68820', N'TONA ', N'68820', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (948, N'68855', N'VALLE DE SAN JOSE', N'68855', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (949, N'68861', N'VELEZ', N'68861', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (950, N'68867', N'VETAS', N'68867', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (951, N'68872', N'VILLANUEVA ', N'68872', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (952, N'68895', N'ZAPATOCA', N'68895', 3, N'68', N'SANTANDER', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (954, N'70001', N'SINCELEJO', N'70001', 3, N'70', N'SUCRE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (955, N'70110', N'BUENAVISTA ', N'70110', 3, N'70', N'SUCRE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (956, N'70124', N'CAIMITO ', N'70124', 3, N'70', N'SUCRE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (957, N'70204', N'COLOSO', N'70204', 3, N'70', N'SUCRE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (958, N'70215', N'COROZAL ', N'70215', 3, N'70', N'SUCRE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (959, N'70221', N'COVEÑAS ', N'70221', 3, N'70', N'SUCRE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (960, N'70230', N'CHALAN', N'70230', 3, N'70', N'SUCRE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (961, N'70233', N'EL ROBLE', N'70233', 3, N'70', N'SUCRE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (962, N'70235', N'GALERAS ', N'70235', 3, N'70', N'SUCRE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (963, N'70265', N'GUARANDA', N'70265', 3, N'70', N'SUCRE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (964, N'70400', N'LA UNION', N'70400', 3, N'70', N'SUCRE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (965, N'70418', N'LOS PALMITOS', N'70418', 3, N'70', N'SUCRE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (966, N'70429', N'MAJAGUAL', N'70429', 3, N'70', N'SUCRE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (967, N'70473', N'MORROA', N'70473', 3, N'70', N'SUCRE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (968, N'70508', N'OVEJAS', N'70508', 3, N'70', N'SUCRE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (969, N'70523', N'PALMITO ', N'70523', 3, N'70', N'SUCRE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (970, N'70670', N'SAMPUES ', N'70670', 3, N'70', N'SUCRE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (971, N'70678', N'SAN BENITO ABAD', N'70678', 3, N'70', N'SUCRE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (972, N'70702', N'SAN JUAN DE BETULIA ', N'70702', 3, N'70', N'SUCRE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (973, N'70708', N'SAN MARCOS ', N'70708', 3, N'70', N'SUCRE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (974, N'70713', N'SAN ONOFRE ', N'70713', 3, N'70', N'SUCRE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (975, N'70717', N'SAN PEDRO', N'70717', 3, N'70', N'SUCRE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (976, N'70742', N'SINCE', N'70742', 3, N'70', N'SUCRE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (977, N'70771', N'SUCRE', N'70771', 3, N'70', N'SUCRE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (978, N'70820', N'SANTIAGO DE TOLU ', N'70820', 3, N'70', N'SUCRE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (979, N'70823', N'TOLUVIEJO', N'70823', 3, N'70', N'SUCRE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (981, N'73001', N'IBAGUE', N'73001', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (982, N'73024', N'ALPUJARRA', N'73024', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (983, N'73026', N'ALVARADO', N'73026', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (984, N'73030', N'AMBALEMA', N'73030', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (985, N'73043', N'ANZOATEGUI ', N'73043', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (986, N'73055', N'ARMERO', N'73055', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (987, N'73067', N'ATACO', N'73067', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (988, N'73124', N'CAJAMARCA', N'73124', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (989, N'73148', N'CARMEN DE APICALA', N'73148', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (990, N'73152', N'CASABIANCA ', N'73152', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (991, N'73168', N'CHAPARRAL', N'73168', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (992, N'73200', N'COELLO', N'73200', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (993, N'73217', N'COYAIMA ', N'73217', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (994, N'73226', N'CUNDAY', N'73226', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (995, N'73236', N'DOLORES ', N'73236', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (996, N'73268', N'ESPINAL ', N'73268', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (997, N'73270', N'FALAN', N'73270', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (998, N'73275', N'FLANDES ', N'73275', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (999, N'73283', N'FRESNO', N'73283', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1000, N'73319', N'GUAMO', N'73319', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1001, N'73347', N'HERVEO', N'73347', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1002, N'73349', N'HONDA', N'73349', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1003, N'73352', N'ICONONZO', N'73352', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1004, N'73408', N'LERIDA', N'73408', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1005, N'73411', N'LIBANO', N'73411', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1006, N'73443', N'MARIQUITA', N'73443', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1007, N'73449', N'MELGAR', N'73449', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1008, N'73461', N'MURILLO ', N'73461', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1009, N'73483', N'NATAGAIMA', N'73483', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1010, N'73504', N'ORTEGA', N'73504', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1011, N'73520', N'PALOCABILDO', N'73520', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1012, N'73547', N'PIEDRAS ', N'73547', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1013, N'73555', N'PLANADAS', N'73555', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1014, N'73563', N'PRADO', N'73563', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1015, N'73585', N'PURIFICACION', N'73585', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1016, N'73616', N'RIOBLANCO', N'73616', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1017, N'73622', N'RONCESVALLES', N'73622', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1018, N'73624', N'ROVIRA', N'73624', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1019, N'73671', N'SALDAÑA ', N'73671', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1020, N'73675', N'SAN ANTONIO', N'73675', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1021, N'73678', N'SAN LUIS', N'73678', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1022, N'73686', N'SANTA ISABEL', N'73686', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1023, N'73770', N'SUAREZ', N'73770', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1024, N'73854', N'VALLE DE SAN JUAN', N'73854', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1025, N'73861', N'VENADILLO', N'73861', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1026, N'73870', N'VILLAHERMOSA', N'73870', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1027, N'73873', N'VILLARRICA ', N'73873', 3, N'73', N'TOLIMA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1029, N'76001', N'CALI ', N'76001', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1030, N'76020', N'ALCALA', N'76020', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1031, N'76036', N'ANDALUCIA', N'76036', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1032, N'76041', N'ANSERMANUEVO', N'76041', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1033, N'76054', N'ARGELIA ', N'76054', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1034, N'76100', N'BOLIVAR ', N'76100', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1035, N'76109', N'BUENAVENTURA', N'76109', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1036, N'76111', N'GUADALAJARA DE BUGA ', N'76111', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1037, N'76113', N'BUGALAGRANDE', N'76113', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1038, N'76122', N'CAICEDONIA ', N'76122', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1039, N'76126', N'CALIMA', N'76126', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1040, N'76130', N'CANDELARIA ', N'76130', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1041, N'76147', N'CARTAGO ', N'76147', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1042, N'76233', N'DAGUA', N'76233', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1043, N'76243', N'EL AGUILA', N'76243', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1044, N'76246', N'EL CAIRO', N'76246', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1045, N'76248', N'EL CERRITO ', N'76248', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1046, N'76250', N'EL DOVIO', N'76250', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1047, N'76275', N'FLORIDA ', N'76275', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1048, N'76306', N'GINEBRA ', N'76306', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1049, N'76318', N'GUACARI ', N'76318', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1050, N'76364', N'JAMUNDI ', N'76364', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1051, N'76377', N'LA CUMBRE', N'76377', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1052, N'76400', N'LA UNION', N'76400', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1053, N'76403', N'LA VICTORIA', N'76403', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1054, N'76497', N'OBANDO', N'76497', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1055, N'76520', N'PALMIRA ', N'76520', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1056, N'76563', N'PRADERA ', N'76563', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1057, N'76606', N'RESTREPO', N'76606', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1058, N'76616', N'RIOFRIO ', N'76616', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1059, N'76622', N'ROLDANILLO ', N'76622', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1060, N'76670', N'SAN PEDRO', N'76670', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1061, N'76736', N'SEVILLA ', N'76736', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1062, N'76823', N'TORO ', N'76823', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1063, N'76828', N'TRUJILLO', N'76828', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1064, N'76834', N'TULUA', N'76834', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1065, N'76845', N'ULLOA', N'76845', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1066, N'76863', N'VERSALLES', N'76863', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1067, N'76869', N'VIJES', N'76869', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1068, N'76890', N'YOTOCO', N'76890', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1069, N'76892', N'YUMBO', N'76892', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1070, N'76895', N'ZARZAL', N'76895', 3, N'76', N'VALLE DEL CAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1072, N'81001', N'ARAUCA', N'81001', 3, N'81', N'ARAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1073, N'81065', N'ARAUQUITA', N'81065', 3, N'81', N'ARAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1074, N'81220', N'CRAVO NORTE', N'81220', 3, N'81', N'ARAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1075, N'81300', N'FORTUL', N'81300', 3, N'81', N'ARAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1076, N'81591', N'PUERTO RONDON ', N'81591', 3, N'81', N'ARAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1077, N'81736', N'SARAVENA', N'81736', 3, N'81', N'ARAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1078, N'81794', N'TAME ', N'81794', 3, N'81', N'ARAUCA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1080, N'85001', N'YOPAL', N'85001', 3, N'85', N'CASANARE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1081, N'85010', N'AGUAZUL ', N'85010', 3, N'85', N'CASANARE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1082, N'85015', N'CHAMEZA ', N'85015', 3, N'85', N'CASANARE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1083, N'85125', N'HATO COROZAL', N'85125', 3, N'85', N'CASANARE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1084, N'85136', N'LA SALINA', N'85136', 3, N'85', N'CASANARE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1085, N'85139', N'MANI ', N'85139', 3, N'85', N'CASANARE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1086, N'85162', N'MONTERREY', N'85162', 3, N'85', N'CASANARE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1087, N'85225', N'NUNCHIA ', N'85225', 3, N'85', N'CASANARE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1088, N'85230', N'OROCUE', N'85230', 3, N'85', N'CASANARE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1089, N'85250', N'PAZ DE ARIPORO', N'85250', 3, N'85', N'CASANARE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1090, N'85263', N'PORE ', N'85263', 3, N'85', N'CASANARE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1091, N'85279', N'RECETOR ', N'85279', 3, N'85', N'CASANARE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1092, N'85300', N'SABANALARGA', N'85300', 3, N'85', N'CASANARE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1093, N'85315', N'SACAMA', N'85315', 3, N'85', N'CASANARE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1094, N'85325', N'SAN LUIS DE PALENQUE', N'85325', 3, N'85', N'CASANARE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1095, N'85400', N'TAMARA', N'85400', 3, N'85', N'CASANARE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1096, N'85410', N'TAURAMENA', N'85410', 3, N'85', N'CASANARE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1097, N'85430', N'TRINIDAD', N'85430', 3, N'85', N'CASANARE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1098, N'85440', N'VILLANUEVA ', N'85440', 3, N'85', N'CASANARE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1100, N'86001', N'MOCOA', N'86001', 3, N'86', N'PUTUMAYO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1101, N'86219', N'COLON', N'86219', 3, N'86', N'PUTUMAYO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1102, N'86320', N'ORITO', N'86320', 3, N'86', N'PUTUMAYO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1103, N'86568', N'PUERTO ASIS', N'86568', 3, N'86', N'PUTUMAYO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1104, N'86569', N'PUERTO CAICEDO', N'86569', 3, N'86', N'PUTUMAYO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1105, N'861', N'PUERTO GUZMAN ', N'86571', 3, N'86', N'PUTUMAYO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1106, N'863', N'LEGUIZAMO', N'86573', 3, N'86', N'PUTUMAYO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1107, N'86749', N'SIBUNDOY', N'86749', 3, N'86', N'PUTUMAYO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1108, N'86755', N'SAN FRANCISCO ', N'86755', 3, N'86', N'PUTUMAYO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1109, N'867', N'SAN MIGUEL ', N'86757', 3, N'86', N'PUTUMAYO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1110, N'86760', N'SANTIAGO', N'86760', 3, N'86', N'PUTUMAYO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1111, N'86865', N'VALLE DEL GUAMUEZ', N'86865', 3, N'86', N'PUTUMAYO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1112, N'86885', N'VILLAGARZON', N'86885', 3, N'86', N'PUTUMAYO', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1114, N'88001', N'SAN ANDRES ', N'88001', 3, N'88', N'ARCHIPIÉLAGO DE SAN ANDRÉS, PROVIDENCIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1115, N'88564', N'PROVIDENCIA', N'88564', 3, N'88', N'ARCHIPIÉLAGO DE SAN ANDRÉS, PROVIDENCIA', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1117, N'91001', N'LETICIA ', N'91001', 3, N'91', N'AMAZONAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1118, N'91263', N'EL ENCANTO ', N'91263', 3, N'91', N'AMAZONAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1119, N'91405', N'LA CHORRERA', N'91405', 3, N'91', N'AMAZONAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1120, N'91407', N'LA PEDRERA ', N'91407', 3, N'91', N'AMAZONAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1121, N'91430', N'LA VICTORIA', N'91430', 3, N'91', N'AMAZONAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1122, N'91460', N'MIRITI  PARANA', N'91460', 3, N'91', N'AMAZONAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1123, N'91530', N'PUERTO ALEGRIA', N'91530', 3, N'91', N'AMAZONAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1124, N'91536', N'PUERTO ARICA', N'91536', 3, N'91', N'AMAZONAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1125, N'91540', N'PUERTO NARIÑO ', N'91540', 3, N'91', N'AMAZONAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1126, N'91798', N'TARAPACA', N'91798', 3, N'91', N'AMAZONAS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1128, N'94001', N'INIRIDA ', N'94001', 3, N'94', N'GUAINÍA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1129, N'94343', N'BARRANCO MINAS', N'94343', 3, N'94', N'GUAINÍA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1130, N'94663', N'MAPIRIPANA ', N'94663', 3, N'94', N'GUAINÍA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1131, N'94883', N'SAN FELIPE ', N'94883', 3, N'94', N'GUAINÍA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1132, N'94884', N'PUERTO COLOMBIA', N'94884', 3, N'94', N'GUAINÍA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1133, N'94885', N'LA GUADALUPE', N'94885', 3, N'94', N'GUAINÍA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1134, N'94886', N'CACAHUAL', N'94886', 3, N'94', N'GUAINÍA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1135, N'94887', N'PANA PANA', N'94887', 3, N'94', N'GUAINÍA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1136, N'94888', N'MORICHAL', N'94888', 3, N'94', N'GUAINÍA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1138, N'95001', N'SAN JOSE DEL GUAVIARE', N'95001', 3, N'95', N'GUAVIARE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1139, N'95015', N'CALAMAR ', N'95015', 3, N'95', N'GUAVIARE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1140, N'95025', N'EL RETORNO ', N'95025', 3, N'95', N'GUAVIARE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1141, N'95200', N'MIRAFLORES ', N'95200', 3, N'95', N'GUAVIARE', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1143, N'97001', N'MITU ', N'97001', 3, N'97', N'VAUPÉS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1144, N'97161', N'CARURU', N'97161', 3, N'97', N'VAUPÉS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1145, N'97511', N'PACOA', N'97511', 3, N'97', N'VAUPÉS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1146, N'97666', N'TARAIRA ', N'97666', 3, N'97', N'VAUPÉS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1147, N'97777', N'PAPUNAUA', N'97777', 3, N'97', N'VAUPÉS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1148, N'97889', N'YAVARATE', N'97889', 3, N'97', N'VAUPÉS', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1150, N'99001', N'PUERTO CARREÑO', N'99001', 3, N'99', N'VICHADA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1151, N'99524', N'LA PRIMAVERA', N'99524', 3, N'99', N'VICHADA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1152, N'99624', N'SANTA ROSALIA ', N'99624', 3, N'99', N'VICHADA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[DivPolitica] ([id], [codigo], [nombre], [codigodane], [nivel], [codeDepartament], [nombredep], [created], [updated], [id_user]) VALUES (1153, N'99773', N'CUMARIBO', N'99773', 3, N'99', N'VICHADA ', CAST(N'20171125 10:12:00' AS SmallDateTime), CAST(N'20171125 10:12:00' AS SmallDateTime), 1)
GO
SET IDENTITY_INSERT [dbo].[DivPolitica] OFF
GO
SET IDENTITY_INSERT [dbo].[Parametros] ON 

GO
INSERT [dbo].[Parametros] ([id], [codigo], [nombre], [valor], [tipo], [created], [updated], [id_user]) VALUES (1, N'COMPANYNAME', N'Nombre de Compañia', N'MOTOSPORST S.A.S', N'TEXT', CAST(N'20171125 22:54:00' AS SmallDateTime), CAST(N'20171125 22:54:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[Parametros] ([id], [codigo], [nombre], [valor], [tipo], [created], [updated], [id_user]) VALUES (2, N'COMPANYNIT', N'Nit Empresa', N'901066217-3', N'TEXT', CAST(N'20171125 22:54:00' AS SmallDateTime), CAST(N'20171125 22:54:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[Parametros] ([id], [codigo], [nombre], [valor], [tipo], [created], [updated], [id_user]) VALUES (3, N'COMPANYDIGVER', N'Digito de Verificacion Compañia', N'', N'TEXT', CAST(N'20171125 22:54:00' AS SmallDateTime), CAST(N'20171125 22:54:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[Parametros] ([id], [codigo], [nombre], [valor], [tipo], [created], [updated], [id_user]) VALUES (4, N'COMPANYADDRESS', N'Direccion de Compañia', N'CLL 49 47 -44 RIONEGRO', N'TEXT', CAST(N'20171125 22:54:00' AS SmallDateTime), CAST(N'20171125 22:54:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[Parametros] ([id], [codigo], [nombre], [valor], [tipo], [created], [updated], [id_user]) VALUES (6, N'COMPANYTEL', N'Telefono de Compañia', N'5322710', N'TEXT', CAST(N'20171125 22:54:00' AS SmallDateTime), CAST(N'20171125 22:54:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[Parametros] ([id], [codigo], [nombre], [valor], [tipo], [created], [updated], [id_user]) VALUES (7, N'COMPANYADMIN', N'Admin de Compañia', N'MARIA ISABEL VALENCIA', N'TEXT', CAST(N'20171125 18:43:00' AS SmallDateTime), CAST(N'20171125 18:43:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[Parametros] ([id], [codigo], [nombre], [valor], [tipo], [created], [updated], [id_user]) VALUES (8, N'COMPANYADMINTEL', N'Tel: Admin de Compañia', N'', N'TEXT', CAST(N'20171125 18:44:00' AS SmallDateTime), CAST(N'20171125 18:44:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[Parametros] ([id], [codigo], [nombre], [valor], [tipo], [created], [updated], [id_user]) VALUES (9, N'COMPANYADMINMAIL', N'Mail Admin de Compañia', N'', N'TEXT', CAST(N'20171125 18:44:00' AS SmallDateTime), CAST(N'20171125 18:44:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[Parametros] ([id], [codigo], [nombre], [valor], [tipo], [created], [updated], [id_user]) VALUES (10, N'COMPANYCITY', N'Ciudad de ubicacion de la Compañia', N'RIONEGRO', N'TEXT', CAST(N'20171125 18:44:00' AS SmallDateTime), CAST(N'20171125 18:44:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[Parametros] ([id], [codigo], [nombre], [valor], [tipo], [created], [updated], [id_user]) VALUES (11, N'COMPANYURLIMG', N'Imagen de Compañia', N'', N'TEXT', CAST(N'20171125 18:59:00' AS SmallDateTime), CAST(N'20171125 18:59:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[Parametros] ([id], [codigo], [nombre], [valor], [tipo], [created], [updated], [id_user]) VALUES (12, N'COMPANYIMGRPT', N'Ruta img para Reportes', N'', N'TEXT', CAST(N'20171125 18:59:00' AS SmallDateTime), CAST(N'20171125 18:59:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[Parametros] ([id], [codigo], [nombre], [valor], [tipo], [created], [updated], [id_user]) VALUES (13, N'TIMESESSION', N'Tiempo de Sesión', N'20000', N'NUMERO', CAST(N'20171125 17:34:00' AS SmallDateTime), CAST(N'20171125 17:34:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[Parametros] ([id], [codigo], [nombre], [valor], [tipo], [created], [updated], [id_user]) VALUES (14, N'PORCEINTERESMORA', N'Porcentaje de Interes x Mora', N'10', N'NUMERO', CAST(N'20171125 12:18:00' AS SmallDateTime), CAST(N'20171125 12:18:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[Parametros] ([id], [codigo], [nombre], [valor], [tipo], [created], [updated], [id_user]) VALUES (15, N'CUENTAINTERESMORA', N'Cuenta de Interes x Mora', N'437', N'NUMERO', CAST(N'20171125 12:25:00' AS SmallDateTime), CAST(N'20171125 12:25:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[Parametros] ([id], [codigo], [nombre], [valor], [tipo], [created], [updated], [id_user]) VALUES (16, N'FACTURAELECTRO', N'Empresa Factura Electronicamente', N'N', N'TEXT', CAST(N'20171125 13:44:00' AS SmallDateTime), CAST(N'20171125 13:44:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[Parametros] ([id], [codigo], [nombre], [valor], [tipo], [created], [updated], [id_user]) VALUES (17, N'ANOMESSTAR', N'Anomes inicio contabilidad', N'202001', N'TEXT', CAST(N'20171125 13:44:00' AS SmallDateTime), CAST(N'20171125 13:44:00' AS SmallDateTime), 1)
GO
INSERT [dbo].[Parametros] ([id], [codigo], [nombre], [valor], [tipo], [created], [updated], [id_user]) VALUES (18, N'PORIVAGEN', N'Porcentaje Iva General', N'19', N'TEXT', CAST(N'20171125 13:44:00' AS SmallDateTime), CAST(N'20171125 13:44:00' AS SmallDateTime), 1)
GO
SET IDENTITY_INSERT [dbo].[Parametros] OFF
GO
SET IDENTITY_INSERT [dbo].[ST_Listados] ON 

GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (1, N'FORMAPAGO', N'', N'', N'Forma de Pagos', 1, CAST(N'20171125 16:38:00' AS SmallDateTime), CAST(N'20171125 16:38:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (2, NULL, N'FORMAPAGO', N'CONTA', N'De Contado', 1, CAST(N'20171125 16:39:00' AS SmallDateTime), CAST(N'20171125 16:39:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (3, NULL, N'FORMAPAGO', N'CREDI', N'A Credito', 1, CAST(N'20171125 16:39:00' AS SmallDateTime), CAST(N'20171125 16:39:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (4, N'ESTADOMOV', N' ', N'', N'Estados de Movimientos', 1, CAST(N'20171125 16:40:00' AS SmallDateTime), CAST(N'20171125 16:40:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (5, NULL, N'ESTADOMOV', N'TEMP', N'TEMPORAL', 1, CAST(N'20171125 16:41:00' AS SmallDateTime), CAST(N'20171125 16:41:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (6, NULL, N'ESTADOMOV', N'PROCE', N'PROCESADO', 1, CAST(N'20171125 16:41:00' AS SmallDateTime), CAST(N'20171125 16:41:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (7, NULL, N'ESTADOMOV', N'REVER', N'REVERTIDO', 1, CAST(N'20171125 16:41:00' AS SmallDateTime), CAST(N'20171125 16:41:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (8, N'TIPOSID', N'', N'', N'Tipo de Identificación', 1, CAST(N'20171125 16:43:00' AS SmallDateTime), CAST(N'20171125 16:43:00' AS SmallDateTime), 1, 0)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (9, '13', N'TIPOSID', N'CC', N'CEDULA DE CIUDADANIA', 1, CAST(N'20171125 16:43:00' AS SmallDateTime), CAST(N'20171125 16:43:00' AS SmallDateTime), 1, 0)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (10, '31', N'TIPOSID', N'NIT', N'NIT', 1, CAST(N'20171125 16:43:00' AS SmallDateTime), CAST(N'20171125 16:43:00' AS SmallDateTime), 1, 0)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (11, '41', N'TIPOSID', N'PS', N'PASAPORTE', 1, CAST(N'20171125 16:43:00' AS SmallDateTime), CAST(N'20171125 16:43:00' AS SmallDateTime), 1, 0)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (12, '22', N'TIPOSID', N'CE', N'CEDULA DE EXTRANJERIA', 1, CAST(N'20171125 16:43:00' AS SmallDateTime), CAST(N'20171125 16:43:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (13, NULL, N'ESTADOMOV', N'REVON', N'REVERSION', 1, CAST(N'20171125 16:41:00' AS SmallDateTime), CAST(N'20171125 16:41:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (14, N'TIPOMOVIMIENTO', N'', N'', N'Tipos de Movimientos', 1, CAST(N'20171125 16:57:00' AS SmallDateTime), CAST(N'20171125 16:57:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (15, NULL, N'TIPOMOVIMIENTO', N'DEB', N'Debito', 1, CAST(N'20171125 16:43:00' AS SmallDateTime), CAST(N'20171125 16:43:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (16, NULL, N'TIPOMOVIMIENTO', N'CRE', N'Credito', 1, CAST(N'20171125 16:41:00' AS SmallDateTime), CAST(N'20171125 16:41:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (17, NULL, N'TIPOMOVIMIENTO', N'CREDEB', N'Credito - Debito', 1, CAST(N'20171125 16:41:00' AS SmallDateTime), CAST(N'20171125 16:41:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (18, N'VENCREDITO', N'', N'', N'Vencimiento de Factura', 1, CAST(N'20171125 10:59:00' AS SmallDateTime), CAST(N'20171125 10:59:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (19, NULL, N'VENCREDITO', N'UMV', N'Ulltimo día de cada Mes', 1, CAST(N'20171125 16:43:00' AS SmallDateTime), CAST(N'20171125 16:43:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (20, NULL, N'VENCREDITO', N'XDV', N'Cada x Días', 1, CAST(N'20171125 16:43:00' AS SmallDateTime), CAST(N'20171125 16:43:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (21, NULL, N'VENCREDITO', N'EDV', N'El día X de cada mes', 1, CAST(N'20171125 16:43:00' AS SmallDateTime), CAST(N'20171125 16:43:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (22, N'FORMAPAGOCONT', N'', N'', N'Forma de Pagos Contabilidad', 1, CAST(N'20171125 18:39:00' AS SmallDateTime), CAST(N'20171125 18:39:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (23, NULL, N'FORMAPAGOCONT', N'CONVENCIO', N'Convencional', 1, CAST(N'20171125 18:40:00' AS SmallDateTime), CAST(N'20171125 18:40:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (24, NULL, N'FORMAPAGOCONT', N'PROVEEDOR', N'Cartera Proveedor', 1, CAST(N'20171125 18:42:00' AS SmallDateTime), CAST(N'20171125 18:42:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (25, N'TIPOREGIMEN', N'', N'', N'Tipo de regimen', 1, CAST(N'20171125 09:45:00' AS SmallDateTime), CAST(N'20171125 09:45:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (26, NULL, N'TIPOREGIMEN', N'NRIVA', N'No responsable', 1, CAST(N'20171125 09:47:00' AS SmallDateTime), CAST(N'20171125 09:47:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (27, NULL, N'TIPOREGIMEN', N'RIVA', N'Responsable', 1, CAST(N'20171125 09:48:00' AS SmallDateTime), CAST(N'20171125 09:48:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (28, N'TIPOPRODUCTO', N'', N'', N'Tipo de Producto', 1, CAST(N'20171125 11:07:00' AS SmallDateTime), CAST(N'20171125 11:07:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (29, NULL, N'TIPOPRODUCTO', N'CONSUMO', N'De Consumo', 1, CAST(N'20171125 11:08:00' AS SmallDateTime), CAST(N'20171125 11:08:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (30, NULL, N'TIPOPRODUCTO', N'PRODUCTO', N'Producto', 1, CAST(N'20171125 11:08:00' AS SmallDateTime), CAST(N'20171125 11:08:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (31, NULL, N'TIPOPRODUCTO', N'SERVICIOS', N'Servicio', 1, CAST(N'20171125 11:09:00' AS SmallDateTime), CAST(N'20171125 11:09:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (32, N'PERSONERIA', N'', N'', N'Tipo de Personeria', 1, CAST(N'20171125 08:34:00' AS SmallDateTime), CAST(N'20171125 08:34:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (33, NULL, N'PERSONERIA', N'NATURAL', N'Natural', 1, CAST(N'20171125 08:34:00' AS SmallDateTime), CAST(N'20171125 08:34:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (34, NULL, N'PERSONERIA', N'JURIDICA', N'Juridica ', 1, CAST(N'20171125 08:35:00' AS SmallDateTime), CAST(N'20171125 08:35:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (35, NULL, N'ESTADOMOV', N'UTIL', N'UTILIZADO', 1, CAST(N'20171125 16:01:00' AS SmallDateTime), CAST(N'20171125 16:01:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (36, NULL, N'ESTADOMOV', N'CANCELADO', N'Cancelado', 1, CAST(N'20171125 14:20:00' AS SmallDateTime), CAST(N'20171125 14:20:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (37, N'NATURALEZA', N'', N'', N'Tipo de Concepto', 1, CAST(N'20171125 13:04:00' AS SmallDateTime), CAST(N'20171125 13:04:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (38, NULL, N'NATURALEZA', N'DEBITO', N'Debito', 1, CAST(N'20171125 13:05:00' AS SmallDateTime), CAST(N'20171125 13:05:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (39, NULL, N'NATURALEZA', N'CREDITO', N'Credito', 1, CAST(N'20171125 13:05:00' AS SmallDateTime), CAST(N'20171125 13:05:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (40, NULL, N'NATURALEZA', N'DEBITO-CREDITO', N'Debito-Credito', 1, CAST(N'20171125 13:06:00' AS SmallDateTime), CAST(N'20171125 13:06:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (41, '11', N'TIPOSID', N'RC', N'REGISTRO CIVIL DE NACIMIENTO', 1, CAST(N'20171125 14:51:00' AS SmallDateTime), CAST(N'20171125 14:51:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (42, '12', N'TIPOSID', N'TI', N'TARJETA DE INDENTIDAD', 1, CAST(N'20171125 14:55:00' AS SmallDateTime), CAST(N'20171125 14:55:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (43, '21', N'TIPOSID', N'TE', N'TARJETA DE EXTRANJERIA', 1, CAST(N'20171125 14:55:00' AS SmallDateTime), CAST(N'20171125 14:55:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (44, N'TIPOSTER', N'', N'', N'Tipos de terceros', 1, CAST(N'20171125 20:08:00' AS SmallDateTime), CAST(N'20171125 20:08:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (45, NULL, N'TIPOSTER', N'CL', N'CLIENTE', 1, CAST(N'20171125 20:10:00' AS SmallDateTime), CAST(N'20171125 20:10:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (46, NULL, N'TIPOSTER', N'PR', N'PROVEEDOR', 1, CAST(N'20171125 20:11:00' AS SmallDateTime), CAST(N'20171125 20:11:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (47, NULL, N'TIPOSTER', N'CO', N'CODEUDOR', 1, CAST(N'20171125 20:12:00' AS SmallDateTime), CAST(N'20171125 20:12:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (48, N'TIPOIMP', N'', N'', N'Tipos de Impuestos', 1, CAST(N'20171125 12:11:00' AS SmallDateTime), CAST(N'20171125 12:11:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (49, NULL, N'TIPOIMP', N'RFUENTE', N'Retefuentes', 1, CAST(N'20171125 12:12:00' AS SmallDateTime), CAST(N'20171125 12:12:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (50, NULL, N'TIPOIMP', N'IVA', N'Iva', 1, CAST(N'20171125 12:12:00' AS SmallDateTime), CAST(N'20171125 12:12:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (51, NULL, N'TIPOIMP', N'INC', N'Inc', 1, CAST(N'20171125 12:13:00' AS SmallDateTime), CAST(N'20171125 12:13:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (52, NULL, N'TIPOIMP', N'RICA', N'Reteica', 1, CAST(N'20171125 12:14:00' AS SmallDateTime), CAST(N'20171125 12:14:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (53, NULL, N'TIPOIMP', N'RIVA', N'Reteiva', 1, CAST(N'20171125 12:14:00' AS SmallDateTime), CAST(N'20171125 12:14:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (54, N'DOCTIPO', N'', N'', N'Tipos de Documentos', 1, CAST(N'20171125 08:27:00' AS SmallDateTime), CAST(N'20171125 08:27:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (55, NULL, N'DOCTIPO', N'COMPRAS', N'Compras', 1, CAST(N'20171125 08:28:00' AS SmallDateTime), CAST(N'20171125 08:28:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (56, NULL, N'DOCTIPO', N'VENTAS', N'Ventas', 1, CAST(N'20171125 08:28:00' AS SmallDateTime), CAST(N'20171125 08:28:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (57, NULL, N'DOCTIPO', N'CAJAS', N'Cajas', 1, CAST(N'20171125 08:29:00' AS SmallDateTime), CAST(N'20171125 08:29:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (58, NULL, N'DOCTIPO', N'CONTABLES', N'Contables', 1, CAST(N'20171125 09:34:00' AS SmallDateTime), CAST(N'20171125 09:34:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (59, N'TYPEFORMPAY', N'', N'', N'Tipo Forma de Pago', 1, CAST(N'20171125 13:41:00' AS SmallDateTime), CAST(N'20171125 13:41:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (60, NULL, N'TYPEFORMPAY', N'10', N'Efectivo', 1, CAST(N'20171125 13:41:00' AS SmallDateTime), CAST(N'20171125 13:41:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (61, NULL, N'TYPEFORMPAY', N'48', N'Tarjeta Credito', 1, CAST(N'20171125 13:41:00' AS SmallDateTime), CAST(N'20171125 13:41:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (62, NULL, N'TYPEFORMPAY', N'49', N'Tarjeta Débito', 1, CAST(N'20171125 13:42:00' AS SmallDateTime), CAST(N'20171125 13:42:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (63, NULL, N'TYPEFORMPAY', N'2', N'Crédito ACH', 1, CAST(N'20171125 13:42:00' AS SmallDateTime), CAST(N'20171125 13:42:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (64, NULL, N'TYPEFORMPAY', N'3', N'Débito ACH', 1, CAST(N'20171125 13:42:00' AS SmallDateTime), CAST(N'20171125 13:42:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (65, NULL, N'TYPEFORMPAY', N'20', N'Cheque', 1, CAST(N'20171125 13:43:00' AS SmallDateTime), CAST(N'20171125 13:43:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (66, NULL, N'TYPEFORMPAY', N'30', N'Transferencia Crédito', 1, CAST(N'20171125 13:43:00' AS SmallDateTime), CAST(N'20171125 13:43:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (67, NULL, N'TYPEFORMPAY', N'31', N'Transferencia Débito', 1, CAST(N'20171125 13:44:00' AS SmallDateTime), CAST(N'20171125 13:44:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (68, NULL, N'TYPEFORMPAY', N'42', N'Consigancion Bancaria', 1, CAST(N'20171125 13:44:00' AS SmallDateTime), CAST(N'20171125 13:44:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (69, NULL, N'TYPEFORMPAY', N'45', N'Transferencia Crédito Bancario', 1, CAST(N'20171125 13:44:00' AS SmallDateTime), CAST(N'20171125 13:44:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (70, NULL, N'TYPEFORMPAY', N'46', N'Transferencia Débito Interbancario', 1, CAST(N'20171125 13:45:00' AS SmallDateTime), CAST(N'20171125 13:45:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (71, NULL, N'TYPEFORMPAY', N'47', N'Transaferencia Débito Bancario', 1, CAST(N'20171125 13:45:00' AS SmallDateTime), CAST(N'20171125 13:45:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (72, NULL, N'DOCTIPO', N'ANTICIPOS', N'Anticipos', 1, CAST(N'20171125 09:34:00' AS SmallDateTime), CAST(N'20171125 09:34:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (73, N'TIPOCTA', N'', N'', N'Tipos de terceros', 1, CAST(N'20171125 20:08:00' AS SmallDateTime), CAST(N'20171125 20:08:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (74, NULL, N'TIPOSTER', N'TC', N'TERCERO', 0, CAST(N'20171125 20:10:00' AS SmallDateTime), CAST(N'20171125 20:10:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (75, NULL, N'TIPOCTA', N'ANT', N'Anticipos', 1, CAST(N'20171125 20:11:00' AS SmallDateTime), CAST(N'20171125 20:11:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (76, NULL, N'TIPOCTA', N'CRED', N'Cartera Cliente', 1, CAST(N'20171125 20:11:00' AS SmallDateTime), CAST(N'20171125 20:11:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (77, NULL, N'TIPOCTA', N'PROVE', N'Cartera Proveedor', 1, CAST(N'20171125 20:11:00' AS SmallDateTime), CAST(N'20171125 20:11:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (78, NULL, N'TIPOCTA', N'TERCE', N'Terceros', 1, CAST(N'20171125 20:11:00' AS SmallDateTime), CAST(N'20171125 20:11:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (79, NULL, N'FORMAPAGOCONT', N'CARTERA', N'Cartera Cliente', 1, CAST(N'20171125 18:40:00' AS SmallDateTime), CAST(N'20171125 18:40:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (80, N'STATEFAC', N'', N'', N'Estados de Facturación', 1, CAST(N'20171125 11:18:00' AS SmallDateTime), CAST(N'20171125 11:18:00' AS SmallDateTime), 1, 0)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (81, NULL, N'STATEFAC', N'PREVIA', N'Previa', 1, CAST(N'20171125 11:37:00' AS SmallDateTime), CAST(N'20171125 11:37:00' AS SmallDateTime), 1, 0)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (82, NULL, N'STATEFAC', N'SEND', N'Enviado', 1, CAST(N'20171125 11:37:00' AS SmallDateTime), CAST(N'20171125 11:37:00' AS SmallDateTime), 1, 0)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (83, NULL, N'STATEFAC', N'ERROR', N'Error', 1, CAST(N'20171125 11:37:00' AS SmallDateTime), CAST(N'20171125 11:37:00' AS SmallDateTime), 1, 0)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (84, NULL, N'STATEFAC', N'SUCCESS', N'Exitoso', 1, CAST(N'20171125 11:37:00' AS SmallDateTime), CAST(N'20171125 11:37:00' AS SmallDateTime), 1, 0)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (85, NULL, N'STATEFAC', N'PREPARE', N'Preparados', 1, CAST(N'20171125 11:37:00' AS SmallDateTime), CAST(N'20171125 11:37:00' AS SmallDateTime), 1, 0)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (86, NULL, N'STATEFAC', N'NOSEND', N'No enviado', 1, CAST(N'20171125 11:37:00' AS SmallDateTime), CAST(N'20171125 11:37:00' AS SmallDateTime), 1, 0)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (87, NULL, N'DOCTIPO', N'AJUSTE', N'Ajustes', 1, CAST(N'20171125 11:37:00' AS SmallDateTime), CAST(N'20171125 11:37:00' AS SmallDateTime), 1, 0)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (88, N'CATEGORIA', N'', N'', N'Categorias de cuentas', 1, CAST(N'20171125 11:37:00' AS SmallDateTime), CAST(N'20171125 11:37:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (89, NULL, N'CATEGORIA', N'CCLIENTE', N'Cliente', 1, CAST(N'20171125 11:37:00' AS SmallDateTime), CAST(N'20171125 11:37:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (90, NULL, N'CATEGORIA', N'CPROVE', N'Proveedor', 1, CAST(N'20171125 11:37:00' AS SmallDateTime), CAST(N'20171125 11:37:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (91, NULL, N'CATEGORIA', N'CTERCE', N'Terceros', 1, CAST(N'20171125 11:37:00' AS SmallDateTime), CAST(N'20171125 11:37:00' AS SmallDateTime), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (92, NULL, N'GESTIONCLI', N'30', N'30', 1, CAST(N'20171125 11:37:00' AS SmallDateTime), CAST(N'20171125 11:37:00' AS SmallDateTime), 1, 0)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (93, NULL, N'GESTIONCLI', N'60', N'60', 1, CAST(N'20171125 11:37:00' AS SmallDateTime), CAST(N'20171125 11:37:00' AS SmallDateTime), 1, 0)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (94, NULL, N'GESTIONCLI', N'90', N'90', 1, CAST(N'20171125 11:37:00' AS SmallDateTime), CAST(N'20171125 11:37:00' AS SmallDateTime), 1, 0)
GO
INSERT [dbo].[ST_Listados] ([id], [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (95, NULL, N'GESTIONCLI', N'PV', N'PV', 1, CAST(N'20171125 11:37:00' AS SmallDateTime), CAST(N'20171125 11:37:00' AS SmallDateTime), 1, 0)
GO
SET IDENTITY_INSERT [dbo].[ST_Listados] OFF
GO

SET IDENTITY_INSERT [dbo].[CNTCuentas] ON 

GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (1, N'1', N'1', N'ACTIVO', 0, NULL, 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 1, NULL, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (2, N'2', N'2', N'PASIVOS', 0, NULL, 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 1, NULL, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (3, N'3', N'3', N'PATRIMONIO', 0, NULL, 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 1, NULL, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (4, N'4', N'4', N'INGRESOS', 0, NULL, 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 1, NULL, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (5, N'5', N'5', N'GASTOS', 0, NULL, 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 1, NULL, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (6, N'6', N'6', N'COSTOS DE VENTA', 0, NULL, 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 1, NULL, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (7, N'7', N'7', N'COSTOS DE PRODUCCIÓN O DE OPERACIÓN', 0, NULL, 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 1, NULL, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (8, N'8', N'8', N'CUENTAS DE ORDEN DEUDORAS', 0, NULL, 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 1, NULL, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (9, N'9', N'9', N'CUENTAS DE ORDEN ACREEDORAS', 0, NULL, 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 1, NULL, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (10, N'1', N'11', N'DISPONIBLE 1', 0, N'1', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200527 23:25:00' AS SmallDateTime), 1, 1, 2, 1, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (11, N'2', N'12', N'INVERSIONES', 0, N'1', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 1, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (12, N'3', N'13', N'DEUDORES', 0, N'1', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 1, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (13, N'4', N'14', N'INVENTARIOS', 0, N'1', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 1, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (14, N'5', N'15', N'PROPIEDAD,PLANTA Y EQUIPO', 0, N'1', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 1, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (15, N'6', N'16', N'INTANGIBLES', 0, N'1', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 1, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (16, N'7', N'17', N'DIFERIDOS', 0, N'1', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 1, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (17, N'8', N'18', N'OTROS ACTIVOS', 0, N'1', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 1, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (18, N'9', N'19', N'VALORIZACIONES', 0, N'1', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 1, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (19, N'1', N'21', N'OBLIGACIONES FINANCIERAS', 0, N'2', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 2, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (20, N'2', N'22', N'PROVEEDORES', 0, N'2', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 2, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (21, N'3', N'23', N'CUENTAS POR PAGAR', 0, N'2', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 2, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (22, N'4', N'24', N'IMPUESTOS,GRAVAMENES Y TASAS', 0, N'2', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 2, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (23, N'5', N'25', N'OBLIGACIONES LABORALES', 0, N'2', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 2, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (24, N'6', N'26', N'PASIVOS ESTIMADOS Y PROVISIONE', 0, N'2', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 2, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (25, N'7', N'27', N'DIFERIDOS', 0, N'2', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 2, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (26, N'8', N'28', N'OTROS PASIVOS', 0, N'2', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 2, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (27, N'1', N'31', N'CAPITAL SOCIAL', 0, N'3', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 3, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (28, N'2', N'32', N'SUPERAVIT DE CAPITAL', 0, N'3', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 3, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (29, N'3', N'33', N'RESERVAS', 0, N'3', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 3, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (30, N'4', N'34', N'REVALORIZACION DEL PATRIMONIO', 0, N'3', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 3, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (31, N'5', N'35', N'PARTICP.DCRET.EN CUOTAS INT.SC', 0, N'3', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 3, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (32, N'6', N'36', N'RESULTADOS DEL EJERCICIO', 0, N'3', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 3, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (33, N'7', N'37', N'RESULTADOS DE EJERCICIOS ANTER', 0, N'3', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 3, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (34, N'8', N'38', N'SUPERAVIT POR VALORIZACIONES', 0, N'3', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 3, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (35, N'1', N'41', N'OPERACIONALES', 0, N'4', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 4, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (36, N'2', N'42', N'NO OPERACIONALES', 0, N'4', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 4, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (37, N'7', N'47', N'AJUSTES POR INFLACION', 0, N'4', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 4, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (38, N'1', N'51', N'OPERACIONALES DE ADMINISTRACIO', 0, N'5', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 5, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (39, N'2', N'52', N'OPERACIONALES DE VENTAS', 0, N'5', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 5, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (40, N'3', N'53', N'NO OPERACIONALES', 0, N'5', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 5, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (41, N'4', N'54', N'IMPUESTO DE RENTA Y COMPLEMENT', 0, N'5', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 5, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (42, N'9', N'59', N'GANANCIAS Y PERDIDAS', 0, N'5', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 5, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (43, N'1', N'61', N'COSTO DE VENTA Y PRESTACION SERV.', 0, N'6', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 6, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (44, N'2', N'62', N'COMPRAS', 0, N'6', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 6, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (45, N'1', N'81', N'DEUDORAS CONTINGENTES', 0, N'8', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 8, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (46, N'2', N'82', N'DEUDORAS DE CONTROL', 0, N'8', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 8, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (47, N'3', N'83', N'ACREED CONTINGENTES POR CONTRA', 0, N'8', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 8, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (48, N'4', N'84', N'ACREED. DE CONTROL POR CONTRA', 0, N'8', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 8, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (49, N'6', N'86', N'ACREEDORAS CONTINGENTES', 0, N'8', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 8, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (50, N'7', N'87', N'ACREEDORAS DE CONTROL', 0, N'8', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 8, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (51, N'8', N'88', N'DEUDORAS CONTINGENT POR CONTRA', 0, N'8', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 8, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (52, N'9', N'89', N'DEUDORAS DE CONTROL POR CONTRA', 0, N'8', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 8, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (53, N'1', N'91', N'CUENTA DE ORDEN X PAGAR COOSALUD', 0, N'9', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 2, 9, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (54, N'05', N'1105', N'CAJA', 0, N'11', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 10, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (55, N'10', N'1110', N'BANCOS', 0, N'11', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 10, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (56, N'15', N'1115', N'REMESAS EN TRANSITO', 0, N'11', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 10, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (57, N'20', N'1120', N'CUENTAS DE AHORROS', 0, N'11', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 10, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (58, N'25', N'1125', N'FONDOS', 0, N'11', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 10, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (59, N'05', N'1205', N'ACCIONES', 0, N'12', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 11, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (60, N'10', N'1210', N'CUOTAS O PARTES DE INT. SOCIAL', 0, N'12', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 11, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (61, N'15', N'1215', N'BONOS', 0, N'12', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 11, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (62, N'20', N'1220', N'CEDULAS', 0, N'12', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 11, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (63, N'25', N'1225', N'CERTIFICADOS', 0, N'12', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 11, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (64, N'40', N'1240', N'ACEPTACIONES BANCARIAS O FINAN', 0, N'12', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 11, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (65, N'55', N'1255', N'OBLIGATORIAS', 0, N'12', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 11, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (66, N'95', N'1295', N'OTRAS INVERSIONES', 0, N'12', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 11, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (67, N'99', N'1299', N'PROVISIONES', 0, N'12', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 11, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (68, N'05', N'1305', N'CLIENTES', 0, N'13', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 12, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (69, N'10', N'1310', N'CUENTAS CORRIENTES COMERCIALES', 0, N'13', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 12, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (70, N'25', N'1325', N'CUENTAS POR COBRAR A SOCIOS', 0, N'13', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 12, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (71, N'30', N'1330', N'ANTICIPOS Y AVANCES', 0, N'13', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 12, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (72, N'35', N'1335', N'DEPOSITOS', 0, N'13', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 12, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (73, N'40', N'1340', N'PROMESAS DE COMPRA VENTA', 0, N'13', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 12, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (74, N'45', N'1345', N'INGRESOS POR COBRAR', 0, N'13', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 12, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (75, N'50', N'1350', N'RETENCION SOBRE CONTRATOS', 0, N'13', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 12, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (76, N'55', N'1355', N'ANTICIPO IMPTOS CONTRIB SDO FV', 0, N'13', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 12, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (77, N'60', N'1360', N'RECLAMACIONES', 0, N'13', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 12, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (78, N'65', N'1365', N'CUENTAS POR COBRAR A TRABAJADORES', 0, N'13', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 12, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (79, N'70', N'1370', N'PRESTAMOS A PARTICULARES', 0, N'13', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 12, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (80, N'75', N'1375', N'CUENTAS EN PARTICIPACION', 0, N'13', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 12, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (81, N'80', N'1380', N'DEUDORES VARIOS', 0, N'13', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 12, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (82, N'85', N'1385', N'DERECHOS DE RECOMPRA CART NEG', 0, N'13', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 12, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (83, N'90', N'1390', N'DEUDAS DE DIFICIL COBRO', 0, N'13', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 12, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (84, N'99', N'1399', N'PROVISIONES', 0, N'13', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 12, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (85, N'35', N'1435', N'MERCANCIA NO FABRICADA POR LA EMPRESA', 0, N'14', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 13, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (86, N'55', N'1455', N'ALMACEN DE MATERIALES REP ACC', 0, N'14', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 13, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (87, N'65', N'1465', N'MERCANCIAS,MAT.PRIM.,REP EN TR', 0, N'14', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 13, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (88, N'99', N'1499', N'PROVISIONES', 0, N'14', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 13, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (89, N'04', N'1504', N'TERRENOS', 0, N'15', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 14, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (90, N'08', N'1508', N'CONSTRUCCIONES EN CURSO', 0, N'15', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 14, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (91, N'16', N'1516', N'EDIFICIOS', 0, N'15', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 14, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (92, N'20', N'1520', N'MAQUINARIA Y EQUIPO', 0, N'15', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 14, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (93, N'24', N'1524', N'EQUIPO DE OFICINA', 0, N'15', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 14, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (94, N'28', N'1528', N'EQUIPO DE COMPUTACION Y COMUNI', 0, N'15', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 14, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (95, N'40', N'1540', N'FLOTA Y EQUIPO DE TRANSPORTE', 0, N'15', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 14, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (96, N'92', N'1592', N'DEPRECIACION ACUMULADA', 0, N'15', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 14, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (97, N'97', N'1597', N'AMORTIZACION ACUMULADA', 0, N'15', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 14, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (98, N'99', N'1599', N'PROVISIONES', 0, N'15', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 14, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (99, N'05', N'1605', N'CREDITO MERCANTIL', 0, N'16', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 15, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (100, N'25', N'1625', N'DERECHOS DE AUTOR', 0, N'16', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 15, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (101, N'98', N'1698', N'AMORTIZACION ACUMULADA', 0, N'16', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 15, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (102, N'05', N'1705', N'GASTOS PAGADOS POR ANTICIPADO', 0, N'17', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 16, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (103, N'10', N'1710', N'CARGOS DIFERIDOS', 0, N'17', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 16, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (104, N'15', N'1715', N'PROYECTOS DE EXPLORAC. EN CURS', 0, N'17', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 16, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (105, N'30', N'1730', N'CARGO POR CORRECCION MONET DIF', 0, N'17', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 16, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (106, N'95', N'1895', N'DIVERSOS', 0, N'18', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 17, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (107, N'99', N'1899', N'PROVISIONES', 0, N'18', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 17, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (108, N'05', N'1905', N'INVERSIONES', 0, N'19', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 18, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (109, N'10', N'1910', N'PROPIEDADES,PLANTA Y EQUIPO', 0, N'19', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 18, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (110, N'95', N'1995', N'OTROS ACTIVOS', 0, N'19', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 18, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (111, N'05', N'2105', N'BANCOS NACIONALES', 0, N'21', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 19, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (112, N'10', N'2110', N'BANCOS DEL EXTERIOR', 0, N'21', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 19, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (113, N'15', N'2115', N'CORPORACIONES FINANCIERAS', 0, N'21', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 19, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (114, N'20', N'2120', N'COMPA¥IAS DE FINANCIAM COMERCI', 0, N'21', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 19, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (115, N'25', N'2125', N'CORPORACIONES DE AHORRO Y VIVI', 0, N'21', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 19, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (116, N'30', N'2130', N'ENTIDADES FINANC DEL EXTERIOR', 0, N'21', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 19, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (117, N'35', N'2135', N'COMPROMISOS DE RECOMPRA INV NG', 0, N'21', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 19, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (118, N'40', N'2140', N'COMPROMISOS DE RECOMPRA CAR NG', 0, N'21', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 19, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (119, N'95', N'2195', N'OTRAS OBLIGACIONES FINANCIERAS', 0, N'21', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 19, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (120, N'05', N'2205', N'NACIONALES', 0, N'22', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 20, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (121, N'10', N'2210', N'DEL EXTERIOR', 0, N'22', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 20, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (122, N'05', N'2305', N'CUENTAS CORRIENTES COMERCIALES', 0, N'23', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 21, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (123, N'20', N'2320', N'A CONTRATISTAS', 0, N'23', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 21, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (124, N'25', N'2325', N'CUENTAS EN PARTICIPACION', 0, N'23', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 21, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (125, N'35', N'2335', N'COSTOS Y GASTOS POR PAGAR', 0, N'23', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 21, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (126, N'45', N'2345', N'ACREEDORES OFICIALES', 0, N'23', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 21, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (127, N'55', N'2355', N'DEUDAS CON SOCIOS', 0, N'23', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 21, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (128, N'60', N'2360', N'PARTICIPACIONES POR PAGAR', 0, N'23', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 21, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (129, N'65', N'2365', N'RETENCION EN LA FUENTE', 0, N'23', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 21, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (130, N'67', N'2367', N'IMPUESTO A LAS VENTAS RETENIDO', 0, N'23', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 21, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (131, N'68', N'2368', N'INDUSTRIA Y COMERCIO RETENIDO', 0, N'23', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 21, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (132, N'70', N'2370', N'RETENCIONES Y APORTES DE NOMIN', 0, N'23', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 21, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (133, N'80', N'2380', N'ACREEDORES VARIOS', 0, N'23', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 21, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (134, N'04', N'2404', N'DE RENTA Y COMPLEMENTARIOS', 0, N'24', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 22, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (135, N'05', N'2405', N'IMPUESTO AL CREE', 0, N'24', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 22, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (136, N'08', N'2408', N'IMPUESTO A LAS VENTAS X PAGAR', 0, N'24', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 22, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (137, N'12', N'2412', N'DE INDUSTRIA Y COMERCIO', 0, N'24', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 22, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (138, N'16', N'2416', N'A LA PROPIEDAD RAIZ', 0, N'24', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 22, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (139, N'2', N'2424', N'DE VALORIZACION', 0, N'24', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 22, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (140, N'36', N'2436', N'DE VEHICULOS', 0, N'24', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 22, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (141, N'95', N'2495', N'OTROS', 0, N'24', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 22, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (142, N'05', N'2505', N'SALARIOS POR PAGAR', 0, N'25', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 23, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (143, N'10', N'2510', N'CESANTIAS CONSOLIDADAS', 0, N'25', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 23, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (144, N'15', N'2515', N'INTERESES SOBRE CESANTIAS', 0, N'25', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 23, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (145, N'20', N'2520', N'PRIMA DE SERVICIOS', 0, N'25', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 23, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (146, N'2', N'2525', N'VACACIONES CONSOLIDADAS', 0, N'25', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 23, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (147, N'30', N'2530', N'PRESTACIONES EXTRALEGALES', 0, N'25', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 23, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (148, N'40', N'2540', N'INDEMNIZACIONES LABORALES', 0, N'25', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 23, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (149, N'05', N'2605', N'PARA COSTOS Y GASTOS', 0, N'26', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 24, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (150, N'10', N'2610', N'PARA OBLIGACIONES LABORALES', 0, N'26', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 24, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (151, N'15', N'2615', N'PARA OBLIGACIONES FISCALES', 0, N'26', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 24, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (152, N'95', N'2695', N'PROVISIONES DIVERSAS', 0, N'26', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 24, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (153, N'05', N'2705', N'INGRESOS RECIBIDOS POR ANTICIP', 0, N'27', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 25, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (154, N'20', N'2720', N'CREDITO POR CORRECCION MON DIF', 0, N'27', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 25, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (155, N'05', N'2805', N'ANTICIPOS Y AVANCES RECIBIDOS', 0, N'28', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 26, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (156, N'10', N'2810', N'DEPOSITOS RECIBIDOS', 0, N'28', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 26, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (157, N'15', N'2815', N'INGRESOS RECIBIDOS PARA TERCER', 0, N'28', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 26, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (158, N'05', N'3105', N'CAPITAL SUSCRITO Y PAGADO', 0, N'31', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 27, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (159, N'15', N'3115', N'APORTES SOCIALES', 0, N'31', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 27, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (160, N'05', N'3205', N'PRIMA COLOC DE ACCIONES', 0, N'32', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 28, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (161, N'10', N'3210', N'DONACIONES', 0, N'32', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 28, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (162, N'05', N'3305', N'OBLIGATORIAS', 0, N'33', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 29, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (163, N'10', N'3310', N'RESERVAS ESTATUTARIAS', 0, N'33', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 29, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (164, N'15', N'3315', N'RESERVAS OCASIONALES', 0, N'33', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 29, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (165, N'05', N'3405', N'DE CAPITAL SOCIAL', 0, N'34', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 30, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (166, N'10', N'3410', N'SANEAMIENTO FISCAL', 0, N'34', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 30, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (167, N'15', N'3415', N'AJUSTES POR INF.DEC.3019/89', 0, N'34', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 30, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (168, N'20', N'3420', N'DE RESULTADOS DE EJERC ANTERIO', 0, N'34', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 30, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (169, N'10', N'3510', N'PART. DCRET. EN CUOTAS INT SOC', 0, N'35', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 31, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (170, N'05', N'3605', N'UTILIDAD DEL EJERCICIO', 0, N'36', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 32, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (171, N'10', N'3610', N'PERDIDA DEL EJERCICIO', 0, N'36', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 32, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (172, N'05', N'3705', N'UTILIDADES O EXCEDENTES ACUMUL', 0, N'37', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 33, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (173, N'10', N'3710', N'PERDIDAS ACUMULADAS', 0, N'37', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 33, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (174, N'05', N'3805', N'DE INVERSIONES', 0, N'38', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 34, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (175, N'10', N'3810', N'PROPIEDADES,PLANTA Y EQUIPO', 0, N'38', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 34, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (176, N'95', N'3895', N'OTROS ACTIVOS', 0, N'38', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 34, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (177, N'02', N'4102', N'INGRESOS', 0, N'41', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 35, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (178, N'35', N'4135', N'COMERCIO AL POR MAYOR Y AL POR MENOR', 0, N'41', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 35, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (179, N'45', N'4145', N'TRANSPORTE,ALMACEN Y COMUNICAC', 0, N'41', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 35, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (180, N'55', N'4155', N'ACTIV.INMOBILIARIAS, EMP. DE AL.', 0, N'41', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 35, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (181, N'75', N'4175', N'DEVOLUCIONES EN VENTAS', 0, N'41', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 35, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (182, N'05', N'4205', N'OTRAS VENTAS', 0, N'42', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 36, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (183, N'10', N'4210', N'FINANCIEROS', 0, N'42', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 36, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (184, N'15', N'4215', N'PARTICIPACIONES', 0, N'42', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 36, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (185, N'20', N'4220', N'ARRENDAMIENTOS', 0, N'42', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 36, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (186, N'25', N'4225', N'COMISIONES', 0, N'42', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 36, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (187, N'30', N'4230', N'HONORARIOS', 0, N'42', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 36, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (188, N'35', N'4235', N'SERVICIOS', 0, N'42', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 36, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (189, N'45', N'4245', N'UTILIDAD DE VENTA DE PROPIEDADES,PLANTAS', 0, N'42', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 36, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (190, N'50', N'4250', N'RECUPERACIONES', 0, N'42', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 36, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (191, N'55', N'4255', N'INDEMNIZACIONES', 0, N'42', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 36, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (192, N'65', N'4265', N'INGRESOS DE EJERCICIOS ANTERIO', 0, N'42', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 36, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (193, N'75', N'4275', N'DEVOLUCIONES EN VENTAS', 0, N'42', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 36, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (194, N'95', N'4295', N'DIVERSOS', 0, N'42', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 36, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (195, N'05', N'4705', N'CORRECCION MONETARIA', 0, N'47', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 37, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (196, N'05', N'5105', N'GASTOS DEL PERSONAL', 0, N'51', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 38, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (197, N'10', N'5110', N'HONORARIOS', 0, N'51', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 38, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (198, N'15', N'5115', N'IMPUESTOS', 0, N'51', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 38, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (199, N'20', N'5120', N'ARRENDAMIENTOS', 0, N'51', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 38, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (200, N'25', N'5125', N'CONTRIBUCIONES Y AFILIACIONES', 0, N'51', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 38, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (201, N'30', N'5130', N'SEGUROS', 0, N'51', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 38, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (202, N'35', N'5135', N'SERVICIOS', 0, N'51', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 38, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (203, N'40', N'5140', N'GASTOS LEGALES', 0, N'51', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 38, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (204, N'45', N'5145', N'MANTENIMIENTO Y REPARACIONES', 0, N'51', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 38, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (205, N'50', N'5150', N'ADECUACION E INSTALACION', 0, N'51', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 38, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (206, N'55', N'5155', N'GASTOS DE VIAJE', 0, N'51', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 38, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (207, N'60', N'5160', N'DEPRECIACIONES', 0, N'51', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 38, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (208, N'65', N'5165', N'AMORTIZACIONES', 0, N'51', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 38, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (209, N'95', N'5195', N'DIVERSOS', 0, N'51', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 38, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (210, N'99', N'5199', N'PROVISIONES', 0, N'51', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 38, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (211, N'05', N'5205', N'GASTOS DE PERSONAL', 0, N'52', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 39, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (212, N'10', N'5210', N'HONORARIOS', 0, N'52', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 39, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (213, N'15', N'5215', N'IMPUESTOS', 0, N'52', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 39, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (214, N'20', N'5220', N'ARRENDAMIENTOS', 0, N'52', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 39, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (215, N'25', N'5225', N'CONTRIBUCIONES Y AFILIACIONES', 0, N'52', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 39, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (216, N'30', N'5230', N'SEGUROS', 0, N'52', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 39, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (217, N'35', N'5235', N'SERVICIOS', 0, N'52', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 39, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (218, N'40', N'5240', N'GASTOS LEGALES', 0, N'52', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 39, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (219, N'45', N'5245', N'MANTENIMIENTO Y REPARACIONES', 0, N'52', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 39, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (220, N'50', N'5250', N'ADECUACION E INSTALACION', 0, N'52', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 39, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (221, N'55', N'5255', N'GASTOS DE VIAJE', 0, N'52', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 39, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (222, N'60', N'5260', N'DEPRECIACIONES', 0, N'52', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 39, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (223, N'70', N'5270', N'AMORTIZACIONES', 0, N'52', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 39, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (224, N'95', N'5295', N'DIVERSOS', 0, N'52', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 39, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (225, N'99', N'5299', N'PROVISIONES', 0, N'52', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 39, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (226, N'05', N'5305', N'FINANCIEROS', 0, N'53', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 40, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (227, N'10', N'5310', N'PERD. EN VTA. Y RETIRO DE BIEN', 0, N'53', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 40, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (228, N'15', N'5315', N'GASTOS EXTRAORDINARIOS', 0, N'53', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 40, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (229, N'95', N'5395', N'GASTOS DIVERSOS', 0, N'53', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 40, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (230, N'05', N'5405', N'IMPUESTO DE RENTA Y COMPLEMENT', 0, N'54', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 41, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (231, N'05', N'5905', N'GANANCIAS', 0, N'59', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 42, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (232, N'15', N'5915', N'PERDIDAS ()', 0, N'59', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 42, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (233, N'35', N'6135', N'COMERCIO AL POR MAYOR  AL POR MENOR', 0, N'61', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 43, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (234, N'25', N'6225', N'DEVOLUCIONES EN COMPRAS', 0, N'62', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 44, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (235, N'05', N'8105', N'BIENES Y VRES ENTREG.EN CUSTOD', 0, N'81', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 45, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (236, N'10', N'8110', N'BIENES Y VRES ENTREG.EN GARANT', 0, N'81', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 45, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (237, N'15', N'8115', N'BIENES Y VRES EN PODER DE TERC', 0, N'81', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 45, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (238, N'20', N'8120', N'LITIGIOS Y/O DEMANDAS', 0, N'81', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 45, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (239, N'95', N'8195', N'DIVERSAS', 0, N'81', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 45, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (240, N'05', N'8205', N'REMESAS Y EFECTOS ENVIA.AL COB', 0, N'82', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 46, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (241, N'10', N'8210', N'BIENES RECIB EN ARREND.FINANCI', 0, N'82', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 46, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (242, N'15', N'8215', N'TITULOS DE INVERSION NO COLOCA', 0, N'82', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 46, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (243, N'20', N'8220', N'CREDITOS A FAVOR NO UTILIZADOS', 0, N'82', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 46, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (244, N'25', N'8225', N'ACTIVOS CASTIGADOS', 0, N'82', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 46, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (245, N'30', N'8230', N'TITULOS DE INVERSION AMORTIZAD', 0, N'82', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 46, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (246, N'35', N'8235', N'PR,PL Y EQ TOTALM DEPREC,AMORT', 0, N'82', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 46, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (247, N'90', N'8290', N'CAPITALIZACION POR REVAL PATRI', 0, N'82', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 46, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (248, N'95', N'8295', N'OTRAS CUENTAS DEUDORAS DE CONT', 0, N'82', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 46, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (249, N'99', N'8299', N'AJUSTES POR INFLACION ACTIVOS', 0, N'82', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 46, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (250, N'05', N'8305', N'ACREE CONTINGENTES X CONTRA(D)', 0, N'83', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 47, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (251, N'05', N'8405', N'ACREED DE CONTROL POR CONT (D)', 0, N'84', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 48, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (252, N'05', N'8605', N'BIENES Y VRES. RECIB. CUSTODIA', 0, N'86', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 49, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (253, N'10', N'8610', N'BIENES Y VRES. RECIB. GARANTIA', 0, N'86', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 49, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (254, N'15', N'8615', N'BIENES Y VRES. RECIB. DEPOSITO', 0, N'86', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 49, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (255, N'20', N'8620', N'LITIGIOS Y/O DEMANDAS', 0, N'86', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 49, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (256, N'95', N'8695', N'OTRAS', 0, N'86', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 49, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (257, N'05', N'8705', N'CONTRAROS DE ARREND.FINANCIERO', 0, N'87', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 50, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (258, N'95', N'8795', N'OTRAS CUENTAS DE ORDEN ACEED', 0, N'87', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 50, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (259, N'99', N'8799', N'AJUSTES POR INFLACION PATRIMON', 0, N'87', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 50, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (260, N'05', N'8805', N'DEUD. CONTING. POR CONTRA (C)', 0, N'88', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 51, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (261, N'05', N'8905', N'DEUD. DE CONTROL POR CONTRA', 0, N'89', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 52, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (262, N'05', N'9105', N'CXP DE ORDEN COOSALUD', 0, N'91', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 3, 53, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (263, N'05', N'110505', N'CAJA GENERAL', 0, N'1105', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200510 14:06:00' AS SmallDateTime), 1, 1, 4, 54, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (264, N'10', N'110510', N'CAJA MENOR', 0, N'1105', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 54, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (265, N'05', N'111005', N'BANCOS NACIONALES', 0, N'1110', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 55, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (266, N'05', N'112005', N'CUENTA DE AHORRO NACIONALES', 0, N'1120', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 57, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (267, N'05', N'130505', N'CLIENTES NACIONALES', 0, N'1305', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 68, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (268, N'20', N'131020', N'CUENTAS CORRIENTES COMERCIALES', 0, N'1310', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 69, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (269, N'95', N'131095', N'OTRAS', 0, N'1310', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 69, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (270, N'05', N'132505', N'CUENTAS COBRAR SOCIOS Y /O ACCIONISTA', 0, N'1325', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 70, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (271, N'05', N'133005', N'A PROVEEDORES', 0, N'1330', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 71, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (272, N'15', N'133015', N'ANTICIPOS TRABAJADORES', 0, N'1330', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 71, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (273, N'95', N'133095', N'OTROS', 0, N'1330', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 71, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (274, N'35', N'133535', N'EN GARANTIA', 0, N'1335', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 72, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (275, N'05', N'135505', N'ANTICIPO DE RENTA Y COMPLEMENTARIOS', 0, N'1355', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 76, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (276, N'10', N'135510', N'ANTICIPO DE INDUSTRIA Y COMERCIO', 0, N'1355', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 76, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (277, N'15', N'135515', N'RETENCION EN  LA FUENTE', 0, N'1355', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 76, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (278, N'17', N'135517', N'IMPTO A LA VTA RETENIDO', 0, N'1355', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 76, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (279, N'18', N'135518', N'IMPUESTO DE IND. Y COMERCIO RETENIDO', 0, N'1355', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 76, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (280, N'20', N'135520', N'SOBRANTES EN LIQ IMPUESTOS', 0, N'1355', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 76, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (281, N'30', N'135530', N'IMPUESTOS DESCONTABLES', 0, N'1355', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 76, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (282, N'95', N'135595', N'RETENCION DESCONTABLE CREE', 0, N'1355', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 76, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (283, N'95', N'136595', N'OTROS', 0, N'1365', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 78, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (284, N'95', N'138095', N'OTROS', 0, N'1380', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 81, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (285, N'05', N'139005', N'DEUDAS DIFICIL COBRO NACIONALES', 0, N'1390', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 83, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (286, N'01', N'143501', N'MERCANCIA NO FABRICADA POR LA EMPRESA', 0, N'1435', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 85, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (287, N'05', N'150405', N'TERRENOS', 0, N'1504', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 89, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (288, N'05', N'150805', N'CONSTRUCCIONES EN CURSO', 0, N'1508', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 90, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (289, N'05', N'151605', N'EDIFICIOS', 0, N'1516', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 91, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (290, N'05', N'152005', N'MAQUINARIA Y EQUIPOS', 0, N'1520', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 92, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (291, N'05', N'152405', N'MUEBLES Y ENSERES', 0, N'1524', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 93, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (292, N'05', N'152805', N'EQUIPO DE COMPUTACION Y COMUNICACION', 0, N'1528', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 94, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (293, N'05', N'154005', N'FLOTA Y EQUIPO DE TRANSPORTE', 0, N'1540', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 95, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (294, N'10', N'159210', N'DPERECIACION DE MAQ. Y EQUIPOS', 0, N'1592', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 96, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (295, N'15', N'159215', N'DEPRECIACION DE EQ. DE OFICINA', 0, N'1592', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 96, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (296, N'20', N'159220', N'DEPRECIACION EQ.PROC. DE DATOS', 0, N'1592', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 96, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (297, N'05', N'170505', N'INTERESES', 0, N'1705', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 102, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (298, N'10', N'170510', N'HONORARIOS', 0, N'1705', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 102, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (299, N'15', N'170515', N'COMISIONES', 0, N'1705', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 102, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (300, N'20', N'170520', N'SEGUROS Y FIANZAS', 0, N'1705', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 102, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (301, N'25', N'170525', N'ARRENDAMIENTOS', 0, N'1705', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 102, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (302, N'40', N'170540', N'SERVICIOS', 0, N'1705', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 102, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (303, N'08', N'171008', N'REMODELACIONES', 0, N'1710', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 103, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (304, N'16', N'171016', N'SOFWARE COMPUTADOR', 0, N'1710', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 103, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (305, N'24', N'171024', N'MEJORAS EN PROPIEDAD AJENAS', 0, N'1710', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 103, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (306, N'44', N'171044', N'PUBLICIDAD PROPAGANDA Y AVISOS', 0, N'1710', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 103, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (307, N'04', N'191004', N'TERRENOS', 0, N'1910', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 109, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (308, N'05', N'210505', N'SOBREGIROS', 0, N'2105', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 111, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (309, N'10', N'210510', N'PAGARÉS', 0, N'2105', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 111, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (310, N'05', N'219505', N'PARTICULARES', 0, N'2195', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 119, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (311, N'20', N'219520', N'SOCIOS O ACCIONISTAS', 0, N'2195', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 119, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (312, N'05', N'220505', N'PROVEEDORES NACIONALES', 0, N'2205', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 120, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (313, N'01', N'230501', N'CUENTAS CORRIENTES COMERCIALES', 0, N'2305', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 122, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (314, N'20', N'233520', N'COMISIONES', 0, N'2335', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 125, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (315, N'25', N'233525', N'HONORARIOS', 0, N'2335', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 125, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (316, N'35', N'233535', N'SERVICIO DE MANTENIMIENTO', 0, N'2335', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 125, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (317, N'40', N'233540', N'ARRENDAMIENTOS', 0, N'2335', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 125, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (318, N'45', N'233545', N'TRANSPORTE, FLETE Y ACARREO', 0, N'2335', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 125, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (319, N'50', N'233550', N'SERVICIOS PUBLICOS', 0, N'2335', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 125, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (320, N'65', N'233565', N'GASTOS DE REPRESENTACION', 0, N'2335', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 125, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (321, N'95', N'233595', N'OTROS', 0, N'2335', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 125, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (322, N'05', N'235505', N'SOCIOS', 0, N'2355', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 127, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (323, N'10', N'236510', N'DIVIDENDOS', 0, N'2365', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 129, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (324, N'15', N'236515', N'HONORARIOS', 0, N'2365', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 129, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (325, N'20', N'236520', N'COMISIONES', 0, N'2365', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 129, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (326, N'25', N'236525', N'SERVICIOS', 0, N'2365', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 129, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (327, N'30', N'236530', N'RET FUE ARREN INMUEBLES', 0, N'2365', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 129, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (328, N'35', N'236535', N'RETENCION POR INTERESES', 0, N'2365', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 129, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (329, N'40', N'236540', N'RETENCION EN COMPRAS', 0, N'2365', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 129, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (330, N'70', N'236570', N'RETENCION CREE', 0, N'2365', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 129, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (331, N'75', N'236575', N'AUTO RETENCIONES', 0, N'2365', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 129, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (332, N'99', N'236599', N'PAGO RETENCION EN LA FUENTE', 0, N'2365', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 129, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (333, N'05', N'236705', N'IMPUESTOS A LAS VENTAS RETENIDO', 0, N'2367', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 130, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (334, N'99', N'236799', N'PAGO IMPUESTO A LAS VENTAS RETENIDO', 0, N'2367', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 130, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (335, N'01', N'236801', N'IMPUESTO DE IND. Y COMERCIO RETENIDO', 0, N'2368', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 131, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (336, N'05', N'237005', N'APORTES DE NOMINA', 0, N'2370', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 132, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (337, N'06', N'237006', N'APORTES ARP', 0, N'2370', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 132, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (338, N'10', N'237010', N'APORTES A ICBF, SENA Y CAJA DE COMPENSAC', 0, N'2370', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 132, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (339, N'45', N'237045', N'FONDOS', 0, N'2370', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 132, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (340, N'01', N'238001', N'ANTICIPO CLIENTES', 0, N'2380', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 133, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (341, N'02', N'238002', N'AVAL', 0, N'2380', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 133, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (342, N'03', N'238003', N'INGRESOS PARA TERCEROS', 0, N'2380', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 133, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (343, N'30', N'238030', N'APORTES A FONDO DE PENSIONES', 0, N'2380', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 133, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (344, N'05', N'240405', N'VIGENCIA FISCAL CORRIENTE', 0, N'2404', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 134, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (345, N'10', N'240410', N'VIGENCIAS FISCALES ANTERIORES', 0, N'2404', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 134, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (346, N'05', N'240505', N'IMPUESTO AL CREE VIGENCIA FISCAL CORRIEN', 0, N'2405', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 135, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (347, N'05', N'240805', N'IVA GENERADO', 0, N'2408', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 136, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (348, N'10', N'240810', N'IVA DESCONTABLE', 0, N'2408', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 136, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (349, N'15', N'240815', N'IVA RETENIDO REGIMEN SIMPLIFICADO', 0, N'2408', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 136, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (350, N'20', N'240820', N'IVA SALDO A FAVOR', 0, N'2408', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 136, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (351, N'80', N'240880', N'IVA POR PAGAR', 0, N'2408', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 136, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (352, N'05', N'241205', N'VIGENCIA FISCAL CORRIENTE', 0, N'2412', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 137, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (353, N'10', N'241210', N'VIGENCIAS FISCALES ANTERIORES', 0, N'2412', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 137, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (354, N'01', N'249501', N'IMPUESTO AL CONSUMO', 0, N'2495', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 141, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (355, N'01', N'250501', N'SALARIOS POR PAGAR', 0, N'2505', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 142, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (356, N'01', N'251001', N'CESANTIAS CONSOLIDADAS', 0, N'2510', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 143, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (357, N'05', N'261005', N'PROVISIONES CESANTIAS', 0, N'2610', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 150, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (358, N'10', N'261010', N'PROVISIONES INTERESES SOBRE CESANTIAS', 0, N'2610', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 150, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (359, N'15', N'261015', N'PROVISIONES VACACIONES', 0, N'2610', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 150, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (360, N'20', N'261020', N'PROVISIONES PRIMA DE SERVIVIO', 0, N'2610', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 150, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (361, N'05', N'269505', N'PROVISIONES DIVERSAS', 0, N'2695', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 152, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (362, N'05', N'280505', N'DE CLIENTES', 0, N'2805', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 155, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (363, N'95', N'280595', N'OTROS', 0, N'2805', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 155, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (364, N'05', N'281005', N'PARA FUTURA SUSCRIPCION DE ACCIONES', 0, N'2810', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 156, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (365, N'01', N'281501', N'INGRESOS RECIBIDOS PARA TERCEROS', 0, N'2815', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 157, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (366, N'05', N'281505', N'INGRESOS  RECIBIDOS PARA TERCEROS', 0, N'2815', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 157, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (367, N'05', N'310505', N'CAPITAL AUTORIZADO', 0, N'3105', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 158, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (368, N'10', N'310510', N'CAPITAL POR SUSCRIBIR (DB)', 0, N'3105', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 158, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (369, N'15', N'310515', N'CAPITAL SUSCRITO POR COBRAR (CR)', 0, N'3105', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 158, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (370, N'05', N'320505', N'PRIMA EN COLOCACION DE ACCIONES', 0, N'3205', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 160, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (371, N'05', N'330505', N'RESERVA LEGAL', 0, N'3305', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 162, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (372, N'05', N'360505', N'UTILIDAD DEL EJERCICIO', 0, N'3605', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 170, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (373, N'01', N'370501', N'UTILIDADES ACUMULADAS', 0, N'3705', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 172, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (374, N'05', N'371005', N'PERDIDAS ACUMULADAS', 0, N'3710', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 173, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (375, N'04', N'381004', N'VALORIZACION TERRENOS', 0, N'3810', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 175, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (376, N'02', N'413502', N'VENTA DE VEHICULOS AUTOMOTORES', 0, N'4135', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 178, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (377, N'04', N'413504', N'MANTENIMIENTO Y REPARACION AUTOMOTOR', 0, N'4135', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 178, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (378, N'06', N'413506', N'VENTA DE PARTES Y PIEZAS Y ACCESORIOS', 0, N'4135', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 178, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (379, N'36', N'413536', N'VENTA DE ELECTRODOMESTICOS', 0, N'4135', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 178, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (380, N'54', N'413554', N'VTA EQUIPO COMPU TECNO COMUNICACION', 0, N'4135', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 178, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (381, N'72', N'413572', N'REPARACION DE ELECTRODOMESTICOS', 0, N'4135', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 178, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (382, N'01', N'417501', N'DEVOLUCIONES REBAJAS Y DESCUENTOS', 0, N'4175', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 181, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (383, N'05', N'421005', N'INTERESES', 0, N'4210', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 183, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (384, N'25', N'421025', N'FINANCIACION DE VEHICULO', 0, N'4210', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 183, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (385, N'40', N'421040', N'DESCUENTOS COMERCIALES', 0, N'4210', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 183, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (386, N'25', N'422525', N'VENTA DE SEGUROS', 0, N'4225', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 186, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (387, N'10', N'423510', N'TRANSPORTE ELECTRODOMESTICOS', 0, N'4235', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 188, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (388, N'16', N'424516', N'EQUIPO DE TRANSPORTE', 0, N'4245', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 189, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (389, N'05', N'425005', N'RECUPERACIONES', 0, N'4250', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 190, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (390, N'40', N'425540', N'POR INCAPACIDADES DE E.P.S.', 0, N'4255', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 191, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (391, N'53', N'429553', N'SOBRANTES DE CAJA', 0, N'4295', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 194, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (392, N'81', N'429581', N'OTROS', 0, N'4295', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 194, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (393, N'06', N'510506', N'SUELDOS', 0, N'5105', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 196, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (394, N'15', N'510515', N'HORAS EXTRAS Y RECARGOS', 0, N'5105', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 196, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (395, N'18', N'510518', N'COMISIONES', 0, N'5105', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 196, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (396, N'21', N'510521', N'VIATICOS', 0, N'5105', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 196, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (397, N'24', N'510524', N'INCAPACIDADES', 0, N'5105', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 196, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (398, N'27', N'510527', N'AUXILIO DE TRANPORTE', 0, N'5105', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 196, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (399, N'30', N'510530', N'CESANTIAS', 0, N'5105', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 196, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (400, N'33', N'510533', N'INTERESES A LA CESANTIAS', 0, N'5105', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 196, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (401, N'36', N'510536', N'PRIMA DE SERVICIOS', 0, N'5105', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 196, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (402, N'39', N'510539', N'VACACIONES', 0, N'5105', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 196, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (403, N'45', N'510545', N'AUXILIOS', 0, N'5105', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 196, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (404, N'48', N'510548', N'BONIFICACIONES', 0, N'5105', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 196, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (405, N'51', N'510551', N'DOTACION Y SUMINISTRO DE TRABAJADORES', 0, N'5105', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 196, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (406, N'60', N'510560', N'INDEMNIZACIONES LABORALES', 0, N'5105', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 196, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (407, N'63', N'510563', N'CAPACITACION PERSONAL', 0, N'5105', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 196, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (408, N'66', N'510566', N'GASTOS DEPORTIVOS Y DE RECREACION', 0, N'5105', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 196, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (409, N'68', N'510568', N'APORTES ARP', 0, N'5105', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 196, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (410, N'69', N'510569', N'APORTES ENT PROM DE SALUD EPS', 0, N'5105', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 196, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (411, N'70', N'510570', N'APORTES A FONDO DE PENSIONES Y/O CESANTI', 0, N'5105', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 196, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (412, N'72', N'510572', N'APORTES CAJA DE COMPENSACION FAMILIAR', 0, N'5105', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 196, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (413, N'75', N'510575', N'APORTES I.C.B.F', 0, N'5105', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 196, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (414, N'78', N'510578', N'SENA', 0, N'5105', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 196, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (415, N'84', N'510584', N'GASTOS MEDICOS Y DROGAS', 0, N'5105', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 196, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (416, N'95', N'510595', N'OTROS GASTOS DE PERSONAL', 0, N'5105', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 196, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (417, N'05', N'511005', N'HONORARIOS', 0, N'5110', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 197, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (418, N'10', N'511010', N'REVISORIA FISCAL', 0, N'5110', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 197, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (419, N'15', N'511015', N'AUDITORIA EXTERNA', 0, N'5110', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 197, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (420, N'25', N'511025', N'ASESORIAS JURIDICAS', 0, N'5110', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 197, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (421, N'35', N'511035', N'ASESORIA TECNICA', 0, N'5110', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 197, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (422, N'95', N'511095', N'OTROS HONORARIOS', 0, N'5110', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 197, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (423, N'05', N'511505', N'INDUSTRIA Y COMERCIO', 0, N'5115', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 198, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (424, N'10', N'511510', N'IMPUESTO DE TIMBRE', 0, N'5115', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 198, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (425, N'15', N'511515', N'A LA PROPIEDAD RAIZ', 0, N'5115', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 198, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (426, N'20', N'511520', N'DERECHOS SOBRE INSTRUMENTOS PUBLICOS', 0, N'5115', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 198, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (427, N'40', N'511540', N'IMPUESTO DE VEHICULO', 0, N'5115', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 198, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (428, N'70', N'511570', N'IVA DESCONTABLE ASUMIDO', 0, N'5115', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 198, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (429, N'95', N'511595', N'OTROS', 0, N'5115', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 198, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (430, N'10', N'512010', N'ARRENDAMIENTOS Y EDIFICACIONES', 0, N'5120', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 199, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (431, N'40', N'512040', N'ARRENDAMIENTO EQUIPO DE TRANSPORTE', 0, N'5120', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 199, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (432, N'05', N'512505', N'CONTRIBUCIONES Y AFILIACIONES', 0, N'5125', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 200, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (433, N'10', N'512510', N'AFILIACIONES Y SOSTENIMIENTOS', 0, N'5125', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 200, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (434, N'05', N'513005', N'SEGUROS', 0, N'5130', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 201, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (435, N'35', N'513035', N'SUSTRACCION Y HURTO', 0, N'5130', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 201, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (436, N'75', N'513075', N'OBLIGATORIO ACCIDENTE DE TRANSITO', 0, N'5130', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 201, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (437, N'95', N'513095', N'OTROS SEGUROS', 0, N'5130', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 201, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (438, N'05', N'513505', N'ASEO Y VIGILANCIA', 0, N'5135', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 202, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (439, N'10', N'513510', N'TEMPORALES', 0, N'5135', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 202, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (440, N'15', N'513515', N'ASISTENCIA TECNICA', 0, N'5135', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 202, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (441, N'20', N'513520', N'PROCESAMIENTO DE DATOS ELECTRONICOS', 0, N'5135', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 202, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (442, N'25', N'513525', N'ACUEDUCTO Y ALCANTARILLADO', 0, N'5135', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 202, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (443, N'30', N'513530', N'ENERGIA ELECTRICA', 0, N'5135', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 202, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (444, N'35', N'513535', N'TELEFONOS', 0, N'5135', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 202, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (445, N'40', N'513540', N'CORREOS PORTES Y TELEGRAMAS', 0, N'5135', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 202, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (446, N'50', N'513550', N'TRANSPORTE FLETE Y ACARREO', 0, N'5135', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 202, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (447, N'55', N'513555', N'GAS', 0, N'5135', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 202, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (448, N'60', N'513560', N'UTILES PAPELERIA Y FOTOCOPIAS', 0, N'5135', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 202, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (449, N'95', N'513595', N'OTROS', 0, N'5135', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 202, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (450, N'05', N'514005', N'GASTOS NOTARIALES', 0, N'5140', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 203, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (451, N'10', N'514010', N'REGISTRO MERCANTIL', 0, N'5140', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 203, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (452, N'15', N'514015', N'TRAMITES Y LICENCIAS', 0, N'5140', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 203, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (453, N'95', N'514095', N'OTROS', 0, N'5140', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 203, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (454, N'10', N'514510', N'CONSTRUCCIONES Y EDIFICACIONES', 0, N'5145', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 204, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (455, N'15', N'514515', N'MAQUINARIA Y EQUIPOS', 0, N'5145', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 204, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (456, N'20', N'514520', N'EQUIPO DE OFICINA', 0, N'5145', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 204, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (457, N'25', N'514525', N'EQUIPO DE COMPUTACION Y COMUNICACION', 0, N'5145', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 204, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (458, N'40', N'514540', N'FLOTA Y EQUIPO DE TRASNPOPRTE', 0, N'5145', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 204, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (459, N'05', N'515005', N'INSTALACIONES ELECTRICAS', 0, N'5150', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 205, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (460, N'10', N'515010', N'ARREGLOS ORNAMENTALES', 0, N'5150', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 205, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (461, N'15', N'515015', N'ADECUACIONES LOCATIVAS', 0, N'5150', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 205, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (462, N'05', N'515505', N'ALOJAMIENTO Y MANUTENCION', 0, N'5155', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 206, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (463, N'15', N'515515', N'GASTO VIAJE PASAJES AEREOS', 0, N'5155', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 206, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (464, N'20', N'515520', N'PASAJES TERRESTRE', 0, N'5155', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 206, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (465, N'10', N'516010', N'DEPRECIACION MAQUINARIA Y EQUIPO', 0, N'5160', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 207, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (466, N'15', N'516015', N'DEPRECIACION DE EQ. DE OFICINA', 0, N'5160', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 207, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (467, N'20', N'516020', N'DEPRECIACION EQUIPO DE COMPUTACION', 0, N'5160', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 207, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (468, N'15', N'516515', N'CARGOS DIFERIDOS', 0, N'5165', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 208, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (469, N'05', N'519505', N'OTROS', 0, N'5195', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 209, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (470, N'10', N'519510', N'LIBROS, SUSCRIPCIONES, REVISTAS', 0, N'5195', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 209, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (471, N'20', N'519520', N'GASTOS DE REPRESENTACION', 0, N'5195', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 209, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (472, N'25', N'519525', N'ELEMENTOS DE ASEO Y CAFETERIA', 0, N'5195', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 209, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (473, N'30', N'519530', N'UTILES DE PAPELERIA Y FOTOCOPIAS', 0, N'5195', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 209, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (474, N'35', N'519535', N'COMBUSTIBLE Y  LUBRICANTES', 0, N'5195', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 209, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (475, N'40', N'519540', N'ENVASES Y EMPAQUES', 0, N'5195', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 209, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (476, N'45', N'519545', N'TAXIS Y BUSES', 0, N'5195', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 209, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (477, N'60', N'519560', N'CASINO Y RESTAURANTE', 0, N'5195', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 209, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (478, N'65', N'519565', N'PARQUEADEROS', 0, N'5195', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 209, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (479, N'95', N'519595', N'OTROS', 0, N'5195', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 209, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (480, N'05', N'519905', N'PROVISIONES CARTERA', 0, N'5199', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 210, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (481, N'60', N'523560', N'PUBLICIDAD PROPAGANDA Y PROMOCION', 0, N'5235', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 217, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (482, N'05', N'530505', N'GASTOS BANCARIOS', 0, N'5305', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 226, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (483, N'15', N'530515', N'COMISIONES', 0, N'5305', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 226, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (484, N'20', N'530520', N'INTERESES', 0, N'5305', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 226, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (485, N'35', N'530535', N'DESCUENTOS COMERCIALES CONDICIONADOS', 0, N'5305', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 226, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (486, N'40', N'531040', N'PERDIDAS POR SINIESTROS', 0, N'5310', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 227, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (487, N'15', N'531515', N'COSTOS Y GASTOS NO DEDUCIBLES', 0, N'5315', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 228, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (488, N'20', N'531520', N'IMPUESTOS ASUMIDOS', 0, N'5315', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 228, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (489, N'95', N'531595', N'OTROS', 0, N'5315', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 228, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (490, N'20', N'539520', N'MULTAS, SANCIONES Y LITIGIOS', 0, N'5395', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 229, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (491, N'25', N'539525', N'DONACIONES', 0, N'5395', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 229, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (492, N'95', N'539595', N'OTROS', 0, N'5395', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 229, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (493, N'05', N'540505', N'IMPUESTO DE RENTA Y COMPLEMANTARIOS', 0, N'5405', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 230, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (494, N'05', N'590505', N'GANANCIAS Y PERDIDAS', 0, N'5905', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 231, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (495, N'02', N'613502', N'COMERCIO AL POR MAYOR Y AL DETAL', 0, N'6135', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 233, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (496, N'04', N'613504', N'MANTENIMIENTO Y REPARACION Y LAVADO DE V', 0, N'6135', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 233, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (497, N'06', N'613506', N'VENTA DE PARTES Y ACCESORIOS DE VEHICULO', 0, N'6135', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 233, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (498, N'36', N'613536', N'VTA DE ELECTRODOMESTICOS Y MUEBLES', 0, N'6135', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 233, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (499, N'95', N'613595', N'VTA DE OTROS PRODUCTOS', 0, N'6135', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 233, NULL)
GO
INSERT [dbo].[CNTCuentas] ([id], [subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta]) VALUES (500, N'35', N'622535', N'DEVOLUCIONES EN COMPRAS', 0, N'6225', 1, CAST(N'20200505 22:26:00' AS SmallDateTime), CAST(N'20200505 22:26:00' AS SmallDateTime), 1, 1, 4, 234, NULL)
GO
SET IDENTITY_INSERT [dbo].[CNTCuentas] OFF
GO


SET IDENTITY_INSERT [dbo].[Menus] ON 

GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (1, N'Parametrización', 1, N'#', 0, N'Menu  de configuración', 4, 1, N'fa-shield', 1, CAST(N'20170217 21:50:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (2, N'Parametros', 1, N'parametros.aspx', 1, N'Listado de parametros del sistema', 4, 0, N'', 1, CAST(N'20170217 21:53:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (3, N'Inventario', 1, N'#', 0, N'Menu  de Funcionalidad', 1, 1, N'fa-th-large', 1, CAST(N'20170217 21:50:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (4, N'Compras', 1, N'entradas.aspx', 3, N'Compras', 2, 0, N'fa-th-large', 1, CAST(N'20170217 21:53:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (5, N'Maestros', 1, N'#', 0, N'Menu  de Maestros', 2, 1, N'fa-cogs', 3, CAST(N'20170217 21:50:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (6, N'Productos', 1, N'productos.aspx', 5, N'Maestro de Productos', 6, 0, N'fa-th-large', 1, CAST(N'20170217 21:53:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (7, N'Categoria de Producto', 1, N'CategoriaProducto.aspx', 5, N'Maestro de Categoria de Producto', 4, 0, N'fa-th-large', 1, CAST(N'20170217 21:53:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (8, N'Turnos', 1, N'turnos.aspx', 1, N'Maestro Turnos', 9, 0, N'fa-th-large', 1, CAST(N'20170217 21:53:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (9, N'Bodegas', 1, N'bodegas.aspx', 5, N'Maestro Bodegas', 10, 0, N'fa-th-large', 1, CAST(N'20170217 21:53:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (10, N'Cajas', 1, N'cajas.aspx', 5, N'Maestro Cajas', 11, 0, N'fa-th-large', 1, CAST(N'20170217 21:53:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (12, N'Cuentas', 1, N'cuentas.aspx', 5, N'Maestro Cuentas', 9, 0, N'fa-th-large', 1, CAST(N'20170217 21:53:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (13, N'Terceros', 1, N'terceros.aspx', 5, N'Maestro Terceros', 3, 0, N'fa-th-large', 1, CAST(N'20170217 21:53:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (16, N'Resolución', 1, N'resoluciones.aspx', 5, N'Maestro Resoluciones', 12, 0, N'fa-th-large', 1, CAST(N'20170217 21:53:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (17, N'Usuarios', 1, N'usuarios.aspx', 1, N'Usuarios', 0, 0, N'fa-th-large', 1, CAST(N'20170217 21:53:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (18, N'Formas de Pago', 1, N'formapago.aspx', 5, N'Formas de Pago', 13, 0, N'fa-th-large', 1, CAST(N'20170217 21:53:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (19, N'Empresa', 1, N'empresa.aspx', 1, N'Empresa', 0, 0, N'fa-th-large', 1, CAST(N'20170217 21:53:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (20, N'Factura', 1, N'facturacion.aspx', 55, N'Facturación de Articulos', 1, 0, N'fa-th-large', 1, CAST(N'20170217 21:53:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (24, N'Traslados', 1, N'traslados.aspx', 3, N'Traslado de artículos', 7, 0, N'fa-th-large', 1, CAST(N'20170217 21:53:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (25, N'Reporteador', 1, N'reporteador.aspx', 26, N'Reporteador', 1, 0, N'fa-th-large', 1, CAST(N'20170217 21:53:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (26, N'Informes', 1, N'#', 0, N'Informes', 2, 1, N'fa-cogs', 1, CAST(N'20170217 21:50:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (28, N'Periodos', 1, N'periodos.aspx', 58, N'Maestro Periodos', 3, 0, N'fa-th-large', 1, CAST(N'20170217 21:53:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (29, N'Cierre Caja', 1, N'cierrecaja.aspx', 3, N'Cierre Caja', 13, 0, N'fa-th-large', 1, CAST(N'20170217 21:53:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (30, N'Ajuste de Inventario', 1, N'ajustes.aspx', 3, N'Ajuste Inventario', 8, 0, N'fa-th-large', 1, CAST(N'2017-12-05 20:36:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (31, N'Nota Crédito Factura', 1, N'devfactura.aspx', 55, N'Devolución de Factura', 2, 0, N'fa-th-large', 1, CAST(N'20170217 21:53:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (32, N'Inicio', 1, N'Default.aspx', 0, N'Inicio', 0, 0, N'fa-th-large', 1, CAST(N'20170217 21:53:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (33, N'Saldos Iniciales', 1, N'saldosiniciales.aspx', 1, N'Inventario Inicial', 5, 0, N'fa-th-large', 1, CAST(N'20170217 21:53:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (34, N'Anticipos', 1, N'anticipos.aspx', 55, N'Anticipos', 3, 0, N'fa-th-large', 1, CAST(N'20170217 21:53:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (36, N'Nota Crédito Compra', 1, N'deventrada.aspx', 3, N'Devolución de Compra', 10, 0, N'fa-th-large', 1, CAST(N'20170217 21:53:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (37, N'Conversión Artículos', 0, N'conversionarticulos.aspx', 3, N'Devolución de Compra', 14, 0, N'fa-th-large', 1, CAST(N'20170217 21:53:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (38, N'Devolución de Anticipos', 1, N'devanticipos.aspx', 55, N'Devolución de Anticipos', 4, 0, N'fa-th-large', 1, CAST(N'20170217 21:53:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (40, N'Centro Costos', 1, N'Centrocostos.aspx', 5, N'Maestro de Centro de Costos', 7, 0, N'fa-th-large', 1, CAST(N'20170217 11:58:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (43, N'Tipo de Documentos', 1, N'CNTTipodocumentos.aspx', 5, N'Maestro de Tipo de Documentos', 8, 0, N'fa-th-large', 1, CAST(N'20191024 09:08:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (44, N'Impuestos', 1, N'CNTTipoimpuestos.aspx', 5, N'Maestro de Tipo de Impuestos', 1, 0, N'fa-th-large', 1, CAST(N'20191024 14:46:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (46, N'Marcas', 1, N'Marcas.aspx', 5, N'Maestro de Marcas', 5, 0, N'fa-th-large', 1, CAST(N'20191118 08:56:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (47, N'Orden de Compras', 1, N'ordencompras.aspx', 3, N'Orden de compras', 1, 0, N'fa-th-large', 1, CAST(N'20170217 10:25:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (48, N'Lotes de Producto', 1, N'lotes.aspx', 5, N'Lotes de Producto', 14, 0, N'fa-th-large', 1, CAST(N'20191125 16:12:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (49, N'Comprobante de Egresos', 1, N'comprobanteegreso.aspx', 50, N'Comprobante de Egresos', 6, 0, N'fa-th-large', 1, CAST(N'20191217 11:15:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (50, N'Contabilidad', 1, N'#', 0, N'Contabilidad', 2, 1, N'fa fa-bank', 1, CAST(N'20200220 09:19:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (51, N'Comprobantes Contables', 1, N'comprobantescontables.aspx', 50, N'Comprobante Contables', 6, 0, N'fa-th-large', 1, CAST(N'20200220 09:31:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (52, N'Recibo de Caja', 1, N'recibocaja.aspx', 50, N'Recibos de Caja', 6, 0, N'fa-th-large', 1, CAST(N'20200227 16:26:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (53, N'Categoria Fiscal', 1, N'catfiscal.aspx', 5, N'Maestro de Articulos', 2, 0, N'fa-th-large', 1, CAST(N'20170217 21:53:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (54, N'Vendedores', 1, N'vendedores.aspx', 5, N'Maestro Vendedores', 15, 0, N'fa-th-large', 1, CAST(N'20170217 21:53:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (55, N'Facturación', 1, N'#', 0, N'Menu  de Funcionalidad', 0, 1, N'fa-th-large', 1, CAST(N'20170217 21:50:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (56, N'Tercero Integral', 1, N'tercerointegral.aspx', 50, N'Terceros Integral', 6, 0, N'fa-th-large', 1, CAST(N'20200904 09:47:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (57, N'Parametros Iniciales', 0, N'parametros.aspx', 1, N'Listado de parametros del sistema', 4, 0, N'fa-th-large', 1, CAST(N'20170217 21:53:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (58, N'Seguridad del Sistema', 1, N'#', 0, N'Menu  de Seguridad', 4, 1, N'fa-lock', 1, CAST(N'20170217 21:50:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (59, N'Factura POS', 1, N'facturacionPos.aspx', 55, N'Factura POS', 1, 0, N'fa-th-large', 1, CAST(N'20170217 21:53:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (60, N'Cotizaciones', 1, N'cotizaciones.aspx', 55, N'Cotizaciones', 5, 0, N'fa-th-large', 1, CAST(N'20200915 17:30:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (61, N'Factura Recurrente', 1, N'facturasrecurrentes.aspx', 55, N'Factura Recurrente', 5, 0, N'fa-th-large', 1, CAST(N'20200915 17:30:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (62, N'Financiero', 1, N'#', 0, N'Menu  de Financiero', 3, 1, N'fa-shield', 1, CAST(N'20170217 21:50:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (63, N'Servicios Financieros', 0, N'serviciosfinanciero.aspx', 62, N'Servicios Financieros', 2, 0, N'fa-th-large', 1, CAST(N'20200915 17:30:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (64, N'Lineas Credito', 0, N'lineascredito.aspx', 62, N'Lineas Creditos', 3, 0, N'fa-th-large', 1, CAST(N'20200915 17:30:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (65, N'Cartera', 1, N'#', 0, N'Menu  de Cartera', 4, 1, N'fa-shield', 1, CAST(N'20170217 21:50:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (66, N'Gestión Cartera', 1, N'gestioncartera.aspx', 65, N'Gestion Cartera', 1, 0, N'fa-th-large', 1, CAST(N'20200915 17:30:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (67, N'Gestión Cliente', 1, N'searchcliente.aspx', 65, N'Gestion Cliente', 2, 0, N'fa-th-large', 1, CAST(N'20200915 17:30:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (68, N'Perfiles', 1, N'perfiles.aspx', 1, N'Perfiles', 2, 0, N'fa-th-large', 1, CAST(N'20200915 17:30:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (69, N'Permisos', 1, N'permisos.aspx', 1, N'PErmisos', 2, 0, N'fa-th-large', 1, CAST(N'20200915 17:30:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (70, N'Sin Contabilizar', 1, N'listsncount.aspx', 50, N'Gestion Cliente', 7, 0, N'fa-th-large', 1, CAST(N'20200915 17:30:00' AS SmallDateTime))
GO
INSERT [dbo].[Menus] ([id], [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES (71, N'Nota Cartera', 1, N'notascartera.aspx', 50, N'Nota Cartera', 5, 0, N'fa-th-large', 1, CAST(N'20200915 17:30:00' AS SmallDateTime))
GO

SET IDENTITY_INSERT [dbo].[Menus] OFF
GO

SET IDENTITY_INSERT [dbo].[Empresas] ON 
GO
INSERT [dbo].[Empresas] ([id], [razonsocial], [nit], [digverificacion], [id_ciudad], [direccion], [telefono], [email], [urlimg], [urlimgrpt], [softid], [softpin], [softtecnikey], [estado], [created], [updated], [id_usercreated], [id_userupdated], [carpetaname], [certificatename], [passcertificate], [testid], [id_tipoid], [tipoambiente], [manual], [nombrecomercial]) VALUES (1, N'Empresa Pruebas', N'00000000', N'0', 1, N'MEDELLIN', N'000000000', N'prueba@mail.com', N'', N'', N'', N'', N'', 1, CAST(N'20200517 22:57:00' AS SmallDateTime), CAST(N'20201001 07:24:00' AS SmallDateTime), 1, 1, N'', N'', N'', N'', 10, 2, 0, N'Empresa Prueba S.A.S')
GO
SET IDENTITY_INSERT [dbo].[Empresas] OFF
GO

SET IDENTITY_INSERT [CNT].[TipoDocumentos] ON 

GO
INSERT [CNT].[TipoDocumentos] ([id], [codigo], [nombre], [id_tipo], [isccosto], [id_centrocosto], [bloqueado], [estado], [created], [updated], [id_usercreated], [id_userupdated]) VALUES (1, N'FV', N'FACTURA DE VENTA', 56, 1, NULL, 1, 1, CAST(N'20201005 10:45:00' AS SmallDateTime), CAST(N'20201005 10:45:00' AS SmallDateTime), 1, 1)
GO
INSERT [CNT].[TipoDocumentos] ([id], [codigo], [nombre], [id_tipo], [isccosto], [id_centrocosto], [bloqueado], [estado], [created], [updated], [id_usercreated], [id_userupdated]) VALUES (2, N'CM', N'ENTRADAS DE MERCANCIA', 55, 1, NULL, 1, 1, CAST(N'20201005 10:46:00' AS SmallDateTime), CAST(N'20201005 10:46:00' AS SmallDateTime), 1, 1)
GO
INSERT [CNT].[TipoDocumentos] ([id], [codigo], [nombre], [id_tipo], [isccosto], [id_centrocosto], [bloqueado], [estado], [created], [updated], [id_usercreated], [id_userupdated]) VALUES (3, N'AN', N'ANTICIPOS', 72, 1, NULL, 1, 1, CAST(N'20201005 10:46:00' AS SmallDateTime), CAST(N'20201005 10:46:00' AS SmallDateTime), 1, 1)
GO
INSERT [CNT].[TipoDocumentos] ([id], [codigo], [nombre], [id_tipo], [isccosto], [id_centrocosto], [bloqueado], [estado], [created], [updated], [id_usercreated], [id_userupdated]) VALUES (4, N'DA', N'DEVOLUCIÓN DE ANTICIPO', 72, 1, NULL, 1, 1, CAST(N'20201005 10:47:00' AS SmallDateTime), CAST(N'20201005 10:47:00' AS SmallDateTime), 1, 1)
GO
INSERT [CNT].[TipoDocumentos] ([id], [codigo], [nombre], [id_tipo], [isccosto], [id_centrocosto], [bloqueado], [estado], [created], [updated], [id_usercreated], [id_userupdated]) VALUES (5, N'FE', N'FACTURA ELECTRONICA', 56, 1, NULL, 1, 1, CAST(N'20201005 10:47:00' AS SmallDateTime), CAST(N'20201005 10:47:00' AS SmallDateTime), 1, 1)
GO
INSERT [CNT].[TipoDocumentos] ([id], [codigo], [nombre], [id_tipo], [isccosto], [id_centrocosto], [bloqueado], [estado], [created], [updated], [id_usercreated], [id_userupdated]) VALUES (6, N'FP', N'FACTURA POS', 56, 1, NULL, 1, 1, CAST(N'20201005 10:47:00' AS SmallDateTime), CAST(N'20201014 17:07:00' AS SmallDateTime), 1, 1)
GO
INSERT [CNT].[TipoDocumentos] ([id], [codigo], [nombre], [id_tipo], [isccosto], [id_centrocosto], [bloqueado], [estado], [created], [updated], [id_usercreated], [id_userupdated]) VALUES (7, N'TR', N'TRASLADO DE MERCANCIA', 55, 1, NULL, 1, 1, CAST(N'20201005 10:47:00' AS SmallDateTime), CAST(N'20201005 10:47:00' AS SmallDateTime), 1, 1)
GO
INSERT [CNT].[TipoDocumentos] ([id], [codigo], [nombre], [id_tipo], [isccosto], [id_centrocosto], [bloqueado], [estado], [created], [updated], [id_usercreated], [id_userupdated]) VALUES (8, N'DC', N'DOCUMENTO DE CAJA	', 57, 1, NULL, 1, 1, CAST(N'20201005 10:48:00' AS SmallDateTime), CAST(N'20201005 10:48:00' AS SmallDateTime), 1, 1)
GO
INSERT [CNT].[TipoDocumentos] ([id], [codigo], [nombre], [id_tipo], [isccosto], [id_centrocosto], [bloqueado], [estado], [created], [updated], [id_usercreated], [id_userupdated]) VALUES (9, N'RC', N'RECIBO DE CAJA', 57, 1, NULL, 1, 1, CAST(N'20201005 10:48:00' AS SmallDateTime), CAST(N'20201023 14:13:00' AS SmallDateTime), 1, 1)
GO
INSERT [CNT].[TipoDocumentos] ([id], [codigo], [nombre], [id_tipo], [isccosto], [id_centrocosto], [bloqueado], [estado], [created], [updated], [id_usercreated], [id_userupdated]) VALUES (10, N'NC', N'NOTA CREDITO', 58, 1, NULL, 1, 1, CAST(N'20201005 10:48:00' AS SmallDateTime), CAST(N'20201005 10:48:00' AS SmallDateTime), 1, 1)
GO
INSERT [CNT].[TipoDocumentos] ([id], [codigo], [nombre], [id_tipo], [isccosto], [id_centrocosto], [bloqueado], [estado], [created], [updated], [id_usercreated], [id_userupdated]) VALUES (11, N'AJ', N'AJUSTE DE MERCANCIA', 55, 1, NULL, 1, 1, CAST(N'20201005 10:49:00' AS SmallDateTime), CAST(N'20201005 10:49:00' AS SmallDateTime), 1, 1)
GO
INSERT [CNT].[TipoDocumentos] ([id], [codigo], [nombre], [id_tipo], [isccosto], [id_centrocosto], [bloqueado], [estado], [created], [updated], [id_usercreated], [id_userupdated]) VALUES (12, N'ND', N'NOTA DEBITO', 58, 1, NULL, 1, 1, CAST(N'20201005 10:49:00' AS SmallDateTime), CAST(N'20201005 10:49:00' AS SmallDateTime), 1, 1)
GO
INSERT [CNT].[TipoDocumentos] ([id], [codigo], [nombre], [id_tipo], [isccosto], [id_centrocosto], [bloqueado], [estado], [created], [updated], [id_usercreated], [id_userupdated]) VALUES (13, N'NF', N'NOTA CREDITO FACTURA', 56, 1, NULL, 1, 1, CAST(N'20201005 10:49:00' AS SmallDateTime), CAST(N'20201005 10:49:00' AS SmallDateTime), 1, 1)
GO
INSERT [CNT].[TipoDocumentos] ([id], [codigo], [nombre], [id_tipo], [isccosto], [id_centrocosto], [bloqueado], [estado], [created], [updated], [id_usercreated], [id_userupdated]) VALUES (14, N'OC', N'ORDENES DE COMPRA	', 55, 1, NULL, 1, 1, CAST(N'20201005 10:49:00' AS SmallDateTime), CAST(N'20201005 10:49:00' AS SmallDateTime), 1, 1)
GO
INSERT [CNT].[TipoDocumentos] ([id], [codigo], [nombre], [id_tipo], [isccosto], [id_centrocosto], [bloqueado], [estado], [created], [updated], [id_usercreated], [id_userupdated]) VALUES (15, N'DV', N'NOTA CREDITO COMPRA', 55, 1, NULL, 1, 1, CAST(N'20201005 10:50:00' AS SmallDateTime), CAST(N'20201005 10:50:00' AS SmallDateTime), 1, 1)
GO
INSERT [CNT].[TipoDocumentos] ([id], [codigo], [nombre], [id_tipo], [isccosto], [id_centrocosto], [bloqueado], [estado], [created], [updated], [id_usercreated], [id_userupdated]) VALUES (16, N'NT', N'NOTA CONTABLE', 58, 1, NULL, 1, 1, CAST(N'20201014 15:06:00' AS SmallDateTime), CAST(N'20201026 07:53:00' AS SmallDateTime), 1, 1)
GO
INSERT [CNT].[TipoDocumentos] ([id], [codigo], [nombre], [id_tipo], [isccosto], [id_centrocosto], [bloqueado], [estado], [created], [updated], [id_usercreated], [id_userupdated]) VALUES (17, N'CE', N'COMPROBANTE DE EGRESO', 58, 1, NULL, 1, 1, CAST(N'20201022 15:26:00' AS SmallDateTime), CAST(N'20201022 15:26:00' AS SmallDateTime), 1, 1)
GO
SET IDENTITY_INSERT [CNT].[TipoDocumentos] OFF
GO


SET IDENTITY_INSERT [dbo].[LotesProducto] ON 

GO
INSERT [dbo].[LotesProducto] ([id], [default], [lote], [vencimiento_lote], [estado], [created], [updated], [id_usercreated], [id_userupdated]) VALUES (1, 1, N'sintesis', CAST(N'1999-01-01 00:00:00' AS SmallDateTime), 1, CAST(N'2020-11-09 15:26:00' AS SmallDateTime), CAST(N'2020-11-09 15:26:00' AS SmallDateTime), 1, 1)
GO
SET IDENTITY_INSERT [dbo].[LotesProducto] OFF
GO


UPDATE Menus SET id_padre = 58 WHERE id = 29
GO

INSERT INTO [dbo].[MenusPerfiles] (id_perfil, id_menu, id_user)
SELECT 1, id, 1 from Menus WHERE padre = 0
GO

INSERT INTO [dbo].[MenusPerfiles] (id_perfil, id_menu, id_user)
SELECT 2, id, 1 from Menus WHERE id NOT IN (33, 37, 57, 59)
GO

INSERT INTO [dbo].[MenusPerfiles] (id_perfil, id_menu, id_user)
SELECT 3, id, 1 from Menus WHERE id IN (13, 20, 25, 52, 55, 56, 59, 60)
GO

INSERT INTO [dbo].[aspnet_RolesInReports](id_perfil, id_reporte, id_user)
SELECT 1, id, 1 FROM [dbo].[ST_Reportes] 
GO

INSERT INTO [dbo].[aspnet_RolesInReports](id_perfil, id_reporte, id_user)
SELECT 2, id, 1 FROM [dbo].[ST_Reportes] 
GO

INSERT INTO [dbo].[aspnet_RolesInReports](id_perfil, id_reporte, id_user)
SELECT 3, id, 1 FROM [dbo].[ST_Reportes] WHERE id IN (9)
GO