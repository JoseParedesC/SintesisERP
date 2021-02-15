--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'inicial' AND TABLE_NAME = 'Solicitudes')
BEGIN
	ALTER TABLE [CRE].[Solicitudes] ADD [inicial] NUMERIC(18,2)
END

IF NOT EXISTS(SELECT 1 FROM [dbo].[Menus] WHERE nombrepagina='Historial de Solicitudes')
BEGIN
INSERT INTO [dbo].[Menus]([nombrepagina],[estado],[pathpagina],[id_padre],[descripcion],[orden],[padre],[icon],[id_usuario],[created])
VALUES('Historial de Solicitudes',	1,	'historialSol.aspx', (SELECT id FROM [dbo].[Menus] WHERE nombrepagina = 'Credito'),	'Maestro de Historial', 6, 0, 'fa-th-large', 1, GETDATE())
END

IF NOT EXISTS (SELECT 1 FROM [dbo].[MenusPerfiles] WHERE [id_menu] = (select id from [dbo].[Menus] where nombrepagina = 'Historial de Solicitudes' ))
BEGIN
INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
		   ,[id_menu]
           ,[id_user])
     VALUES
           (1,
		   (select id from [dbo].[Menus] where nombrepagina = 'Historial de Solicitudes' )
           ,1)

INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
		   ,[id_menu]
           ,[id_user])
     VALUES
           (2,
		   (select id from [dbo].[Menus] where nombrepagina = 'Historial de Solicitudes' )
           ,1)

END

IF OBJECT_ID('dbo.ArticulosFormula', 'U') IS NOT NULL 
  DROP TABLE dbo.ArticulosFormula;
GO
If NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[Productos_Formulados]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
	CREATE TABLE [dbo].[Productos_Formulados](
		[id] [bigint] IDENTITY(1,1) NOT NULL,
		[created] [smalldatetime] NOT NULL CONSTRAINT [DF_Productos_Formulados_created]  DEFAULT (getdate()),
		[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_Productos_Formulados_updated]  DEFAULT (getdate()),
		[id_user] [bigint] NOT NULL,
		[id_producto] [bigint] NOT NULL,
		[cantidad] [numeric](18, 2) NOT NULL,
		[id_item] [bigint] NOT NULL,
	 CONSTRAINT [PK_Productos_Formulados] PRIMARY KEY CLUSTERED 
	(
		[id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
GO
ALTER TABLE [dbo].[Productos_Formulados]  WITH CHECK ADD  CONSTRAINT [FK_Productos_Formulados_Productos] FOREIGN KEY([id_item])
REFERENCES [dbo].[Productos] ([id])
GO
ALTER TABLE [dbo].[Productos_Formulados] CHECK CONSTRAINT [FK_Productos_Formulados_Productos]
GO
ALTER TABLE [dbo].[Productos_Formulados]  WITH CHECK ADD  CONSTRAINT [FK_Productos_Formulados_Productos1] FOREIGN KEY([id_producto])
REFERENCES [dbo].[Productos] ([id])
GO
ALTER TABLE [dbo].[Productos_Formulados] CHECK CONSTRAINT [FK_Productos_Formulados_Productos1]
GO

If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[MOVConversionesItemsForm]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
	DROP TABLE [dbo].[MOVConversionesItemsForm]
END
GO

If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[MOVConversionesItems]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
	DROP TABLE [dbo].[MOVConversionesItems]
END
GO

If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[MOVConversiones]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
	DROP TABLE [dbo].[MOVConversiones]
END
GO

/*TABLA MOVCONVERSIONES*/
If NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[MOVConversiones]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
	CREATE TABLE [dbo].[MOVConversiones](
		[id] [bigint] IDENTITY(1,1) NOT NULL,
		[fechadocumen] [smalldatetime] NOT NULL,
		[estado] [int] NOT NULL,
		[id_reversion] [bigint] NULL,
		[created] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVConversiones_created]  DEFAULT (getdate()),
		[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVConversiones_updated]  DEFAULT (getdate()),
		[id_user] [int] NOT NULL,
		[id_bodegadef] [bigint] NULL,
		[id_centrocosto] [bigint] NULL,
		[contabilizado] [bit] NULL,
		[costo] [numeric](18, 2) NULL,
	 CONSTRAINT [PK_MOVConversiones] PRIMARY KEY CLUSTERED 
	(
		[id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[MOVConversionesItems]    Script Date: 28/01/2021 16:06:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
If NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[MOVConversionesItems]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
	CREATE TABLE [dbo].[MOVConversionesItems](
		[id] [bigint] IDENTITY(1,1) NOT NULL,
		[id_conversion] [bigint] NOT NULL,
		[id_articulo] [bigint] NOT NULL,
		[id_bodega] [bigint] NOT NULL,
		[serie] [bit] NOT NULL DEFAULT(0),
		[cantidad] [numeric](18, 2) NOT NULL,
		[costo] [numeric](18, 4) NOT NULL,
		[costototal] [numeric](18, 4) NOT NULL CONSTRAINT [DF_MOVConversionesItems_costototal]  DEFAULT ((0)),
		[created] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVConversionesItems_created]  DEFAULT (getdate()),
		[id_user] [int] NOT NULL,
	 CONSTRAINT [PK_MOVConversionesItems] PRIMARY KEY CLUSTERED 
	(
		[id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[MOVConversionesItemsForm]    Script Date: 28/01/2021 16:06:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
If NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[MOVConversionesItemsForm]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
	CREATE TABLE [dbo].[MOVConversionesItemsForm](
		[id] [bigint] IDENTITY(1,1) NOT NULL,
		[id_conversion] [bigint] NOT NULL,
		[id_articulofac] [bigint] NOT NULL,
		[id_articulo] [bigint] NOT NULL,
		[serie] [bit] NOT NULL,
		[id_lote] [bigint] NULL,
		[id_bodega] [bigint] NOT NULL,
		[cantidad] [numeric](18, 2) NOT NULL,
		[costo] [numeric](18, 4) NOT NULL CONSTRAINT [DF_MOVConversionesItems_costoForm]  DEFAULT ((0)),
		[created] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVConversionesItems_createdForm]  DEFAULT (getdate()),
		[id_user] [int] NOT NULL,
	 CONSTRAINT [PK_MOVConversionesItemsForm] PRIMARY KEY CLUSTERED 
	(
		[id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MOVConversionesItemsSeries]    Script Date: 28/01/2021 16:06:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
If NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[MOVConversionesItemsSeries]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
	CREATE TABLE [dbo].[MOVConversionesItemsSeries](
		[id] [bigint] IDENTITY(1,1) NOT NULL,
		[id_conversion] [bigint] NOT NULL,
		[id_producto] [bigint] NOT NULL,
		[serie] [varchar](200) NOT NULL,
		[created] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVConversionesItemsSeries_created]  DEFAULT (getdate()),
		[id_user] [bigint] NOT NULL,
	 CONSTRAINT [PK_MOVConversionesItemsSeries] PRIMARY KEY CLUSTERED 
	(
		[id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MOVConversionesItemsSeriesForm]    Script Date: 28/01/2021 16:06:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
If NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[MOVConversionesItemsSeriesForm]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
	CREATE TABLE [dbo].[MOVConversionesItemsSeriesForm](
		[id] [bigint] IDENTITY(1,1) NOT NULL,
		[id_conversion] [bigint] NOT NULL,
		[id_producto] [bigint] NOT NULL,
		[serie] [varchar](200) NOT NULL,
		[created] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVConversionesItemsSeriesForm_created]  DEFAULT (getdate()),
		[id_user] [bigint] NOT NULL,
	 CONSTRAINT [PK_MOVConversionesItemsSeriesForm] PRIMARY KEY CLUSTERED 
	(
		[id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[MOVConversiones]  WITH CHECK ADD  CONSTRAINT [FK_MOVConversiones_MOVConversiones] FOREIGN KEY([id_reversion])
REFERENCES [dbo].[MOVConversiones] ([id])
GO
ALTER TABLE [dbo].[MOVConversiones] CHECK CONSTRAINT [FK_MOVConversiones_MOVConversiones]
GO
ALTER TABLE [dbo].[MOVConversionesItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVConversionesItems_Articulos] FOREIGN KEY([id_articulo])
REFERENCES [dbo].[Productos] ([id])
GO
ALTER TABLE [dbo].[MOVConversionesItems] CHECK CONSTRAINT [FK_MOVConversionesItems_Articulos]
GO
ALTER TABLE [dbo].[MOVConversionesItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVConversionesItems_Bodegas] FOREIGN KEY([id_bodega])
REFERENCES [dbo].[Bodegas] ([id])
GO
ALTER TABLE [dbo].[MOVConversionesItems] CHECK CONSTRAINT [FK_MOVConversionesItems_Bodegas]
GO
ALTER TABLE [dbo].[MOVConversionesItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVConversionesItems_MOVConversiones] FOREIGN KEY([id_conversion])
REFERENCES [dbo].[MOVConversiones] ([id])
GO
ALTER TABLE [dbo].[MOVConversionesItems] CHECK CONSTRAINT [FK_MOVConversionesItems_MOVConversiones]
GO
ALTER TABLE [dbo].[MOVConversionesItemsForm]  WITH CHECK ADD  CONSTRAINT [FK_MOVConversionesItemsForm_Articulos] FOREIGN KEY([id_articulo])
REFERENCES [dbo].[Productos] ([id])
GO
ALTER TABLE [dbo].[MOVConversionesItemsForm] CHECK CONSTRAINT [FK_MOVConversionesItemsForm_Articulos]
GO
ALTER TABLE [dbo].[MOVConversionesItemsForm]  WITH CHECK ADD  CONSTRAINT [FK_MOVConversionesItemsForm_Bodegas] FOREIGN KEY([id_bodega])
REFERENCES [dbo].[Bodegas] ([id])
GO
ALTER TABLE [dbo].[MOVConversionesItemsForm] CHECK CONSTRAINT [FK_MOVConversionesItemsForm_Bodegas]
GO
ALTER TABLE [dbo].[MOVConversionesItemsForm]  WITH CHECK ADD  CONSTRAINT [FK_MOVConversionesItemsForm_MOVConversiones] FOREIGN KEY([id_conversion])
REFERENCES [dbo].[MOVConversiones] ([id])
GO
ALTER TABLE [dbo].[MOVConversionesItemsForm] CHECK CONSTRAINT [FK_MOVConversionesItemsForm_MOVConversiones]
GO
ALTER TABLE [dbo].[MOVConversionesItemsForm]  WITH CHECK ADD  CONSTRAINT [FK_MOVConversionesItemsForm_MOVConversionesItems] FOREIGN KEY([id_articulofac])
REFERENCES [dbo].[MOVConversionesItems] ([id])
GO
ALTER TABLE [dbo].[MOVConversionesItemsForm] CHECK CONSTRAINT [FK_MOVConversionesItemsForm_MOVConversionesItems]
GO
ALTER TABLE [dbo].[MOVConversionesItemsSeries]  WITH CHECK ADD  CONSTRAINT [FK_MOVConversionesItemsSeries_MOVConversiones] FOREIGN KEY([id_conversion])
REFERENCES [dbo].[MOVConversiones] ([id])
GO
ALTER TABLE [dbo].[MOVConversionesItemsSeries] CHECK CONSTRAINT [FK_MOVConversionesItemsSeries_MOVConversiones]
GO
ALTER TABLE [dbo].[MOVConversionesItemsSeries]  WITH CHECK ADD  CONSTRAINT [FK_MOVConversionesItemsSeries_MOVConversionesItems] FOREIGN KEY([id_producto])
REFERENCES [dbo].[MOVConversionesItems] ([id])
GO
ALTER TABLE [dbo].[MOVConversionesItemsSeries] CHECK CONSTRAINT [FK_MOVConversionesItemsSeries_MOVConversionesItems]
GO
ALTER TABLE [dbo].[MOVConversionesItemsSeriesForm]  WITH CHECK ADD  CONSTRAINT [FK_MOVConversionesItemsSeriesForm_MOVConversionesItemsForm] FOREIGN KEY([id_producto])
REFERENCES [dbo].[MOVConversionesItemsForm] ([id])
GO
ALTER TABLE [dbo].[MOVConversionesItemsSeriesForm] CHECK CONSTRAINT [FK_MOVConversionesItemsSeriesForm_MOVConversionesItemsForm]
GO

/*INSERT KMARTINEZ*/
IF NOT EXISTS(SELECT 1 FROM [dbo].[ST_Reportes] WHERE codigo = 'REFINANAMORTIZACION')
BEGIN
	INSERT [dbo].[ST_Reportes] ([codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) 
	VALUES (N'REFINANAMORTIZACION', N'RefinanAmortizacion', N'AmortizacionRefinan.frx', 0, 1, GETDATE(), GETDATE(), 1, N'[CNT].[ST_Rpt_RefinanCuotaAmortizacion]', N'')
END
GO

IF NOT EXISTS(SELECT 1 FROM [dbo].[Menus] WHERE nombrepagina='Refinanciacion')
BEGIN
 INSERT [dbo].[Menus] ([nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) 
 VALUES (N'Refinanciacion', 1, N'Refinanciacion.aspx', (SELECT id FROM [dbo].[Menus] WHERE nombrepagina = 'Financiero'), N'Refinanciacion', 4, 0, N'fa-th-large', 1, GETDATE())
END
GO

IF NOT EXISTS (SELECT 1 FROM [dbo].[MenusPerfiles] WHERE [id_menu] = (select id from [dbo].[Menus] where nombrepagina = 'Refinanciacion' ))
BEGIN

	INSERT [dbo].[MenusPerfiles] ([id_perfil], [id_menu], [created], [updated], [id_user]) 
	VALUES ( 1,  (select id from [dbo].[Menus] where nombrepagina = 'Refinanciacion' ), GETDATE(), GETDATE(), 1),
	 ( 2, (select id from [dbo].[Menus] where nombrepagina = 'Refinanciacion' ), GETDATE(), GETDATE(), 1)
END
GO

If NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FIN].[RefinanciacionItems]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
	CREATE TABLE [FIN].[RefinanciacionItems](
		[id] [bigint] IDENTITY(1,1) NOT NULL,
		[id_refinan] [bigint] NULL,
		[id_cliente] [bigint] NULL,
		[id_factura] [bigint] NOT NULL,
		[numfactura] [varchar](30) NULL,
		[new] [bit] NULL,
		[cuota] [int] NOT NULL,
		[valorcuota] [numeric](18, 2) NOT NULL,
		[saldo] [numeric](18, 2) NOT NULL,
		[saldo_anterior] [numeric](18, 2) NOT NULL,
		[interes] [numeric](18, 2) NOT NULL,
		[acapital] [numeric](18, 2) NOT NULL,
		[valorFianza] [numeric](18, 2) NULL,
		[tasaanual] [numeric](18, 2) NULL,
		[porcentaje] [numeric](18, 2) NOT NULL,
		[fecha_inicial] [varchar](10) NOT NULL,
		[vencimiento] [varchar](10) NOT NULL,
		[fecha_pagointeres] [varchar](10) NOT NULL,
		[created] [smalldatetime] NOT NULL CONSTRAINT [DF_RefinanciacionItems_created]  DEFAULT (getdate()),
		[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_RefinanciacionItems_updated]  DEFAULT (getdate())
	) ON [PRIMARY]
END
GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [FIN].[RefinanciacionFact]    Script Date: 27/01/2021 16:58:14 ******/
 
IF NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FIN].[RefinanciacionFact]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
	CREATE TABLE [FIN].[RefinanciacionFact](
		[id] [bigint] IDENTITY(1,1) NOT NULL,
		[id_tipodoc] [bigint] NOT NULL,
		[id_centrocostos] [bigint] NOT NULL,
		[fechadoc] [smalldatetime] NOT NULL,
		[id_cliente] [bigint] NOT NULL,
		[id_factura] [bigint] NOT NULL,
		[numfactura] [varchar](30) NULL,
		[totalcredito] [numeric](18, 2) NOT NULL,
		[cuotas] [int] NOT NULL,
		[formapago] [int] NOT NULL,
		[estado] [int] NULL,
		[id_reversion] [bigint] NULL,
		[created] [smalldatetime] NOT NULL CONSTRAINT [DF_RefinanciacionFact_created]  DEFAULT (getdate()),
		[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_RefinanciacionFact_updated]  DEFAULT (getdate()),
		[id_user] [int] NOT NULL
	) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO



IF COL_LENGTH('[FIN].[SaldoCliente_Cuotas]', 'id_refinanciado') IS NULL
BEGIN
	ALTER TABLE 
		[FIN].[SaldoCliente_Cuotas]
	ADD 
		[id_refinanciado][BIGINT] NULL 
END
GO

IF NOT EXISTS(SELECT 1 FROM [dbo].[ST_Reportes] WHERE codigo = 'MOVAMORTIZACION')
BEGIN
	SET IDENTITY_INSERT [dbo].[ST_Reportes] OFF 
	INSERT [dbo].[ST_Reportes] ([codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (N'MOVAMORTIZACION', N'FinanAmortizacion', N'Amortizacion.frx', 0, 1, GETDATE(), GETDATE(), 1, N'[CNT].[ST_Rpt_Amortizacion]', N'')
 
 END
 
 IF COL_LENGTH('[FIN].[LineasCreditos]', 'Tasaanual') IS NULL
BEGIN
	ALTER TABLE 
		[FIN].[LineasCreditos]
	ADD 
		[Tasaanual][NUMERIC](18,2) NOT NULL DEFAULT(25.98) 
END
GO
 IF COL_LENGTH('[FIN].[SaldoCliente_Cuotas]', 'estado') IS NULL
BEGIN
	ALTER TABLE 
		[FIN].[SaldoCliente_Cuotas]
	ADD 
		[estado][BIT] NOT NULL DEFAULT(1) 
END
GO

IF COL_LENGTH('[FIN].[SaldoCliente_Cuotas]', 'Tasaanual') IS NULL
BEGIN
	ALTER TABLE 
		[FIN].[SaldoCliente_Cuotas]
	ADD 
		[Tasaanual][NUMERIC](18,2) NOT NULL DEFAULT(25.98) 
END
GO

IF COL_LENGTH('[FIN].[RefinanciacionFact]', 'id_cuenta') IS NULL
BEGIN
   ALTER TABLE 
   	[FIN].[RefinanciacionFact]
   ADD 
	[id_cuenta] [BIGINT]
END
GO

IF COL_LENGTH('[FIN].[RefinanciacionFact]', 'valorintmora') IS NULL
BEGIN
   ALTER TABLE 
   	[FIN].[RefinanciacionFact]
   ADD 
	[valorintmora] [NUMERIC](18, 2) NOT NULL DEFAULT(0)
END
GO


UPDATE Menus SET estado = 1 WHERE nombrepagina = 'Recaudo Cartera'
GO
UPDATE Menus SET estado = 0 WHERE nombrepagina = 'Servicios Financieros'
GO
UPDATE Menus SET estado = 1, descripcion = 'Conversión de Articulo' WHERE pathpagina = 'conversionarticulos.aspx'
GO

IF NOT EXISTS(SELECT 1 FROM [dbo].[ST_Reportes] WHERE codigo = 'MOVCAJA')
BEGIN
	DECLARE @id_return BIGINT

	INSERT INTO [dbo].[ST_Reportes] ([codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) 
			VALUES ( 'MOVCAJA', 'Movimientos de Caja', N'MovimientosCaja.frx', 1, 1, '20210129 16:32', '20210129 16:32', 1, NULL, '')

	SET @id_return = SCOPE_IDENTITY();

	INSERT INTO [dbo].[ST_CamposReporte]
		(parametro, codigo, nombre, tipo, fuente, ancho, orden, metadata, campos, seleccion, id_reporte, estado, requerido, id_user)
	VALUES
		('fechaini', 'FECHAINI', 'Fecha inicial', 'date', '', 2, 1, '', '', '', @id_return, 1, 1, 1),
		('fechafin', 'FECHAFIN', 'Fecha fin', 'date', '', 2, 2, '', '', '', @id_return, 1, 1, 1),
		('cuenta_inicial', 'CUENTAINI', 'Cuenta Inicial', 'search', 'CNTCuentas', 3, 3, 'CNTCuentasDetalle', 'id,codigo,nombre', '1,2', @id_return, 1, 1, 1),
		('cuenta_final', 'CUENTAFIN', 'Cuenta Final', 'search', 'CNTCuentas', 3, 4, 'CNTCuentasDetalle', 'id,codigo,nombre', '1,2', @id_return, 1, 1, 1) 
END

INSERT [dbo].[aspnet_RolesInReports] ([id_reporte], [id_perfil],
[created], [updated], [id_user])
     VALUES (@id_return, 1, CAST(N'20201205 16:26:00' AS SmallDateTime),
CAST(N'20201205 16:26:00' AS SmallDateTime), 1)

     INSERT [dbo].[aspnet_RolesInReports] ([id_reporte], [id_perfil],
[created], [updated], [id_user])
     VALUES (@id_return, 2, CAST(N'20201205 16:26:00' AS SmallDateTime),
CAST(N'20201205 16:26:00' AS SmallDateTime), 1)

GO
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS i WHERE COLUMN_NAME = 'id_bodegadef' AND TABLE_NAME = 'MOVConversiones')
	ALTER TABLE [dbo].[MOVConversiones] add [id_bodegadef] [bigint] NULL
GO
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS i WHERE COLUMN_NAME = 'id_centrocosto' AND TABLE_NAME = 'MOVConversiones')
	ALTER TABLE [dbo].[MOVConversiones] add [id_centrocosto] [bigint] NULL
GO

UPDATE Menus SET orden = 2 WHERE nombrepagina = 'Contabilidad'
GO
UPDATE Menus SET orden = 3 WHERE nombrepagina = 'Financiero'
GO
UPDATE Menus SET orden = 4 WHERE nombrepagina = 'Cartera'
GO
UPDATE Menus SET orden = 5 WHERE nombrepagina = 'Credito'
GO
UPDATE Menus SET orden = 6 WHERE nombrepagina = 'Informes'
GO
UPDATE Menus SET orden = 7 WHERE nombrepagina = 'Seguridad del Sistema'
GO
UPDATE Menus SET orden = 8 WHERE nombrepagina like 'Parametrizaci%'
GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS i WHERE COLUMN_NAME = 'id_tipodoc' AND TABLE_NAME = 'MOVConversiones')
ALTER TABLE [dbo].[MOVConversiones] add id_tipodoc BIGINT
GO
IF NOT EXISTS (SELECT 1 FROM [dbo].[Parametros] WHERE codigo = 'SINTESISVERSION')
BEGIN
	INSERT [dbo].[Parametros] ([codigo], [nombre], [valor], [tipo], [created], [updated], [id_user], [default]) 
	VALUES (N'SINTESISVERSION', N'Sintesis Cloud Version', N'Version 1.2.1', N'TEXT', CAST(N'20171125 13:44:00' AS SmallDateTime), CAST(N'20171125 13:44:00' AS SmallDateTime), 1, 1)
END
GO

UPDATE M
	SET M.orden = 1
FROM [dbo].[Menus] M WHERE [nombrepagina] = 'Solicitud credito'
GO
UPDATE M
	SET M.orden = 2
FROM [dbo].[Menus] M WHERE [nombrepagina] = 'Analisis'
GO
UPDATE M
	SET M.orden = 3
FROM [dbo].[Menus] M WHERE [nombrepagina] = 'Analisis Excepcionado'
GO
UPDATE M
	SET M.orden = 4
FROM [dbo].[Menus] M WHERE [nombrepagina] = 'Historial de Solicitudes'
GO