--liquibase formatted sql
--changeset ,KMARTINEZ:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
IF EXISTS(select 1 from [dbo].[Parametros] where [codigo] = 'PORCENTOPEMAX')
BEGIN
	DELETE FROM [dbo].[Parametros] where [codigo] = 'PORCENTOPEMAX'
END
GO
SET IDENTITY_INSERT [dbo].[Parametros] OFF 
GO
INSERT [dbo].[Parametros] ([codigo], [nombre], [valor], [tipo], [created], [updated], [id_user], [default], [icon], [metadata], [fuente], [ancho], [orden], [campos], [seleccion], [params], [extratexto]) VALUES (N'PORCENTOPEMAX', N'Maximo Interes ', N'2', N'NUMERO', GETDATE(), GETDATE(), 1, 0, N'<i class="fa fa-cog" aria-hidden="true"></i>', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO


IF EXISTS(select 1 from [dbo].[ST_Listados] where [codigogen] = 'FORMACREDI')
BEGIN
	DELETE FROM [dbo].[ST_Listados] where [codigogen] = 'FORMACREDI' or [codigo] = 'FORMACREDI'
END
GO
SET IDENTITY_INSERT [dbo].[ST_Listados] OFF
INSERT [dbo].[ST_Listados] ( [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES ( N'FORMACREDI', N'', N'', N'pagos creditos', 1, GETDATE(), GETDATE(), 1, 1)
GO
INSERT [dbo].[ST_Listados] ([codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'FORMACREDI', N'CONV', N'Convencional', 1, GETDATE(), GETDATE(), 1, 1)
GO
INSERT [dbo].[ST_Listados] ( [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'FORMACREDI', N'CREDI', N'A creditos', 1, GETDATE(), GETDATE(), 1, 1)
GO
INSERT [dbo].[ST_Listados] ( [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'FORMACREDI', N'FINAN', N'Financiera', 1, GETDATE(), GETDATE(), 1, 1)
GO

IF COL_LENGTH('[dbo].[MOVFactura]', 'tipofactura') IS NULL
BEGIN
   ALTER TABLE 
   	[dbo].[MOVFactura] 
   ADD 
	[tipofactura] [varchar](50) NULL
END
GO

IF COL_LENGTH('[dbo].[MOVFactura]', 'PagoFinan') IS NULL
BEGIN
	ALTER TABLE 
		[dbo].[MOVFactura] 
	ADD 
		[PagoFinan] [bigint] NULL

END
GO

IF COL_LENGTH('[dbo].[MOVFactura]', 'valorFianza') IS NULL
BEGIN
	ALTER TABLE 
		[dbo].[MOVFactura] 
	ADD [valorFianza] [NUMERIC] (18,2) NULL

END

SET IDENTITY_INSERT [dbo].[ST_Reportes] OFF
GO
INSERT [dbo].[ST_Reportes] ( [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (N'MOVRECAUDOC', N'Recaudo Cartera', N'MOVRecaudoC.frx', 0, 1, CAST(N'2017-12-09 11:06:00' AS SmallDateTime), CAST(N'2017-12-09 11:06:00' AS SmallDateTime), 1, N'[CNT].[ST_Rpt_MovReciboCaja] ', N'')
GO

if EXISTS(SELECT 1 FROM [dbo].[Menus] WHERE [nombrepagina] = 'Recaudo Cartera')
BEGIN
	DELETE [dbo].[MenusPerfiles] WHERE ID_MENU = (SELECT id FROM [dbo].[Menus] WHERE [nombrepagina] = 'Recaudo Cartera')
	DELETE [dbo].[Menus]  WHERE [nombrepagina] = 'Recaudo Cartera'

END
SET IDENTITY_INSERT [dbo].[Menus] OFF
INSERT [dbo].[Menus] ( [nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) VALUES ( N'Recaudo Cartera', 1, N'RecaudoCartera.aspx', 62, N'Recaudo Cartera', 3, 0, N'fa-th-large', 1, GETDATE())

SET IDENTITY_INSERT [dbo].[MenusPerfiles] OFF 
INSERT [dbo].[MenusPerfiles] ( [id_perfil], [id_menu], [created], [updated], [id_user]) 
VALUES (1, (SELECT id FROM [dbo].[Menus] WHERE [nombrepagina] = 'Recaudo Cartera' ), GETDATE(), GETDATE(), 1), ( 2, (SELECT id FROM [dbo].[Menus] WHERE [nombrepagina] = 'Recaudo Cartera' ), GETDATE(), GETDATE(), 1)
GO

 
SET ANSI_PADDING ON
GO
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FIN].[RecaudoCarteraFormaPago]') and OBJECTPROPERTY(id, N'IsTable') = 1)
DROP TABLE [FIN].[RecaudoCarteraFormaPago]
GO
CREATE TABLE [FIN].[RecaudoCarteraFormaPago](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_recibo] [bigint] NOT NULL,
	[id_formapago] [bigint] NOT NULL,
	[voucher] [varchar](100) NOT NULL,
	[valor] [numeric](18, 2) NOT NULL,
	[created] [smalldatetime] NOT NULL DEFAULT(GETDATE()),
	[id_user] [int] NOT NULL,
	[codcuenta] [bigint] NOT NULL,
 CONSTRAINT [PK_RecaudoCarteraFormaPago] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FIN].[RecaudocarteraItems]') and OBJECTPROPERTY(id, N'IsTable') = 1)
DROP TABLE [FIN].[RecaudocarteraItems]
GO
CREATE TABLE [FIN].[RecaudocarteraItems](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_recibo] [bigint] NOT NULL,
	[id_factura] [varchar](50) NULL,
	[cuota] INT NULL,
	[valorCuota] [numeric](18, 2) NULL,
	[pagoCuota] [numeric](18, 2) NULL,
	[porcenInCorriente] [numeric](18, 2) NULL,
	[valorIva] [numeric](18, 2) NULL,
	[valorServicios] [numeric](18, 2) NULL,
	[interesCorriente] [numeric](18, 2) NULL,
	[diasInCorrientePagado] [int] NULL,
	[pagoTotal_InCorriente] [bit] NULL,
	[porceInMora] [numeric](18, 2) NULL,
	[InteresMora] [numeric](18, 2) NULL,
	[dias_interes_pagadoMora] [int] NULL,
	[pagoTotal_InMora] [bit] NULL,
	[totalpagado] [numeric](18, 2) NULL,
	[vencimiento_interes] [varchar](10) NULL,
	[created] [smalldatetime] NOT NULL DEFAULT(GETDATE()),
	[id_user] [bigint] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO 
 
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FIN].[Recaudocartera]') and OBJECTPROPERTY(id, N'IsTable') = 1)
DROP TABLE [FIN].[Recaudocartera]
GO
CREATE TABLE [FIN].[Recaudocartera](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_tipodoc] [bigint] NULL,
	[id_centrocostos] [bigint] NULL,
	[fecha] [smalldatetime] NOT NULL,
	[id_cliente] [bigint] NULL,
	[id_conceptoDescuento] [bigint] NULL,
	[valorDescuento] [numeric](18, 2) NULL,
	[valorcliente] [numeric](18, 2) NOT NULL,
	[valorconcepto] [numeric](18, 2) NOT NULL,
	[estado] [int] NOT NULL,
	[detalle] [varchar](max) NULL,
	[cambio] [numeric](18, 2) NULL,
	[id_reversion] [bigint] NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_ST_Recaudocartera_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_ST_Recaudocartera_updated]  DEFAULT (getdate()),
	[id_usercreated] [bigint] NOT NULL,
	[id_userupdated] [bigint] NOT NULL,
 CONSTRAINT [PK_RecaudocarteraSave] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

SET ANSI_PADDING ON
GO
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FIN].[SaldoCliente_Cuotas]') and OBJECTPROPERTY(id, N'IsTable') = 1)
DROP TABLE [FIN].[SaldoCliente_Cuotas]
GO
CREATE TABLE [FIN].[SaldoCliente_Cuotas](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[anomes] [varchar](10) NOT NULL,
	[iva] [bit] NULL,
	[porcenIva] [numeric](18, 2) NULL,
	[id_saldo] [bigint] NOT NULL,
	[cuota] [int] NOT NULL,
	[vlrcuota] [numeric](18, 2) NOT NULL,
	[saldo] [numeric](18, 2) NOT NULL,
	[saldo_anterior] [numeric](18, 2) NULL,
	[saldocuota] [numeric](18, 2) NOT NULL,
	[interes] [numeric](18, 2) NULL,
	[acapital] [numeric](18, 2) NULL,
	[porcentaje] [numeric](18, 2) NULL,
	[fecha_inicial] [smalldatetime] NULL,
	[vencimiento_cuota] [smalldatetime] NOT NULL,
	[fechapagointeres] [smalldatetime] NOT NULL,
	[abono] [numeric](18, 2) NOT NULL,
	[cancelada] [bit] NOT NULL CONSTRAINT [DF_SaldoCliente_Cuotas_cancelada]  DEFAULT ((0)),
	[devolucion] [bit] NOT NULL CONSTRAINT [DF_SaldoCliente_Cuotas_devolucion]  DEFAULT ((0)),
	[id_user] [bigint] NOT NULL,
	[create] [smalldatetime] NOT NULL CONSTRAINT [DF_SaldoCliente_Cuotas_create]  DEFAULT (getdate()),
	[update] [smalldatetime] NULL CONSTRAINT [DF_SaldoCliente_Cuotas_update]  DEFAULT (getdate())
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

SET ANSI_PADDING ON
GO
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FIN].[SaldoCliente]') and OBJECTPROPERTY(id, N'IsTable') = 1)
DROP TABLE [FIN].[SaldoCliente]
GO
CREATE TABLE [FIN].[SaldoCliente](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[anomes] [varchar](6) NOT NULL,
	[id_cliente] [bigint] NOT NULL,
	[id_documento] [bigint] NULL,
	[nrofactura] [varchar](50) NOT NULL,
	[fechaactual] [smalldatetime] NOT NULL,
	[fechavencimiento] [smalldatetime] NOT NULL,
	[saldoanterior] [numeric](18, 2) NOT NULL,
	[movDebito] [numeric](18, 2) NOT NULL,
	[movCredito] [numeric](18, 2) NOT NULL,
	[saldoActual] [numeric](18, 2) NOT NULL,
	[porcentaje] [numeric](18, 0) NULL,
	[id_user] [bigint] NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_SaldoCliente_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_SaldoCliente_updated]  DEFAULT (getdate()),
 CONSTRAINT [PK_SaldoCliente_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO


------------------------------[FIN].[RecaudocarteraItems]
ALTER TABLE [FIN].[RecaudocarteraItems]  WITH CHECK ADD  CONSTRAINT [FK_RecaudocarteraItems_Recaudocartera] FOREIGN KEY([id_recibo])
REFERENCES [FIN].[Recaudocartera] ([id])
GO
ALTER TABLE [FIN].[RecaudocarteraItems] CHECK CONSTRAINT [FK_RecaudocarteraItems_Recaudocartera]
GO
ALTER TABLE [FIN].[RecaudocarteraItems]  WITH CHECK ADD  CONSTRAINT [FK_RecaudocarteraItems_Usuarios] FOREIGN KEY([id_user])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [FIN].[RecaudocarteraItems] CHECK CONSTRAINT [FK_RecaudocarteraItems_Usuarios]
GO

----------------------------[FIN].[SaldoCliente]
ALTER TABLE [FIN].[SaldoCliente]  WITH CHECK ADD  CONSTRAINT [FK_SaldoCliente_MOvFactura] FOREIGN KEY([id_documento])
REFERENCES [dbo].[MOVFactura] ([id])
GO
ALTER TABLE [FIN].[SaldoCliente] CHECK CONSTRAINT [FK_SaldoCliente_MOvFactura]
GO
ALTER TABLE [FIN].[SaldoCliente]  WITH CHECK ADD  CONSTRAINT [FK_SaldoCliente_Terceros] FOREIGN KEY([id_cliente])
REFERENCES [CNT].[TipoTerceros] ([id])
GO
ALTER TABLE [FIN].[SaldoCliente] CHECK CONSTRAINT [FK_SaldoCliente_Terceros]
GO
ALTER TABLE [FIN].[SaldoCliente]  WITH CHECK ADD  CONSTRAINT [FK_SaldoCliente_Usuarios] FOREIGN KEY([id_user])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [FIN].[SaldoCliente] CHECK CONSTRAINT [FK_SaldoCliente_Usuarios]
GO

----------------------------[FIN].[SaldoCliente_Cuotas]
ALTER TABLE [FIN].[SaldoCliente_Cuotas]  WITH CHECK ADD  CONSTRAINT [FK_SaldoCliente_Cuotas_SaldoCliente] FOREIGN KEY([id_saldo])
REFERENCES [FIN].[SaldoCliente] ([id])
GO
ALTER TABLE [FIN].[SaldoCliente_Cuotas] CHECK CONSTRAINT [FK_SaldoCliente_Cuotas_SaldoCliente]
GO
ALTER TABLE [FIN].[SaldoCliente_Cuotas]  WITH CHECK ADD  CONSTRAINT [FK_SaldoCliente_Cuotas_Usuarios] FOREIGN KEY([id_user])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [FIN].[SaldoCliente_Cuotas] CHECK CONSTRAINT [FK_SaldoCliente_Cuotas_Usuarios]
GO

IF COL_LENGTH('[dbo].[MovFacturaCuotas]', 'valorcuota') IS NULL
BEGIN
   ALTER TABLE 
   	[dbo].[MovFacturaCuotas]
   ADD 
	[valorcuota] [decimal](18, 4) NULL
END
GO

IF COL_LENGTH('[dbo].[MovFacturaCuotas]', 'saldo_anterior') IS NULL
BEGIN
   ALTER TABLE 
   	[dbo].[MovFacturaCuotas]
   ADD 
	[saldo_anterior][decimal](18, 4) NULL
END
GO
 

 IF COL_LENGTH('[dbo].[MovFacturaCuotas]', 'interes') IS NULL
BEGIN
   ALTER TABLE 
   	[dbo].[MovFacturaCuotas]
   ADD 
	[interes][decimal](18, 4) NULL
END
GO
 

 IF COL_LENGTH('[dbo].[MovFacturaCuotas]', 'acapital') IS NULL
BEGIN
   ALTER TABLE 
   	[dbo].[MovFacturaCuotas]
   ADD 
	[acapital][decimal](18, 4) NULL
END
GO
 
 
 IF COL_LENGTH('[dbo].[MovFacturaCuotas]', 'porcentaje') IS NULL
BEGIN
   ALTER TABLE 
   	[dbo].[MovFacturaCuotas]
   ADD 
	[porcentaje][numeric](18, 0) NULL
END
GO
 
 IF COL_LENGTH('[dbo].[MovFacturaCuotas]', 'fecha_inicial') IS NULL
BEGIN
   ALTER TABLE 
   	[dbo].[MovFacturaCuotas]
   ADD 
	[fecha_inicial][VARCHAR](10) NULL
END
GO


  IF COL_LENGTH('[FIN].[LineasCreditos]', 'id_ctaantFianza') IS NULL
BEGIN
   ALTER TABLE 
	 [FIN].[LineasCreditos]
   ADD 
	[id_ctaantFianza] [bigint] NULL
END
GO

  IF COL_LENGTH('[FIN].[LineasCreditos]', 'ivaIncluido') IS NULL
BEGIN
   ALTER TABLE 
	 [FIN].[LineasCreditos]
   ADD 
	[ivaIncluido] [bit] NULL
END
GO
 
IF COL_LENGTH('[FIN].[LineasCreditos]', 'porcenIva') IS NULL
BEGIN
   ALTER TABLE 
	 [FIN].[LineasCreditos]
   ADD 
	[porcenIva] [numeric](18, 2) NULL
END
GO

UPDATE Menus SET estado = 1 WHERE nombrepagina IN ('Servicios Financieros', 'Lineas Credito')
GO

IF COL_LENGTH('[FIN].[LineasCreditos]', 'Porcentaje') IS NOT NULL
BEGIN
	ALTER TABLE [FIN].[LineasCreditos]
	ALTER COLUMN  [Porcentaje] [NUMERIC] (18,2) NULL
END

IF COL_LENGTH('[FIN].[SaldoCliente_Cuotas]', 'numfactura') IS NULL
BEGIN
   ALTER TABLE 
	 [FIN].[SaldoCliente_Cuotas]
   ADD 
	[numfactura] VARCHAR(30) NULL
END
GO

IF COL_LENGTH('[FIN].[SaldoCliente_Cuotas]', 'CuotaFianza') IS NULL
BEGIN
   ALTER TABLE 
	 [FIN].[SaldoCliente_Cuotas]
   ADD 
	[CuotaFianza] NUMERIC(18,2) NOT NULL DEFAULT (0)
END
GO

IF COL_LENGTH('[FIN].[SaldoCliente_Cuotas]', 'Valorfianza') IS NULL
BEGIN
   ALTER TABLE 
	 [FIN].[SaldoCliente_Cuotas]
   ADD 
	[Valorfianza] NUMERIC(18,2) NOT NULL DEFAULT (0)
END
GO

IF COL_LENGTH('[FIN].[SaldoCliente_Cuotas]', 'AbonoFianza') IS NULL
BEGIN
   ALTER TABLE 
	 [FIN].[SaldoCliente_Cuotas]
   ADD 
	[AbonoFianza] NUMERIC(18,2) NOT NULL DEFAULT (0)
END
GO

IF COL_LENGTH('[FIN].[SaldoCliente_Cuotas]', 'InteresCausado') IS NULL
BEGIN
   ALTER TABLE 
	 [FIN].[SaldoCliente_Cuotas]
   ADD 
	[InteresCausado] NUMERIC(18,2) NOT NULL DEFAULT (0)
END
GO

IF COL_LENGTH('[FIN].[SaldoCliente_Cuotas]', 'AbonoInteres') IS NULL
BEGIN
   ALTER TABLE 
	 [FIN].[SaldoCliente_Cuotas]
   ADD 
	[AbonoInteres] NUMERIC(18,2) NOT NULL DEFAULT (0)
END
GO

IF COL_LENGTH('[FIN].[SaldoCliente_Cuotas]', 'id_tercero') IS NULL
BEGIN
   ALTER TABLE 
	 [FIN].[SaldoCliente_Cuotas]
   ADD 
	[id_tercero] BIGINT NOT NULL DEFAULT (0)
END
GO

IF COL_LENGTH('[FIN].[SaldoCliente_Cuotas]', 'diasmora') IS NULL
BEGIN
   ALTER TABLE 
	 [FIN].[SaldoCliente_Cuotas]
   ADD 
	[diasmora] INT NOT NULL DEFAULT (0)
END
GO

IF COL_LENGTH('[FIN].[SaldoCliente_Cuotas]', 'diasintcorpagados') IS NULL
BEGIN
   ALTER TABLE 
	 [FIN].[SaldoCliente_Cuotas]
   ADD 
	[diasintcorpagados] INT NOT NULL DEFAULT (0)
END
GO


IF COL_LENGTH('[FIN].[SaldoCliente]', 'porcentaje') IS NOT NULL
BEGIN
	ALTER TABLE [FIN].SaldoCliente
	ALTER COLUMN  [porcentaje] [NUMERIC] (18,2) NULL
END

IF COL_LENGTH('[DBO].[MovFactura]', 'porintfin') IS  NULL
BEGIN
	ALTER TABLE [DBO].MovFactura
	ADD  [porintfin] [NUMERIC] (18,2) NOT NULL DEFAULT(0)
END

IF COL_LENGTH('[DBO].[MovFactura]', 'id_ctafin') IS  NULL
BEGIN
	ALTER TABLE [DBO].MovFactura
	ADD  [id_ctafin] [BIGINT] NULL;

	ALTER TABLE [DBO].MovFactura  WITH CHECK ADD  CONSTRAINT [FK_MovFactura_CuentaFinan] FOREIGN KEY([id_ctafin])
	REFERENCES [dbo].CNTCuentas ([id])
	
	ALTER TABLE [DBO].MovFactura CHECK CONSTRAINT [FK_MovFactura_CuentaFinan]
	
END

IF COL_LENGTH('[DBO].[MovFactura]', 'iscausacion') IS  NULL
BEGIN
	ALTER TABLE [DBO].MovFactura
	ADD  [iscausacion] BIT NOT NULL DEFAULT(0)
END

IF COL_LENGTH('[DBO].[MovFacturaCuotas]', 'porcentaje') IS NOT NULL
BEGIN
	ALTER TABLE [DBO].MovFacturaCuotas
	ALTER COLUMN  [porcentaje] [NUMERIC] (18,2) NULL
END

SET IDENTITY_INSERT [dbo].[Parametros] OFF 
GO
IF NOT EXISTS(select 1 from [dbo].[Parametros] where [codigo] = 'FECHAGESTION')
BEGIN
	DECLARE @cortegestion VARCHAR(6) = (SELECT MAX(anomes) FROM [CNT].[Periodos])
	INSERT [dbo].[Parametros] ([codigo], [nombre], [valor], [tipo], [created], [updated], [id_user], [default], [icon], [metadata], [fuente], [ancho], [orden], [campos], [seleccion], [params], [extratexto]) 
	VALUES (N'FECHAGESTION',  N'Fecha Corte Gestió', ISNULL(@cortegestion, '202101'), N'TEXT', GETDATE(), GETDATE(), 1, 1, N'<i class="fa fa-cog" aria-hidden="true"></i>', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
END
GO

IF NOT EXISTS(select 1 from [dbo].[Parametros] where [codigo] = 'DAYSCAUCATION')
BEGIN
	DECLARE @cortegestion VARCHAR(6) = (SELECT MAX(anomes) FROM [CNT].[Periodos])
	INSERT [dbo].[Parametros] ([codigo], [nombre], [valor], [tipo], [created], [updated], [id_user], [default], [icon], [metadata], [fuente], [ancho], [orden], [campos], [seleccion], [params], [extratexto]) 
	VALUES (N'DAYSCAUCATION',  N'Dias de diferencia para Caucacion', N'20', N'NUMERO', GETDATE(), GETDATE(), 1, 1, N'<i class="fa fa-cog" aria-hidden="true"></i>', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
END
GO

IF COL_LENGTH('[DBO].[MOVFacturaFormaPago]', 'codcuenta') IS NOT NULL
BEGIN
	ALTER TABLE [DBO].MOVFacturaFormaPago
	ALTER COLUMN  [codcuenta] BIGINT
END

IF COL_LENGTH('[DBO].[MOVFacturaFormaPago]', 'codcuenta') IS NOT NULL
BEGIN
	ALTER TABLE [DBO].MOVFacturaFormaPago
	ALTER COLUMN  [codcuenta] BIGINT
END

IF NOT EXISTS (SELECT 1 FROM FormaPagos WHERE codigo = 'FPC')
BEGIN
	INSERT INTO dbo.FormaPagos (codigo, nombre, id_tipo, id_typeFE, id_cuenta, voucher, id_usercreated, id_userupdated, [default])
	VALUES('FPC', 'A Credito', DBO.ST_FnGetIdList('CARTERA'), (SELECT TOP 1 id FROM ST_Listados WHERE codigo = 'TYPEFORMPAY' AND iden = '2'), NULL, 0, 1, 1, 1)
END
GO

IF COL_LENGTH('[DBO].[MOVFacturaItems]', 'descripcion') IS NULL
BEGIN
	ALTER TABLE [DBO].MOVFacturaItems
	ADD [descripcion] VARCHAR(300) NOT NULL DEFAULT('')
END

IF COL_LENGTH('[DBO].[MOVFacturaItems]', 'id_faccau') IS NULL
BEGIN
	ALTER TABLE [DBO].MOVFacturaItems
	ADD [id_faccau] BIGINT NULL 

	ALTER TABLE [DBO].MOVFacturaItems  WITH CHECK ADD  CONSTRAINT [FK_MOVFacturaItems_MOVFacturaCau] FOREIGN KEY([id_faccau])
	REFERENCES [dbo].MovFactura ([id])
	
	ALTER TABLE [DBO].MOVFacturaItems CHECK CONSTRAINT [FK_MOVFacturaItems_MOVFacturaCau]
END

IF COL_LENGTH('[DBO].[MOVFacturaItems]', 'cuota') IS NULL
BEGIN
	ALTER TABLE [DBO].MOVFacturaItems
	ADD [cuota] INT NOT NULL DEFAULT(0)
END

IF COL_LENGTH('[DBO].[MOVFacturaItemsTemp]', 'iscausacion') IS NULL
BEGIN
	ALTER TABLE [DBO].MOVFacturaItemsTemp
	ADD [iscausacion] BIT NOT NULL DEFAULT(0)
END


IF COL_LENGTH('[DBO].[MovDevFactura]', 'iscausacion') IS  NULL
BEGIN
	ALTER TABLE [DBO].MovDevFactura
	ADD  [iscausacion] BIT NOT NULL DEFAULT(0)
END

IF NOT EXISTS(SELECT TOP 1 1 FROM Productos WHERE codigo = 'INTCOR')
BEGIN
		INSERT INTO dbo.productos (codigo, codigobarra, nombre, presentacion, modelo, color, categoria, marca, impuesto, ivaincluido, id_iva, id_inc, 
		porcendescto, precio, serie, formulado, stock, id_usercreated,id_userupdated, urlimg, facturable, lote, tipoproducto, inventario, id_ctacontable, 
		id_tipodocu, id_naturaleza, esDescuento)
		VALUES('INTCOR', 'INTCOR', 'INTERESES PAGADOS', 'UND', '', '', NULL, NULL, 1, 0, NULL, NULL, 0,
		0, 0, 0, 0, 1, 1, '', 0, 0, DBO.ST_FnGetIdList('SERVICIOS'), 0, NULL, NULL, NULL, 0)

END
GO

IF NOT EXISTS(SELECT 1 FROM [dbo].[ST_Reportes] WHERE codigo = 'CARTERACLIENTE')
BEGIN
	SET IDENTITY_INSERT [dbo].[ST_Reportes] OFF 
	INSERT [dbo].[ST_Reportes] ([codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (N'CARTERACLIENTE', N'Contabilidad - Cartera Cliente', N'CarteraCliente.frx', 1, 1, GETDATE(), GETDATE(), 1, N'[CNT].[ST_Rpt_CarteraCliente]', N'')
END
GO
	
IF NOT EXISTS(SELECT 1 FROM [dbo].[ST_CamposReporte] WHERE id_reporte = (SELECT id FROM [dbo].[ST_Reportes] WHERE [codigo] = 'CARTERACLIENTE'))
BEGIN
	SET IDENTITY_INSERT [dbo].[ST_CamposReporte] OFF  
	INSERT [dbo].[ST_CamposReporte] ([parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) 
	VALUES (N'anomes', N'ANOMES', N'Año Mes', N'date', N'', 2, 2, N'', N'', N'',(SELECT id FROM [dbo].[ST_Reportes] WHERE [codigo] = 'CARTERACLIENTE'), 1, 1, GETDATE(), GETDATE(), 1, N''),
	 (N'idTercero', N'TERCERO', N'Cliente', N'search', N'CNTTerceros', 4, 4, N'CNTTercerosListTipo', N'id,tercompleto', N'1,2', (SELECT id FROM [dbo].[ST_Reportes] WHERE [codigo] = 'CARTERACLIENTE'), 1, 0, GETDATE(), GETDATE(), 1, N'tipoter;CL|')
END
GO
	
IF NOT EXISTS(SELECT 1 FROM [dbo].[ST_Reportes] WHERE codigo = 'CARTERAPROVEEDOR')
BEGIN
	 SET IDENTITY_INSERT [dbo].[ST_Reportes] OFF 
	 INSERT [dbo].[ST_Reportes] ([codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) 
	 VALUES (N'CARTERAPROVEEDOR', N'Contabilidad - Cartera Proveedor', N'CarteraProveedor.frx', 1, 1, GETDATE(), GETDATE(), 1, N'[CNT].[ST_Rpt_CarteraCliente]', N'')	
END
GO
IF NOT EXISTS(SELECT 1 FROM [dbo].[ST_CamposReporte] WHERE id_reporte = (SELECT id FROM [dbo].[ST_Reportes] WHERE [codigo] = 'CARTERAPROVEEDOR'))
BEGIN
	SET IDENTITY_INSERT [dbo].[ST_CamposReporte] OFF  
	INSERT [dbo].[ST_CamposReporte] ([parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) 
	VALUES (N'anomes', N'ANOMES', N'Año Mes', N'date', N'', 2, 2, N'', N'', N'',(SELECT id FROM [dbo].[ST_Reportes] WHERE [codigo] = 'CARTERAPROVEEDOR'), 1, 1, GETDATE(), GETDATE(), 1, N''),
	(N'idTercero', N'TERCERO', N'Proveedor', N'search', N'CNTTerceros', 4, 4, N'CNTTercerosListTipo', N'id,tercompleto', N'1,2', (SELECT id FROM [dbo].[ST_Reportes] WHERE [codigo] = 'CARTERAPROVEEDOR'), 1, 0, GETDATE(), GETDATE(), 1, N'tipoter;PR|')
END
GO

INSERT INTO [dbo].[aspnet_RolesInReports](id_reporte, id_perfil, id_user)
VALUES((SELECT id FROM [dbo].[ST_Reportes] WHERE [codigo] = 'CARTERACLIENTE'), 1, 1), 
	  ((SELECT id FROM [dbo].[ST_Reportes] WHERE [codigo] = 'CARTERACLIENTE'), 2, 1),
	  ((SELECT id FROM [dbo].[ST_Reportes] WHERE [codigo] = 'CARTERAPROVEEDOR'), 1, 1), 
	  ((SELECT id FROM [dbo].[ST_Reportes] WHERE [codigo] = 'CARTERAPROVEEDOR'), 2, 1)
	
