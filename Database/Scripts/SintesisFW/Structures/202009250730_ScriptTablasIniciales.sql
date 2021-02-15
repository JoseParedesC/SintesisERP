--liquibase formatted sql
--changeset jtous:1 dbms:mssql endDelimiter:GO
/****** Object:  Table [CNT].[CentroCosto]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [CNT].[CentroCosto](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[subcodigo] [varchar](3) NOT NULL,
	[codigo] [varchar](20) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[id_padre] [varchar](20) NOT NULL CONSTRAINT [DF_CentroCosto_id_padre]  DEFAULT (''),
	[detalle] [bit] NULL,
	[estado] [bit] NOT NULL CONSTRAINT [DF_CentroCosto_estado]  DEFAULT ((1)),
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_CentroCosto_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_CentroCosto_updated]  DEFAULT (getdate()),
	[id_usercreated] [bigint] NOT NULL,
	[id_userupdated] [bigint] NOT NULL,
	[indice] [int] NOT NULL,
	[idparent] [bigint] NULL,
 CONSTRAINT [PK_CentroCosto] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_CentroCosto] UNIQUE NONCLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [CNT].[Impuestos]    Script Date: 22/11/2020 6:37:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [CNT].[Impuestos](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[codigo] [varchar](8) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[id_tipoimp] [int] NOT NULL,
	[valor] [numeric](18, 2) NOT NULL,
	[id_ctaventa] [bigint] NOT NULL,
	[id_ctadevVenta] [bigint] NOT NULL,
	[id_ctacompra] [bigint] NOT NULL,
	[id_ctadevcompra] [bigint] NOT NULL,
	[estado] [bit] NOT NULL CONSTRAINT [DF_TipoImpuestos_estado]  DEFAULT ((1)),
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_TipoImpuestos_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_TipoImpuestos_updated]  DEFAULT (getdate()),
	[id_usercreated] [bigint] NOT NULL,
	[id_userupdated] [bigint] NULL,
 CONSTRAINT [PK_TipoImpuestos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_TipoImpuestos] UNIQUE NONCLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [CNT].[ImpuestosTipoImpuestos]    Script Date: 22/11/2020 6:37:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CNT].[ImpuestosTipoImpuestos](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_tipoimpuesto] [bigint] NOT NULL,
	[id_cuenta] [bigint] NOT NULL,
	[tarifa] [decimal](5, 2) NOT NULL,
	[categoria] [int] NULL,
	[estado] [bit] NOT NULL,
	[created] [smalldatetime] NOT NULL,
	[updated] [smalldatetime] NOT NULL,
	[id_usercreated] [bigint] NOT NULL,
	[id_userupdated] [bigint] NOT NULL,
 CONSTRAINT [PK_impuestos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [CNT].[MOVComprobanteEgresoFormaPago]    Script Date: 22/11/2020 6:21:32 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [CNT].[MOVComprobanteEgresoFormaPago](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_comprobante] [bigint] NOT NULL,
	[id_formapago] [bigint] NOT NULL,
	[voucher] [varchar](100) NOT NULL,
	[valor] [numeric](18, 2) NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVComprobanteEgresoFormaPago_created]  DEFAULT (getdate()),
	[id_user] [int] NOT NULL,
	[codcuenta] [bigint] NOT NULL,
 CONSTRAINT [PK_MOVComprobanteEgresoFormaPago] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [CNT].[MOVComprobantesContables]    Script Date: 22/11/2020 6:21:32 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [CNT].[MOVComprobantesContables](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[fecha] [smalldatetime] NOT NULL,
	[id_documento] [bigint] NULL,
	[id_centrocosto] [bigint] NULL,
	[detalle] [varchar](max) NOT NULL,
	[estado] [bigint] NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVComprobantesContables_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVComprobantesContables_updated]  DEFAULT (getdate()),
	[id_usercreated] [bigint] NOT NULL,
	[id_userupdated] [bigint] NOT NULL,
	[id_reversion] [bigint] NULL,
 CONSTRAINT [PK_MOVComprobantesContables] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [CNT].[MOVComprobantesContablesItems]    Script Date: 22/11/2020 6:21:32 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [CNT].[MOVComprobantesContablesItems](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_comprobante] [bigint] NOT NULL,
	[id_concepto] [bigint] NULL,
	[id_cuenta] [bigint] NOT NULL,
	[id_tercero] [bigint] NOT NULL,
	[factura] [varchar](50) NULL,
	[fechavencimiento] [smalldatetime] NULL,
	[detalle] [varchar](max) NULL,
	[valor] [numeric](18, 4) NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVComprobantesContablesItems_created]  DEFAULT (getdate()),
	[id_usercreated] [bigint] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [CNT].[MOVComprobantesContablesTemp]    Script Date: 22/11/2020 6:21:32 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [CNT].[MOVComprobantesContablesTemp](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[fecha] [smalldatetime] NULL,
	[detalle] [varchar](max) NULL,
	[estado] [bigint] NULL,
	[created] [smalldatetime] NULL CONSTRAINT [DF_MOVComprobantesContablesTemp_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NULL CONSTRAINT [DF_MOVComprobantesContablesTemp_updated]  DEFAULT (getdate()),
	[id_usercreated] [bigint] NULL,
	[id_userupdated] [bigint] NULL,
 CONSTRAINT [PK_MOVComprobantesContablesTemp] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [CNT].[MOVComprobantesEgresos]    Script Date: 22/11/2020 6:21:32 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [CNT].[MOVComprobantesEgresos](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_tipodoc] [bigint] NOT NULL,
	[id_centrocosto] [bigint] NULL,
	[fecha] [smalldatetime] NULL,
	[id_proveedor] [bigint] NOT NULL,
	[valorpagado] [numeric](18, 2) NOT NULL,
	[valorconcepto] [numeric](18, 2) NULL,
	[cambio] [numeric](18, 2) NULL,
	[detalle] [varchar](max) NULL,
	[estado] [int] NULL,
	[id_reversion] [bigint] NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_PagoProveedores_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_PagoProveedores_updated]  DEFAULT (getdate()),
	[id_usercreated] [bigint] NOT NULL,
	[id_userupdated] [bigint] NOT NULL,
 CONSTRAINT [PK_PagoProveedores] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [CNT].[MOVComprobantesEgresosConcepto]    Script Date: 22/11/2020 6:21:32 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CNT].[MOVComprobantesEgresosConcepto](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_comprobante] [bigint] NOT NULL,
	[id_concepto] [bigint] NOT NULL,
	[valor] [numeric](18, 2) NOT NULL,
	[created] [smalldatetime] NOT NULL,
	[id_usercreated] [bigint] NOT NULL,
 CONSTRAINT [PK_MOVComprobantesEgresosConcepto] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [CNT].[MOVComprobantesEgresosItems]    Script Date: 22/11/2020 6:21:32 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [CNT].[MOVComprobantesEgresosItems](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_comprobante] [bigint] NOT NULL,
	[id_documento] [bigint] NOT NULL,
	[nrofactura] [varchar](50) NOT NULL,
	[valor] [numeric](18, 2) NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_PagoProveedoresItems_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_PagoProveedoresItems_updated]  DEFAULT (getdate()),
	[id_usercreated] [bigint] NOT NULL,
 CONSTRAINT [PK_PagoProveedoresItems] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [CNT].[MOVComprobantesItemsTemp]    Script Date: 22/11/2020 6:21:32 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [CNT].[MOVComprobantesItemsTemp](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_comprobante] [bigint] NOT NULL,
	[id_concepto] [bigint] NULL,
	[id_cuenta] [bigint] NOT NULL,
	[id_tercero] [bigint] NOT NULL,
	[factura] [varchar](50) NULL,
	[fechavencimiento] [smalldatetime] NULL,
	[detalle] [varchar](max) NULL,
	[valor] [numeric](18, 4) NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVComprobantesItemsTemp_created]  DEFAULT (getdate()),
	[id_usercreated] [bigint] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

/****** Object:  Table [CNT].[MOVReciboCajas]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [CNT].[MOVReciboCajas](
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
	[created] [smalldatetime] NOT NULL,
	[updated] [smalldatetime] NOT NULL,
	[id_usercreated] [bigint] NOT NULL,
	[id_userupdated] [bigint] NOT NULL,
 CONSTRAINT [PK_MOVReciboCajas] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [CNT].[MOVReciboCajasConcepto]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CNT].[MOVReciboCajasConcepto](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_recibo] [bigint] NOT NULL,
	[id_concepto] [bigint] NOT NULL,
	[valor] [numeric](18, 2) NOT NULL,
	[created] [smalldatetime] NOT NULL,
	[id_usercreated] [bigint] NOT NULL,
 CONSTRAINT [PK_MovReciboCajasConcepto] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [CNT].[MOVReciboCajasFormaPago]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [CNT].[MOVReciboCajasFormaPago](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_recibo] [bigint] NOT NULL,
	[id_formapago] [bigint] NOT NULL,
	[voucher] [varchar](100) NOT NULL,
	[valor] [numeric](18, 2) NOT NULL,
	[created] [smalldatetime] NOT NULL,
	[id_user] [int] NOT NULL,
	[codcuenta] [bigint] NOT NULL,
 CONSTRAINT [PK_MOVReciboCajasFormaPago] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [CNT].[MOVReciboCajasItems]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [CNT].[MOVReciboCajasItems](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_recibo] [bigint] NOT NULL,
	[id_factura] [varchar](50) NULL,
	[id_cuota] [bigint] NULL,
	[valorCuota] [numeric](18, 2) NULL,
	[pagoCuota] [numeric](18, 2) NULL,
	[porceInteres] [numeric](18, 2) NULL,
	[pagoInteres] [numeric](18, 2) NULL,
	[totalpagado] [numeric](18, 2) NULL,
	[vencimiento_interes] [varchar](10) NULL,
	[created] [smalldatetime] NOT NULL,
	[id_user] [bigint] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [CNT].[SaldoAnticipos]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [CNT].[SaldoAnticipos](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_cuenta] [bigint] NOT NULL,
	[id_tercero] [bigint] NOT NULL,
	[anomes] [varchar](7) NOT NULL,
	[saldoanterior] [decimal](18, 4) NOT NULL,
	[movdebito] [decimal](18, 4) NOT NULL,
	[movcredito] [decimal](18, 4) NOT NULL,
	[saldoactual] [decimal](18, 4) NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_SaldoAnticipos_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_SaldoAnticipos_created1]  DEFAULT (getdate()),
 CONSTRAINT [PK_SaldoAnticipos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [CNT].[SaldoCliente]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [CNT].[SaldoCliente](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[anomes] [varchar](6) NOT NULL,
	[id_cliente] [bigint] NOT NULL,
	[id_documento] [bigint] NULL,
	[nrofactura] [varchar](50) NOT NULL,
	[id_cuenta] [bigint] NULL,
	[fechaactual] [smalldatetime] NOT NULL,
	[fechavencimiento] [smalldatetime] NOT NULL,
	[saldoanterior] [numeric](18, 2) NOT NULL,
	[movDebito] [numeric](18, 2) NOT NULL,
	[movCredito] [numeric](18, 2) NOT NULL,
	[saldoActual] [numeric](18, 2) NOT NULL,
	[id_saldonota] [bigint] NULL,
	[id_nota] [bigint] NULL,
	[id_devolucion] [bigint] NULL,
	[id_user] [bigint] NOT NULL,
	[changed] [bit] NULL CONSTRAINT [DF_SaldoCliente_changed]  DEFAULT ((0)),
	[before] [bit] NULL CONSTRAINT [DF_SaldoCliente_before]  DEFAULT ((0)),
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
/****** Object:  Table [CNT].[SaldoCliente_Cuotas]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [CNT].[SaldoCliente_Cuotas](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[anomes] [varchar](10) NOT NULL CONSTRAINT [DF_SaldoCliente_Cuotas_anomes]  DEFAULT (''),
	[id_cliente] [bigint] NULL,
	[nrofactura] [varchar](50) NULL,
	[id_cuenta] [bigint] NULL,
	[cuota] [int] NOT NULL,
	[saldoAnterior] [numeric](18, 2) NOT NULL CONSTRAINT [DF_SaldoCliente_Cuotas_saldoAnterior]  DEFAULT ((0)),
	[movdebito] [numeric](18, 2) NOT NULL,
	[movCredito] [numeric](18, 2) NOT NULL,
	[saldoActual] [numeric](18, 2) NOT NULL,
	[vencimiento_cuota] [smalldatetime] NOT NULL,
	[fechapagointeres] [smalldatetime] NOT NULL,
	[cancelada] [bit] NOT NULL CONSTRAINT [DF_SaldoCliente_Cuotas_cancelada]  DEFAULT ((0)),
	[id_nota] [bigint] NULL,
	[id_devolucion] [bigint] NULL,
	[changed] [bit] NULL CONSTRAINT [DF_SaldoCliente_Cuotas_changed]  DEFAULT ((0)),
	[before] [bit] NULL CONSTRAINT [DF_SaldoCliente_Cuotas_before]  DEFAULT ((0)),
	[id_user] [bigint] NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_SaldoCliente_Cuotas_create]  DEFAULT (getdate()),
	[updated] [smalldatetime] NULL CONSTRAINT [DF_SaldoCliente_Cuotas_update]  DEFAULT (getdate())
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [CNT].[SaldoCuenta]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [CNT].[SaldoCuenta](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[anomes] [varchar](6) NOT NULL,
	[id_cuenta] [bigint] NOT NULL,
	[saldoanterior] [numeric](18, 2) NOT NULL,
	[movDebito] [numeric](18, 2) NOT NULL,
	[movCredito] [numeric](18, 2) NOT NULL,
	[saldoActual] [numeric](18, 2) NOT NULL,
	[changed] [bit] NOT NULL CONSTRAINT [DF_SaldoCuenta_modified]  DEFAULT ((0)),
	[before] [bit] NULL CONSTRAINT [DF_SaldoCuenta_before]  DEFAULT ((0)),
	[id_user] [bigint] NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_SaldoCuenta_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_SaldoCuenta_updated]  DEFAULT (getdate()),
 CONSTRAINT [PK_SaldoCuenta_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [CNT].[SaldoProveedor]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [CNT].[SaldoProveedor](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[anomes] [varchar](6) NOT NULL,
	[id_proveedor] [bigint] NOT NULL,
	[id_documento] [bigint] NOT NULL,
	[nrofactura] [varchar](50) NOT NULL,
	[id_cuenta] [bigint] NULL,
	[fechaactual] [smalldatetime] NOT NULL,
	[fechavencimiento] [smalldatetime] NOT NULL,
	[saldoanterior] [numeric](18, 2) NOT NULL,
	[movDebito] [numeric](18, 2) NOT NULL,
	[movCredito] [numeric](18, 2) NOT NULL,
	[saldoActual] [numeric](18, 2) NOT NULL,
	[id_saldonota] [bigint] NULL,
	[id_nota] [bigint] NULL,
	[id_user] [bigint] NOT NULL,
	[changed] [bit] NULL CONSTRAINT [DF_SaldoProveedor_changed]  DEFAULT ((0)),
	[before] [bit] NULL CONSTRAINT [DF_SaldoProveedor_before]  DEFAULT ((0)),
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_SaldoProveedor_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_SaldoProveedor_updated]  DEFAULT (getdate()),
 CONSTRAINT [PK_SaldoProveedor] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [CNT].[TerceroAdicionales]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [CNT].[TerceroAdicionales](
	[id] [bigint] NOT NULL,
	[id_tercero] [bigint] NOT NULL,
	[id_estrato] [int] NULL,
	[id_genero] [int] NULL,
	[profesion] [varchar](50) NULL,
	[id_estadocivil] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [CNT].[Terceros]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [CNT].[Terceros](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_personeria] [int] NOT NULL,
	[tipoiden] [int] NOT NULL,
	[iden] [varchar](50) NOT NULL,
	[digitoverificacion] [char](1) NULL,
	[primernombre] [varchar](50) NULL,
	[segundonombre] [varchar](50) NULL,
	[primerapellido] [varchar](50) NULL,
	[segundoapellido] [varchar](50) NULL,
	[razonsocial] [varchar](100) NOT NULL,
	[sucursal] [varchar](50) NULL,
	[tiporegimen] [bit] NOT NULL,
	[id_catfiscal] [bigint] NULL,
	[nombrecomercial] [varchar](50) NULL,
	[paginaweb] [varchar](80) NULL,
	[fechaexpedicion] [smalldatetime] NULL,
	[fechanacimiento] [smalldatetime] NULL,
	[direccion] [varchar](100) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[telefono] [varchar](20) NOT NULL,
	[celular] [varchar](20) NOT NULL,
	[id_ciudad] [bigint] NOT NULL,
	[nombrescontacto] [varchar](200) NULL,
	[telefonocontacto] [varchar](20) NULL,
	[emailcontacto] [varchar](100) NULL,
	[estado] [bit] NULL CONSTRAINT [DF_Terceros_estado]  DEFAULT ((1)),
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_Terceros_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_Terceros_updated]  DEFAULT (getdate()),
	[id_usercreated] [bigint] NOT NULL,
	[id_userupdated] [bigint] NOT NULL,
 CONSTRAINT [PK_Terceros] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [CNT].[TipoDocumentos]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [CNT].[TipoDocumentos](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[codigo] [varchar](2) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[id_tipo] [int] NULL,
	[isccosto] [bit] NOT NULL,
	[id_centrocosto] [bigint] NULL,
	[bloqueado] [bit] NOT NULL CONSTRAINT [DF_TipoDocumentos_bloqueado]  DEFAULT ((1)),
	[estado] [bit] NOT NULL CONSTRAINT [DF_TipoDocumentos_estado]  DEFAULT ((1)),
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_TipoDocumentos_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_TipoDocumentos_updated]  DEFAULT (getdate()),
	[id_usercreated] [bigint] NOT NULL,
	[id_userupdated] [bigint] NOT NULL,
 CONSTRAINT [PK_TipoDocumentos_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_TipoDocumentos] UNIQUE NONCLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [CNT].[TipoTerceros]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CNT].[TipoTerceros](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_tercero] [bigint] NOT NULL,
	[id_tipotercero] [int] NOT NULL,
	[estado] [bit] NOT NULL CONSTRAINT [DF_TipoTerceros_estado]  DEFAULT ((1)),
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_TipoTerceros_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_TipoTerceros_updated]  DEFAULT (getdate()),
	[id_usercreated] [bigint] NOT NULL,
	[id_userupdated] [bigint] NOT NULL,
 CONSTRAINT [PK_TipoTerceros] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [CNT].[Transacciones]    Script Date: 22/11/2020 6:56:02 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [CNT].[Transacciones](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[anomes] [varchar](6) NULL,
	[id_centrocosto] [bigint] NULL,
	[nrodocumento] [varchar](50) NULL,
	[nrofactura] [varchar](50) NULL,
	[fechadcto] [datetime2](7) NULL,
	[id_cuenta] [bigint] NOT NULL,
	[id_tercero] [bigint] NULL,
	[codigoproducto] [varchar](50) NULL,
	[presentacionproducto] [varchar](50) NULL,
	[nombreproducto] [varchar](100) NULL,
	[valor] [decimal](18, 4) NULL,
	[formapago] [varchar](50) NULL,
	[baseimp] [decimal](18, 4) NULL,
	[porceimp] [decimal](6, 2) NULL,
	[cantidad] [decimal](18, 2) NULL,
	[tipodocumento] [varchar](2) NULL,
	[descripcion] [varchar](100) NULL,
	[estado] [int] NULL,
	[fechavencimiento] [smalldatetime] NULL,
	[created] [smalldatetime] NULL CONSTRAINT [DF_Transacciones_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NULL CONSTRAINT [DF_Transacciones_updated]  DEFAULT (getdate()),
	[id_usercreated] [bigint] NULL,
	[id_userupdated] [bigint] NULL,
 CONSTRAINT [PK_Transacciones] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[aspnet_Applications]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_Applications](
	[ApplicationName] [nvarchar](256) NOT NULL,
	[LoweredApplicationName] [nvarchar](256) NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL DEFAULT (newid()),
	[Description] [nvarchar](256) NULL,
PRIMARY KEY NONCLUSTERED 
(
	[ApplicationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[LoweredApplicationName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[ApplicationName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[aspnet_Membership]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_Membership](
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[Password] [nvarchar](128) NOT NULL,
	[PasswordFormat] [int] NOT NULL DEFAULT ((0)),
	[PasswordSalt] [nvarchar](128) NOT NULL,
	[MobilePIN] [nvarchar](16) NULL,
	[Email] [nvarchar](256) NULL,
	[LoweredEmail] [nvarchar](256) NULL,
	[PasswordQuestion] [nvarchar](256) NULL,
	[PasswordAnswer] [nvarchar](128) NULL,
	[IsApproved] [bit] NOT NULL,
	[IsLockedOut] [bit] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastLoginDate] [datetime] NOT NULL,
	[LastPasswordChangedDate] [datetime] NOT NULL,
	[LastLockoutDate] [datetime] NOT NULL,
	[FailedPasswordAttemptCount] [int] NOT NULL,
	[FailedPasswordAttemptWindowStart] [datetime] NOT NULL,
	[FailedPasswordAnswerAttemptCount] [int] NOT NULL,
	[FailedPasswordAnswerAttemptWindowStart] [datetime] NOT NULL,
	[Comment] [ntext] NULL,
PRIMARY KEY NONCLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[aspnet_Roles]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_Roles](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL CONSTRAINT [DF__aspnet_Ro__RoleI__3D5E1FD2]  DEFAULT (newid()),
	[RoleName] [nvarchar](256) NOT NULL,
	[LoweredRoleName] [nvarchar](256) NOT NULL,
	[Description] [nvarchar](256) NULL,
 CONSTRAINT [PK__aspnet_R__8AFACE1B5BB4ADAB] PRIMARY KEY NONCLUSTERED 
(
	[RoleId] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_aspnet_Roles] UNIQUE NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[aspnet_RolesInReports]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_RolesInReports](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_reporte] [bigint] NOT NULL,
	[id_perfil] [bigint] NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_aspnet_RolesReports_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_aspnet_RolesReports_updated]  DEFAULT (getdate()),
	[id_user] [int] NOT NULL,
 CONSTRAINT [PK_aspnet_RolesReports] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[aspnet_SchemaVersions]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_SchemaVersions](
	[Feature] [nvarchar](128) NOT NULL,
	[CompatibleSchemaVersion] [nvarchar](128) NOT NULL,
	[IsCurrentVersion] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Feature] ASC,
	[CompatibleSchemaVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[aspnet_Users]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_Users](
	[idUser] [bigint] IDENTITY(1,1) NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL CONSTRAINT [DF__aspnet_Us__UserI__182C9B23]  DEFAULT (newid()),
	[UserName] [nvarchar](256) NOT NULL,
	[LoweredUserName] [nvarchar](256) NOT NULL,
	[MobileAlias] [nvarchar](16) NULL CONSTRAINT [DF__aspnet_Us__Mobil__1920BF5C]  DEFAULT (NULL),
	[IsAnonymous] [bit] NOT NULL CONSTRAINT [DF__aspnet_Us__IsAno__1A14E395]  DEFAULT ((0)),
	[LastActivityDate] [datetime] NOT NULL,
 CONSTRAINT [PK__aspnet_U__1788CC4D1493D9E0] PRIMARY KEY NONCLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[aspnet_UsersInCajas]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_UsersInCajas](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[user_id] [bigint] NOT NULL,
	[id_caja] [bigint] NOT NULL,
	[created] [smalldatetime] NOT NULL,
	[updated] [smalldatetime] NOT NULL,
	[id_user] [int] NOT NULL,
 CONSTRAINT [PK_aspnet_UsersInCajas] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[aspnet_UsersInRoles]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_UsersInRoles](
	[UserId] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Bodegas]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Bodegas](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[codigo] [varchar](10) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[ctainven] [bigint] NULL,
	[ctacosto] [bigint] NULL,
	[ctadescuento] [bigint] NULL,
	[ctaingreso] [bigint] NULL,
	[ctaingresoexc] [bigint] NULL,
	[ctaivaflete] [bigint] NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_Bodegas_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_Bodegas_updated]  DEFAULT (getdate()),
	[estado] [bit] NOT NULL CONSTRAINT [DF_Bodegas_estado]  DEFAULT ((1)),
	[id_user] [int] NOT NULL CONSTRAINT [DF_Bodegas_id_user]  DEFAULT ((0)),
 CONSTRAINT [PK_Bodegas] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BodegasProducto]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BodegasProducto](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_producto] [bigint] NOT NULL,
	[id_bodega] [bigint] NOT NULL,
	[stockmin] [decimal](18, 2) NOT NULL,
	[stockmax] [decimal](18, 3) NOT NULL,
	[created] [smalldatetime] NOT NULL,
	[updated] [smalldatetime] NOT NULL,
	[id_usercreated] [bigint] NOT NULL,
	[id_userupdated] [bigint] NOT NULL,
 CONSTRAINT [PK_BodegasProducto] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cajas]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cajas](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[codigo] [varchar](10) NULL,
	[nombre] [varchar](50) NOT NULL,
	[id_bodega] [bigint] NOT NULL,
	[id_cliente] [bigint] NOT NULL,
	[id_vendedor] [bigint] NOT NULL CONSTRAINT [DF_Cajas_id_vendedor]  DEFAULT ((3)),
	[id_centrocosto] [bigint] NULL,
	[id_cuenta] [bigint] NULL,
	[cabecera] [text] NOT NULL,
	[piecera] [text] NOT NULL,
	[estado] [bit] NOT NULL CONSTRAINT [DF_Cajas_estado]  DEFAULT ((1)),
	[created] [smalldatetime] NULL CONSTRAINT [DF_Cajas_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NULL CONSTRAINT [DF_Cajas_updated]  DEFAULT (getdate()),
	[id_user] [int] NULL,
	[userproceso] [bigint] NULL,
	[cajaproceso] [bit] NOT NULL CONSTRAINT [DF_Cajas_cajaproceso]  DEFAULT ((0)),
	[id_ctaant] [bigint] NULL,
 CONSTRAINT [PK_Cajas] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CajasProceso]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CajasProceso](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_caja] [bigint] NOT NULL,
	[id_userapertura] [bigint] NOT NULL,
	[fechaapertura] [smalldatetime] NOT NULL,
	[valor] [numeric](18, 2) NOT NULL,
	[estado] [bit] NOT NULL,
	[id_usercierre] [bigint] NULL,
	[fechacierre] [smalldatetime] NULL,
	[created] [smalldatetime] NOT NULL,
	[updated] [smalldatetime] NOT NULL,
	[contabilizado] [bit] NOT NULL,
 CONSTRAINT [PK_CajaProceso] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CategoriasProductos]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CategoriasProductos](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[estado] [bit] NOT NULL CONSTRAINT [DF_GroupArticles_estado]  DEFAULT ((1)),
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_GroupArticles_sd_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_GroupArticles_sd_updated]  DEFAULT (getdate()),
	[id_user] [int] NOT NULL,
 CONSTRAINT [PK_TipoArticulo] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CNTCategoriaFiscal]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CNTCategoriaFiscal](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[codigo] [varchar](10) NOT NULL,
	[descripcion] [varchar](100) NOT NULL,
	[id_retefuente] [bigint] NULL,
	[id_reteiva] [bigint] NULL,
	[id_reteica] [bigint] NULL,
	[valorfuente] [numeric](18, 4) NOT NULL,
	[valorica] [numeric](18, 4) NOT NULL,
	[valoriva] [numeric](18, 4) NOT NULL,
	[estado] [bit] NOT NULL CONSTRAINT [DF_CNTCategoriaFiscal_estado]  DEFAULT ((1)),
	[retiene] [bit] NOT NULL CONSTRAINT [DF_CNTCategoriaFiscal_retiene]  DEFAULT ((0)),
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_CNTCategoriaFiscal_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_CNTCategoriaFiscal_updated]  DEFAULT (getdate()),
	[id_user] [int] NOT NULL,
 CONSTRAINT [PK_CNTCategoriaFiscal] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_CNTCategoriaFiscal] UNIQUE NONCLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CNTCuentas]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CNTCuentas](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[subcodigo] [varchar](3) NOT NULL,
	[codigo] [varchar](25) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[tipo] [bit] NOT NULL,
	[id_padre] [varchar](25) NULL,
	[estado] [bit] NOT NULL CONSTRAINT [DF_CNTCuentas_estado]  DEFAULT ((1)),
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_CNTCuentas_created_1]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_CNTCuentas_updated_1]  DEFAULT (getdate()),
	[id_user] [int] NULL,
	[bloqueada] [bit] NOT NULL,
	[indice] [int] NULL,
	[idparent] [bigint] NULL,
	[id_tipocta] [int] NULL,
	[id_naturaleza] [int] NULL,
	[categoria] [bigint] NULL,
 CONSTRAINT [PK_CNTCuentas_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Conceptos]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Conceptos](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[codigo] [varchar](15) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[id_tipo] [int] NOT NULL,
	[id_cuenta] [bigint] NULL,
	[iva] [bit] NOT NULL,
	[ivaincluido] [bit] NOT NULL,
	[id_cuentaiva] [bigint] NULL,
	[porceniva] [numeric](18, 2) NULL,
	[precio] [numeric](18, 2) NULL,
	[doccaja] [bit] NOT NULL,
	[estado] [bit] NOT NULL,
	[created] [smalldatetime] NOT NULL,
	[updated] [smalldatetime] NOT NULL,
	[id_user] [int] NOT NULL,
 CONSTRAINT [PK_Conceptos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Conceptos] UNIQUE NONCLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[DiasFac]    Script Date: 29/09/2020 7:47:27 a. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DiasFac](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[fecha] [smalldatetime] NOT NULL,
	[estado] [bit] NOT NULL CONSTRAINT [DF_DiasFac_estado]  DEFAULT ((1)),
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_DiasFac_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_DiasFac_updated]  DEFAULT (getdate()),
	[id_user] [int] NOT NULL,
	[anomes] [varchar](10) NOT NULL CONSTRAINT [DF_DiasFac_anomes]  DEFAULT (''),
 CONSTRAINT [PK_DiasFac] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_DiasFac] UNIQUE NONCLUSTERED 
(
	[fecha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DivPolitica]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DivPolitica](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[codigo] [varchar](50) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[codigodane] [varchar](50) NULL,
	[nivel] [tinyint] NOT NULL,
	[codeDepartament] [varchar](25) NOT NULL,
	[nombredep] [varchar](50) NOT NULL CONSTRAINT [DF_DivPolitica_nombredep_1]  DEFAULT (''),
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_DivPolitica_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_DivPolitica_updated]  DEFAULT (getdate()),
	[id_user] [int] NOT NULL CONSTRAINT [DF_DivPolitica_id_user]  DEFAULT ((1)),
 CONSTRAINT [PK_DivPolitica] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DocumentosTecnicaKey]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DocumentosTecnicaKey](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[prefijo] [varchar](20) NOT NULL,
	[resolucion] [varchar](50) NOT NULL,
	[tecnicakey] [varchar](100) NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_CajasResolucion_created]  DEFAULT (getdate()),
	[rangoini] [int] NOT NULL,
	[rangofin] [int] NOT NULL,
	[fechaini] [smalldatetime] NOT NULL,
	[fechafin] [smalldatetime] NOT NULL,
	[estado] [bit] NOT NULL CONSTRAINT [DF_DocumentosTecnicaKey_estado]  DEFAULT ((1)),
	[consecutivo] [bigint] NOT NULL,
	[leyenda] [varchar](max) NOT NULL,
	[isfe] [bit] NOT NULL,
	[id_ccosto] [bigint] NULL,
	[id_user] [int] NOT NULL,
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_DocumentosTecnicaKey_updated]  DEFAULT (getdate()),
 CONSTRAINT [PK_CajasResolucion_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Empresas]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Empresas](
	[id] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[razonsocial] [varchar](100) NOT NULL,
	[nit] [varchar](20) NOT NULL,
	[digverificacion] [varchar](50) NOT NULL CONSTRAINT [DF_Empresas_digverificacion]  DEFAULT ('1'),
	[id_ciudad] [bigint] NULL CONSTRAINT [DF_Empresas_id_city]  DEFAULT (''),
	[direccion] [varchar](200) NOT NULL CONSTRAINT [DF_Empresas_direccion]  DEFAULT (''),
	[telefono] [varchar](50) NOT NULL CONSTRAINT [DF_Empresas_telefono]  DEFAULT (''),
	[email] [varchar](200) NOT NULL CONSTRAINT [DF_Empresas_email]  DEFAULT (''),
	[urlimg] [varchar](500) NOT NULL CONSTRAINT [DF_Empresas_urlimg]  DEFAULT (''),
	[urlimgrpt] [varchar](500) NOT NULL CONSTRAINT [DF_Empresas_urlrpt]  DEFAULT (''),
	[softid] [varchar](100) NOT NULL CONSTRAINT [DF_Empresas_softid]  DEFAULT (''),
	[softpin] [varchar](50) NOT NULL CONSTRAINT [DF_Empresas_softpin]  DEFAULT (''),
	[softtecnikey] [varchar](200) NOT NULL CONSTRAINT [DF_Empresas_softtecnikey]  DEFAULT (''),
	[estado] [bit] NOT NULL CONSTRAINT [DF_Empresas_estado]  DEFAULT ((1)),
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_Empresas_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_Empresas_updated]  DEFAULT (getdate()),
	[id_usercreated] [bigint] NOT NULL CONSTRAINT [DF_Empresas_id_user]  DEFAULT ((1)),
	[id_userupdated] [bigint] NOT NULL CONSTRAINT [DF_Empresas_id_userupdated]  DEFAULT ((0)),
	[carpetaname] [varchar](100) NOT NULL CONSTRAINT [DF_Empresas_carpetaname]  DEFAULT (''),
	[certificatename] [varchar](100) NOT NULL CONSTRAINT [DF_Empresas_certificatename]  DEFAULT (''),
	[passcertificate] [varchar](100) NOT NULL CONSTRAINT [DF_Empresas_passcertificate]  DEFAULT (''),
	[testid] [varchar](50) NOT NULL CONSTRAINT [DF_Empresas_testid]  DEFAULT (''),
	[id_tipoid] [int] NOT NULL CONSTRAINT [DF_Empresas_id_tipoid]  DEFAULT ((31)),
	[tipoambiente] [int] NOT NULL CONSTRAINT [DF_Empresas_tipoambiente]  DEFAULT ((2)),
	[manual] [bit] NOT NULL CONSTRAINT [DF_Empresas_manual]  DEFAULT ((0)),
	[nombrecomercial] [varchar](250) NOT NULL,
 CONSTRAINT [PK_Empresas] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Existencia]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Existencia](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_articulo] [bigint] NOT NULL,
	[id_bodega] [bigint] NOT NULL,
	[existencia] [numeric](18, 2) NOT NULL,
	[disponibilidad] [numeric](18, 2) NOT NULL,
	[costo] [money] NOT NULL,
	[id_user] [int] NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_Existencia_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_Existencia_updated]  DEFAULT (getdate()),
 CONSTRAINT [PK_Existencia] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ExistenciaLoteSerie]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ExistenciaLoteSerie](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_lote] [bigint] NOT NULL,
	[serie] [varchar](200) NOT NULL CONSTRAINT [DF_ExistenciaLoteSerie_serie]  DEFAULT (''),
	[existencia] [decimal](18, 2) NOT NULL,
	[id_existencia] [bigint] NOT NULL,
	[created] [datetime2](7) NOT NULL CONSTRAINT [DF_ExistenciaLoteSerie_created]  DEFAULT (getdate()),
	[updated] [datetime2](7) NOT NULL CONSTRAINT [DF_ExistenciaLoteSerie_updated]  DEFAULT (getdate()),
	[id_user] [bigint] NOT NULL,
 CONSTRAINT [PK_ExistenciaLoteSerie] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FormaPagos]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FormaPagos](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[codigo] [varchar](20) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[id_tipo] [int] NOT NULL,
	[id_typeFE] [int] NULL,
	[categoria] [int] NULL,
	[voucher] [bit] NULL CONSTRAINT [DF_FormaPagos_voucher]  DEFAULT ((1)),
	[estado] [bit] NOT NULL CONSTRAINT [DF_FormaPagos_estado]  DEFAULT ((1)),
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_FormaPagos_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_FormaPagos_updated]  DEFAULT (getdate()),
	[id_usercreated] [bigint] NOT NULL CONSTRAINT [DF_FormaPagos_id_user]  DEFAULT ((0)),
	[id_userupdated] [bigint] NOT NULL,
	[id_cuenta] [bigint] NULL,
 CONSTRAINT [PK_FormaPagos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_FormaPagos] UNIQUE NONCLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LotesProducto]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LotesProducto](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[default] [bit] NOT NULL CONSTRAINT [DF_LotesProducto_default]  DEFAULT ((0)),
	[lote] [varchar](30) NOT NULL,
	[vencimiento_lote] [smalldatetime] NULL,
	[estado] [bit] NOT NULL CONSTRAINT [DF_LotesProducto_estado]  DEFAULT ((1)),
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_LotesProducto_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_LotesProducto_updated]  DEFAULT (getdate()),
	[id_usercreated] [bigint] NOT NULL,
	[id_userupdated] [bigint] NOT NULL,
 CONSTRAINT [PK_LotesProducto_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Marcas]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Marcas](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[codigo] [varchar](50) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[estado] [bigint] NOT NULL CONSTRAINT [DF_Marcas_estado]  DEFAULT ((1)),
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_Marcas_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_Marcas_updated]  DEFAULT (getdate()),
	[id_usercreated] [bigint] NOT NULL,
	[id_userupdated] [bigint] NOT NULL,
 CONSTRAINT [PK_Marcas] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Menus]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Menus](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[nombrepagina] [varchar](200) NOT NULL,
	[estado] [int] NOT NULL,
	[pathpagina] [varchar](200) NOT NULL,
	[id_padre] [int] NOT NULL,
	[descripcion] [text] NOT NULL,
	[orden] [int] NOT NULL,
	[padre] [int] NULL,
	[icon] [varchar](50) NOT NULL CONSTRAINT [DF_Menus_icon]  DEFAULT ('fa-th-large'),
	[id_usuario] [int] NOT NULL CONSTRAINT [DF_Menus_is_Usuario]  DEFAULT ((1)),
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_Menu_FechaCrecion]  DEFAULT (getdate()),
 CONSTRAINT [PK_Appmenus] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MenusPerfiles]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MenusPerfiles](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_perfil] [bigint] NOT NULL,
	[id_menu] [bigint] NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_MenusPerfiles_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_MenusPerfiles_updated]  DEFAULT (getdate()),
	[id_user] [int] NOT NULL,
 CONSTRAINT [PK_MenusPerfiles] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MOVAjustes]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MOVAjustes](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_tipodoc] [bigint] NOT NULL,
	[id_centrocosto] [bigint] NULL,
	[estado] [int] NOT NULL,
	[detalle] [varchar](max) NULL,
	[fecha] [smalldatetime] NOT NULL,
	[id_concepto] [bigint] NOT NULL,
	[costototal] [numeric](18, 2) NOT NULL,
	[id_reversion] [bigint] NULL,
	[created] [smalldatetime] NOT NULL,
	[updated] [smalldatetime] NOT NULL,
	[id_user] [bigint] NOT NULL,
	[contabilizado] [bit] NOT NULL,
 CONSTRAINT [PK_MOVAjustes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MOVAjustesItems]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOVAjustesItems](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_ajuste] [bigint] NOT NULL,
	[id_articulo] [bigint] NOT NULL,
	[serie] [bit] NOT NULL,
	[lote] [bit] NOT NULL,
	[id_lote] [bigint] NOT NULL,
	[id_bodega] [bigint] NOT NULL,
	[cantidad] [numeric](18, 2) NOT NULL,
	[costo] [numeric](18, 4) NOT NULL,
	[costoante] [numeric](18, 2) NULL,
	[created] [smalldatetime] NOT NULL,
	[id_user] [bigint] NOT NULL,
	[id_itemtemp] [bigint] NOT NULL,
 CONSTRAINT [PK_MOVAjustesItems] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MovAjustesLotes]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovAjustesLotes](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_item] [bigint] NOT NULL,
	[id_lote] [bigint] NOT NULL,
	[id_ajuste] [bigint] NOT NULL,
	[cantidad] [numeric](18, 2) NOT NULL,
	[created] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_MovAjustesLotes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MovAjustesSeries]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MovAjustesSeries](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_items] [bigint] NOT NULL,
	[id_ajuste] [bigint] NOT NULL,
	[serie] [varchar](200) NOT NULL,
	[created] [smalldatetime] NOT NULL,
	[selected] [bit] NOT NULL,
 CONSTRAINT [PK_MovAjustesSeries] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MOVAnticipos]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MOVAnticipos](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_tipodoc] [bigint] NULL,
	[id_centrocostos] [bigint] NULL,
	[fecha] [smalldatetime] NOT NULL,
	[id_tercero] [bigint] NOT NULL,
	[id_cuenta] [bigint] NOT NULL,
	[descripcion] [varchar](max) NOT NULL,
	[valor] [numeric](18, 2) NOT NULL,
	[id_formapago] [bigint] NULL CONSTRAINT [DF_MOVAnticipos_id_formapago]  DEFAULT ((1)),
	[id_reversion] [bigint] NULL,
	[estado] [int] NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVAnticipos_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVAnticipos_updated]  DEFAULT (getdate()),
	[id_user] [int] NOT NULL,
	[voucher] [varchar](200) NOT NULL CONSTRAINT [DF_MOVAnticipos_voucher]  DEFAULT (''),
	[contabilizado] [bit] NOT NULL CONSTRAINT [DF_MOVAnticipos_contabilizado]  DEFAULT (0),
 CONSTRAINT [PK_MOVAnticipos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MOVConversiones]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOVConversiones](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[fechadocumen] [smalldatetime] NOT NULL,
	[estado] [int] NOT NULL,
	[id_concepto] [bigint] NOT NULL,
	[costo] [numeric](18, 2) NOT NULL,
	[id_reversion] [bigint] NULL,
	[created] [smalldatetime] NOT NULL,
	[updated] [smalldatetime] NOT NULL,
	[id_user] [int] NOT NULL,
	[contabilizado] [bit] NOT NULL,
 CONSTRAINT [PK_MOVConversiones] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MOVConversionesItems]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOVConversionesItems](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_conversion] [bigint] NOT NULL,
	[id_articulo] [bigint] NOT NULL,
	[id_bodega] [bigint] NOT NULL,
	[cantidad] [numeric](18, 2) NOT NULL,
	[costo] [numeric](18, 4) NOT NULL,
	[costototal] [numeric](18, 4) NOT NULL,
	[created] [smalldatetime] NOT NULL,
	[id_user] [int] NOT NULL,
 CONSTRAINT [PK_MOVConversionesItems] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MOVConversionesItemsForm]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MOVConversionesItemsForm](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_conversion] [bigint] NOT NULL,
	[id_articulofac] [bigint] NOT NULL,
	[id_articulo] [bigint] NOT NULL,
	[serie] [varchar](255) NOT NULL,
	[id_lote] [bigint] NOT NULL,
	[id_bodega] [bigint] NOT NULL,
	[cantidad] [numeric](18, 2) NOT NULL,
	[costo] [numeric](18, 4) NOT NULL,
	[created] [smalldatetime] NOT NULL,
	[id_user] [int] NOT NULL,
 CONSTRAINT [PK_MOVConversionesItemsForm] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MOVCotizacion]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOVCotizacion](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[fechacot] [smalldatetime] NOT NULL,
	[estado] [int] NOT NULL,
	[id_vendedor] [bigint] NOT NULL,
	[id_cliente] [bigint] NOT NULL,
	[id_bodega] [bigint] NULL,
	[iva] [money] NOT NULL,
	[descuento] [money] NOT NULL,
	[subtotal] [money] NOT NULL,
	[total] [money] NOT NULL,
	[id_caja] [bigint] NULL,
	[id_turno] [bigint] NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVCotizacion_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVCotizacion_updated]  DEFAULT (getdate()),
	[id_user] [int] NOT NULL,
 CONSTRAINT [PK_MOVCotizacion] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MOVCotizacionItems]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOVCotizacionItems](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_Cotizacion] [bigint] NOT NULL,
	[id_articulo] [bigint] NOT NULL,
	[id_bodega] [bigint] NULL,
	[cantidad] [numeric](18, 2) NOT NULL,
	[precio] [numeric](18, 4) NOT NULL,
	[total] [numeric](18, 4) NOT NULL,
	[descuento] [numeric](18, 4) NOT NULL,
	[iva] [numeric](18, 4) NOT NULL,
	[created] [smalldatetime] NOT NULL,
	[id_user] [int] NOT NULL,
 CONSTRAINT [PK_MOVCotizacionItems] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MOVDevAnticipos]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MOVDevAnticipos](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_tipodoc] [bigint] NOT NULL,
	[id_centrocostos] [bigint] NULL,
	[fecha] [smalldatetime] NOT NULL,
	[id_cliente] [bigint] NOT NULL,
	[id_cta] [bigint] NOT NULL,
	[descripcion] [varchar](max) NOT NULL,
	[valor] [numeric](18, 2) NOT NULL,
	[id_formapago] [bigint] NULL,
	[estado] [int] NOT NULL,
	[created] [smalldatetime] NOT NULL,
	[updated] [smalldatetime] NOT NULL,
	[id_user] [int] NOT NULL,
	[id_reversion] [bigint] NULL,
	[contabilizado] [bit] NOT NULL CONSTRAINT [DF_MOVDevAnticipos_contabilizado]  DEFAULT (0),
 CONSTRAINT [PK_MOVDevAnticipos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MOVDevEntradas]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOVDevEntradas](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_entrada] [bigint] NOT NULL,
	[id_tipodoc] [bigint] NOT NULL,
	[id_centrocostos] [bigint] NULL,
	[fechadocumen] [smalldatetime] NOT NULL,
	[id_formaPagos] [bigint] NOT NULL,
	[id_bodega] [bigint] NOT NULL,
	[costo] [numeric](18, 2) NOT NULL,
	[iva] [numeric](18, 2) NOT NULL,
	[inc] [numeric](18, 2) NOT NULL,
	[descuento] [numeric](18, 2) NOT NULL,
	[valor] [numeric](18, 2) NOT NULL,
	[estado] [int] NOT NULL,
	[id_reversion] [bigint] NULL,
	[poriva] [numeric](5, 2) NOT NULL,
	[reteiva] [numeric](18, 2) NOT NULL,
	[porfuente] [numeric](5, 2) NOT NULL,
	[retefuente] [numeric](18, 2) NOT NULL,
	[porica] [numeric](5, 2) NOT NULL,
	[reteica] [numeric](18, 2) NOT NULL,
	[id_formapagoflete] [bigint] NULL,
	[created] [smalldatetime] NOT NULL,
	[updated] [smalldatetime] NOT NULL,
	[id_user] [int] NOT NULL,
	[contabilizado] [bit] NOT NULL CONSTRAINT [DF_MOVDevEntradas_contabilizado]  DEFAULT (0),
 CONSTRAINT [PK_MOVDevEntradas] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MOVDevEntradasItems]    Script Date: 22/11/2020 6:32:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOVDevEntradasItems](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_devolucion] [bigint] NOT NULL,
	[id_articulo] [bigint] NOT NULL,
	[id_itementra] [bigint] NOT NULL,
	[serie] [bit] NOT NULL,
	[id_lote] [bigint] NOT NULL,
	[id_bodega] [bigint] NOT NULL,
	[cantidad] [numeric](18, 2) NOT NULL,
	[costo] [numeric](18, 4) NOT NULL,
	[pordescuento] [numeric](18, 2) NOT NULL CONSTRAINT [DF_MOVDevEntradasItems_pordescuento]  DEFAULT ((0)),
	[descuentound] [numeric](18, 4) NOT NULL CONSTRAINT [DF_MOVDevEntradasItems_descuentound]  DEFAULT ((0)),
	[descuento] [numeric](18, 4) NOT NULL,
	[id_iva] [bigint] NULL,
	[porceniva] [numeric](18, 4) NOT NULL,
	[iva] [numeric](18, 4) NOT NULL,
	[porceninc] [numeric](4, 2) NOT NULL,
	[id_inc] [bigint] NULL,
	[inc] [numeric](18, 4) NOT NULL,
	[costototal] [numeric](18, 4) NOT NULL CONSTRAINT [DF_MOVDevEntradasItems_costototal_1]  DEFAULT ((0)),
	[id_ctaiva] [bigint] NULL,
	[id_ctainc] [bigint] NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVDevEntradasItems_created_1]  DEFAULT (getdate()),
	[id_user] [int] NOT NULL,
	[lote] [bit] NOT NULL CONSTRAINT [DF_MOVDevEntradasItems_lote]  DEFAULT ((0)),
	[inventarial] [bit] NOT NULL CONSTRAINT [DF_MOVDevEntradasItems_inventarial]  DEFAULT ((0)),
 CONSTRAINT [PK_MOVDevEntradasItems] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MovDevEntradasSeries]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[MovDevEntradasSeries](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_items] [bigint] NOT NULL,
	[id_devolucion] [bigint] NOT NULL,
	[serie] [varchar](200) NOT NULL,
	[created] [smalldatetime] NOT NULL,
	[selected] [bit] NOT NULL,
 CONSTRAINT [PK_MovDevEntradasSeries] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MOVDevFactura]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MOVDevFactura](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_tipodoc] [bigint] NOT NULL,
	[id_centrocostos] [bigint] NULL,
	[id_factura] [bigint] NOT NULL,
	[id_caja] [bigint] NULL,
	[id_bodega] [bigint] NULL,
	[id_ctaant] [bigint] NULL,
	[valoranticipo] [numeric](18, 2) NOT NULL CONSTRAINT [DF_MOVDevFactura_valoranticipo]  DEFAULT ((0)),
	[fecha] [smalldatetime] NOT NULL,
	[estado] [int] NOT NULL,
	[inc] [money] NOT NULL CONSTRAINT [DF_MOVDevFactura_inc]  DEFAULT ((0)),
	[iva] [money] NOT NULL,
	[descuento] [money] NOT NULL,
	[subtotal] [money] NOT NULL,
	[total] [money] NOT NULL,
	[isPos] [bit] NOT NULL,
	[id_reversion] [bigint] NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVDevFactura_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVDevFactura_updated]  DEFAULT (getdate()),
	[id_user] [int] NOT NULL,
	[contabilizado] [bit] NOT NULL CONSTRAINT [DF_MOVDevFactura_contabilizado]  DEFAULT ((0)),
	[codcuenta] [varchar](25) NULL,
 CONSTRAINT [PK_MOVDevFactura] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MOVDevFacturaConceptos]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOVDevFacturaConceptos](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_devolucion] [bigint] NOT NULL,
	[id_concepto] [bigint] NOT NULL,
	[valor] [numeric](18, 2) NOT NULL,
	[iva] [numeric](18, 2) NOT NULL,
	[total] [numeric](18, 2) NOT NULL,
	[created] [smalldatetime] NOT NULL,
	[id_user] [int] NOT NULL,
	[pordctofac] [numeric](4, 2) NOT NULL,
	[valordesc] [numeric](18, 2) NOT NULL,
	[ivadesc] [numeric](18, 2) NOT NULL,
	[id_tercero] [bigint] NULL,
	[id_facconcepto] [bigint] NOT NULL,
 CONSTRAINT [PK_MOVDevFacturaConceptos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MOVDevFacturaFormaPago]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOVDevFacturaFormaPago](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_devolucion] [bigint] NULL,
	[id_factura] [bigint] NULL,
	[id_formapago] [bigint] NULL,
	[valor] [numeric](18, 2) NULL,
	[created] [smalldatetime] NULL CONSTRAINT [DF_MOVDevFacturaFormaPago_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NULL CONSTRAINT [DF_MOVDevFacturaFormaPago_updated]  DEFAULT (getdate()),
	[id_usercreated] [bigint] NULL,
	[id_userupdated] [bigint] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MOVDevFacturaItems]    Script Date: 22/11/2020 6:40:24 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOVDevFacturaItems](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_devolucion] [bigint] NOT NULL,
	[id_articulo] [bigint] NOT NULL,
	[id_itemfac] [bigint] NOT NULL,
	[serie] [bit] NOT NULL,
	[lote] [bit] NOT NULL,
	[id_bodega] [bigint] NOT NULL,
	[cantidad] [numeric](18, 2) NOT NULL,
	[precio] [numeric](18, 4) NOT NULL,
	[pordescuento] [numeric](6, 2) NULL,
	[descuento] [numeric](18, 4) NOT NULL,
	[total] [numeric](18, 4) NOT NULL,
	[porceniva] [numeric](6, 2) NULL,
	[id_iva] [bigint] NULL,
	[iva] [numeric](18, 4) NOT NULL,
	[id_ctaiva] [bigint] NULL,
	[porceninc] [numeric](6, 2) NULL,
	[id_inc] [bigint] NULL,
	[inc] [numeric](18, 2) NULL,
	[id_ctainc] [bigint] NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVDevFacturaItems_created]  DEFAULT (getdate()),
	[id_user] [int] NOT NULL,
	[costo] [numeric](18, 4) NOT NULL CONSTRAINT [DF_MOVDevFacturaItems_costo]  DEFAULT ((0)),
	[formulado] [bit] NOT NULL CONSTRAINT [DF_MOVDevFacturaItems_formulado]  DEFAULT ((0)),
	[preciodesc] [numeric](18, 4) NOT NULL CONSTRAINT [DF_MOVDevFacturaItems_preciodesc]  DEFAULT ((0)),
	[ivadesc] [numeric](18, 4) NOT NULL CONSTRAINT [DF_MOVDevFacturaItems_ivadesc]  DEFAULT ((0)),
	[inventarial] [bit] NOT NULL,
 CONSTRAINT [PK_MOVDevFacturaItems] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MOVDevFacturaItemsForm]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOVDevFacturaItemsForm](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_devfactura] [bigint] NOT NULL,
	[id_articulofac] [bigint] NOT NULL,
	[id_articulo] [bigint] NOT NULL,
	[id_bodega] [bigint] NOT NULL,
	[cantidad] [numeric](18, 2) NOT NULL,
	[costo] [numeric](18, 4) NOT NULL,
	[created] [smalldatetime] NOT NULL,
	[id_user] [int] NOT NULL,
 CONSTRAINT [PK_MOVDevFacturaItemsForm] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MOVDevFacturaLotes]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOVDevFacturaLotes](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_item] [bigint] NOT NULL,
	[id_lote] [bigint] NOT NULL,
	[id_devolucion] [bigint] NOT NULL,
	[cantidad] [numeric](18, 2) NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVDevFacturaLotes_created]  DEFAULT (getdate()),
 CONSTRAINT [PK_MOVDevFacturaLotes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MovDevFacturasSeries]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[MovDevFacturasSeries](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_items] [bigint] NOT NULL,
	[id_devolucion] [bigint] NOT NULL,
	[serie] [varchar](200) NOT NULL,
	[created] [smalldatetime] NOT NULL,
	[selected] [bit] NOT NULL,
 CONSTRAINT [PK_MovDevFacturasSeries] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MOVDocumentItemTemp]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MOVDocumentItemTemp](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[idToken] [varchar](255) NOT NULL,
	[id_articulo] [bigint] NOT NULL,
	[serie] [bit] NOT NULL,
	[lote] [bit] NOT NULL,
	[id_bodega] [bigint] NOT NULL,
	[id_bodegades] [bigint] NULL,
	[cantidad] [numeric](18, 2) NOT NULL,
	[costo] [numeric](18, 2) NOT NULL CONSTRAINT [DF_MovDcumentItemTemp_costo]  DEFAULT ((0.00)),
	[precio] [numeric](18, 2) NOT NULL CONSTRAINT [DF_MovDcumentItemTemp_precio]  DEFAULT ((0.00)),
	[tipodoc] [char](1) NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_MovDcumentItemTemp_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_MovDcumentItemTemp_updated]  DEFAULT (getdate()),
	[id_user] [int] NOT NULL,
 CONSTRAINT [PK_MOVDcumentItemTemp_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MOVDocumentoConctTemp]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MOVDocumentoConctTemp](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[idToken] [varchar](255) NOT NULL,
	[id_concepto] [bigint] NOT NULL,
	[valor] [numeric](18, 2) NOT NULL,
	[iva] [numeric](18, 2) NOT NULL,
	[descuento] [numeric](18, 2) NOT NULL,
	[tipo] [varchar](2) NOT NULL,
	[tipodoc] [char](1) NOT NULL,
	[created] [smalldatetime] NOT NULL,
	[updated] [smalldatetime] NOT NULL,
	[id_user] [int] NOT NULL,
 CONSTRAINT [PK_MOVDocumentoConctTemp] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MOVDocumentosCajas]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MOVDocumentosCajas](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[estado] [int] NOT NULL,
	[fecha] [smalldatetime] NOT NULL,
	[anomes] [varchar](6) NOT NULL,
	[descripcion] [varchar](max) NOT NULL,
	[total] [numeric](18, 2) NOT NULL,
	[id_tercero] [bigint] NOT NULL,
	[id_caja] [bigint] NOT NULL,
	[id_cuenta] [bigint] NULL,
	[id_reversion] [bigint] NULL,
	[created] [smalldatetime] NOT NULL,
	[updated] [smalldatetime] NOT NULL,
	[id_user] [int] NOT NULL,
	[codcuenta] [varchar](25) NULL,
	[contabilizado] [bit] NOT NULL,
 CONSTRAINT [PK_MOVDocumentosCajas] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MOVDocumentosCajasCpts]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOVDocumentosCajasCpts](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_tipo] [int] NOT NULL,
	[id_concepto] [bigint] NOT NULL,
	[valor] [numeric](18, 2) NOT NULL,
	[id_doccaja] [bigint] NOT NULL,
	[created] [smalldatetime] NOT NULL,
	[id_user] [int] NOT NULL,
 CONSTRAINT [PK_MOVDocumentosCajasCpts] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MOVEntradaLotesTemp]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MOVEntradaLotesTemp](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_itemtemp] [bigint] NOT NULL,
	[id_lote] [bigint] NOT NULL,
	[id_factura] [varchar](255) NOT NULL,
	[cantidad] [numeric](18, 2) NOT NULL,
	[created] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_MOVEntradaLotesTemp] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MOVEntradas]    Script Date: 22/11/2020 7:03:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MOVEntradas](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_tipodoc] [bigint] NOT NULL,
	[id_centrocostos] [bigint] NULL,
	[id_formaPagos] [bigint] NOT NULL CONSTRAINT [DF_MOVEntradas_id_formaPagos]  DEFAULT ((3)),
	[id_proveedor] [bigint] NOT NULL,
	[id_bodega] [bigint] NOT NULL,
	[fechadocumen] [smalldatetime] NOT NULL,
	[fechafactura] [smalldatetime] NOT NULL,
	[fechavence] [smalldatetime] NOT NULL,
	[numfactura] [varchar](50) NOT NULL,
	[diasvence] [numeric](18, 0) NOT NULL,
	[estado] [int] NOT NULL,
	[costo] [numeric](18, 2) NOT NULL,
	[iva] [numeric](18, 2) NOT NULL,
	[inc] [numeric](18, 2) NULL,
	[descuento] [numeric](18, 2) NOT NULL,
	[ivaflete] [numeric](18, 2) NOT NULL CONSTRAINT [DF_MOVEntradas_ivaflete]  DEFAULT ((0)),
	[flete] [numeric](18, 2) NOT NULL,
	[valor] [numeric](18, 2) NOT NULL,
	[id_reversion] [bigint] NULL,
	[id_pedido] [bigint] NULL,
	[poriva] [numeric](5, 2) NOT NULL CONSTRAINT [DF_MOVEntradas_poriva]  DEFAULT ((0)),
	[reteiva] [numeric](18, 2) NOT NULL CONSTRAINT [DF_MOVEntradas_ReteIva]  DEFAULT ((0.00)),
	[porfuente] [numeric](5, 2) NOT NULL CONSTRAINT [DF_MOVEntradas_porfuente]  DEFAULT ((0)),
	[retefuente] [numeric](18, 2) NOT NULL CONSTRAINT [DF_MOVEntradas_ReteFuente]  DEFAULT ((0.00)),
	[porica] [numeric](5, 2) NULL CONSTRAINT [DF_MOVEntradas_porica]  DEFAULT ((0)),
	[reteica] [numeric](18, 2) NOT NULL CONSTRAINT [DF_MOVEntradas_ReteIca]  DEFAULT ((0.00)),
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVEntradas_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVEntradas_updated]  DEFAULT (getdate()),
	[id_user] [int] NOT NULL,
	[id_proveflete] [bigint] NULL,
	[prorratea] [bit] NULL,
	[tipoprorrateo] [char](1) NULL,
	[id_orden] [bigint] NULL,
	[id_formapagoflete] [bigint] NULL,
	[contabilizado] [bit] NOT NULL CONSTRAINT [DF_MOVEntradas_contabilizado]  DEFAULT ((0)),
 CONSTRAINT [PK_MOVEntradas] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MOVEntradasItems]    Script Date: 22/11/2020 7:03:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOVEntradasItems](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_entrada] [bigint] NOT NULL,
	[id_articulo] [bigint] NOT NULL,
	[serie] [bit] NOT NULL CONSTRAINT [DF_MOVEntradasItems_serie]  DEFAULT ((0)),
	[lote] [bit] NOT NULL CONSTRAINT [DF_MOVEntradasItems_lote]  DEFAULT ((0)),
	[id_lote] [bigint] NOT NULL,
	[id_bodega] [bigint] NOT NULL,
	[cantidad] [numeric](18, 2) NOT NULL,
	[costo] [numeric](18, 4) NOT NULL,
	[precio] [numeric](18, 4) NOT NULL,
	[pordescuento] [numeric](18, 2) NOT NULL CONSTRAINT [DF_MOVEntradasItems_pordescuento]  DEFAULT ((0)),
	[descuentound] [numeric](18, 4) NOT NULL CONSTRAINT [DF_MOVEntradasItems_descuentound]  DEFAULT ((0)),
	[descuento] [numeric](18, 4) NOT NULL,
	[porceniva] [numeric](18, 4) NOT NULL,
	[iva] [numeric](18, 4) NOT NULL,
	[porceninc] [numeric](4, 2) NOT NULL,
	[inc] [numeric](18, 4) NOT NULL,
	[costototal] [numeric](18, 4) NOT NULL CONSTRAINT [DF_MOVEntradasItems_costototal]  DEFAULT ((0)),
	[fleteund] [decimal](18, 4) NOT NULL CONSTRAINT [DF_MOVEntradasItems_fleteund]  DEFAULT ((0)),
	[flete] [numeric](18, 4) NOT NULL CONSTRAINT [DF_MOVEntradasItems_flete]  DEFAULT ((0)),
	[id_iva] [bigint] NULL,
	[id_ctaiva] [bigint] NULL,
	[id_inc] [bigint] NULL,
	[id_ctainc] [bigint] NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVEntradasItems_created]  DEFAULT (getdate()),
	[id_user] [int] NOT NULL,
	[inventarial] [bit] NOT NULL CONSTRAINT [DF_MOVEntradasItems_inventarial]  DEFAULT ((0)),
	[id_itemtemp] [bigint] NOT NULL CONSTRAINT [DF_MOVEntradasItems_id_itemtemp]  DEFAULT ((0)),
 CONSTRAINT [PK_MOVEntradasItems] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MOVEntradasItemsTemp]    Script Date: 22/11/2020 7:03:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MOVEntradasItemsTemp](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_entrada] [bigint] NOT NULL,
	[id_articulo] [bigint] NOT NULL,
	[id_bodega] [bigint] NULL,
	[id_bodegadest] [bigint] NULL,
	[serie] [bit] NOT NULL,
	[id_lote] [varchar](200) NULL,
	[vencimientolote] [smalldatetime] NULL,
	[cantidad] [numeric](18, 2) NOT NULL,
	[costo] [numeric](18, 4) NULL,
	[descuentound] [numeric](18, 4) NOT NULL,
	[pordescuento] [decimal](5, 2) NOT NULL,
	[descuento] [numeric](18, 4) NOT NULL,
	[id_iva] [bigint] NULL,
	[porceniva] [numeric](4, 2) NULL,
	[iva] [numeric](18, 4) NULL,
	[id_inc] [bigint] NULL,
	[porceninc] [numeric](4, 2) NULL,
	[inc] [numeric](18, 4) NULL,
	[costototal] [numeric](18, 4) NULL,
	[precio] [numeric](18, 4) NULL,
	[fleteund] [decimal](18, 4) NOT NULL,
	[flete] [numeric](18, 4) NOT NULL,
	[created] [smalldatetime] NOT NULL,
	[id_user] [int] NOT NULL,
	[inventarial] [bit] NOT NULL,
	[lote] [bit] NOT NULL,
	[selected] [bit] NOT NULL,
	[cantidaddev] [numeric](18, 2) NULL,
	[id_itementra] [bigint] NULL,
 CONSTRAINT [PK_MOVEntradasItemsTemp] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MOVEntradasLotesTemp]    Script Date: 22/11/2020 7:03:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MOVEntradasLotesTemp](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_itemtemp] [bigint] NOT NULL,
	[id_lote] [bigint] NOT NULL,
	[id_factura] [varchar](255) NOT NULL,
	[cantidad] [numeric](18, 2) NOT NULL,
	[created] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_MOVEntradasLotesTemp] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MovEntradasSeries]    Script Date: 22/11/2020 7:03:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MovEntradasSeries](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_items] [bigint] NOT NULL,
	[id_entrada] [bigint] NOT NULL,
	[serie] [varchar](200) NOT NULL,
	[created] [smalldatetime] NOT NULL,
	[selected] [bit] NOT NULL,
 CONSTRAINT [PK_MovEntradasSeries] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MovEntradasSeriesTemp]    Script Date: 22/11/2020 7:03:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MovEntradasSeriesTemp](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_itemstemp] [bigint] NOT NULL,
	[id_entradatemp] [bigint] NOT NULL,
	[serie] [varchar](200) NOT NULL,
	[created] [smalldatetime] NOT NULL,
	[selected] [bit] NOT NULL,
 CONSTRAINT [PK_MovEntradasSeriesTemp] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MOVEntradasTemp]    Script Date: 22/11/2020 7:03:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MOVEntradasTemp](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_tipodoc] [bigint] NULL,
	[fechadocumen] [smalldatetime] NULL,
	[fechafactura] [smalldatetime] NULL,
	[fechavence] [smalldatetime] NULL,
	[numfactura] [varchar](50) NULL,
	[diasvence] [int] NULL,
	[id_bodega] [bigint] NULL,
	[id_proveedor] [bigint] NULL,
	[cat_fiscal] [bigint] NULL,
	[flete] [numeric](18, 2) NULL,
	[id_pedido] [bigint] NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVEntradasTemp_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVEntradasTemp_updated]  DEFAULT (getdate()),
	[id_user] [int] NOT NULL,
	[id_orden] [bigint] NULL,
 CONSTRAINT [PK_MOVEntradasTemp] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MOVFactura]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MOVFactura](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_tipodoc] [bigint] NOT NULL,
	[id_centrocostos] [bigint] NULL,
	[fechafac] [smalldatetime] NOT NULL,
	[estado] [int] NOT NULL,
	[id_tercero] [bigint] NOT NULL,
	[iva] [numeric](18, 2) NOT NULL,
	[inc] [numeric](18, 2) NOT NULL,
	[descuento] [numeric](18, 2) NOT NULL,
	[subtotal] [numeric](18, 2) NOT NULL,
	[total] [numeric](18, 2) NOT NULL,
	[valorpagado] [numeric](18, 2) NOT NULL,
	[totalcredito] [numeric](18, 2) NOT NULL,
	[id_resolucion] [bigint] NULL,
	[resolucion] [varchar](50) NOT NULL,
	[consecutivo] [numeric](18, 0) NOT NULL,
	[prefijo] [varchar](20) NOT NULL,
	[isPos] [bit] NULL,
	[isFe] [bit] NOT NULL,
	[id_turno] [bigint] NOT NULL,
	[cambio] [numeric](18, 2) NOT NULL CONSTRAINT [DF_MOVFactura_cambio]  DEFAULT ((0)),
	[id_ctaant] [bigint] NULL,
	[valoranticipo] [numeric](18, 2) NOT NULL CONSTRAINT [DF_MOVFactura_valoranticipo]  DEFAULT ((0)),
	[cuotas] [int] NOT NULL,
	[veninicial] [smalldatetime] NOT NULL,
	[dias] [int] NOT NULL,
	[id_tipovence] [int] NULL,
	[cufe] [varchar](255) NULL,
	[keyid] [varchar](255) NULL CONSTRAINT [DF_MOVFactura_keyid_1]  DEFAULT (newid()),
	[estadoFE] [int] NULL,
	[id_reversion] [bigint] NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVFactura_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVFactura_updated]  DEFAULT (getdate()),
	[id_user] [int] NOT NULL,
	[id_vendedor] [bigint] NOT NULL,
	[id_caja] [bigint] NULL,
	[contabilizado] [bit] NOT NULL CONSTRAINT [DF_MOVFactura_contabilizado]  DEFAULT (0),
 CONSTRAINT [PK_MOVFactura] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MovFacturaCuotas]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MovFacturaCuotas](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_factura] [bigint] NOT NULL,
	[cuota] [int] NOT NULL,
	[valorcuota] [decimal](18, 4) NOT NULL,
	[saldo] [decimal](18, 4) NOT NULL,
	[saldoactual] [decimal](18, 4) NOT NULL CONSTRAINT [DF_MovFacturaCuotas_saldoactual]  DEFAULT ((0)),
	[vencimiento] [varchar](10) NOT NULL,
	[fecha_pagointeres] [varchar](10) NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_MovFacturaCuotas_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_MovFacturaCuotas_updated]  DEFAULT (getdate()),
 CONSTRAINT [PK_MovFacturaCuotas] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MOVFacturaFormaPago]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MOVFacturaFormaPago](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_factura] [bigint] NOT NULL,
	[id_formapago] [bigint] NOT NULL,
	[voucher] [varchar](100) NOT NULL,
	[valor] [numeric](18, 2) NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVFacturaFormaPago_created]  DEFAULT (getdate()),
	[id_user] [int] NOT NULL,
	[codcuenta] [bigint] NOT NULL,
 CONSTRAINT [PK_MOVFacturaFormaPago] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MOVFacturaItems]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOVFacturaItems](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_factura] [bigint] NOT NULL,
	[id_producto] [bigint] NOT NULL,
	[id_bodega] [bigint] NULL,
	[serie] [bit] NOT NULL,
	[lote] [bit] NOT NULL,
	[cantidad] [numeric](18, 2) NOT NULL,
	[costo] [numeric](18, 4) NOT NULL CONSTRAINT [DF_MOVFacturaItems_costo]  DEFAULT ((0)),
	[precio] [numeric](18, 4) NOT NULL,
	[preciodesc] [numeric](18, 4) NOT NULL CONSTRAINT [DF_MOVFacturaItems_preciodesc]  DEFAULT ((0)),
	[descuentound] [decimal](18, 4) NOT NULL,
	[pordescuento] [numeric](5, 2) NOT NULL,
	[descuento] [numeric](18, 4) NOT NULL,
	[id_iva] [bigint] NULL,
	[id_ctaiva] [bigint] NULL,
	[poriva] [numeric](4, 2) NOT NULL,
	[iva] [numeric](18, 4) NOT NULL,
	[id_inc] [bigint] NULL,
	[id_ctainc] [bigint] NULL,
	[porinc] [numeric](4, 2) NOT NULL,
	[inc] [numeric](18, 4) NOT NULL,
	[total] [numeric](18, 4) NOT NULL,
	[formulado] [bit] NOT NULL CONSTRAINT [DF_MOVFacturaItems_formulado]  DEFAULT ((0)),
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVFacturaItems_created]  DEFAULT (getdate()),
	[id_user] [int] NOT NULL,
	[inventarial] [bit] NOT NULL CONSTRAINT [DF_MOVFacturaItems_inventarial]  DEFAULT ((0)),
	[id_itemtemp] [bigint] NOT NULL,
 CONSTRAINT [PK_MOVFacturaItems] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MOVFacturaItemsForm]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOVFacturaItemsForm](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_factura] [bigint] NOT NULL,
	[id_articulofac] [bigint] NOT NULL,
	[id_articulo] [bigint] NOT NULL,
	[id_bodega] [bigint] NOT NULL,
	[cantidad] [numeric](18, 2) NOT NULL,
	[costo] [numeric](18, 4) NOT NULL,
	[created] [smalldatetime] NOT NULL,
	[id_user] [int] NOT NULL,
 CONSTRAINT [PK_MOVFacturaItemsForm] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MOVFacturaItemsTemp]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MOVFacturaItemsTemp](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_factura] [varchar](255) NOT NULL,
	[id_articulo] [bigint] NOT NULL,
	[id_bodega] [bigint] NOT NULL,
	[serie] [bit] NOT NULL,
	[lote] [bit] NOT NULL,
	[cantidad] [numeric](18, 2) NOT NULL,
	[costo] [numeric](18, 4) NOT NULL,
	[precio] [numeric](18, 4) NOT NULL,
	[descuentound] [numeric](18, 4) NOT NULL CONSTRAINT [DF_MOVFacturaItemsTemp_descuentound]  DEFAULT ((0)),
	[pordescuento] [decimal](5, 2) NOT NULL,
	[descuento] [numeric](18, 4) NOT NULL,
	[id_iva] [bigint] NULL,
	[poriva] [numeric](4, 2) NOT NULL CONSTRAINT [DF_MOVFacturaItemsTemp_poriva]  DEFAULT ((0)),
	[iva] [numeric](18, 4) NOT NULL,
	[id_inc] [bigint] NULL,
	[porinc] [numeric](4, 2) NOT NULL,
	[inc] [numeric](18, 4) NOT NULL,
	[total] [numeric](18, 4) NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVFacturaItemsTemp_created]  DEFAULT (getdate()),
	[id_user] [int] NOT NULL,
	[preciodes] [numeric](18, 4) NOT NULL CONSTRAINT [DF_MOVFacturaItemsTemp_preciodes]  DEFAULT ((0)),
	[formulado] [bit] NOT NULL CONSTRAINT [DF_MOVFacturaItemsTemp_formulado]  DEFAULT ((0)),
	[ivades] [numeric](18, 4) NOT NULL CONSTRAINT [DF_MOVFacturaItemsTemp_ivades]  DEFAULT ((0)),
	[selected] [bit] NOT NULL CONSTRAINT [DF_MOVFacturaItemsTemp_seleccionado]  DEFAULT ((0)),
	[cantidaddev] [numeric](18, 2) NULL,
	[id_itemfac] [bigint] NULL,
	[inventarial] [bit] NOT NULL CONSTRAINT [DF_MOVFacturaItemsTemp_inventarial]  DEFAULT ((0)),
 CONSTRAINT [PK_MOVFacturaItemsTemp] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MOVFacturaLotes]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOVFacturaLotes](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_item] [bigint] NOT NULL,
	[id_lote] [bigint] NOT NULL,
	[id_factura] [bigint] NOT NULL,
	[cantidad] [numeric](18, 2) NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVFacturaLotes_created]  DEFAULT (getdate()),
 CONSTRAINT [PK_MOVFacturaLotes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MOVFacturaLotesTemp]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MOVFacturaLotesTemp](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_itemtemp] [bigint] NOT NULL,
	[id_lote] [bigint] NOT NULL,
	[id_factura] [varchar](255) NOT NULL,
	[cantidad] [numeric](18, 2) NOT NULL,	
	[cantidaddev] [numeric](18, 2) NOT NULL CONSTRAINT [DF_MOVFacturaLotesTemp_cantidaddev]  DEFAULT (0),
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVFacturaLotesTemp_created]  DEFAULT (getdate()),
 CONSTRAINT [PK_MOVFacturaLotesTemp] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MovFacturaSeries]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[MovFacturaSeries](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_items] [bigint] NOT NULL,
	[id_factura] [bigint] NOT NULL,
	[serie] [varchar](200) NOT NULL,
	[created] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_MovFacturaSeries] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MovFacturaSeriesTemp]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[MovFacturaSeriesTemp](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_itemstemp] [bigint] NOT NULL,
	[id_facturatemp] [varchar](255) NOT NULL,
	[serie] [varchar](200) NOT NULL,
	[created] [smalldatetime] NOT NULL,
	[selected] [bit] NOT NULL,
 CONSTRAINT [PK_MovFacturaSeriesTemp] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MOVInvenInicial]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOVInvenInicial](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[fecha] [smalldatetime] NOT NULL,
	[estado] [int] NOT NULL,
	[created] [smalldatetime] NOT NULL,
	[updated] [smalldatetime] NOT NULL,
	[id_user] [int] NOT NULL,
	[id_reversion] [bigint] NULL,
 CONSTRAINT [PK_MOVInvenInicial] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MOVInvenInicialItems]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOVInvenInicialItems](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_invinicial] [bigint] NOT NULL,
	[id_articulo] [bigint] NOT NULL,
	[costo] [numeric](18, 4) NOT NULL,
	[cantidad] [numeric](18, 2) NOT NULL,
	[id_bodega] [bigint] NOT NULL,
	[created] [smalldatetime] NOT NULL,
	[updated] [smalldatetime] NOT NULL,
	[id_user] [int] NOT NULL,
 CONSTRAINT [PK_MOVInvenInicialItems] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MovOrdenCompras]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovOrdenCompras](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_tipodoc] [bigint] NOT NULL,
	[id_centrocostos] [bigint] NULL,
	[fechadocument] [smalldatetime] NOT NULL,
	[estado] [int] NOT NULL,
	[id_proveedor] [bigint] NOT NULL,
	[bodega] [bigint] NOT NULL,
	[costo] [decimal](18, 4) NOT NULL,
	[id_reversion] [bigint] NULL,
	[created] [smalldatetime] NOT NULL,
	[updated] [smalldatetime] NOT NULL,
	[id_usercreated] [bigint] NOT NULL,
	[id_userupdated] [bigint] NOT NULL,
 CONSTRAINT [PK_MovOrdenCompras] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MOVOrdenComprasItem]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOVOrdenComprasItem](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_ordencompra] [bigint] NOT NULL,
	[id_producto] [bigint] NOT NULL,
	[id_bodega] [bigint] NOT NULL,
	[cantidad] [numeric](18, 2) NOT NULL,
	[costo] [decimal](18, 4) NOT NULL,
	[costototal] [decimal](18, 4) NOT NULL,
	[created] [smalldatetime] NOT NULL,
	[updated] [smalldatetime] NOT NULL,
	[id_usercreated] [bigint] NOT NULL,
	[id_userupdated] [bigint] NOT NULL,
 CONSTRAINT [PK_MOVOrdenComprasItem] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MOVPagoCajas]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MOVPagoCajas](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[estado] [int] NOT NULL,
	[fecha] [smalldatetime] NOT NULL,
	[Anomes] [varchar](6) NOT NULL,
	[id_tercero] [bigint] NOT NULL,
	[tipo] [int] NOT NULL,
	[valor] [money] NOT NULL,
	[observaciones] [varchar](max) NOT NULL,
	[id_cuenta] [bigint] NULL,
	[id_caja] [bigint] NOT NULL,
	[id_reversion] [bigint] NOT NULL,
	[id_concepto] [bigint] NOT NULL,
	[created] [smalldatetime] NOT NULL,
	[updated] [smalldatetime] NOT NULL,
	[id_user] [int] NOT NULL,
 CONSTRAINT [PK_MOVPagoCajas] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MOVPedidos]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOVPedidos](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[estado] [int] NOT NULL,
	[fechadocumen] [smalldatetime] NOT NULL,
	[id_proveedor] [bigint] NOT NULL,
	[id_reversion] [bigint] NOT NULL,
	[created] [smalldatetime] NOT NULL,
	[updated] [smalldatetime] NOT NULL,
	[id_user] [int] NOT NULL,
 CONSTRAINT [PK_Pedidos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MOVPedidosItems]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOVPedidosItems](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_pedido] [bigint] NOT NULL,
	[id_articulo] [bigint] NOT NULL,
	[id_bodega] [bigint] NOT NULL,
	[cantidad] [numeric](18, 2) NOT NULL,
	[costo] [numeric](18, 4) NOT NULL,
	[descuento] [numeric](18, 4) NOT NULL,
	[iva] [numeric](18, 4) NOT NULL,
	[created] [smalldatetime] NOT NULL,
	[id_user] [int] NOT NULL,
 CONSTRAINT [PK_FMOVPedidosItems] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[MOVTasaFactura]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOVTasaFactura](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[numcuota] [int] NOT NULL,
	[tasa] [numeric](18, 8) NOT NULL,
	[id_caja] [bigint] NOT NULL,
	[created] [smalldatetime] NOT NULL,
	[updated] [smalldatetime] NOT NULL,
	[id_user] [int] NOT NULL,
 CONSTRAINT [PK_MOVTasaFactura] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MOVTraslados]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MOVTraslados](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_tipodoc] [bigint] NULL,
	[id_centrocosto] [bigint] NULL,
	[estado] [int] NOT NULL,
	[fecha] [smalldatetime] NOT NULL,
	[descripcion] [varchar](500) NULL,
	[id_reversion] [bigint] NULL,
	[costototal] [numeric](18, 2) NULL,
	[created] [smalldatetime] NOT NULL,
	[updated] [smalldatetime] NOT NULL,
	[id_user] [int] NOT NULL,
	[contabilizado] [bit] NOT NULL CONSTRAINT [DF_MOVTraslados_contabilizado]  DEFAULT (0),
 CONSTRAINT [PK_Traslados] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MOVTrasladosItems]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOVTrasladosItems](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_traslado] [bigint] NULL,
	[id_articulo] [bigint] NOT NULL,
	[serie] [bit] NOT NULL,
	[lote] [bit] NOT NULL,
	[id_lote] [bigint] NOT NULL,
	[id_bodega] [bigint] NOT NULL,
	[id_bodegades] [bigint] NULL,
	[cantidad] [numeric](18, 2) NOT NULL,
	[costo] [numeric](18, 4) NOT NULL,
	[id_itemtemp] [bigint] NOT NULL,
	[created] [smalldatetime] NOT NULL,
	[id_user] [int] NOT NULL,
 CONSTRAINT [PK_MOVTrasladosItems] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MOVTrasladosLotes]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOVTrasladosLotes](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_item] [bigint] NOT NULL,
	[id_lote] [bigint] NOT NULL,
	[id_ajuste] [bigint] NOT NULL,
	[cantidad] [numeric](18, 2) NOT NULL,
	[created] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_MOVTrasladosLotes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MOVTrasladosSeries]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MOVTrasladosSeries](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_items] [bigint] NOT NULL,
	[id_ajuste] [bigint] NOT NULL,
	[serie] [varchar](200) NOT NULL,
	[created] [smalldatetime] NOT NULL,
	[selected] [bit] NOT NULL,
 CONSTRAINT [PK_MOVTrasladosSeries] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Parametros]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Parametros](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[codigo] [varchar](20) NOT NULL,
	[nombre] [varchar](200) NOT NULL,
	[valor] [varchar](max) NOT NULL,
	[tipo] [varchar](20) NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_Parametros_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_Parametros_updated]  DEFAULT (getdate()),
	[id_user] [int] NOT NULL,
 CONSTRAINT [PK_Parametros_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Parametros] UNIQUE NONCLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Productos](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[tipoproducto] [bigint] NOT NULL,
	[codigo] [varchar](50) NOT NULL,
	[codigobarra] [varchar](100) NULL,
	[presentacion] [varchar](50) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[modelo] [varchar](100) NOT NULL CONSTRAINT [DF_Articulos_descripcion]  DEFAULT (''),
	[color] [varchar](50) NULL,
	[categoria] [bigint] NULL,
	[marca] [bigint] NULL,
	[impuesto] [bit] NOT NULL CONSTRAINT [DF_Articulos_iva]  DEFAULT ((0)),
	[ivaincluido] [bit] NOT NULL CONSTRAINT [DF_Articulos_ivaincluido]  DEFAULT ((0)),
	[id_iva] [bigint] NULL CONSTRAINT [DF_Articulos_poriva]  DEFAULT ((0)),
	[id_inc] [bigint] NULL,
	[porcendescto] [numeric](4, 2) NOT NULL CONSTRAINT [DF_Articulos_pordescto]  DEFAULT ((0)),
	[precio] [decimal](18, 4) NOT NULL,
	[serie] [bit] NOT NULL CONSTRAINT [DF_Articulos_serie]  DEFAULT ((0)),
	[formulado] [bit] NOT NULL CONSTRAINT [DF_Articulos_formulado]  DEFAULT ((0)),
	[urlimg] [varchar](max) NOT NULL,
	[stock] [bit] NOT NULL CONSTRAINT [DF_Articulos_stock]  DEFAULT ((0)),
	[lote] [bit] NOT NULL CONSTRAINT [DF_Productos_lote]  DEFAULT ((0)),
	[inventario] [bit] NOT NULL,
	[estado] [bit] NOT NULL CONSTRAINT [DF_Articulos_estado]  DEFAULT ((1)),
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_Articulos_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_Articulos_updated]  DEFAULT (getdate()),
	[id_usercreated] [int] NOT NULL CONSTRAINT [DF_Articles_id_user]  DEFAULT ((1)),
	[id_userupdated] [int] NOT NULL,
	[facturable] [bit] NOT NULL CONSTRAINT [DF_Articulos_facturable]  DEFAULT ((1)),
	[costoestandar] [numeric](18, 4) NOT NULL CONSTRAINT [DF_Articulos_costoestandar]  DEFAULT ((0)),
	[id_ctacontable] [bigint] NULL,
	[id_ctaiva] [bigint] NULL,
	[id_tipodocu] [int] NULL,
	[id_naturaleza] [bigint] NULL,
	[esDescuento] [bit] NULL,
 CONSTRAINT [PK_Articulos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ArticulosFormula]    Script Date: 29/09/2020 9:53:05 a. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[ArticulosFormula](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_articuloformu] [bigint] NOT NULL,
	[id_articulo] [bigint] NOT NULL,
	[serie] [varchar](50) NULL,
	[id_lote] [bigint] NULL,
	[cantidad] [numeric](18, 4) NOT NULL,
	[created] [smalldatetime] NOT NULL,
	[updated] [smalldatetime] NOT NULL,
	[id_user] [int] NOT NULL,
 CONSTRAINT [PK_ArticulosFormula] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[ArticulosFormula] ADD  CONSTRAINT [DF_ArticulosFormula_created]  DEFAULT (getdate()) FOR [created]
GO

ALTER TABLE [dbo].[ArticulosFormula] ADD  CONSTRAINT [DF_ArticulosFormula_updated]  DEFAULT (getdate()) FOR [updated]
GO

ALTER TABLE [dbo].[ArticulosFormula] ADD  CONSTRAINT [DF_ArticulosFormula_id_user]  DEFAULT ((1)) FOR [id_user]
GO

ALTER TABLE [dbo].[ArticulosFormula]  WITH CHECK ADD  CONSTRAINT [FK_ArticulosFormula_Articulos] FOREIGN KEY([id_articulo])
REFERENCES [dbo].[Productos] ([id])
GO

ALTER TABLE [dbo].[ArticulosFormula] CHECK CONSTRAINT [FK_ArticulosFormula_Articulos]
GO

ALTER TABLE [dbo].[ArticulosFormula]  WITH CHECK ADD  CONSTRAINT [FK_ArticulosFormula_Articulos1] FOREIGN KEY([id_articuloformu])
REFERENCES [dbo].[Productos] ([id])
GO

ALTER TABLE [dbo].[ArticulosFormula] CHECK CONSTRAINT [FK_ArticulosFormula_Articulos1]
GO

/****** Object:  Table [dbo].[ST_CamposReporte]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ST_CamposReporte](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[parametro] [varchar](50) NULL,
	[codigo] [varchar](20) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[tipo] [varchar](20) NOT NULL,
	[fuente] [varchar](max) NOT NULL,
	[ancho] [int] NOT NULL,
	[orden] [int] NOT NULL CONSTRAINT [DF_ST_CamposReporte_orden]  DEFAULT ((0)),
	[metadata] [varchar](500) NOT NULL CONSTRAINT [DF_ST_CamposReporte_metadado]  DEFAULT (''),
	[campos] [varchar](100) NOT NULL CONSTRAINT [DF_ST_CamposReporte_campos]  DEFAULT (''),
	[seleccion] [varchar](20) NOT NULL CONSTRAINT [DF_ST_CamposReporte_seleccion]  DEFAULT (''),
	[id_reporte] [bigint] NOT NULL,
	[estado] [bit] NOT NULL CONSTRAINT [DF_ST_CamposReporte_estado]  DEFAULT ((1)),
	[requerido] [bit] NOT NULL CONSTRAINT [DF_ST_CamposReporte_requerido]  DEFAULT ((0)),
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_ST_CamposReporte_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_ST_CamposReporte_updated]  DEFAULT (getdate()),
	[id_user] [int] NOT NULL,
	[params] [varchar](500) NOT NULL CONSTRAINT [DF_ST_CamposReporte_params]  DEFAULT (''),
 CONSTRAINT [PK_ST_CamposReporte] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_ST_CamposReporte] UNIQUE NONCLUSTERED 
(
	[codigo] ASC,
	[id_reporte] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ST_Listados]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ST_Listados](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[codigogen] [varchar](20) NULL,
	[codigo] [varchar](20) NOT NULL,
	[iden] [varchar](20) NOT NULL CONSTRAINT [DF_ST_Listados_iden]  DEFAULT (''),
	[nombre] [varchar](100) NULL,
	[estado] [bit] NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_ST_Listados_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_ST_Listados_updated]  DEFAULT (getdate()),
	[id_user] [int] NOT NULL CONSTRAINT [DF_ST_Listados_id_user]  DEFAULT ((1)),
	[bloqueo] [bit] NULL CONSTRAINT [DF__ST_Listad__bloqu__7914ADD4]  DEFAULT ((0)),
 CONSTRAINT [PK_Appsyscodes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ST_Reportes]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ST_Reportes](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[codigo] [varchar](20) NOT NULL,
	[nombre] [varchar](128) NOT NULL CONSTRAINT [DF_ST_Reportes_nombre]  DEFAULT (''),
	[frx] [varchar](128) NOT NULL,
	[listado] [bit] NOT NULL CONSTRAINT [DF_ST_Reportes_listado]  DEFAULT ((1)),
	[estado] [bit] NOT NULL CONSTRAINT [DF_ST_Reportes_estado]  DEFAULT ((1)),
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_ST_Reportes_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_ST_Reportes_updated]  DEFAULT (getdate()),
	[id_user] [int] NOT NULL,
	[nombreproce] [varchar](50) NULL,
	[paramadicionales] [varchar](100) NOT NULL CONSTRAINT [DF_ST_Reportes_paramadicionales]  DEFAULT (''),
 CONSTRAINT [PK_ST_Reportes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_ST_Reportes] UNIQUE NONCLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_ST_Reportes_1] UNIQUE NONCLUSTERED 
(
	[frx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Turnos]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Turnos](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[horainicio] [varchar](5) NOT NULL,
	[horafin] [varchar](5) NOT NULL,
	[estado] [bit] NOT NULL CONSTRAINT [DF_Turnos_estado]  DEFAULT ((1)),
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_Shifts_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_Shifts_updated]  DEFAULT (getdate()),
	[id_user] [int] NOT NULL,
 CONSTRAINT [PK_Turnos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usuarios](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[nombre] [varchar](150) NOT NULL,
	[identificacion] [varchar](50) NULL,
	[id_turno] [bigint] NULL,
	[telefono] [varchar](50) NULL,
	[email] [varchar](100) NULL,
	[id_perfil] [bigint] NULL,
	[userid] [uniqueidentifier] NOT NULL,
	[estado] [bit] NOT NULL CONSTRAINT [DF_Usuarios_estado]  DEFAULT ((1)),
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_Usuarios_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_Usuarios_updated]  DEFAULT (getdate()),
	[id_user] [int] NOT NULL CONSTRAINT [DF_Usuarios_id_user]  DEFAULT ((0)),
	[apptoken] [varchar](255) NOT NULL CONSTRAINT [DF_Usuarios_apptoken]  DEFAULT (''),
 CONSTRAINT [PK_Usuarios_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Usuarios] UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [PK_IdUser] UNIQUE NONCLUSTERED 
(
	[userid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Vendedores]    Script Date: 28/09/2020 3:30:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Vendedores](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[codigo] [varchar](20) NOT NULL,
	[nombre] [varchar](150) NOT NULL,
	[estado] [bit] NOT NULL CONSTRAINT [DF_Vendedores_estado]  DEFAULT ((1)),
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_Vendedores_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_Vendedores_updated]  DEFAULT (getdate()),
	[id_usercreated] [bigint] NOT NULL,
	[id_userupdated] [bigint] NOT NULL,
 CONSTRAINT [PK_Vendedores] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

/****** Object:  Table [CNT].[Periodos]    Script Date: 29/09/2020 12:12:43 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [CNT].[Periodos](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[anomes] [varchar](10) NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_Table_1_created1]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_Periodos_updated]  DEFAULT (getdate()),
	[contabilidad] [bit] NOT NULL,
	[inventario] [bit] NOT NULL CONSTRAINT [DF_Periodos_inventario]  DEFAULT ((0)),
	[id_usercreated] [int] NOT NULL,
	[id_userupdated] [int] NOT NULL,
	[reapertura] [bit] NOT NULL CONSTRAINT [DF_Periodos_reapertura]  DEFAULT ((0)),
 CONSTRAINT [PK_Periodos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Periodos] UNIQUE NONCLUSTERED 
(
	[anomes] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SaldoExistencia]    Script Date: 29/09/2020 12:12:43 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SaldoExistencia](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[anomes] [varchar](10) NOT NULL,
	[id_articulo] [bigint] NOT NULL,
	[id_bodega] [bigint] NOT NULL,
	[SaldoExistencia] [numeric](18, 2) NOT NULL,
	[disponibilidad] [numeric](18, 2) NOT NULL,
	[costo] [money] NOT NULL,
	[id_user] [int] NOT NULL,
	[created] [smalldatetime] NOT NULL,
	[updated] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_SaldoExistencia] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SaldoExistenciaLoteSerie]    Script Date: 29/09/2020 12:12:43 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SaldoExistenciaLoteSerie](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[anomes] [varchar](10) NOT NULL,
	[id_lote] [bigint] NOT NULL,
	[serie] [varchar](200) NOT NULL,
	[existencia] [decimal](18, 2) NOT NULL,
	[id_existencia] [bigint] NOT NULL,
	[created] [datetime2](7) NOT NULL,
	[updated] [datetime2](7) NOT NULL,
	[id_user] [bigint] NOT NULL,
 CONSTRAINT [PK_SaldoExistenciaLoteSerie] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO


/****** Object:  Table [dbo].[LogContabilizacion]    Script Date: 13/10/2020 4:26:59 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[LogContabilizacion](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[TipoDoc] [varchar](10) NOT NULL,
	[fecha] [varchar](10) NOT NULL,
	[id_caja] [int] NULL,
	[id_doc] [int] NULL,
	[mensaje] [varchar](max) NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_LogContabilizacion_created]  DEFAULT (getdate()),
	[id_user] [int] NOT NULL,
 CONSTRAINT [PK_LogContabilizacion] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO
/****** Object:  Table [CNT].[MOVNotasCartera]    Script Date: 22/11/2020 5:53:32 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [CNT].[MOVNotasCartera](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_tipodoc] [bigint] NOT NULL,
	[id_centrocosto] [bigint] NULL,
	[fecha] [smalldatetime] NOT NULL,
	[id_tercero] [bigint] NOT NULL,
	[id_saldo] [bigint] NOT NULL,
	[id_ctaant] [bigint] NULL,
	[id_ctaact] [bigint] NULL,
	[vencimientoact] [smalldatetime] NULL,
	[id_tipoven] [int] NULL,
	[dia] [int] NULL,
	[saldoactual] [numeric](18, 2) NULL,
	[nrocuotas] [int] NULL,
	[detalle] [varchar](max) NULL,
	[id_saldoact] [bigint] NULL,
	[estado] [bigint] NULL,
	[id_reversion] [bigint] NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVNotasCartera_created]  DEFAULT (getdate()),
	[id_usercreated] [bigint] NOT NULL,
 CONSTRAINT [PK_MOVNotasCartera] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO


ALTER TABLE [dbo].[SaldoExistencia] ADD  CONSTRAINT [DF_SaldoExistencia_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[SaldoExistencia] ADD  CONSTRAINT [DF_SaldoExistencia_updated]  DEFAULT (getdate()) FOR [updated]
GO
ALTER TABLE [dbo].[SaldoExistenciaLoteSerie] ADD  CONSTRAINT [DF_SaldoExistenciaLoteSerie_serie]  DEFAULT ('') FOR [serie]
GO
ALTER TABLE [dbo].[SaldoExistenciaLoteSerie] ADD  CONSTRAINT [DF_SaldoExistenciaLoteSerie_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[SaldoExistenciaLoteSerie] ADD  CONSTRAINT [DF_SaldoExistenciaLoteSerie_updated]  DEFAULT (getdate()) FOR [updated]
GO
ALTER TABLE [dbo].[SaldoExistencia]  WITH CHECK ADD  CONSTRAINT [FK_SaldoExistencia_Articulos] FOREIGN KEY([id_articulo])
REFERENCES [dbo].[Productos] ([id])
GO
ALTER TABLE [dbo].[SaldoExistencia] CHECK CONSTRAINT [FK_SaldoExistencia_Articulos]
GO
ALTER TABLE [dbo].[SaldoExistencia]  WITH CHECK ADD  CONSTRAINT [FK_SaldoExistencia_Bodegas] FOREIGN KEY([id_bodega])
REFERENCES [dbo].[Bodegas] ([id])
GO
ALTER TABLE [dbo].[SaldoExistencia] CHECK CONSTRAINT [FK_SaldoExistencia_Bodegas]
GO
ALTER TABLE [dbo].[SaldoExistenciaLoteSerie]  WITH CHECK ADD  CONSTRAINT [FK_SaldoExistenciaLoteSerie_Existencia] FOREIGN KEY([id_existencia])
REFERENCES [dbo].[SaldoExistencia] ([id])
GO
ALTER TABLE [dbo].[SaldoExistenciaLoteSerie] CHECK CONSTRAINT [FK_SaldoExistenciaLoteSerie_Existencia]
GO
ALTER TABLE [dbo].[SaldoExistenciaLoteSerie]  WITH CHECK ADD  CONSTRAINT [FK_SaldoExistenciaLoteSerie_LotesProducto] FOREIGN KEY([id_lote])
REFERENCES [dbo].[LotesProducto] ([id])
GO
ALTER TABLE [dbo].[SaldoExistenciaLoteSerie] CHECK CONSTRAINT [FK_SaldoExistenciaLoteSerie_LotesProducto]
GO
ALTER TABLE [dbo].[SaldoExistenciaLoteSerie]  WITH CHECK ADD  CONSTRAINT [FK_SaldoExistenciaLoteSerie_Usuarios] FOREIGN KEY([id_user])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [dbo].[SaldoExistenciaLoteSerie] CHECK CONSTRAINT [FK_SaldoExistenciaLoteSerie_Usuarios]
GO
ALTER TABLE [CNT].[ImpuestosTipoImpuestos] ADD  CONSTRAINT [DF_Impuestos_estado]  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [CNT].[ImpuestosTipoImpuestos] ADD  CONSTRAINT [DF_Impuestos_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [CNT].[ImpuestosTipoImpuestos] ADD  CONSTRAINT [DF_Impuestos_updated]  DEFAULT (getdate()) FOR [updated]
GO
ALTER TABLE [CNT].[MOVReciboCajas] ADD  CONSTRAINT [DF_MOVRecibodeCajas_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [CNT].[MOVReciboCajas] ADD  CONSTRAINT [DF_MOVRecibodeCajas_updated]  DEFAULT (getdate()) FOR [updated]
GO
ALTER TABLE [CNT].[MOVReciboCajasConcepto] ADD  CONSTRAINT [DF_MovReciboCajasConcepto_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [CNT].[MOVReciboCajasFormaPago] ADD  CONSTRAINT [DF_MOVReciboCajasFormaPago_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [CNT].[MOVReciboCajasItems] ADD  CONSTRAINT [DF_MOVReciboItems_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[aspnet_UsersInCajas] ADD  CONSTRAINT [DF_aspnet_UsersInCajas_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[aspnet_UsersInCajas] ADD  CONSTRAINT [DF_aspnet_UsersInCajas_updated]  DEFAULT (getdate()) FOR [updated]
GO
ALTER TABLE [dbo].[BodegasProducto] ADD  CONSTRAINT [DF_BodegasProducto_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[BodegasProducto] ADD  CONSTRAINT [DF_BodegasProducto_updated]  DEFAULT (getdate()) FOR [updated]
GO
ALTER TABLE [dbo].[CajasProceso] ADD  CONSTRAINT [DF_CajaProceso_valor]  DEFAULT ((0)) FOR [valor]
GO
ALTER TABLE [dbo].[CajasProceso] ADD  CONSTRAINT [DF_CajaProceso_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[CajasProceso] ADD  CONSTRAINT [DF_CajaProceso_updated]  DEFAULT (getdate()) FOR [updated]
GO
ALTER TABLE [dbo].[CajasProceso] ADD  CONSTRAINT [DF_CajasProceso_contabilizado]  DEFAULT ((0)) FOR [contabilizado]
GO
ALTER TABLE [dbo].[Conceptos] ADD  CONSTRAINT [DF_Concepto_Iva]  DEFAULT ((0)) FOR [iva]
GO
ALTER TABLE [dbo].[Conceptos] ADD  CONSTRAINT [DF_Concepto_ivaincluido]  DEFAULT ((0)) FOR [ivaincluido]
GO
ALTER TABLE [dbo].[Conceptos] ADD  CONSTRAINT [DF_Concepts_estado]  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[Conceptos] ADD  CONSTRAINT [DF_Concepts_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[Conceptos] ADD  CONSTRAINT [DF_Concepts_updated]  DEFAULT (getdate()) FOR [updated]
GO
ALTER TABLE [dbo].[Conceptos] ADD  CONSTRAINT [DF_Concepts_id_user]  DEFAULT ((0)) FOR [id_user]
GO
ALTER TABLE [dbo].[MOVAjustes] ADD  CONSTRAINT [DF_MOVAjustes_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MOVAjustes] ADD  CONSTRAINT [DF_MOVAjustes_updated]  DEFAULT (getdate()) FOR [updated]
GO
ALTER TABLE [dbo].[MOVAjustes] ADD  CONSTRAINT [DF_MOVAjustes_contabilizado]  DEFAULT ((0)) FOR [contabilizado]
GO
ALTER TABLE [dbo].[MOVAjustesItems] ADD  CONSTRAINT [DF_MOVAjustesItems_costoante]  DEFAULT ((0)) FOR [costoante]
GO
ALTER TABLE [dbo].[MOVAjustesItems] ADD  CONSTRAINT [DF_MOVAjustesItems_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MovAjustesLotes] ADD  CONSTRAINT [DF_MovAjustesLotes_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MovAjustesSeries] ADD  CONSTRAINT [DF_MovAjustesSeries_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MovAjustesSeries] ADD  CONSTRAINT [DF_MovAjustesSeries_selected]  DEFAULT ((0)) FOR [selected]
GO
ALTER TABLE [dbo].[MOVConversiones] ADD  CONSTRAINT [DF_MOVConversiones_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MOVConversiones] ADD  CONSTRAINT [DF_MOVConversiones_updated]  DEFAULT (getdate()) FOR [updated]
GO
ALTER TABLE [dbo].[MOVConversiones] ADD  CONSTRAINT [DF_MOVConversiones_contabilizado]  DEFAULT ((0)) FOR [contabilizado]
GO
ALTER TABLE [dbo].[MOVConversionesItems] ADD  CONSTRAINT [DF_MOVConversionesItems_costototal]  DEFAULT ((0)) FOR [costototal]
GO
ALTER TABLE [dbo].[MOVConversionesItems] ADD  CONSTRAINT [DF_MOVConversionesItems_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MOVConversionesItemsForm] ADD  CONSTRAINT [DF_MOVConversionesItems_costoForm]  DEFAULT ((0)) FOR [costo]
GO
ALTER TABLE [dbo].[MOVConversionesItemsForm] ADD  CONSTRAINT [DF_MOVConversionesItems_createdForm]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MOVCotizacionItems] ADD  CONSTRAINT [DF_MOVCotizacionItems_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MOVDevAnticipos] ADD  CONSTRAINT [DF_MOVDevAnticipos_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MOVDevAnticipos] ADD  CONSTRAINT [DF_MOVDevAnticipos_updated]  DEFAULT (getdate()) FOR [updated]
GO
ALTER TABLE [dbo].[MOVDevEntradas] ADD  CONSTRAINT [DF_MOVDevEntradas_id_formaPagos]  DEFAULT ((3)) FOR [id_formaPagos]
GO
ALTER TABLE [dbo].[MOVDevEntradas] ADD  CONSTRAINT [DF_MOVDevEntradas_poriva]  DEFAULT ((0)) FOR [poriva]
GO
ALTER TABLE [dbo].[MOVDevEntradas] ADD  CONSTRAINT [DF_MOVDevEntradas_reteiva_1]  DEFAULT ((0.00)) FOR [reteiva]
GO
ALTER TABLE [dbo].[MOVDevEntradas] ADD  CONSTRAINT [DF_MOVDevEntradas_porfuente]  DEFAULT ((0)) FOR [porfuente]
GO
ALTER TABLE [dbo].[MOVDevEntradas] ADD  CONSTRAINT [DF_MOVDevEntradas_retefuente_1]  DEFAULT ((0.00)) FOR [retefuente]
GO
ALTER TABLE [dbo].[MOVDevEntradas] ADD  CONSTRAINT [DF_MOVDevEntradas_porica]  DEFAULT ((0)) FOR [porica]
GO
ALTER TABLE [dbo].[MOVDevEntradas] ADD  CONSTRAINT [DF_MOVDevEntradas_reteica_1]  DEFAULT ((0.00)) FOR [reteica]
GO
ALTER TABLE [dbo].[MOVDevEntradas] ADD  CONSTRAINT [DF_MOVDevEntradas_created_1]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MOVDevEntradas] ADD  CONSTRAINT [DF_MOVDevEntradas_updated_1]  DEFAULT (getdate()) FOR [updated]
GO
ALTER TABLE [dbo].[MovDevEntradasSeries] ADD  CONSTRAINT [DF_MovDevEntradasSeries_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MovDevEntradasSeries] ADD  CONSTRAINT [DF_MovDevEntradasSeries_selected]  DEFAULT ((0)) FOR [selected]
GO
ALTER TABLE [dbo].[MOVDevFacturaConceptos] ADD  CONSTRAINT [DF_MOVDevFacturaConceptos_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MOVDevFacturaConceptos] ADD  CONSTRAINT [DF_MOVDevFacturaConceptos_pordctofac]  DEFAULT ((0)) FOR [pordctofac]
GO
ALTER TABLE [dbo].[MOVDevFacturaConceptos] ADD  CONSTRAINT [DF_MOVDevFacturaConceptos_valordesc]  DEFAULT ((0)) FOR [valordesc]
GO
ALTER TABLE [dbo].[MOVDevFacturaConceptos] ADD  CONSTRAINT [DF_MOVDevFacturaConceptos_ivadesc]  DEFAULT ((0)) FOR [ivadesc]
GO
ALTER TABLE [dbo].[MOVDevFacturaItemsForm] ADD  CONSTRAINT [DF_MOVDevFacturaItems_costoForm]  DEFAULT ((0)) FOR [costo]
GO
ALTER TABLE [dbo].[MOVDevFacturaItemsForm] ADD  CONSTRAINT [DF_MOVDevFacturaItems_createdForm]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MovDevFacturasSeries] ADD  CONSTRAINT [DF_MovDevFacturasSeries_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MovDevFacturasSeries] ADD  CONSTRAINT [DF_MovDevFacturasSeries_selected]  DEFAULT ((0)) FOR [selected]
GO
ALTER TABLE [dbo].[MOVDocumentoConctTemp] ADD  CONSTRAINT [DF_MOVDocumentoConctTemp_iva]  DEFAULT ((0)) FOR [iva]
GO
ALTER TABLE [dbo].[MOVDocumentoConctTemp] ADD  CONSTRAINT [DF_MOVDocumentoConctTemp_descuento]  DEFAULT ((0)) FOR [descuento]
GO
ALTER TABLE [dbo].[MOVDocumentoConctTemp] ADD  CONSTRAINT [DF_MOVDocumentoConctTemp_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MOVDocumentoConctTemp] ADD  CONSTRAINT [DF_MOVDocumentoConctTemp_updated]  DEFAULT (getdate()) FOR [updated]
GO
ALTER TABLE [dbo].[MOVDocumentosCajas] ADD  CONSTRAINT [DF_MOVDocumentosCajas_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MOVDocumentosCajas] ADD  CONSTRAINT [DF_MOVDocumentosCajas_updated]  DEFAULT (getdate()) FOR [updated]
GO
ALTER TABLE [dbo].[MOVDocumentosCajas] ADD  CONSTRAINT [DF_MOVDocumentosCajas_contabilizado]  DEFAULT ((0)) FOR [contabilizado]
GO
ALTER TABLE [dbo].[MOVDocumentosCajasCpts] ADD  CONSTRAINT [DF_MOVDocumentosCajasCpts_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MOVEntradaLotesTemp] ADD  CONSTRAINT [DF_MOVEntradaLotesTemp_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MOVEntradasLotesTemp] ADD  CONSTRAINT [DF_MOVEntradasLotesTemp_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MovEntradasSeries] ADD  CONSTRAINT [DF_MovEntradasSeries_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MovEntradasSeries] ADD  CONSTRAINT [DF_MovEntradasSeries_selected]  DEFAULT ((0)) FOR [selected]
GO
ALTER TABLE [dbo].[MovEntradasSeriesTemp] ADD  CONSTRAINT [DF_MovEntradasSeriesTemp_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MovEntradasSeriesTemp] ADD  CONSTRAINT [DF_MovEntradasSeriesTemp_selected]  DEFAULT ((0)) FOR [selected]
GO
ALTER TABLE [dbo].[MOVFacturaItemsForm] ADD  CONSTRAINT [DF_MOVFacturaItems_costoForm]  DEFAULT ((0)) FOR [costo]
GO
ALTER TABLE [dbo].[MOVFacturaItemsForm] ADD  CONSTRAINT [DF_MOVFacturaItems_createdForm]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MovFacturaSeries] ADD  CONSTRAINT [DF_MovFacturaSeries_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MovFacturaSeriesTemp] ADD  CONSTRAINT [DF_MovFacturaSeriesTemp_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MovFacturaSeriesTemp] ADD  CONSTRAINT [DF_MovFacturaSeriesTemp_selected]  DEFAULT ((0)) FOR [selected]
GO
ALTER TABLE [dbo].[MOVInvenInicial] ADD  CONSTRAINT [DF_MOVInvenInicial_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MOVInvenInicial] ADD  CONSTRAINT [DF_MOVInvenInicial_updated]  DEFAULT (getdate()) FOR [updated]
GO
ALTER TABLE [dbo].[MOVInvenInicialItems] ADD  CONSTRAINT [DF_MOVInvenInicialItems_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MOVInvenInicialItems] ADD  CONSTRAINT [DF_MOVInvenInicialItems_updated]  DEFAULT (getdate()) FOR [updated]
GO
ALTER TABLE [dbo].[MovOrdenCompras] ADD  CONSTRAINT [DF_MovOrdenCompras_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MovOrdenCompras] ADD  CONSTRAINT [DF_MovOrdenCompras_updated]  DEFAULT (getdate()) FOR [updated]
GO
ALTER TABLE [dbo].[MOVOrdenComprasItem] ADD  CONSTRAINT [DF_MOVOrdenComprasItem_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MOVOrdenComprasItem] ADD  CONSTRAINT [DF_MOVOrdenComprasItem_updated]  DEFAULT (getdate()) FOR [updated]
GO
ALTER TABLE [dbo].[MOVPagoCajas] ADD  CONSTRAINT [DF_MOVPagoCajas_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MOVPagoCajas] ADD  CONSTRAINT [DF_MOVPagoCajas_updated]  DEFAULT (getdate()) FOR [updated]
GO
ALTER TABLE [dbo].[MOVPedidos] ADD  CONSTRAINT [DF_GroupArticles_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MOVPedidos] ADD  CONSTRAINT [DF_GroupArticles_updated]  DEFAULT (getdate()) FOR [updated]
GO
ALTER TABLE [dbo].[MOVPedidosItems] ADD  CONSTRAINT [DF_MOVPedidosItems_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MOVTasaFactura] ADD  CONSTRAINT [DF_MOVTasaFactura_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MOVTasaFactura] ADD  CONSTRAINT [DF_MOVTasaFactura_updated]  DEFAULT (getdate()) FOR [updated]
GO
ALTER TABLE [dbo].[MOVTraslados] ADD  CONSTRAINT [DF_MOVTraslados_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MOVTraslados] ADD  CONSTRAINT [DF_MOVTraslados_updated]  DEFAULT (getdate()) FOR [updated]
GO
ALTER TABLE [dbo].[MOVTrasladosItems] ADD  CONSTRAINT [DF_MOVTrasladosItems_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MOVTrasladosLotes] ADD  CONSTRAINT [DF_MOVTrasladosLotes_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MOVTrasladosSeries] ADD  CONSTRAINT [DF_MOVTrasladosSeries_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MOVTrasladosSeries] ADD  CONSTRAINT [DF_MOVTrasladosSeries_selected]  DEFAULT ((0)) FOR [selected]
GO

ALTER TABLE [dbo].[Bodegas]  WITH CHECK ADD  CONSTRAINT [FK_Bodegas_CNTCuentas] FOREIGN KEY([ctaivaflete])
REFERENCES [dbo].[CNTCuentas] ([id])
GO
ALTER TABLE [CNT].[CentroCosto]  WITH CHECK ADD  CONSTRAINT [FK_CentroCosto_CentroCosto1] FOREIGN KEY([idparent])
REFERENCES [CNT].[CentroCosto] ([id])
GO
ALTER TABLE [CNT].[CentroCosto] CHECK CONSTRAINT [FK_CentroCosto_CentroCosto1]
GO
ALTER TABLE [CNT].[CentroCosto]  WITH CHECK ADD  CONSTRAINT [FK_CentroCosto_UsuariosCreated] FOREIGN KEY([id_usercreated])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [CNT].[CentroCosto] CHECK CONSTRAINT [FK_CentroCosto_UsuariosCreated]
GO
ALTER TABLE [CNT].[CentroCosto]  WITH CHECK ADD  CONSTRAINT [FK_CentroCosto_UsuarioUpdated] FOREIGN KEY([id_userupdated])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [CNT].[CentroCosto] CHECK CONSTRAINT [FK_CentroCosto_UsuarioUpdated]
GO
ALTER TABLE [CNT].[Impuestos]  WITH CHECK ADD  CONSTRAINT [FK_Impuestos_CNTCuentas] FOREIGN KEY([id_ctacompra])
REFERENCES [dbo].[CNTCuentas] ([id])
GO
ALTER TABLE [CNT].[Impuestos] CHECK CONSTRAINT [FK_Impuestos_CNTCuentas]
GO
ALTER TABLE [CNT].[Impuestos]  WITH CHECK ADD  CONSTRAINT [FK_Impuestos_CNTCuentas1] FOREIGN KEY([id_ctadevVenta])
REFERENCES [dbo].[CNTCuentas] ([id])
GO
ALTER TABLE [CNT].[Impuestos] CHECK CONSTRAINT [FK_Impuestos_CNTCuentas1]
GO
ALTER TABLE [CNT].[Impuestos]  WITH CHECK ADD  CONSTRAINT [FK_Impuestos_CNTCuentas2] FOREIGN KEY([id_ctaventa])
REFERENCES [dbo].[CNTCuentas] ([id])
GO
ALTER TABLE [CNT].[Impuestos] CHECK CONSTRAINT [FK_Impuestos_CNTCuentas2]
GO
ALTER TABLE [CNT].[Impuestos]  WITH CHECK ADD  CONSTRAINT [FK_Impuestos_ST_Listados] FOREIGN KEY([id_tipoimp])
REFERENCES [dbo].[ST_Listados] ([id])
GO
ALTER TABLE [CNT].[Impuestos] CHECK CONSTRAINT [FK_Impuestos_ST_Listados]
GO
ALTER TABLE [CNT].[Impuestos]  WITH CHECK ADD  CONSTRAINT [FK_TipoImpuestos_Usuarioscreated] FOREIGN KEY([id_usercreated])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [CNT].[Impuestos] CHECK CONSTRAINT [FK_TipoImpuestos_Usuarioscreated]
GO
ALTER TABLE [CNT].[Impuestos]  WITH CHECK ADD  CONSTRAINT [FK_TipoImpuestos_usuarioupdated] FOREIGN KEY([id_userupdated])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [CNT].[Impuestos] CHECK CONSTRAINT [FK_TipoImpuestos_usuarioupdated]
GO
ALTER TABLE [CNT].[ImpuestosTipoImpuestos]  WITH CHECK ADD  CONSTRAINT [FK_impuestos_Usuarioscreated] FOREIGN KEY([id_usercreated])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [CNT].[ImpuestosTipoImpuestos] CHECK CONSTRAINT [FK_impuestos_Usuarioscreated]
GO
ALTER TABLE [CNT].[ImpuestosTipoImpuestos]  WITH CHECK ADD  CONSTRAINT [FK_impuestos_usuariosupdate] FOREIGN KEY([id_userupdated])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [CNT].[ImpuestosTipoImpuestos] CHECK CONSTRAINT [FK_impuestos_usuariosupdate]
GO
ALTER TABLE [CNT].[ImpuestosTipoImpuestos]  WITH CHECK ADD  CONSTRAINT [FK_ImpuestosTipoDocumentos_cuenta] FOREIGN KEY([id_cuenta])
REFERENCES [dbo].[CNTCuentas] ([id])
GO
ALTER TABLE [CNT].[ImpuestosTipoImpuestos] CHECK CONSTRAINT [FK_ImpuestosTipoDocumentos_cuenta]
GO
ALTER TABLE [CNT].[MOVComprobanteEgresoFormaPago]  WITH CHECK ADD  CONSTRAINT [FK_MOVComprobanteEgresoFormaPago_FormaPagos] FOREIGN KEY([id_formapago])
REFERENCES [dbo].[FormaPagos] ([id])
GO
ALTER TABLE [CNT].[MOVComprobanteEgresoFormaPago] CHECK CONSTRAINT [FK_MOVComprobanteEgresoFormaPago_FormaPagos]
GO
ALTER TABLE [CNT].[MOVComprobantesContables]  WITH CHECK ADD  CONSTRAINT [FK_MOVComprobantesContables_MOVComprobantesContables] FOREIGN KEY([id])
REFERENCES [CNT].[MOVComprobantesContables] ([id])
GO
ALTER TABLE [CNT].[MOVComprobantesContables] CHECK CONSTRAINT [FK_MOVComprobantesContables_MOVComprobantesContables]
GO
ALTER TABLE [CNT].[MOVComprobantesContables]  WITH CHECK ADD  CONSTRAINT [FK_MOVComprobantesContables_MOVComprobantesContables2] FOREIGN KEY([id_reversion])
REFERENCES [CNT].[MOVComprobantesContables] ([id])
GO
ALTER TABLE [CNT].[MOVComprobantesContables] CHECK CONSTRAINT [FK_MOVComprobantesContables_MOVComprobantesContables2]
GO
ALTER TABLE [CNT].[MOVComprobantesContables]  WITH CHECK ADD  CONSTRAINT [FK_MOVComprobantesContables_TipoDocumentos] FOREIGN KEY([id_documento])
REFERENCES [CNT].[TipoDocumentos] ([id])
GO
ALTER TABLE [CNT].[MOVComprobantesContables] CHECK CONSTRAINT [FK_MOVComprobantesContables_TipoDocumentos]
GO
ALTER TABLE [CNT].[MOVComprobantesContables]  WITH CHECK ADD  CONSTRAINT [FK_MOVComprobantesContables_Usuarios] FOREIGN KEY([id_usercreated])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [CNT].[MOVComprobantesContables] CHECK CONSTRAINT [FK_MOVComprobantesContables_Usuarios]
GO
ALTER TABLE [CNT].[MOVComprobantesContables]  WITH CHECK ADD  CONSTRAINT [FK_MOVComprobantesContables_Usuarios1] FOREIGN KEY([id_userupdated])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [CNT].[MOVComprobantesContables] CHECK CONSTRAINT [FK_MOVComprobantesContables_Usuarios1]
GO
ALTER TABLE [CNT].[MOVComprobantesContablesItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVComprobantesContablesItems_CNTCuentas] FOREIGN KEY([id_cuenta])
REFERENCES [dbo].[CNTCuentas] ([id])
GO
ALTER TABLE [CNT].[MOVComprobantesContablesItems] CHECK CONSTRAINT [FK_MOVComprobantesContablesItems_CNTCuentas]
GO
ALTER TABLE [CNT].[MOVComprobantesContablesItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVComprobantesContablesItems_MOVComprobantesContables] FOREIGN KEY([id_comprobante])
REFERENCES [CNT].[MOVComprobantesContables] ([id])
GO
ALTER TABLE [CNT].[MOVComprobantesContablesItems] CHECK CONSTRAINT [FK_MOVComprobantesContablesItems_MOVComprobantesContables]
GO
ALTER TABLE [CNT].[MOVComprobantesContablesItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVComprobantesContablesItems_Terceros] FOREIGN KEY([id_tercero])
REFERENCES [CNT].[TipoTerceros] ([id])
GO
ALTER TABLE [CNT].[MOVComprobantesContablesItems] CHECK CONSTRAINT [FK_MOVComprobantesContablesItems_Terceros]
GO
ALTER TABLE [CNT].[MOVComprobantesEgresos]  WITH CHECK ADD  CONSTRAINT [FK_ComprobanteEgre_ComprobanteEgre] FOREIGN KEY([id_reversion])
REFERENCES [CNT].[MOVComprobantesEgresos] ([id])
GO
ALTER TABLE [CNT].[MOVComprobantesEgresos] CHECK CONSTRAINT [FK_ComprobanteEgre_ComprobanteEgre]
GO
ALTER TABLE [CNT].[MOVComprobantesEgresos]  WITH CHECK ADD  CONSTRAINT [FK_ComprobanteEgre_ST_Listados] FOREIGN KEY([estado])
REFERENCES [dbo].[ST_Listados] ([id])
GO
ALTER TABLE [CNT].[MOVComprobantesEgresos] CHECK CONSTRAINT [FK_ComprobanteEgre_ST_Listados]
GO
ALTER TABLE [CNT].[MOVComprobantesEgresos]  WITH CHECK ADD  CONSTRAINT [FK_ComprobanteEgre_Terceros] FOREIGN KEY([id_proveedor])
REFERENCES [CNT].[TipoTerceros] ([id])
GO
ALTER TABLE [CNT].[MOVComprobantesEgresos] CHECK CONSTRAINT [FK_ComprobanteEgre_Terceros]
GO
ALTER TABLE [CNT].[MOVComprobantesEgresos]  WITH CHECK ADD  CONSTRAINT [FK_ComprobanteEgre_Usuarios] FOREIGN KEY([id_usercreated])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [CNT].[MOVComprobantesEgresos] CHECK CONSTRAINT [FK_ComprobanteEgre_Usuarios]
GO
ALTER TABLE [CNT].[MOVComprobantesEgresos]  WITH CHECK ADD  CONSTRAINT [FK_ComprobanteEgre_Usuarios1] FOREIGN KEY([id_userupdated])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [CNT].[MOVComprobantesEgresos] CHECK CONSTRAINT [FK_ComprobanteEgre_Usuarios1]
GO
ALTER TABLE [CNT].[MOVComprobantesEgresos]  WITH CHECK ADD  CONSTRAINT [FK_MOVComprobantesEgresos_TipoDocumentos] FOREIGN KEY([id_tipodoc])
REFERENCES [CNT].[TipoDocumentos] ([id])
GO
ALTER TABLE [CNT].[MOVComprobantesEgresos] CHECK CONSTRAINT [FK_MOVComprobantesEgresos_TipoDocumentos]
GO
ALTER TABLE [CNT].[MOVComprobantesEgresosConcepto]  WITH CHECK ADD  CONSTRAINT [FK_MOVComprobantesEgresosConcepto_MOVComprobantesEgresos] FOREIGN KEY([id_comprobante])
REFERENCES [CNT].[MOVComprobantesEgresos] ([id])
GO
ALTER TABLE [CNT].[MOVComprobantesEgresosConcepto] CHECK CONSTRAINT [FK_MOVComprobantesEgresosConcepto_MOVComprobantesEgresos]
GO
ALTER TABLE [CNT].[MOVComprobantesEgresosConcepto]  WITH CHECK ADD  CONSTRAINT [FK_MOVComprobantesEgresosConcepto_Usuarios] FOREIGN KEY([id_usercreated])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [CNT].[MOVComprobantesEgresosConcepto] CHECK CONSTRAINT [FK_MOVComprobantesEgresosConcepto_Usuarios]
GO
ALTER TABLE [CNT].[MOVComprobantesEgresosItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVComprobantesEgresosItems_MOVComprobantesEgresos] FOREIGN KEY([id_comprobante])
REFERENCES [CNT].[MOVComprobantesEgresos] ([id])
GO
ALTER TABLE [CNT].[MOVComprobantesEgresosItems] CHECK CONSTRAINT [FK_MOVComprobantesEgresosItems_MOVComprobantesEgresos]
GO
ALTER TABLE [CNT].[MOVComprobantesEgresosItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVComprobantesEgresosItems_SaldoProveedor] FOREIGN KEY([id_documento])
REFERENCES [CNT].[SaldoProveedor] ([id])
GO
ALTER TABLE [CNT].[MOVComprobantesEgresosItems] CHECK CONSTRAINT [FK_MOVComprobantesEgresosItems_SaldoProveedor]
GO

ALTER TABLE [CNT].[MOVReciboCajas]  WITH CHECK ADD  CONSTRAINT [FK_MOVReciboCajas_ST_Listados] FOREIGN KEY([estado])
REFERENCES [dbo].[ST_Listados] ([id])
GO
ALTER TABLE [CNT].[MOVReciboCajas] CHECK CONSTRAINT [FK_MOVReciboCajas_ST_Listados]
GO
ALTER TABLE [CNT].[MOVReciboCajas]  WITH CHECK ADD  CONSTRAINT [FK_MOVReciboCajas_TipoDocumentos] FOREIGN KEY([id_tipodoc])
REFERENCES [CNT].[TipoDocumentos] ([id])
GO
ALTER TABLE [CNT].[MOVReciboCajas] CHECK CONSTRAINT [FK_MOVReciboCajas_TipoDocumentos]
GO
ALTER TABLE [CNT].[MOVReciboCajas]  WITH CHECK ADD  CONSTRAINT [FK_MOVRecibodeCajas_Usuarios] FOREIGN KEY([id_usercreated])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [CNT].[MOVReciboCajas] CHECK CONSTRAINT [FK_MOVRecibodeCajas_Usuarios]
GO
ALTER TABLE [CNT].[MOVReciboCajas]  WITH CHECK ADD  CONSTRAINT [FK_MOVRecibodeCajas_Usuarios1] FOREIGN KEY([id_userupdated])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [CNT].[MOVReciboCajas] CHECK CONSTRAINT [FK_MOVRecibodeCajas_Usuarios1]
GO
ALTER TABLE [CNT].[MOVReciboCajasConcepto]  WITH CHECK ADD  CONSTRAINT [FK_MovReciboCajasConcepto_MOVReciboCajas] FOREIGN KEY([id_recibo])
REFERENCES [CNT].[MOVReciboCajas] ([id])
GO
ALTER TABLE [CNT].[MOVReciboCajasConcepto] CHECK CONSTRAINT [FK_MovReciboCajasConcepto_MOVReciboCajas]
GO
ALTER TABLE [CNT].[MOVReciboCajasConcepto]  WITH CHECK ADD  CONSTRAINT [FK_MovReciboCajasConcepto_Usuarios] FOREIGN KEY([id_usercreated])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [CNT].[MOVReciboCajasConcepto] CHECK CONSTRAINT [FK_MovReciboCajasConcepto_Usuarios]
GO
ALTER TABLE [CNT].[MOVReciboCajasFormaPago]  WITH CHECK ADD  CONSTRAINT [FK_MOVReciboCajasFormaPago_FormaPagos] FOREIGN KEY([id_formapago])
REFERENCES [dbo].[FormaPagos] ([id])
GO
ALTER TABLE [CNT].[MOVReciboCajasFormaPago] CHECK CONSTRAINT [FK_MOVReciboCajasFormaPago_FormaPagos]
GO
ALTER TABLE [CNT].[MOVReciboCajasFormaPago]  WITH CHECK ADD  CONSTRAINT [FK_MOVReciboCajasFormaPago_MOVReciboCajas] FOREIGN KEY([id_recibo])
REFERENCES [CNT].[MOVReciboCajas] ([id])
GO
ALTER TABLE [CNT].[MOVReciboCajasFormaPago] CHECK CONSTRAINT [FK_MOVReciboCajasFormaPago_MOVReciboCajas]
GO
ALTER TABLE [CNT].[MOVReciboCajasItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVReciboCajasItems_MOVReciboCajas] FOREIGN KEY([id_recibo])
REFERENCES [CNT].[MOVReciboCajas] ([id])
GO
ALTER TABLE [CNT].[MOVReciboCajasItems] CHECK CONSTRAINT [FK_MOVReciboCajasItems_MOVReciboCajas]
GO
ALTER TABLE [CNT].[MOVReciboCajasItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVReciboCajasItems_Usuarios] FOREIGN KEY([id_user])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [CNT].[MOVReciboCajasItems] CHECK CONSTRAINT [FK_MOVReciboCajasItems_Usuarios]
GO
ALTER TABLE [CNT].[SaldoAnticipos]  WITH CHECK ADD  CONSTRAINT [FK_SaldoAnticipos_CNTCuentas] FOREIGN KEY([id_cuenta])
REFERENCES [dbo].[CNTCuentas] ([id])
GO
ALTER TABLE [CNT].[SaldoAnticipos] CHECK CONSTRAINT [FK_SaldoAnticipos_CNTCuentas]
GO
ALTER TABLE [CNT].[SaldoAnticipos]  WITH CHECK ADD  CONSTRAINT [FK_SaldoAnticipos_Terceros] FOREIGN KEY([id_tercero])
REFERENCES [CNT].[TipoTerceros] ([id])
GO
ALTER TABLE [CNT].[SaldoAnticipos] CHECK CONSTRAINT [FK_SaldoAnticipos_Terceros]
GO
ALTER TABLE [CNT].[SaldoCliente]  WITH CHECK ADD  CONSTRAINT [FK_SaldoCliente_CNTCuentas] FOREIGN KEY([id_cuenta])
REFERENCES [dbo].[CNTCuentas] ([id])
GO
ALTER TABLE [CNT].[SaldoCliente] CHECK CONSTRAINT [FK_SaldoCliente_CNTCuentas]
GO
ALTER TABLE [CNT].[SaldoCliente]  WITH CHECK ADD  CONSTRAINT [FK_SaldoCliente_MOVDevFactura] FOREIGN KEY([id_devolucion])
REFERENCES [dbo].[MOVDevFactura] ([id])
GO
ALTER TABLE [CNT].[SaldoCliente] CHECK CONSTRAINT [FK_SaldoCliente_MOVDevFactura]
GO
ALTER TABLE [CNT].[SaldoCliente]  WITH CHECK ADD  CONSTRAINT [FK_SaldoCliente_MOVNotasCartera] FOREIGN KEY([id_nota])
REFERENCES [CNT].[MOVNotasCartera] ([id])
GO
ALTER TABLE [CNT].[SaldoCliente] CHECK CONSTRAINT [FK_SaldoCliente_MOVNotasCartera]
GO
ALTER TABLE [CNT].[SaldoCliente]  WITH CHECK ADD  CONSTRAINT [FK_SaldoCliente_SaldoCliente] FOREIGN KEY([id_saldonota])
REFERENCES [CNT].[SaldoCliente] ([id])
GO
ALTER TABLE [CNT].[SaldoCliente] CHECK CONSTRAINT [FK_SaldoCliente_SaldoCliente]
GO
ALTER TABLE [CNT].[SaldoCliente]  WITH CHECK ADD  CONSTRAINT [FK_SaldoCliente_Terceros] FOREIGN KEY([id_cliente])
REFERENCES [CNT].[TipoTerceros] ([id])
GO
ALTER TABLE [CNT].[SaldoCliente] CHECK CONSTRAINT [FK_SaldoCliente_Terceros]
GO
ALTER TABLE [CNT].[SaldoCliente]  WITH CHECK ADD  CONSTRAINT [FK_SaldoCliente_Usuarios] FOREIGN KEY([id_user])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [CNT].[SaldoCliente] CHECK CONSTRAINT [FK_SaldoCliente_Usuarios]
GO
ALTER TABLE [CNT].[SaldoCliente_Cuotas]  WITH CHECK ADD  CONSTRAINT [FK_SaldoCliente_Cuotas_MOVDevFactura] FOREIGN KEY([id_devolucion])
REFERENCES [dbo].[MOVDevFactura] ([id])
GO
ALTER TABLE [CNT].[SaldoCliente_Cuotas] CHECK CONSTRAINT [FK_SaldoCliente_Cuotas_MOVDevFactura]
GO
ALTER TABLE [CNT].[SaldoCliente_Cuotas]  WITH CHECK ADD  CONSTRAINT [FK_SaldoCliente_Cuotas_MOVNotasCartera] FOREIGN KEY([id_nota])
REFERENCES [CNT].[MOVNotasCartera] ([id])
GO
ALTER TABLE [CNT].[SaldoCliente_Cuotas] CHECK CONSTRAINT [FK_SaldoCliente_Cuotas_MOVNotasCartera]
GO
ALTER TABLE [CNT].[SaldoCliente_Cuotas]  WITH CHECK ADD  CONSTRAINT [FK_SaldoCliente_Cuotas_Usuarios] FOREIGN KEY([id_user])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [CNT].[SaldoCliente_Cuotas] CHECK CONSTRAINT [FK_SaldoCliente_Cuotas_Usuarios]
GO
ALTER TABLE [CNT].[SaldoCuenta]  WITH CHECK ADD  CONSTRAINT [FK_SaldoCuenta_Cuenta] FOREIGN KEY([id_cuenta])
REFERENCES [dbo].[CNTCuentas] ([id])
GO
ALTER TABLE [CNT].[SaldoCuenta] CHECK CONSTRAINT [FK_SaldoCuenta_Cuenta]
GO
ALTER TABLE [CNT].[SaldoCuenta]  WITH CHECK ADD  CONSTRAINT [FK_SaldoCuenta_Usuarios] FOREIGN KEY([id_user])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [CNT].[SaldoCuenta] CHECK CONSTRAINT [FK_SaldoCuenta_Usuarios]
GO
ALTER TABLE [CNT].[SaldoProveedor]  WITH CHECK ADD  CONSTRAINT [FK_SaldoProveedor_CNTCuentas] FOREIGN KEY([id_cuenta])
REFERENCES [dbo].[CNTCuentas] ([id])
GO
ALTER TABLE [CNT].[SaldoProveedor] CHECK CONSTRAINT [FK_SaldoProveedor_CNTCuentas]
GO
ALTER TABLE [CNT].[SaldoProveedor]  WITH CHECK ADD  CONSTRAINT [FK_SaldoProveedor_MOVNotasCartera] FOREIGN KEY([id_nota])
REFERENCES [CNT].[MOVNotasCartera] ([id])
GO
ALTER TABLE [CNT].[SaldoProveedor] CHECK CONSTRAINT [FK_SaldoProveedor_MOVNotasCartera]
GO
ALTER TABLE [CNT].[SaldoProveedor]  WITH CHECK ADD  CONSTRAINT [FK_SaldoProveedor_SaldoProveedor] FOREIGN KEY([id_saldonota])
REFERENCES [CNT].[SaldoProveedor] ([id])
GO
ALTER TABLE [CNT].[SaldoProveedor] CHECK CONSTRAINT [FK_SaldoProveedor_SaldoProveedor]
GO
ALTER TABLE [CNT].[SaldoProveedor]  WITH CHECK ADD  CONSTRAINT [FK_SaldoProveedor_Terceros] FOREIGN KEY([id_proveedor])
REFERENCES [CNT].[TipoTerceros] ([id])
GO
ALTER TABLE [CNT].[SaldoProveedor] CHECK CONSTRAINT [FK_SaldoProveedor_Terceros]
GO
ALTER TABLE [CNT].[SaldoProveedor]  WITH CHECK ADD  CONSTRAINT [FK_SaldoProveedor_Usuarios] FOREIGN KEY([id_user])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [CNT].[SaldoProveedor] CHECK CONSTRAINT [FK_SaldoProveedor_Usuarios]
GO
ALTER TABLE [CNT].[Terceros]  WITH CHECK ADD  CONSTRAINT [FK_Terceros_CNTCategoriaFiscal] FOREIGN KEY([id_catfiscal])
REFERENCES [dbo].[CNTCategoriaFiscal] ([id])
GO
ALTER TABLE [CNT].[Terceros] CHECK CONSTRAINT [FK_Terceros_CNTCategoriaFiscal]
GO
ALTER TABLE [CNT].[TipoDocumentos]  WITH CHECK ADD  CONSTRAINT [FK_TipoDocumentos_CentroCosto] FOREIGN KEY([id_centrocosto])
REFERENCES [CNT].[CentroCosto] ([id])
GO
ALTER TABLE [CNT].[TipoDocumentos] CHECK CONSTRAINT [FK_TipoDocumentos_CentroCosto]
GO
ALTER TABLE [CNT].[TipoDocumentos]  WITH CHECK ADD  CONSTRAINT [FK_TipoDocumentos_ST_Listados] FOREIGN KEY([id_tipo])
REFERENCES [dbo].[ST_Listados] ([id])
GO
ALTER TABLE [CNT].[TipoDocumentos] CHECK CONSTRAINT [FK_TipoDocumentos_ST_Listados]
GO
ALTER TABLE [CNT].[TipoDocumentos]  WITH CHECK ADD  CONSTRAINT [FK_TipoDocumentos_usuarioscreated] FOREIGN KEY([id_usercreated])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [CNT].[TipoDocumentos] CHECK CONSTRAINT [FK_TipoDocumentos_usuarioscreated]
GO
ALTER TABLE [CNT].[TipoDocumentos]  WITH CHECK ADD  CONSTRAINT [FK_TipoDocumentos_usuarioupdated] FOREIGN KEY([id_userupdated])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [CNT].[TipoDocumentos] CHECK CONSTRAINT [FK_TipoDocumentos_usuarioupdated]
GO
ALTER TABLE [CNT].[TipoTerceros]  WITH CHECK ADD  CONSTRAINT [FK_TipoTerceros_ST_Listados] FOREIGN KEY([id_tipotercero])
REFERENCES [dbo].[ST_Listados] ([id])
GO
ALTER TABLE [CNT].[TipoTerceros] CHECK CONSTRAINT [FK_TipoTerceros_ST_Listados]
GO
ALTER TABLE [CNT].[TipoTerceros]  WITH CHECK ADD  CONSTRAINT [FK_TipoTerceros_Terceros] FOREIGN KEY([id_tercero])
REFERENCES [CNT].[Terceros] ([id])
GO
ALTER TABLE [CNT].[TipoTerceros] CHECK CONSTRAINT [FK_TipoTerceros_Terceros]
GO
ALTER TABLE [CNT].[Transacciones]  WITH CHECK ADD  CONSTRAINT [FK_Transacciones_CNTCuentas] FOREIGN KEY([id_cuenta])
REFERENCES [dbo].[CNTCuentas] ([id])
GO
ALTER TABLE [CNT].[Transacciones] CHECK CONSTRAINT [FK_Transacciones_CNTCuentas]
GO
ALTER TABLE [CNT].[Transacciones]  WITH CHECK ADD  CONSTRAINT [FK_Transacciones_ST_Listados] FOREIGN KEY([estado])
REFERENCES [dbo].[ST_Listados] ([id])
GO
ALTER TABLE [CNT].[Transacciones] CHECK CONSTRAINT [FK_Transacciones_ST_Listados]
GO
ALTER TABLE [CNT].[Transacciones]  WITH CHECK ADD  CONSTRAINT [FK_Transacciones_Terceros] FOREIGN KEY([id_tercero])
REFERENCES [CNT].[TipoTerceros] ([id])
GO
ALTER TABLE [CNT].[Transacciones] CHECK CONSTRAINT [FK_Transacciones_Terceros]
GO
ALTER TABLE [dbo].[aspnet_Membership]  WITH CHECK ADD FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
GO
ALTER TABLE [dbo].[aspnet_Membership]  WITH CHECK ADD  CONSTRAINT [FK__aspnet_Me__UserI__286302EC] FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
ALTER TABLE [dbo].[aspnet_Membership] CHECK CONSTRAINT [FK__aspnet_Me__UserI__286302EC]
GO
ALTER TABLE [dbo].[aspnet_Roles]  WITH CHECK ADD  CONSTRAINT [FK__aspnet_Ro__Appli__3C69FB99] FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
GO
ALTER TABLE [dbo].[aspnet_Roles] CHECK CONSTRAINT [FK__aspnet_Ro__Appli__3C69FB99]
GO
ALTER TABLE [dbo].[aspnet_RolesInReports]  WITH CHECK ADD  CONSTRAINT [FK_aspnet_RolesReports_aspnet_Roles] FOREIGN KEY([id_perfil])
REFERENCES [dbo].[aspnet_Roles] ([id])
GO
ALTER TABLE [dbo].[aspnet_RolesInReports] CHECK CONSTRAINT [FK_aspnet_RolesReports_aspnet_Roles]
GO
ALTER TABLE [dbo].[aspnet_RolesInReports]  WITH CHECK ADD  CONSTRAINT [FK_aspnet_RolesReports_ST_Reportes] FOREIGN KEY([id_reporte])
REFERENCES [dbo].[ST_Reportes] ([id])
GO
ALTER TABLE [dbo].[aspnet_RolesInReports] CHECK CONSTRAINT [FK_aspnet_RolesReports_ST_Reportes]
GO
ALTER TABLE [dbo].[aspnet_Users]  WITH CHECK ADD  CONSTRAINT [FK__aspnet_Us__Appli__173876EA] FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
GO
ALTER TABLE [dbo].[aspnet_Users] CHECK CONSTRAINT [FK__aspnet_Us__Appli__173876EA]
GO
ALTER TABLE [dbo].[aspnet_UsersInCajas]  WITH CHECK ADD  CONSTRAINT [FK_aspnet_UsersInCajas_Cajas] FOREIGN KEY([id_caja])
REFERENCES [dbo].[Cajas] ([id])
GO
ALTER TABLE [dbo].[aspnet_UsersInCajas] CHECK CONSTRAINT [FK_aspnet_UsersInCajas_Cajas]
GO
ALTER TABLE [dbo].[aspnet_UsersInCajas]  WITH CHECK ADD  CONSTRAINT [FK_aspnet_UsersInCajas_Usuarios] FOREIGN KEY([user_id])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [dbo].[aspnet_UsersInCajas] CHECK CONSTRAINT [FK_aspnet_UsersInCajas_Usuarios]
GO
ALTER TABLE [dbo].[aspnet_UsersInRoles]  WITH CHECK ADD  CONSTRAINT [FK__aspnet_Us__UserI__403A8C7D] FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
ALTER TABLE [dbo].[aspnet_UsersInRoles] CHECK CONSTRAINT [FK__aspnet_Us__UserI__403A8C7D]
GO
ALTER TABLE [dbo].[BodegasProducto]  WITH CHECK ADD  CONSTRAINT [FK_BodegasProducto_Bodegas] FOREIGN KEY([id_bodega])
REFERENCES [dbo].[Bodegas] ([id])
GO
ALTER TABLE [dbo].[BodegasProducto] CHECK CONSTRAINT [FK_BodegasProducto_Bodegas]
GO
ALTER TABLE [dbo].[Cajas]  WITH CHECK ADD  CONSTRAINT [FK_Cajas_CentroCosto] FOREIGN KEY([id_centrocosto])
REFERENCES [CNT].[CentroCosto] ([id])
GO
ALTER TABLE [dbo].[Cajas] CHECK CONSTRAINT [FK_Cajas_CentroCosto]
GO
ALTER TABLE [dbo].[Cajas]  WITH CHECK ADD  CONSTRAINT [FK_Cajas_CNTCuentas] FOREIGN KEY([id_cuenta])
REFERENCES [dbo].[CNTCuentas] ([id])
GO
ALTER TABLE [dbo].[Cajas] CHECK CONSTRAINT [FK_Cajas_CNTCuentas]
GO
ALTER TABLE [dbo].[Cajas]  WITH CHECK ADD  CONSTRAINT [FK_Cajas_CNTCuentas1] FOREIGN KEY([id_ctaant])
REFERENCES [dbo].[CNTCuentas] ([id])
GO
ALTER TABLE [dbo].[Cajas] CHECK CONSTRAINT [FK_Cajas_CNTCuentas1]
GO
ALTER TABLE [dbo].[Cajas]  WITH CHECK ADD  CONSTRAINT [FK_Cajas_Usuarios] FOREIGN KEY([userproceso])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [dbo].[Cajas] CHECK CONSTRAINT [FK_Cajas_Usuarios]
GO
ALTER TABLE [dbo].[Cajas]  WITH CHECK ADD  CONSTRAINT [FK_Cajas_Vendedores] FOREIGN KEY([id_vendedor])
REFERENCES [dbo].[Vendedores] ([id])
GO
ALTER TABLE [dbo].[Cajas] CHECK CONSTRAINT [FK_Cajas_Vendedores]
GO
ALTER TABLE [dbo].[CajasProceso]  WITH CHECK ADD  CONSTRAINT [FK_CajaProceso_Cajas] FOREIGN KEY([id_caja])
REFERENCES [dbo].[Cajas] ([id])
GO
ALTER TABLE [dbo].[CajasProceso] CHECK CONSTRAINT [FK_CajaProceso_Cajas]
GO
ALTER TABLE [dbo].[CajasProceso]  WITH CHECK ADD  CONSTRAINT [FK_CajaProceso_Usuarios] FOREIGN KEY([id_userapertura])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [dbo].[CajasProceso] CHECK CONSTRAINT [FK_CajaProceso_Usuarios]
GO
ALTER TABLE [dbo].[CajasProceso]  WITH CHECK ADD  CONSTRAINT [FK_CajaProceso_Usuarios1] FOREIGN KEY([id_usercierre])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [dbo].[CajasProceso] CHECK CONSTRAINT [FK_CajaProceso_Usuarios1]
GO
ALTER TABLE [dbo].[CNTCategoriaFiscal]  WITH CHECK ADD  CONSTRAINT [FK_CNTCategoriaFiscal_Impuestos] FOREIGN KEY([id_retefuente])
REFERENCES [CNT].[Impuestos] ([id])
GO
ALTER TABLE [dbo].[CNTCategoriaFiscal] CHECK CONSTRAINT [FK_CNTCategoriaFiscal_Impuestos]
GO
ALTER TABLE [dbo].[CNTCategoriaFiscal]  WITH CHECK ADD  CONSTRAINT [FK_CNTCategoriaFiscal_Impuestos1] FOREIGN KEY([id_reteica])
REFERENCES [CNT].[Impuestos] ([id])
GO
ALTER TABLE [dbo].[CNTCategoriaFiscal] CHECK CONSTRAINT [FK_CNTCategoriaFiscal_Impuestos1]
GO
ALTER TABLE [dbo].[CNTCategoriaFiscal]  WITH CHECK ADD  CONSTRAINT [FK_CNTCategoriaFiscal_Impuestos2] FOREIGN KEY([id_reteiva])
REFERENCES [CNT].[Impuestos] ([id])
GO
ALTER TABLE [dbo].[CNTCategoriaFiscal] CHECK CONSTRAINT [FK_CNTCategoriaFiscal_Impuestos2]
GO
ALTER TABLE [dbo].[CNTCuentas]  WITH CHECK ADD  CONSTRAINT [FK_CNTCuentas_CNTCuentas] FOREIGN KEY([idparent])
REFERENCES [dbo].[CNTCuentas] ([id])
GO
ALTER TABLE [dbo].[CNTCuentas] CHECK CONSTRAINT [FK_CNTCuentas_CNTCuentas]
GO
ALTER TABLE [dbo].[CNTCuentas]  WITH CHECK ADD  CONSTRAINT [FK_CNTCuentas_ST_Listados] FOREIGN KEY([id_tipocta])
REFERENCES [dbo].[ST_Listados] ([id])
GO
ALTER TABLE [dbo].[CNTCuentas] CHECK CONSTRAINT [FK_CNTCuentas_ST_Listados]
GO
ALTER TABLE [dbo].[Conceptos]  WITH CHECK ADD  CONSTRAINT [FK_Conceptos_Cuenta] FOREIGN KEY([id_cuenta])
REFERENCES [dbo].[CNTCuentas] ([id])
GO
ALTER TABLE [dbo].[Conceptos] CHECK CONSTRAINT [FK_Conceptos_Cuenta]
GO
ALTER TABLE [dbo].[Conceptos]  WITH CHECK ADD  CONSTRAINT [FK_Conceptos_ST_Listados] FOREIGN KEY([id_tipo])
REFERENCES [dbo].[ST_Listados] ([id])
GO
ALTER TABLE [dbo].[Conceptos] CHECK CONSTRAINT [FK_Conceptos_ST_Listados]
GO
ALTER TABLE [dbo].[Conceptos]  WITH CHECK ADD  CONSTRAINT [FK_Concepts_cuentaiva] FOREIGN KEY([id_cuentaiva])
REFERENCES [dbo].[CNTCuentas] ([id])
GO
ALTER TABLE [dbo].[Conceptos] CHECK CONSTRAINT [FK_Concepts_cuentaiva]
GO
ALTER TABLE [dbo].[DocumentosTecnicaKey]  WITH CHECK ADD  CONSTRAINT [FK_CajasResolucion_Cajas] FOREIGN KEY([id_ccosto])
REFERENCES [CNT].[CentroCosto] ([id])
GO
ALTER TABLE [dbo].[DocumentosTecnicaKey] CHECK CONSTRAINT [FK_CajasResolucion_Cajas]
GO
ALTER TABLE [dbo].[Empresas]  WITH CHECK ADD  CONSTRAINT [FK_Empresas_Usuarios] FOREIGN KEY([id_usercreated])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [dbo].[Empresas] CHECK CONSTRAINT [FK_Empresas_Usuarios]
GO
ALTER TABLE [dbo].[Existencia]  WITH CHECK ADD  CONSTRAINT [FK_Existencia_Articulos] FOREIGN KEY([id_articulo])
REFERENCES [dbo].[Productos] ([id])
GO
ALTER TABLE [dbo].[Existencia] CHECK CONSTRAINT [FK_Existencia_Articulos]
GO
ALTER TABLE [dbo].[Existencia]  WITH CHECK ADD  CONSTRAINT [FK_Existencia_Bodegas] FOREIGN KEY([id_bodega])
REFERENCES [dbo].[Bodegas] ([id])
GO
ALTER TABLE [dbo].[Existencia] CHECK CONSTRAINT [FK_Existencia_Bodegas]
GO
ALTER TABLE [dbo].[ExistenciaLoteSerie]  WITH CHECK ADD  CONSTRAINT [FK_ExistenciaLoteSerie_Existencia] FOREIGN KEY([id_existencia])
REFERENCES [dbo].[Existencia] ([id])
GO
ALTER TABLE [dbo].[ExistenciaLoteSerie] CHECK CONSTRAINT [FK_ExistenciaLoteSerie_Existencia]
GO
ALTER TABLE [dbo].[ExistenciaLoteSerie]  WITH CHECK ADD  CONSTRAINT [FK_ExistenciaLoteSerie_LotesProducto] FOREIGN KEY([id_lote])
REFERENCES [dbo].[LotesProducto] ([id])
GO
ALTER TABLE [dbo].[ExistenciaLoteSerie] CHECK CONSTRAINT [FK_ExistenciaLoteSerie_LotesProducto]
GO
ALTER TABLE [dbo].[ExistenciaLoteSerie]  WITH CHECK ADD  CONSTRAINT [FK_ExistenciaLoteSerie_Usuarios] FOREIGN KEY([id_user])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [dbo].[ExistenciaLoteSerie] CHECK CONSTRAINT [FK_ExistenciaLoteSerie_Usuarios]
GO
ALTER TABLE [dbo].[FormaPagos]  WITH CHECK ADD  CONSTRAINT [FK_FormaPagos_Cuenta] FOREIGN KEY([id_cuenta])
REFERENCES [dbo].[CNTCuentas] ([id])
GO
ALTER TABLE [dbo].[FormaPagos] CHECK CONSTRAINT [FK_FormaPagos_Cuenta]
GO
ALTER TABLE [dbo].[FormaPagos]  WITH CHECK ADD  CONSTRAINT [FK_FormaPagos_ST_Listados] FOREIGN KEY([id_typeFE])
REFERENCES [dbo].[ST_Listados] ([id])
GO
ALTER TABLE [dbo].[FormaPagos] CHECK CONSTRAINT [FK_FormaPagos_ST_Listados]
GO
ALTER TABLE [dbo].[FormaPagos]  WITH CHECK ADD  CONSTRAINT [FK_FormaPagos_tipoformapago] FOREIGN KEY([id_tipo])
REFERENCES [dbo].[ST_Listados] ([id])
GO
ALTER TABLE [dbo].[FormaPagos] CHECK CONSTRAINT [FK_FormaPagos_tipoformapago]
GO
ALTER TABLE [dbo].[FormaPagos]  WITH CHECK ADD  CONSTRAINT [FK_FormaPagos_Usuariocreated] FOREIGN KEY([id_usercreated])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [dbo].[FormaPagos] CHECK CONSTRAINT [FK_FormaPagos_Usuariocreated]
GO
ALTER TABLE [dbo].[FormaPagos]  WITH CHECK ADD  CONSTRAINT [FK_FormaPagos_Usuarioupdate] FOREIGN KEY([id_userupdated])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [dbo].[FormaPagos] CHECK CONSTRAINT [FK_FormaPagos_Usuarioupdate]
GO
ALTER TABLE [dbo].[MenusPerfiles]  WITH CHECK ADD  CONSTRAINT [FK_MenusPerfiles_aspnet_Roles] FOREIGN KEY([id_perfil])
REFERENCES [dbo].[aspnet_Roles] ([id])
GO
ALTER TABLE [dbo].[MenusPerfiles] CHECK CONSTRAINT [FK_MenusPerfiles_aspnet_Roles]
GO
ALTER TABLE [dbo].[MenusPerfiles]  WITH CHECK ADD  CONSTRAINT [FK_MenusPerfiles_Menus] FOREIGN KEY([id_menu])
REFERENCES [dbo].[Menus] ([id])
GO
ALTER TABLE [dbo].[MenusPerfiles] CHECK CONSTRAINT [FK_MenusPerfiles_Menus]
GO
ALTER TABLE [dbo].[MOVAjustes]  WITH CHECK ADD  CONSTRAINT [FK_MOVAjustes_Conceptos] FOREIGN KEY([id_concepto])
REFERENCES [dbo].[Productos] ([id])
GO
ALTER TABLE [dbo].[MOVAjustes] CHECK CONSTRAINT [FK_MOVAjustes_Conceptos]
GO
ALTER TABLE [dbo].[MOVAjustes]  WITH CHECK ADD  CONSTRAINT [FK_MOVAjustes_MOVAjustes1] FOREIGN KEY([id_reversion])
REFERENCES [dbo].[MOVAjustes] ([id])
GO
ALTER TABLE [dbo].[MOVAjustes] CHECK CONSTRAINT [FK_MOVAjustes_MOVAjustes1]
GO
ALTER TABLE [dbo].[MOVAjustes]  WITH CHECK ADD  CONSTRAINT [FK_MOVAjustes_ST_Listados] FOREIGN KEY([estado])
REFERENCES [dbo].[ST_Listados] ([id])
GO
ALTER TABLE [dbo].[MOVAjustes] CHECK CONSTRAINT [FK_MOVAjustes_ST_Listados]
GO
ALTER TABLE [dbo].[MOVAjustes]  WITH CHECK ADD  CONSTRAINT [FK_MOVAjustes_Usuarios] FOREIGN KEY([id_user])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [dbo].[MOVAjustes] CHECK CONSTRAINT [FK_MOVAjustes_Usuarios]
GO
ALTER TABLE [dbo].[MOVAjustesItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVAjustesItems_Articulos] FOREIGN KEY([id_articulo])
REFERENCES [dbo].[Productos] ([id])
GO
ALTER TABLE [dbo].[MOVAjustesItems] CHECK CONSTRAINT [FK_MOVAjustesItems_Articulos]
GO
ALTER TABLE [dbo].[MOVAjustesItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVAjustesItems_Bodegas] FOREIGN KEY([id_bodega])
REFERENCES [dbo].[Bodegas] ([id])
GO
ALTER TABLE [dbo].[MOVAjustesItems] CHECK CONSTRAINT [FK_MOVAjustesItems_Bodegas]
GO
ALTER TABLE [dbo].[MOVAjustesItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVAjustesItems_MOVAjustes] FOREIGN KEY([id_ajuste])
REFERENCES [dbo].[MOVAjustes] ([id])
GO
ALTER TABLE [dbo].[MOVAjustesItems] CHECK CONSTRAINT [FK_MOVAjustesItems_MOVAjustes]
GO
ALTER TABLE [dbo].[MOVAjustesItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVAjustesItems_Usuarios] FOREIGN KEY([id_user])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [dbo].[MOVAjustesItems] CHECK CONSTRAINT [FK_MOVAjustesItems_Usuarios]
GO
ALTER TABLE [dbo].[MovAjustesLotes]  WITH CHECK ADD  CONSTRAINT [FK_MovAjustesLotes_LotesProducto] FOREIGN KEY([id_lote])
REFERENCES [dbo].[LotesProducto] ([id])
GO
ALTER TABLE [dbo].[MovAjustesLotes] CHECK CONSTRAINT [FK_MovAjustesLotes_LotesProducto]
GO
ALTER TABLE [dbo].[MovAjustesLotes]  WITH CHECK ADD  CONSTRAINT [FK_MovAjustesLotes_MOVAjustes] FOREIGN KEY([id_ajuste])
REFERENCES [dbo].[MOVAjustes] ([id])
GO
ALTER TABLE [dbo].[MovAjustesLotes] CHECK CONSTRAINT [FK_MovAjustesLotes_MOVAjustes]
GO
ALTER TABLE [dbo].[MovAjustesLotes]  WITH CHECK ADD  CONSTRAINT [FK_MovAjustesLotes_MOVAjustesItems] FOREIGN KEY([id_item])
REFERENCES [dbo].[MOVAjustesItems] ([id])
GO
ALTER TABLE [dbo].[MovAjustesLotes] CHECK CONSTRAINT [FK_MovAjustesLotes_MOVAjustesItems]
GO
ALTER TABLE [dbo].[MovAjustesSeries]  WITH CHECK ADD  CONSTRAINT [FK_MovAjustesSeries_MOVAjustes] FOREIGN KEY([id_ajuste])
REFERENCES [dbo].[MOVAjustes] ([id])
GO
ALTER TABLE [dbo].[MovAjustesSeries] CHECK CONSTRAINT [FK_MovAjustesSeries_MOVAjustes]
GO
ALTER TABLE [dbo].[MovAjustesSeries]  WITH CHECK ADD  CONSTRAINT [FK_MovAjustesSeries_MOVEntradasItems] FOREIGN KEY([id_items])
REFERENCES [dbo].[MOVAjustesItems] ([id])
GO
ALTER TABLE [dbo].[MovAjustesSeries] CHECK CONSTRAINT [FK_MovAjustesSeries_MOVEntradasItems]
GO
ALTER TABLE [dbo].[MOVAnticipos]  WITH CHECK ADD  CONSTRAINT [FK_MOVAnticipos_FormaPagos] FOREIGN KEY([id_formapago])
REFERENCES [dbo].[FormaPagos] ([id])
GO
ALTER TABLE [dbo].[MOVAnticipos] CHECK CONSTRAINT [FK_MOVAnticipos_FormaPagos]
GO
ALTER TABLE [dbo].[MOVAnticipos]  WITH CHECK ADD  CONSTRAINT [FK_MOVAnticipos_MOVAnticipos] FOREIGN KEY([id_reversion])
REFERENCES [dbo].[MOVAnticipos] ([id])
GO
ALTER TABLE [dbo].[MOVAnticipos] CHECK CONSTRAINT [FK_MOVAnticipos_MOVAnticipos]
GO
ALTER TABLE [dbo].[MOVAnticipos]  WITH CHECK ADD  CONSTRAINT [FK_MOVAnticipos_Productos] FOREIGN KEY([id_cuenta])
REFERENCES [dbo].[CNTCuentas] ([id])
GO
ALTER TABLE [dbo].[MOVAnticipos] CHECK CONSTRAINT [FK_MOVAnticipos_Productos]
GO
ALTER TABLE [dbo].[MOVAnticipos]  WITH CHECK ADD  CONSTRAINT [FK_MOVAnticipos_Terceros] FOREIGN KEY([id_tercero])
REFERENCES [CNT].[TipoTerceros] ([id])
GO
ALTER TABLE [dbo].[MOVAnticipos] CHECK CONSTRAINT [FK_MOVAnticipos_Terceros]
GO
ALTER TABLE [dbo].[MOVConversiones]  WITH CHECK ADD  CONSTRAINT [FK_MOVConversiones_Conceptos] FOREIGN KEY([id_concepto])
REFERENCES [dbo].[Productos] ([id])
GO
ALTER TABLE [dbo].[MOVConversiones] CHECK CONSTRAINT [FK_MOVConversiones_Conceptos]
GO
ALTER TABLE [dbo].[MOVConversiones]  WITH CHECK ADD  CONSTRAINT [FK_MOVConversiones_MOVConversiones] FOREIGN KEY([id_reversion])
REFERENCES [dbo].[MOVConversiones] ([id])
GO
ALTER TABLE [dbo].[MOVConversiones] CHECK CONSTRAINT [FK_MOVConversiones_MOVConversiones]
GO
ALTER TABLE [dbo].[MOVConversiones]  WITH CHECK ADD  CONSTRAINT [FK_MOVConversiones_ST_Listados] FOREIGN KEY([estado])
REFERENCES [dbo].[ST_Listados] ([id])
GO
ALTER TABLE [dbo].[MOVConversiones] CHECK CONSTRAINT [FK_MOVConversiones_ST_Listados]
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
ALTER TABLE [dbo].[MOVCotizacion]  WITH CHECK ADD  CONSTRAINT [FK_MOVCotizacion_Bodegas] FOREIGN KEY([id_bodega])
REFERENCES [dbo].[Bodegas] ([id])
GO
ALTER TABLE [dbo].[MOVCotizacion] CHECK CONSTRAINT [FK_MOVCotizacion_Bodegas]
GO
ALTER TABLE [dbo].[MOVCotizacion]  WITH CHECK ADD  CONSTRAINT [FK_MOVCotizacion_Cajas] FOREIGN KEY([id_caja])
REFERENCES [dbo].[Cajas] ([id])
GO
ALTER TABLE [dbo].[MOVCotizacion] CHECK CONSTRAINT [FK_MOVCotizacion_Cajas]
GO
ALTER TABLE [dbo].[MOVCotizacion]  WITH CHECK ADD  CONSTRAINT [FK_MOVCotizacion_Turnos] FOREIGN KEY([id_turno])
REFERENCES [dbo].[Turnos] ([id])
GO
ALTER TABLE [dbo].[MOVCotizacion] CHECK CONSTRAINT [FK_MOVCotizacion_Turnos]
GO
ALTER TABLE [dbo].[MOVCotizacion]  WITH CHECK ADD  CONSTRAINT [FK_MOVCotizacion_Vendedores] FOREIGN KEY([id_vendedor])
REFERENCES [dbo].[Vendedores] ([id])
GO
ALTER TABLE [dbo].[MOVCotizacion] CHECK CONSTRAINT [FK_MOVCotizacion_Vendedores]
GO
ALTER TABLE [dbo].[MOVCotizacionItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVCotizacionItems_Articulos] FOREIGN KEY([id_articulo])
REFERENCES [dbo].[Productos] ([id])
GO
ALTER TABLE [dbo].[MOVCotizacionItems] CHECK CONSTRAINT [FK_MOVCotizacionItems_Articulos]
GO
ALTER TABLE [dbo].[MOVCotizacionItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVCotizacionItems_Bodegas] FOREIGN KEY([id_bodega])
REFERENCES [dbo].[Bodegas] ([id])
GO
ALTER TABLE [dbo].[MOVCotizacionItems] CHECK CONSTRAINT [FK_MOVCotizacionItems_Bodegas]
GO
ALTER TABLE [dbo].[MOVCotizacionItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVCotizacionItems_MOVCotizacion] FOREIGN KEY([id_Cotizacion])
REFERENCES [dbo].[MOVCotizacion] ([id])
GO
ALTER TABLE [dbo].[MOVCotizacionItems] CHECK CONSTRAINT [FK_MOVCotizacionItems_MOVCotizacion]
GO
ALTER TABLE [dbo].[MOVDevAnticipos]  WITH CHECK ADD  CONSTRAINT [FK_MOVDevAnticipos_CNTCuentas] FOREIGN KEY([id_cta])
REFERENCES [dbo].[CNTCuentas] ([id])
GO
ALTER TABLE [dbo].[MOVDevAnticipos] CHECK CONSTRAINT [FK_MOVDevAnticipos_CNTCuentas]
GO
ALTER TABLE [dbo].[MOVDevAnticipos]  WITH CHECK ADD  CONSTRAINT [FK_MOVDevAnticipos_FormaPagos] FOREIGN KEY([id_formapago])
REFERENCES [dbo].[FormaPagos] ([id])
GO
ALTER TABLE [dbo].[MOVDevAnticipos] CHECK CONSTRAINT [FK_MOVDevAnticipos_FormaPagos]
GO
ALTER TABLE [dbo].[MOVDevAnticipos]  WITH CHECK ADD  CONSTRAINT [FK_MOVDevAnticipos_MOVDevAnticipos] FOREIGN KEY([id_reversion])
REFERENCES [dbo].[MOVDevAnticipos] ([id])
GO
ALTER TABLE [dbo].[MOVDevAnticipos] CHECK CONSTRAINT [FK_MOVDevAnticipos_MOVDevAnticipos]
GO
ALTER TABLE [dbo].[MOVDevEntradas]  WITH CHECK ADD  CONSTRAINT [FK_MOVDevEntradas_MOVEntradas] FOREIGN KEY([id_entrada])
REFERENCES [dbo].[MOVEntradas] ([id])
GO
ALTER TABLE [dbo].[MOVDevEntradas] CHECK CONSTRAINT [FK_MOVDevEntradas_MOVEntradas]
GO
ALTER TABLE [dbo].[MOVDevEntradas]  WITH CHECK ADD  CONSTRAINT [FK_MOVDevEntradas_ST_Listados] FOREIGN KEY([estado])
REFERENCES [dbo].[ST_Listados] ([id])
GO
ALTER TABLE [dbo].[MOVDevEntradas] CHECK CONSTRAINT [FK_MOVDevEntradas_ST_Listados]
GO
ALTER TABLE [dbo].[MOVDevEntradasItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVDevEntradasItems_Articulos] FOREIGN KEY([id_articulo])
REFERENCES [dbo].[Productos] ([id])
GO
ALTER TABLE [dbo].[MOVDevEntradasItems] CHECK CONSTRAINT [FK_MOVDevEntradasItems_Articulos]
GO
ALTER TABLE [dbo].[MOVDevEntradasItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVDevEntradasItems_Bodegas] FOREIGN KEY([id_bodega])
REFERENCES [dbo].[Bodegas] ([id])
GO
ALTER TABLE [dbo].[MOVDevEntradasItems] CHECK CONSTRAINT [FK_MOVDevEntradasItems_Bodegas]
GO
ALTER TABLE [dbo].[MOVDevEntradasItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVDevEntradasItems_MOVEntradas] FOREIGN KEY([id_devolucion])
REFERENCES [dbo].[MOVDevEntradas] ([id])
GO
ALTER TABLE [dbo].[MOVDevEntradasItems] CHECK CONSTRAINT [FK_MOVDevEntradasItems_MOVEntradas]
GO
ALTER TABLE [dbo].[MOVDevEntradasItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVDevEntradasItems_MOVEntradasItems] FOREIGN KEY([id_itementra])
REFERENCES [dbo].[MOVEntradasItems] ([id])
GO
ALTER TABLE [dbo].[MOVDevEntradasItems] CHECK CONSTRAINT [FK_MOVDevEntradasItems_MOVEntradasItems]
GO
ALTER TABLE [dbo].[MovDevEntradasSeries]  WITH CHECK ADD  CONSTRAINT [FK_MovDevEntradasSeries_MOVEntradas] FOREIGN KEY([id_devolucion])
REFERENCES [dbo].[MOVDevEntradas] ([id])
GO
ALTER TABLE [dbo].[MovDevEntradasSeries] CHECK CONSTRAINT [FK_MovDevEntradasSeries_MOVEntradas]
GO
ALTER TABLE [dbo].[MovDevEntradasSeries]  WITH CHECK ADD  CONSTRAINT [FK_MovDevEntradasSeries_MOVEntradasItems] FOREIGN KEY([id_items])
REFERENCES [dbo].[MOVDevEntradasItems] ([id])
GO
ALTER TABLE [dbo].[MovDevEntradasSeries] CHECK CONSTRAINT [FK_MovDevEntradasSeries_MOVEntradasItems]
GO
ALTER TABLE [dbo].[MOVDevFactura]  WITH CHECK ADD  CONSTRAINT [FK_MOVDevFactura_Cajas] FOREIGN KEY([id_caja])
REFERENCES [dbo].[Cajas] ([id])
GO
ALTER TABLE [dbo].[MOVDevFactura] CHECK CONSTRAINT [FK_MOVDevFactura_Cajas]
GO
ALTER TABLE [dbo].[MOVDevFactura]  WITH CHECK ADD  CONSTRAINT [FK_MOVDevFactura_CNTCuentas] FOREIGN KEY([id_ctaant])
REFERENCES [dbo].[CNTCuentas] ([id])
GO
ALTER TABLE [dbo].[MOVDevFactura] CHECK CONSTRAINT [FK_MOVDevFactura_CNTCuentas]
GO
ALTER TABLE [dbo].[MOVDevFactura]  WITH CHECK ADD  CONSTRAINT [FK_MOVDevFactura_MOVDevFactura] FOREIGN KEY([id_reversion])
REFERENCES [dbo].[MOVDevFactura] ([id])
GO
ALTER TABLE [dbo].[MOVDevFactura] CHECK CONSTRAINT [FK_MOVDevFactura_MOVDevFactura]
GO
ALTER TABLE [dbo].[MOVDevFactura]  WITH CHECK ADD  CONSTRAINT [FK_MOVDevFactura_MOVFactura] FOREIGN KEY([id_factura])
REFERENCES [dbo].[MOVFactura] ([id])
GO
ALTER TABLE [dbo].[MOVDevFactura] CHECK CONSTRAINT [FK_MOVDevFactura_MOVFactura]
GO
ALTER TABLE [dbo].[MOVDevFacturaConceptos]  WITH CHECK ADD  CONSTRAINT [FK_MOVDevFacturaConceptos_Conceptos] FOREIGN KEY([id_concepto])
REFERENCES [dbo].[Conceptos] ([id])
GO
ALTER TABLE [dbo].[MOVDevFacturaConceptos] CHECK CONSTRAINT [FK_MOVDevFacturaConceptos_Conceptos]
GO
ALTER TABLE [dbo].[MOVDevFacturaConceptos]  WITH CHECK ADD  CONSTRAINT [FK_MOVDevFacturaConceptos_MOVDevFactura] FOREIGN KEY([id_devolucion])
REFERENCES [dbo].[MOVDevFactura] ([id])
GO
ALTER TABLE [dbo].[MOVDevFacturaConceptos] CHECK CONSTRAINT [FK_MOVDevFacturaConceptos_MOVDevFactura]
GO
ALTER TABLE [dbo].[MOVDevFacturaFormaPago]  WITH CHECK ADD  CONSTRAINT [FK_MOVDevFacturaFormaPago_FormaPagos] FOREIGN KEY([id_formapago])
REFERENCES [dbo].[FormaPagos] ([id])
GO
ALTER TABLE [dbo].[MOVDevFacturaFormaPago] CHECK CONSTRAINT [FK_MOVDevFacturaFormaPago_FormaPagos]
GO
ALTER TABLE [dbo].[MOVDevFacturaFormaPago]  WITH CHECK ADD  CONSTRAINT [FK_MOVDevFacturaFormaPago_MOVDevFactura] FOREIGN KEY([id_devolucion])
REFERENCES [dbo].[MOVDevFactura] ([id])
GO
ALTER TABLE [dbo].[MOVDevFacturaFormaPago] CHECK CONSTRAINT [FK_MOVDevFacturaFormaPago_MOVDevFactura]
GO
ALTER TABLE [dbo].[MOVDevFacturaFormaPago]  WITH CHECK ADD  CONSTRAINT [FK_MOVDevFacturaFormaPago_MOVFactura] FOREIGN KEY([id_factura])
REFERENCES [dbo].[MOVFactura] ([id])
GO
ALTER TABLE [dbo].[MOVDevFacturaFormaPago] CHECK CONSTRAINT [FK_MOVDevFacturaFormaPago_MOVFactura]
GO
ALTER TABLE [dbo].[MOVDevFacturaItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVDevFacturaItems_Articulos] FOREIGN KEY([id_articulo])
REFERENCES [dbo].[Productos] ([id])
GO
ALTER TABLE [dbo].[MOVDevFacturaItems] CHECK CONSTRAINT [FK_MOVDevFacturaItems_Articulos]
GO
ALTER TABLE [dbo].[MOVDevFacturaItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVDevFacturaItems_Bodegas] FOREIGN KEY([id_bodega])
REFERENCES [dbo].[Bodegas] ([id])
GO
ALTER TABLE [dbo].[MOVDevFacturaItems] CHECK CONSTRAINT [FK_MOVDevFacturaItems_Bodegas]
GO
ALTER TABLE [dbo].[MOVDevFacturaItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVDevFacturaItems_CNTCuentas] FOREIGN KEY([id_ctainc])
REFERENCES [dbo].[CNTCuentas] ([id])
GO

ALTER TABLE [dbo].[MOVDevFacturaItems] CHECK CONSTRAINT [FK_MOVDevFacturaItems_CNTCuentas]
GO

ALTER TABLE [dbo].[MOVDevFacturaItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVDevFacturaItems_MOVDevFactura] FOREIGN KEY([id_devolucion])
REFERENCES [dbo].[MOVDevFactura] ([id])
GO
ALTER TABLE [dbo].[MOVDevFacturaItems] CHECK CONSTRAINT [FK_MOVDevFacturaItems_MOVDevFactura]
GO
ALTER TABLE [dbo].[MOVDevFacturaItemsForm]  WITH CHECK ADD  CONSTRAINT [FK_MOVDevFacturaItemsForm_Articulos] FOREIGN KEY([id_articulo])
REFERENCES [dbo].[Productos] ([id])
GO
ALTER TABLE [dbo].[MOVDevFacturaItemsForm] CHECK CONSTRAINT [FK_MOVDevFacturaItemsForm_Articulos]
GO
ALTER TABLE [dbo].[MOVDevFacturaItemsForm]  WITH CHECK ADD  CONSTRAINT [FK_MOVDevFacturaItemsForm_Bodegas] FOREIGN KEY([id_bodega])
REFERENCES [dbo].[Bodegas] ([id])
GO
ALTER TABLE [dbo].[MOVDevFacturaItemsForm] CHECK CONSTRAINT [FK_MOVDevFacturaItemsForm_Bodegas]
GO
ALTER TABLE [dbo].[MOVDevFacturaItemsForm]  WITH CHECK ADD  CONSTRAINT [FK_MOVDevFacturaItemsForm_MOVDevFactura] FOREIGN KEY([id_devfactura])
REFERENCES [dbo].[MOVDevFactura] ([id])
GO
ALTER TABLE [dbo].[MOVDevFacturaItemsForm] CHECK CONSTRAINT [FK_MOVDevFacturaItemsForm_MOVDevFactura]
GO
ALTER TABLE [dbo].[MOVDevFacturaItemsForm]  WITH CHECK ADD  CONSTRAINT [FK_MOVDevFacturaItemsForm_MOVFacturaItems] FOREIGN KEY([id_articulofac])
REFERENCES [dbo].[MOVDevFacturaItems] ([id])
GO
ALTER TABLE [dbo].[MOVDevFacturaItemsForm] CHECK CONSTRAINT [FK_MOVDevFacturaItemsForm_MOVFacturaItems]
GO
ALTER TABLE [dbo].[MOVDevFacturaLotes]  WITH CHECK ADD  CONSTRAINT [FK_MOVDevFacturaLotes_LotesProducto] FOREIGN KEY([id_lote])
REFERENCES [dbo].[LotesProducto] ([id])
GO
ALTER TABLE [dbo].[MOVDevFacturaLotes] CHECK CONSTRAINT [FK_MOVDevFacturaLotes_LotesProducto]
GO
ALTER TABLE [dbo].[MOVDevFacturaLotes]  WITH CHECK ADD  CONSTRAINT [FK_MOVDevFacturaLotes_MOVDevFactura] FOREIGN KEY([id_devolucion])
REFERENCES [dbo].[MOVDevFactura] ([id])
GO
ALTER TABLE [dbo].[MOVDevFacturaLotes] CHECK CONSTRAINT [FK_MOVDevFacturaLotes_MOVDevFactura]
GO
ALTER TABLE [dbo].[MOVDevFacturaLotes]  WITH CHECK ADD  CONSTRAINT [FK_MOVDevFacturaLotes_MOVDevFacturaItems] FOREIGN KEY([id_item])
REFERENCES [dbo].[MOVDevFacturaItems] ([id])
GO
ALTER TABLE [dbo].[MOVDevFacturaLotes] CHECK CONSTRAINT [FK_MOVDevFacturaLotes_MOVDevFacturaItems]
GO
ALTER TABLE [dbo].[MovDevFacturasSeries]  WITH CHECK ADD  CONSTRAINT [FK_MovDevFacturasSeries_MOVDevfactura] FOREIGN KEY([id_devolucion])
REFERENCES [dbo].[MOVDevFactura] ([id])
GO
ALTER TABLE [dbo].[MovDevFacturasSeries] CHECK CONSTRAINT [FK_MovDevFacturasSeries_MOVDevfactura]
GO
ALTER TABLE [dbo].[MovDevFacturasSeries]  WITH CHECK ADD  CONSTRAINT [FK_MovDevFacturasSeries_MOVDevFacturaItems] FOREIGN KEY([id_items])
REFERENCES [dbo].[MOVDevFacturaItems] ([id])
GO
ALTER TABLE [dbo].[MovDevFacturasSeries] CHECK CONSTRAINT [FK_MovDevFacturasSeries_MOVDevFacturaItems]
GO
ALTER TABLE [dbo].[MOVDocumentItemTemp]  WITH CHECK ADD  CONSTRAINT [FK_MovDcumentItemTemp_Articulos] FOREIGN KEY([id_articulo])
REFERENCES [dbo].[Productos] ([id])
GO
ALTER TABLE [dbo].[MOVDocumentItemTemp] CHECK CONSTRAINT [FK_MovDcumentItemTemp_Articulos]
GO
ALTER TABLE [dbo].[MOVDocumentItemTemp]  WITH CHECK ADD  CONSTRAINT [FK_MovDcumentItemTemp_Bodegas] FOREIGN KEY([id_bodega])
REFERENCES [dbo].[Bodegas] ([id])
GO
ALTER TABLE [dbo].[MOVDocumentItemTemp] CHECK CONSTRAINT [FK_MovDcumentItemTemp_Bodegas]
GO
ALTER TABLE [dbo].[MOVDocumentItemTemp]  WITH CHECK ADD  CONSTRAINT [FK_MovDcumentItemTemp_Bodegas1] FOREIGN KEY([id_bodegades])
REFERENCES [dbo].[Bodegas] ([id])
GO
ALTER TABLE [dbo].[MOVDocumentItemTemp] CHECK CONSTRAINT [FK_MovDcumentItemTemp_Bodegas1]
GO
ALTER TABLE [dbo].[MOVDocumentoConctTemp]  WITH CHECK ADD  CONSTRAINT [FK_MOVDocumentoConctTemp_Conceptos] FOREIGN KEY([id_concepto])
REFERENCES [dbo].[Conceptos] ([id])
GO
ALTER TABLE [dbo].[MOVDocumentoConctTemp] CHECK CONSTRAINT [FK_MOVDocumentoConctTemp_Conceptos]
GO
ALTER TABLE [dbo].[MOVDocumentosCajas]  WITH CHECK ADD  CONSTRAINT [FK_MOVDocumentosCajas_Cajas] FOREIGN KEY([id_caja])
REFERENCES [dbo].[Cajas] ([id])
GO
ALTER TABLE [dbo].[MOVDocumentosCajas] CHECK CONSTRAINT [FK_MOVDocumentosCajas_Cajas]
GO
ALTER TABLE [dbo].[MOVDocumentosCajas]  WITH CHECK ADD  CONSTRAINT [FK_MOVDocumentosCajas_MOVDocumentosCajas] FOREIGN KEY([id_reversion])
REFERENCES [dbo].[MOVDocumentosCajas] ([id])
GO
ALTER TABLE [dbo].[MOVDocumentosCajas] CHECK CONSTRAINT [FK_MOVDocumentosCajas_MOVDocumentosCajas]
GO
ALTER TABLE [dbo].[MOVDocumentosCajasCpts]  WITH CHECK ADD  CONSTRAINT [FK_MOVDocumentosCajasCpts_Conceptos] FOREIGN KEY([id_concepto])
REFERENCES [dbo].[Conceptos] ([id])
GO
ALTER TABLE [dbo].[MOVDocumentosCajasCpts] CHECK CONSTRAINT [FK_MOVDocumentosCajasCpts_Conceptos]
GO
ALTER TABLE [dbo].[MOVDocumentosCajasCpts]  WITH CHECK ADD  CONSTRAINT [FK_MOVDocumentosCajasCpts_MOVDocumentosCajas] FOREIGN KEY([id_doccaja])
REFERENCES [dbo].[MOVDocumentosCajas] ([id])
GO
ALTER TABLE [dbo].[MOVDocumentosCajasCpts] CHECK CONSTRAINT [FK_MOVDocumentosCajasCpts_MOVDocumentosCajas]
GO
ALTER TABLE [dbo].[MOVDocumentosCajasCpts]  WITH CHECK ADD  CONSTRAINT [FK_MOVDocumentosCajasCpts_ST_Listados] FOREIGN KEY([id_tipo])
REFERENCES [dbo].[ST_Listados] ([id])
GO
ALTER TABLE [dbo].[MOVDocumentosCajasCpts] CHECK CONSTRAINT [FK_MOVDocumentosCajasCpts_ST_Listados]
GO
ALTER TABLE [dbo].[MOVEntradaLotesTemp]  WITH CHECK ADD  CONSTRAINT [FK_MOVEntradaLotesTemp_LotesProducto] FOREIGN KEY([id_lote])
REFERENCES [dbo].[LotesProducto] ([id])
GO
ALTER TABLE [dbo].[MOVEntradaLotesTemp] CHECK CONSTRAINT [FK_MOVEntradaLotesTemp_LotesProducto]
GO
ALTER TABLE [dbo].[MOVEntradaLotesTemp]  WITH CHECK ADD  CONSTRAINT [FK_MOVEntradaLotesTemp_MOVEntradasItemsTemp] FOREIGN KEY([id_itemtemp])
REFERENCES [dbo].[MOVEntradasItemsTemp] ([id])
GO
ALTER TABLE [dbo].[MOVEntradaLotesTemp] CHECK CONSTRAINT [FK_MOVEntradaLotesTemp_MOVEntradasItemsTemp]
GO
ALTER TABLE [dbo].[MOVEntradas]  WITH CHECK ADD  CONSTRAINT [FK_MOVEntradas_Bodegas] FOREIGN KEY([id_bodega])
REFERENCES [dbo].[Bodegas] ([id])
GO
ALTER TABLE [dbo].[MOVEntradas] CHECK CONSTRAINT [FK_MOVEntradas_Bodegas]
GO
ALTER TABLE [dbo].[MOVEntradas]  WITH CHECK ADD  CONSTRAINT [FK_MOVEntradas_MOVEntradas] FOREIGN KEY([id_reversion])
REFERENCES [dbo].[MOVEntradas] ([id])
GO
ALTER TABLE [dbo].[MOVEntradas] CHECK CONSTRAINT [FK_MOVEntradas_MOVEntradas]
GO
ALTER TABLE [dbo].[MOVEntradas]  WITH CHECK ADD  CONSTRAINT [FK_MOVEntradas_MOVPedidos] FOREIGN KEY([id_pedido])
REFERENCES [dbo].[MOVPedidos] ([id])
GO
ALTER TABLE [dbo].[MOVEntradas] CHECK CONSTRAINT [FK_MOVEntradas_MOVPedidos]
GO
ALTER TABLE [dbo].[MOVEntradas]  WITH CHECK ADD  CONSTRAINT [FK_MOVEntradas_Proveedores] FOREIGN KEY([id_proveedor])
REFERENCES [CNT].[TipoTerceros] ([id])
GO
ALTER TABLE [dbo].[MOVEntradas] CHECK CONSTRAINT [FK_MOVEntradas_Proveedores]
GO
ALTER TABLE [dbo].[MOVEntradas]  WITH CHECK ADD  CONSTRAINT [FK_MOVEntradas_ST_Listados] FOREIGN KEY([estado])
REFERENCES [dbo].[ST_Listados] ([id])
GO
ALTER TABLE [dbo].[MOVEntradas] CHECK CONSTRAINT [FK_MOVEntradas_ST_Listados]
GO
ALTER TABLE [dbo].[MOVEntradas]  WITH CHECK ADD  CONSTRAINT [FK_MOVEntradas_TipoDocumentos] FOREIGN KEY([id_tipodoc])
REFERENCES [CNT].[TipoDocumentos] ([id])
GO
ALTER TABLE [dbo].[MOVEntradas] CHECK CONSTRAINT [FK_MOVEntradas_TipoDocumentos]
GO
ALTER TABLE [dbo].[MOVEntradasItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVEntradasItems_Articulos] FOREIGN KEY([id_articulo])
REFERENCES [dbo].[Productos] ([id])
GO
ALTER TABLE [dbo].[MOVEntradasItems] CHECK CONSTRAINT [FK_MOVEntradasItems_Articulos]
GO
ALTER TABLE [dbo].[MOVEntradasItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVEntradasItems_Bodegas] FOREIGN KEY([id_bodega])
REFERENCES [dbo].[Bodegas] ([id])
GO
ALTER TABLE [dbo].[MOVEntradasItems] CHECK CONSTRAINT [FK_MOVEntradasItems_Bodegas]
GO
ALTER TABLE [dbo].[MOVEntradasItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVEntradasItems_CNTCuentas] FOREIGN KEY([id_ctainc])
REFERENCES [dbo].[CNTCuentas] ([id])
GO
ALTER TABLE [dbo].[MOVEntradasItems] CHECK CONSTRAINT [FK_MOVEntradasItems_CNTCuentas]
GO
ALTER TABLE [dbo].[MOVEntradasItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVEntradasItems_CNTCuentas1] FOREIGN KEY([id_ctaiva])
REFERENCES [dbo].[CNTCuentas] ([id])
GO
ALTER TABLE [dbo].[MOVEntradasItems] CHECK CONSTRAINT [FK_MOVEntradasItems_CNTCuentas1]
GO
ALTER TABLE [dbo].[MOVEntradasItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVEntradasItems_LotesProducto] FOREIGN KEY([id_lote])
REFERENCES [dbo].[LotesProducto] ([id])
GO
ALTER TABLE [dbo].[MOVEntradasItems] CHECK CONSTRAINT [FK_MOVEntradasItems_LotesProducto]
GO
ALTER TABLE [dbo].[MOVEntradasItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVEntradasItems_MOVEntradas] FOREIGN KEY([id_entrada])
REFERENCES [dbo].[MOVEntradas] ([id])
GO
ALTER TABLE [dbo].[MOVEntradasItems] CHECK CONSTRAINT [FK_MOVEntradasItems_MOVEntradas]
GO
ALTER TABLE [dbo].[MOVEntradasItemsTemp]  WITH CHECK ADD  CONSTRAINT [FK_MOVEntradasItemsTemp_Articulos] FOREIGN KEY([id_articulo])
REFERENCES [dbo].[Productos] ([id])
GO
ALTER TABLE [dbo].[MOVEntradasItemsTemp] CHECK CONSTRAINT [FK_MOVEntradasItemsTemp_Articulos]
GO
ALTER TABLE [dbo].[MOVEntradasItemsTemp]  WITH CHECK ADD  CONSTRAINT [FK_MOVEntradasItemsTemp_Bodegas] FOREIGN KEY([id_bodega])
REFERENCES [dbo].[Bodegas] ([id])
GO
ALTER TABLE [dbo].[MOVEntradasItemsTemp] CHECK CONSTRAINT [FK_MOVEntradasItemsTemp_Bodegas]
GO
ALTER TABLE [dbo].[MOVEntradasItemsTemp]  WITH CHECK ADD  CONSTRAINT [FK_MOVEntradasItemsTemp_Impuestos] FOREIGN KEY([id_inc])
REFERENCES [CNT].[Impuestos] ([id])
GO
ALTER TABLE [dbo].[MOVEntradasItemsTemp] CHECK CONSTRAINT [FK_MOVEntradasItemsTemp_Impuestos]
GO
ALTER TABLE [dbo].[MOVEntradasItemsTemp]  WITH CHECK ADD  CONSTRAINT [FK_MOVEntradasItemsTemp_Impuestos1] FOREIGN KEY([id_iva])
REFERENCES [CNT].[Impuestos] ([id])
GO
ALTER TABLE [dbo].[MOVEntradasItemsTemp] CHECK CONSTRAINT [FK_MOVEntradasItemsTemp_Impuestos1]
GO
ALTER TABLE [dbo].[MOVEntradasItemsTemp]  WITH CHECK ADD  CONSTRAINT [FK_MOVEntradasItemsTemp_MOVEntradasItems] FOREIGN KEY([id_itementra])
REFERENCES [dbo].[MOVEntradasItems] ([id])
GO
ALTER TABLE [dbo].[MOVEntradasItemsTemp] CHECK CONSTRAINT [FK_MOVEntradasItemsTemp_MOVEntradasItems]
GO
ALTER TABLE [dbo].[MOVEntradasItemsTemp]  WITH CHECK ADD  CONSTRAINT [FK_MOVEntradasItemsTemp_MOVEntradasTemp] FOREIGN KEY([id_entrada])
REFERENCES [dbo].[MOVEntradasTemp] ([id])
GO
ALTER TABLE [dbo].[MOVEntradasItemsTemp] CHECK CONSTRAINT [FK_MOVEntradasItemsTemp_MOVEntradasTemp]
GO
ALTER TABLE [dbo].[MOVEntradasLotesTemp]  WITH CHECK ADD  CONSTRAINT [FK_MOVEntradasLotesTemp_LotesProducto] FOREIGN KEY([id_lote])
REFERENCES [dbo].[LotesProducto] ([id])
GO
ALTER TABLE [dbo].[MOVEntradasLotesTemp] CHECK CONSTRAINT [FK_MOVEntradasLotesTemp_LotesProducto]
GO
ALTER TABLE [dbo].[MovEntradasSeries]  WITH CHECK ADD  CONSTRAINT [FK_MovEntradasSeries_MOVEntradas] FOREIGN KEY([id_entrada])
REFERENCES [dbo].[MOVEntradas] ([id])
GO
ALTER TABLE [dbo].[MovEntradasSeries] CHECK CONSTRAINT [FK_MovEntradasSeries_MOVEntradas]
GO
ALTER TABLE [dbo].[MovEntradasSeries]  WITH CHECK ADD  CONSTRAINT [FK_MovEntradasSeries_MOVEntradasItems] FOREIGN KEY([id_items])
REFERENCES [dbo].[MOVEntradasItems] ([id])
GO
ALTER TABLE [dbo].[MovEntradasSeries] CHECK CONSTRAINT [FK_MovEntradasSeries_MOVEntradasItems]
GO
ALTER TABLE [dbo].[MovEntradasSeriesTemp]  WITH CHECK ADD  CONSTRAINT [FK_MovEntradasSeriesTemp_MOVEntradasItemsTemp] FOREIGN KEY([id_itemstemp])
REFERENCES [dbo].[MOVEntradasItemsTemp] ([id])
GO
ALTER TABLE [dbo].[MovEntradasSeriesTemp] CHECK CONSTRAINT [FK_MovEntradasSeriesTemp_MOVEntradasItemsTemp]
GO
ALTER TABLE [dbo].[MovEntradasSeriesTemp]  WITH CHECK ADD  CONSTRAINT [FK_MovEntradasSeriesTemp_MOVEntradasTemp] FOREIGN KEY([id_entradatemp])
REFERENCES [dbo].[MOVEntradasTemp] ([id])
GO
ALTER TABLE [dbo].[MovEntradasSeriesTemp] CHECK CONSTRAINT [FK_MovEntradasSeriesTemp_MOVEntradasTemp]
GO
ALTER TABLE [dbo].[MOVEntradasTemp]  WITH CHECK ADD  CONSTRAINT [FK_MOVEntradasTemp_Bodegas] FOREIGN KEY([id_bodega])
REFERENCES [dbo].[Bodegas] ([id])
GO
ALTER TABLE [dbo].[MOVEntradasTemp] CHECK CONSTRAINT [FK_MOVEntradasTemp_Bodegas]
GO
ALTER TABLE [dbo].[MOVEntradasTemp]  WITH CHECK ADD  CONSTRAINT [FK_MOVEntradasTemp_MOVPedidos] FOREIGN KEY([id_pedido])
REFERENCES [dbo].[MOVPedidos] ([id])
GO
ALTER TABLE [dbo].[MOVEntradasTemp] CHECK CONSTRAINT [FK_MOVEntradasTemp_MOVPedidos]
GO
ALTER TABLE [dbo].[MOVEntradasTemp]  WITH CHECK ADD  CONSTRAINT [FK_MOVEntradasTemp_Proveedores] FOREIGN KEY([id_proveedor])
REFERENCES [CNT].[TipoTerceros] ([id])
GO
ALTER TABLE [dbo].[MOVEntradasTemp] CHECK CONSTRAINT [FK_MOVEntradasTemp_Proveedores]
GO
ALTER TABLE [dbo].[MOVFactura]  WITH CHECK ADD  CONSTRAINT [FK_MOVFactura_Cajas] FOREIGN KEY([id_caja])
REFERENCES [dbo].[Cajas] ([id])
GO
ALTER TABLE [dbo].[MOVFactura] CHECK CONSTRAINT [FK_MOVFactura_Cajas]
GO
ALTER TABLE [dbo].[MOVFactura]  WITH CHECK ADD  CONSTRAINT [FK_MOVFactura_CentroCosto] FOREIGN KEY([id_centrocostos])
REFERENCES [CNT].[CentroCosto] ([id])
GO
ALTER TABLE [dbo].[MOVFactura] CHECK CONSTRAINT [FK_MOVFactura_CentroCosto]
GO
ALTER TABLE [dbo].[MOVFactura]  WITH CHECK ADD  CONSTRAINT [FK_MOVFactura_CNTCuentas] FOREIGN KEY([id_ctaant])
REFERENCES [dbo].[CNTCuentas] ([id])
GO
ALTER TABLE [dbo].[MOVFactura] CHECK CONSTRAINT [FK_MOVFactura_CNTCuentas]
GO
ALTER TABLE [dbo].[MOVFactura]  WITH CHECK ADD  CONSTRAINT [FK_MOVFactura_DocumentosTecnicaKey] FOREIGN KEY([id_resolucion])
REFERENCES [dbo].[DocumentosTecnicaKey] ([id])
GO
ALTER TABLE [dbo].[MOVFactura] CHECK CONSTRAINT [FK_MOVFactura_DocumentosTecnicaKey]
GO
ALTER TABLE [dbo].[MOVFactura]  WITH CHECK ADD  CONSTRAINT [FK_MOVFactura_MOVFactura] FOREIGN KEY([id_reversion])
REFERENCES [dbo].[MOVFactura] ([id])
GO
ALTER TABLE [dbo].[MOVFactura] CHECK CONSTRAINT [FK_MOVFactura_MOVFactura]
GO
ALTER TABLE [dbo].[MOVFactura]  WITH CHECK ADD  CONSTRAINT [FK_MOVFactura_ST_Listados] FOREIGN KEY([id_tipovence])
REFERENCES [dbo].[ST_Listados] ([id])
GO
ALTER TABLE [dbo].[MOVFactura] CHECK CONSTRAINT [FK_MOVFactura_ST_Listados]
GO
ALTER TABLE [dbo].[MOVFactura]  WITH CHECK ADD  CONSTRAINT [FK_MOVFactura_Tercero] FOREIGN KEY([id_tercero])
REFERENCES [CNT].[TipoTerceros] ([id])
GO
ALTER TABLE [dbo].[MOVFactura] CHECK CONSTRAINT [FK_MOVFactura_Tercero]
GO
ALTER TABLE [dbo].[MOVFactura]  WITH CHECK ADD  CONSTRAINT [FK_MOVFactura_TipoDocumentos] FOREIGN KEY([id_tipodoc])
REFERENCES [CNT].[TipoDocumentos] ([id])
GO
ALTER TABLE [dbo].[MOVFactura] CHECK CONSTRAINT [FK_MOVFactura_TipoDocumentos]
GO
ALTER TABLE [dbo].[MOVFactura]  WITH CHECK ADD  CONSTRAINT [FK_MOVFactura_Turnos] FOREIGN KEY([id_turno])
REFERENCES [dbo].[Turnos] ([id])
GO
ALTER TABLE [dbo].[MOVFactura] CHECK CONSTRAINT [FK_MOVFactura_Turnos]
GO
ALTER TABLE [dbo].[MOVFactura]  WITH CHECK ADD  CONSTRAINT [FK_MOVFactura_Vendedores] FOREIGN KEY([id_vendedor])
REFERENCES [dbo].[Vendedores] ([id])
GO
ALTER TABLE [dbo].[MOVFactura] CHECK CONSTRAINT [FK_MOVFactura_Vendedores]
GO
ALTER TABLE [dbo].[MovFacturaCuotas]  WITH CHECK ADD  CONSTRAINT [FK_MovFacturaCuotas_MOVFactura] FOREIGN KEY([id_factura])
REFERENCES [dbo].[MOVFactura] ([id])
GO
ALTER TABLE [dbo].[MovFacturaCuotas] CHECK CONSTRAINT [FK_MovFacturaCuotas_MOVFactura]
GO
ALTER TABLE [dbo].[MOVFacturaFormaPago]  WITH CHECK ADD  CONSTRAINT [FK_MOVFacturaFormaPago_FormaPagos] FOREIGN KEY([id_formapago])
REFERENCES [dbo].[FormaPagos] ([id])
GO
ALTER TABLE [dbo].[MOVFacturaFormaPago] CHECK CONSTRAINT [FK_MOVFacturaFormaPago_FormaPagos]
GO
ALTER TABLE [dbo].[MOVFacturaFormaPago]  WITH CHECK ADD  CONSTRAINT [FK_MOVFacturaFormaPago_MOVFactura] FOREIGN KEY([id_factura])
REFERENCES [dbo].[MOVFactura] ([id])
GO
ALTER TABLE [dbo].[MOVFacturaFormaPago] CHECK CONSTRAINT [FK_MOVFacturaFormaPago_MOVFactura]
GO
ALTER TABLE [dbo].[MOVFacturaItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVFacturaItems_Articulos] FOREIGN KEY([id_producto])
REFERENCES [dbo].[Productos] ([id])
GO
ALTER TABLE [dbo].[MOVFacturaItems] CHECK CONSTRAINT [FK_MOVFacturaItems_Articulos]
GO
ALTER TABLE [dbo].[MOVFacturaItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVFacturaItems_Bodegas] FOREIGN KEY([id_bodega])
REFERENCES [dbo].[Bodegas] ([id])
GO
ALTER TABLE [dbo].[MOVFacturaItems] CHECK CONSTRAINT [FK_MOVFacturaItems_Bodegas]
GO
ALTER TABLE [dbo].[MOVFacturaItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVFacturaItems_CNTCuentas] FOREIGN KEY([id_ctaiva])
REFERENCES [dbo].[CNTCuentas] ([id])
GO
ALTER TABLE [dbo].[MOVFacturaItems] CHECK CONSTRAINT [FK_MOVFacturaItems_CNTCuentas]
GO
ALTER TABLE [dbo].[MOVFacturaItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVFacturaItems_CNTCuentas1] FOREIGN KEY([id_ctainc])
REFERENCES [dbo].[CNTCuentas] ([id])
GO
ALTER TABLE [dbo].[MOVFacturaItems] CHECK CONSTRAINT [FK_MOVFacturaItems_CNTCuentas1]
GO
ALTER TABLE [dbo].[MOVFacturaItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVFacturaItems_MOVFactura] FOREIGN KEY([id_factura])
REFERENCES [dbo].[MOVFactura] ([id])
GO
ALTER TABLE [dbo].[MOVFacturaItems] CHECK CONSTRAINT [FK_MOVFacturaItems_MOVFactura]
GO
ALTER TABLE [dbo].[MOVFacturaItemsForm]  WITH CHECK ADD  CONSTRAINT [FK_MOVFacturaItemsForm_Articulos] FOREIGN KEY([id_articulo])
REFERENCES [dbo].[Productos] ([id])
GO
ALTER TABLE [dbo].[MOVFacturaItemsForm] CHECK CONSTRAINT [FK_MOVFacturaItemsForm_Articulos]
GO
ALTER TABLE [dbo].[MOVFacturaItemsForm]  WITH CHECK ADD  CONSTRAINT [FK_MOVFacturaItemsForm_Bodegas] FOREIGN KEY([id_bodega])
REFERENCES [dbo].[Bodegas] ([id])
GO
ALTER TABLE [dbo].[MOVFacturaItemsForm] CHECK CONSTRAINT [FK_MOVFacturaItemsForm_Bodegas]
GO
ALTER TABLE [dbo].[MOVFacturaItemsForm]  WITH CHECK ADD  CONSTRAINT [FK_MOVFacturaItemsForm_MOVFactura] FOREIGN KEY([id_factura])
REFERENCES [dbo].[MOVFactura] ([id])
GO
ALTER TABLE [dbo].[MOVFacturaItemsForm] CHECK CONSTRAINT [FK_MOVFacturaItemsForm_MOVFactura]
GO
ALTER TABLE [dbo].[MOVFacturaItemsForm]  WITH CHECK ADD  CONSTRAINT [FK_MOVFacturaItemsForm_MOVFacturaItems] FOREIGN KEY([id_articulofac])
REFERENCES [dbo].[MOVFacturaItems] ([id])
GO
ALTER TABLE [dbo].[MOVFacturaItemsForm] CHECK CONSTRAINT [FK_MOVFacturaItemsForm_MOVFacturaItems]
GO
ALTER TABLE [dbo].[MOVFacturaItemsTemp]  WITH CHECK ADD  CONSTRAINT [FK_MOVFacturaItemsTemp_Articulos1] FOREIGN KEY([id_articulo])
REFERENCES [dbo].[Productos] ([id])
GO
ALTER TABLE [dbo].[MOVFacturaItemsTemp] CHECK CONSTRAINT [FK_MOVFacturaItemsTemp_Articulos1]
GO
ALTER TABLE [dbo].[MOVFacturaLotes]  WITH CHECK ADD  CONSTRAINT [FK_MOVFacturaLotes_LotesProducto] FOREIGN KEY([id_lote])
REFERENCES [dbo].[LotesProducto] ([id])
GO
ALTER TABLE [dbo].[MOVFacturaLotes] CHECK CONSTRAINT [FK_MOVFacturaLotes_LotesProducto]
GO
ALTER TABLE [dbo].[MOVFacturaLotes]  WITH CHECK ADD  CONSTRAINT [FK_MOVFacturaLotes_MOVFactura] FOREIGN KEY([id_factura])
REFERENCES [dbo].[MOVFactura] ([id])
GO
ALTER TABLE [dbo].[MOVFacturaLotes] CHECK CONSTRAINT [FK_MOVFacturaLotes_MOVFactura]
GO
ALTER TABLE [dbo].[MOVFacturaLotes]  WITH CHECK ADD  CONSTRAINT [FK_MOVFacturaLotes_MOVFacturaItems] FOREIGN KEY([id_item])
REFERENCES [dbo].[MOVFacturaItems] ([id])
GO
ALTER TABLE [dbo].[MOVFacturaLotes] CHECK CONSTRAINT [FK_MOVFacturaLotes_MOVFacturaItems]
GO
ALTER TABLE [dbo].[MOVFacturaLotesTemp]  WITH CHECK ADD  CONSTRAINT [FK_MOVFacturaLotesTemp_LotesProducto] FOREIGN KEY([id_lote])
REFERENCES [dbo].[LotesProducto] ([id])
GO
ALTER TABLE [dbo].[MOVFacturaLotesTemp] CHECK CONSTRAINT [FK_MOVFacturaLotesTemp_LotesProducto]
GO
ALTER TABLE [dbo].[MOVFacturaLotesTemp]  WITH CHECK ADD  CONSTRAINT [FK_MOVFacturaLotesTemp_MOVFacturaItemsTemp] FOREIGN KEY([id_itemtemp])
REFERENCES [dbo].[MOVFacturaItemsTemp] ([id])
GO
ALTER TABLE [dbo].[MOVFacturaLotesTemp] CHECK CONSTRAINT [FK_MOVFacturaLotesTemp_MOVFacturaItemsTemp]
GO
ALTER TABLE [dbo].[MovFacturaSeries]  WITH CHECK ADD  CONSTRAINT [FK_MovFacturaSeries_MOVFactura] FOREIGN KEY([id_factura])
REFERENCES [dbo].[MOVFactura] ([id])
GO
ALTER TABLE [dbo].[MovFacturaSeries] CHECK CONSTRAINT [FK_MovFacturaSeries_MOVFactura]
GO
ALTER TABLE [dbo].[MovFacturaSeries]  WITH CHECK ADD  CONSTRAINT [FK_MovFacturaSeries_MOVFacturasItems] FOREIGN KEY([id_items])
REFERENCES [dbo].[MOVFacturaItems] ([id])
GO
ALTER TABLE [dbo].[MovFacturaSeries] CHECK CONSTRAINT [FK_MovFacturaSeries_MOVFacturasItems]
GO
ALTER TABLE [dbo].[MovFacturaSeriesTemp]  WITH CHECK ADD  CONSTRAINT [FK_MovFacturaSeriesTemp_MOVFacturasItemsTemp] FOREIGN KEY([id_itemstemp])
REFERENCES [dbo].[MOVFacturaItemsTemp] ([id])
GO
ALTER TABLE [dbo].[MovFacturaSeriesTemp] CHECK CONSTRAINT [FK_MovFacturaSeriesTemp_MOVFacturasItemsTemp]
GO
ALTER TABLE [dbo].[MOVInvenInicial]  WITH CHECK ADD  CONSTRAINT [FK_MOVInvenInicial_MOVInvenInicial] FOREIGN KEY([id_reversion])
REFERENCES [dbo].[MOVInvenInicial] ([id])
GO
ALTER TABLE [dbo].[MOVInvenInicial] CHECK CONSTRAINT [FK_MOVInvenInicial_MOVInvenInicial]
GO
ALTER TABLE [dbo].[MOVInvenInicial]  WITH CHECK ADD  CONSTRAINT [FK_MOVInvenInicial_ST_Listados] FOREIGN KEY([estado])
REFERENCES [dbo].[ST_Listados] ([id])
GO
ALTER TABLE [dbo].[MOVInvenInicial] CHECK CONSTRAINT [FK_MOVInvenInicial_ST_Listados]
GO
ALTER TABLE [dbo].[MOVInvenInicialItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVInvenInicialItems_Articulos] FOREIGN KEY([id_articulo])
REFERENCES [dbo].[Productos] ([id])
GO
ALTER TABLE [dbo].[MOVInvenInicialItems] CHECK CONSTRAINT [FK_MOVInvenInicialItems_Articulos]
GO
ALTER TABLE [dbo].[MOVInvenInicialItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVInvenInicialItems_Bodegas] FOREIGN KEY([id_bodega])
REFERENCES [dbo].[Bodegas] ([id])
GO
ALTER TABLE [dbo].[MOVInvenInicialItems] CHECK CONSTRAINT [FK_MOVInvenInicialItems_Bodegas]
GO
ALTER TABLE [dbo].[MOVInvenInicialItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVInvenInicialItems_MOVInvenInicial] FOREIGN KEY([id_invinicial])
REFERENCES [dbo].[MOVInvenInicial] ([id])
GO
ALTER TABLE [dbo].[MOVInvenInicialItems] CHECK CONSTRAINT [FK_MOVInvenInicialItems_MOVInvenInicial]
GO
ALTER TABLE [dbo].[MovOrdenCompras]  WITH CHECK ADD  CONSTRAINT [FK_MovOrdenCompras_CentroCosto1] FOREIGN KEY([id_centrocostos])
REFERENCES [CNT].[CentroCosto] ([id])
GO
ALTER TABLE [dbo].[MovOrdenCompras] CHECK CONSTRAINT [FK_MovOrdenCompras_CentroCosto1]
GO
ALTER TABLE [dbo].[MovOrdenCompras]  WITH CHECK ADD  CONSTRAINT [FK_MovOrdenCompras_MovOrdenCompras] FOREIGN KEY([id_reversion])
REFERENCES [dbo].[MovOrdenCompras] ([id])
GO
ALTER TABLE [dbo].[MovOrdenCompras] CHECK CONSTRAINT [FK_MovOrdenCompras_MovOrdenCompras]
GO
ALTER TABLE [dbo].[MovOrdenCompras]  WITH CHECK ADD  CONSTRAINT [FK_MovOrdenCompras_Terceros1] FOREIGN KEY([id_proveedor])
REFERENCES [CNT].[TipoTerceros] ([id])
GO
ALTER TABLE [dbo].[MovOrdenCompras] CHECK CONSTRAINT [FK_MovOrdenCompras_Terceros1]
GO
ALTER TABLE [dbo].[MovOrdenCompras]  WITH CHECK ADD  CONSTRAINT [FK_MovOrdenCompras_TipoDocumentos] FOREIGN KEY([id_tipodoc])
REFERENCES [CNT].[TipoDocumentos] ([id])
GO
ALTER TABLE [dbo].[MovOrdenCompras] CHECK CONSTRAINT [FK_MovOrdenCompras_TipoDocumentos]
GO
ALTER TABLE [dbo].[MovOrdenCompras]  WITH CHECK ADD  CONSTRAINT [FK_MovOrdenCompras_Usuarios] FOREIGN KEY([id_userupdated])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [dbo].[MovOrdenCompras] CHECK CONSTRAINT [FK_MovOrdenCompras_Usuarios]
GO
ALTER TABLE [dbo].[MovOrdenCompras]  WITH CHECK ADD  CONSTRAINT [FK_MovOrdenCompras_Usuarioscreated] FOREIGN KEY([id_usercreated])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [dbo].[MovOrdenCompras] CHECK CONSTRAINT [FK_MovOrdenCompras_Usuarioscreated]
GO
ALTER TABLE [dbo].[MOVOrdenComprasItem]  WITH CHECK ADD  CONSTRAINT [FK_MOVOrdenComprasItem_Bodegas] FOREIGN KEY([id_bodega])
REFERENCES [dbo].[Bodegas] ([id])
GO
ALTER TABLE [dbo].[MOVOrdenComprasItem] CHECK CONSTRAINT [FK_MOVOrdenComprasItem_Bodegas]
GO
ALTER TABLE [dbo].[MOVOrdenComprasItem]  WITH CHECK ADD  CONSTRAINT [FK_MOVOrdenComprasItem_MovOrdenCompras] FOREIGN KEY([id_ordencompra])
REFERENCES [dbo].[MovOrdenCompras] ([id])
GO
ALTER TABLE [dbo].[MOVOrdenComprasItem] CHECK CONSTRAINT [FK_MOVOrdenComprasItem_MovOrdenCompras]
GO
ALTER TABLE [dbo].[MOVOrdenComprasItem]  WITH CHECK ADD  CONSTRAINT [FK_MOVOrdenComprasItem_Productos] FOREIGN KEY([id_producto])
REFERENCES [dbo].[Productos] ([id])
GO
ALTER TABLE [dbo].[MOVOrdenComprasItem] CHECK CONSTRAINT [FK_MOVOrdenComprasItem_Productos]
GO
ALTER TABLE [dbo].[MOVOrdenComprasItem]  WITH CHECK ADD  CONSTRAINT [FK_MOVOrdenComprasItem_Usuarios] FOREIGN KEY([id_usercreated])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [dbo].[MOVOrdenComprasItem] CHECK CONSTRAINT [FK_MOVOrdenComprasItem_Usuarios]
GO
ALTER TABLE [dbo].[MOVOrdenComprasItem]  WITH CHECK ADD  CONSTRAINT [FK_MOVOrdenComprasItem_UsuariosUpdated] FOREIGN KEY([id_userupdated])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [dbo].[MOVOrdenComprasItem] CHECK CONSTRAINT [FK_MOVOrdenComprasItem_UsuariosUpdated]
GO
ALTER TABLE [dbo].[MOVPagoCajas]  WITH CHECK ADD  CONSTRAINT [FK_MOVPagoCajas_Cajas] FOREIGN KEY([id_caja])
REFERENCES [dbo].[Cajas] ([id])
GO
ALTER TABLE [dbo].[MOVPagoCajas] CHECK CONSTRAINT [FK_MOVPagoCajas_Cajas]
GO
ALTER TABLE [dbo].[MOVPagoCajas]  WITH CHECK ADD  CONSTRAINT [FK_MOVPagoCajas_MOVPagoCajas] FOREIGN KEY([id_reversion])
REFERENCES [dbo].[MOVPagoCajas] ([id])
GO
ALTER TABLE [dbo].[MOVPagoCajas] CHECK CONSTRAINT [FK_MOVPagoCajas_MOVPagoCajas]
GO
ALTER TABLE [dbo].[MOVPedidos]  WITH CHECK ADD  CONSTRAINT [FK_MOVPedidos_MOVPedidos] FOREIGN KEY([id_reversion])
REFERENCES [dbo].[MOVPedidos] ([id])
GO
ALTER TABLE [dbo].[MOVPedidos] CHECK CONSTRAINT [FK_MOVPedidos_MOVPedidos]
GO
ALTER TABLE [dbo].[MOVPedidosItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVPedidosItems_Articulos] FOREIGN KEY([id_articulo])
REFERENCES [dbo].[Productos] ([id])
GO
ALTER TABLE [dbo].[MOVPedidosItems] CHECK CONSTRAINT [FK_MOVPedidosItems_Articulos]
GO
ALTER TABLE [dbo].[MOVPedidosItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVPedidosItems_Bodegas] FOREIGN KEY([id_bodega])
REFERENCES [dbo].[Bodegas] ([id])
GO
ALTER TABLE [dbo].[MOVPedidosItems] CHECK CONSTRAINT [FK_MOVPedidosItems_Bodegas]
GO
ALTER TABLE [dbo].[MOVPedidosItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVPedidosItems_MOVPedidos] FOREIGN KEY([id_pedido])
REFERENCES [dbo].[MOVPedidos] ([id])
GO
ALTER TABLE [dbo].[MOVPedidosItems] CHECK CONSTRAINT [FK_MOVPedidosItems_MOVPedidos]
GO
ALTER TABLE [dbo].[MOVTraslados]  WITH CHECK ADD  CONSTRAINT [FK_MOVTraslados_MOVTraslados] FOREIGN KEY([id_reversion])
REFERENCES [dbo].[MOVTraslados] ([id])
GO
ALTER TABLE [dbo].[MOVTraslados] CHECK CONSTRAINT [FK_MOVTraslados_MOVTraslados]
GO
ALTER TABLE [dbo].[MOVTrasladosItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVTrasladosItems_Articulos] FOREIGN KEY([id_articulo])
REFERENCES [dbo].[Productos] ([id])
GO
ALTER TABLE [dbo].[MOVTrasladosItems] CHECK CONSTRAINT [FK_MOVTrasladosItems_Articulos]
GO
ALTER TABLE [dbo].[MOVTrasladosItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVTrasladosItems_Bodegas] FOREIGN KEY([id_bodega])
REFERENCES [dbo].[Bodegas] ([id])
GO
ALTER TABLE [dbo].[MOVTrasladosItems] CHECK CONSTRAINT [FK_MOVTrasladosItems_Bodegas]
GO
ALTER TABLE [dbo].[MOVTrasladosItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVTrasladosItems_Bodegasdes] FOREIGN KEY([id_bodegades])
REFERENCES [dbo].[Bodegas] ([id])
GO
ALTER TABLE [dbo].[MOVTrasladosItems] CHECK CONSTRAINT [FK_MOVTrasladosItems_Bodegasdes]
GO
ALTER TABLE [dbo].[MOVTrasladosItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVTrasladosItems_MOVTraslados] FOREIGN KEY([id_traslado])
REFERENCES [dbo].[MOVTraslados] ([id])
GO
ALTER TABLE [dbo].[MOVTrasladosItems] CHECK CONSTRAINT [FK_MOVTrasladosItems_MOVTraslados]
GO
ALTER TABLE [dbo].[MOVTrasladosLotes]  WITH CHECK ADD  CONSTRAINT [FK_MOVTrasladosLotes_LotesProducto] FOREIGN KEY([id_lote])
REFERENCES [dbo].[LotesProducto] ([id])
GO
ALTER TABLE [dbo].[MOVTrasladosLotes] CHECK CONSTRAINT [FK_MOVTrasladosLotes_LotesProducto]
GO
ALTER TABLE [dbo].[MOVTrasladosLotes]  WITH CHECK ADD  CONSTRAINT [FK_MOVTrasladosLotes_MOVTraslados] FOREIGN KEY([id_ajuste])
REFERENCES [dbo].[MOVTraslados] ([id])
GO
ALTER TABLE [dbo].[MOVTrasladosLotes] CHECK CONSTRAINT [FK_MOVTrasladosLotes_MOVTraslados]
GO
ALTER TABLE [dbo].[MOVTrasladosLotes]  WITH CHECK ADD  CONSTRAINT [FK_MOVTrasladosLotes_MOVTrasladosItems] FOREIGN KEY([id_item])
REFERENCES [dbo].[MOVTrasladosItems] ([id])
GO
ALTER TABLE [dbo].[MOVTrasladosLotes] CHECK CONSTRAINT [FK_MOVTrasladosLotes_MOVTrasladosItems]
GO
ALTER TABLE [dbo].[MOVTrasladosSeries]  WITH CHECK ADD  CONSTRAINT [FK_MOVTrasladosSeries_MOVTraslados] FOREIGN KEY([id_ajuste])
REFERENCES [dbo].[MOVTraslados] ([id])
GO
ALTER TABLE [dbo].[MOVTrasladosSeries] CHECK CONSTRAINT [FK_MOVTrasladosSeries_MOVTraslados]
GO
ALTER TABLE [dbo].[MOVTrasladosSeries]  WITH CHECK ADD  CONSTRAINT [FK_MOVTrasladosSeries_MOVTrasladosItems] FOREIGN KEY([id_items])
REFERENCES [dbo].[MOVTrasladosItems] ([id])
GO
ALTER TABLE [dbo].[MOVTrasladosSeries] CHECK CONSTRAINT [FK_MOVTrasladosSeries_MOVTrasladosItems]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [FK_Articulos_TipoArticulos] FOREIGN KEY([categoria])
REFERENCES [dbo].[CategoriasProductos] ([id])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [FK_Articulos_TipoArticulos]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [FK_Productos_CNTCuentas] FOREIGN KEY([id_ctacontable])
REFERENCES [dbo].[CNTCuentas] ([id])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [FK_Productos_CNTCuentas]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [FK_Productos_CNTCuentasIVA] FOREIGN KEY([id_ctaiva])
REFERENCES [dbo].[CNTCuentas] ([id])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [FK_Productos_CNTCuentasIVA]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [FK_Productos_Impuestos] FOREIGN KEY([id_iva])
REFERENCES [CNT].[Impuestos] ([id])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [FK_Productos_Impuestos]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [FK_Productos_Impuestos1] FOREIGN KEY([id_inc])
REFERENCES [CNT].[Impuestos] ([id])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [FK_Productos_Impuestos1]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [FK_Productos_Marcas] FOREIGN KEY([marca])
REFERENCES [dbo].[Marcas] ([id])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [FK_Productos_Marcas]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [FK_Productos_TipoDocumentos] FOREIGN KEY([id_tipodocu])
REFERENCES [dbo].[ST_Listados] ([id])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [FK_Productos_TipoDocumentos]
GO
ALTER TABLE [dbo].[ST_CamposReporte]  WITH CHECK ADD  CONSTRAINT [FK_ST_CamposReporte_ST_Reportes] FOREIGN KEY([id_reporte])
REFERENCES [dbo].[ST_Reportes] ([id])
GO
ALTER TABLE [dbo].[ST_CamposReporte] CHECK CONSTRAINT [FK_ST_CamposReporte_ST_Reportes]
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD  CONSTRAINT [FK_Usuarios_aspnet_Membership] FOREIGN KEY([userid])
REFERENCES [dbo].[aspnet_Membership] ([UserId])
GO
ALTER TABLE [dbo].[Usuarios] CHECK CONSTRAINT [FK_Usuarios_aspnet_Membership]
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD  CONSTRAINT [FK_Usuarios_aspnet_Roles] FOREIGN KEY([id_perfil])
REFERENCES [dbo].[aspnet_Roles] ([id])
GO
ALTER TABLE [dbo].[Usuarios] CHECK CONSTRAINT [FK_Usuarios_aspnet_Roles]
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD  CONSTRAINT [FK_Usuarios_Turnos] FOREIGN KEY([id_turno])
REFERENCES [dbo].[Turnos] ([id])
GO
ALTER TABLE [dbo].[Usuarios] CHECK CONSTRAINT [FK_Usuarios_Turnos]
GO
ALTER TABLE [dbo].[Vendedores]  WITH CHECK ADD  CONSTRAINT [FK_Vendedores_Usuarios] FOREIGN KEY([id_usercreated])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [dbo].[Vendedores] CHECK CONSTRAINT [FK_Vendedores_Usuarios]
GO
ALTER TABLE [dbo].[Vendedores]  WITH CHECK ADD  CONSTRAINT [FK_Vendedores_Usuarios1] FOREIGN KEY([id_userupdated])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [dbo].[Vendedores] CHECK CONSTRAINT [FK_Vendedores_Usuarios1]
GO
ALTER TABLE [dbo].[CNTCuentas]  WITH CHECK ADD  CONSTRAINT [FK_CNTCuentas_ST_Listados2] FOREIGN KEY([id_naturaleza])
REFERENCES [dbo].[ST_Listados] ([id])
GO
ALTER TABLE [dbo].[CNTCuentas] CHECK CONSTRAINT [FK_CNTCuentas_ST_Listados2]

ALTER TABLE [CNT].[MOVNotasCartera]  WITH CHECK ADD  CONSTRAINT [FK_MOVNotasCartera_CentroCosto] FOREIGN KEY([id_centrocosto])
REFERENCES [CNT].[CentroCosto] ([id])
GO
ALTER TABLE [CNT].[MOVNotasCartera] CHECK CONSTRAINT [FK_MOVNotasCartera_CentroCosto]
GO
ALTER TABLE [CNT].[MOVNotasCartera]  WITH CHECK ADD  CONSTRAINT [FK_MOVNotasCartera_CNTCuentas] FOREIGN KEY([id_ctaact])
REFERENCES [dbo].[CNTCuentas] ([id])
GO
ALTER TABLE [CNT].[MOVNotasCartera] CHECK CONSTRAINT [FK_MOVNotasCartera_CNTCuentas]
GO
ALTER TABLE [CNT].[MOVNotasCartera]  WITH CHECK ADD  CONSTRAINT [FK_MOVNotasCartera_CNTCuentas1] FOREIGN KEY([id_ctaant])
REFERENCES [dbo].[CNTCuentas] ([id])
GO
ALTER TABLE [CNT].[MOVNotasCartera] CHECK CONSTRAINT [FK_MOVNotasCartera_CNTCuentas1]
GO
ALTER TABLE [CNT].[MOVNotasCartera]  WITH CHECK ADD  CONSTRAINT [FK_MOVNotasCartera_ST_Listados] FOREIGN KEY([id_tipoven])
REFERENCES [dbo].[ST_Listados] ([id])
GO
ALTER TABLE [CNT].[MOVNotasCartera] CHECK CONSTRAINT [FK_MOVNotasCartera_ST_Listados]
GO
ALTER TABLE [CNT].[MOVNotasCartera]  WITH CHECK ADD  CONSTRAINT [FK_MOVNotasCartera_TipoDocumentos] FOREIGN KEY([id_tipodoc])
REFERENCES [CNT].[TipoDocumentos] ([id])
GO
ALTER TABLE [CNT].[MOVNotasCartera] CHECK CONSTRAINT [FK_MOVNotasCartera_TipoDocumentos]
GO
ALTER TABLE [CNT].[MOVNotasCartera]  WITH CHECK ADD  CONSTRAINT [FK_MOVNotasCartera_TipoTerceros] FOREIGN KEY([id_tercero])
REFERENCES [CNT].[TipoTerceros] ([id])
GO
ALTER TABLE [CNT].[MOVNotasCartera] CHECK CONSTRAINT [FK_MOVNotasCartera_TipoTerceros]
GO
ALTER TABLE [CNT].[MOVNotasCartera]  WITH CHECK ADD  CONSTRAINT [FK_MOVNotasCartera_Usuarios] FOREIGN KEY([id_usercreated])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [CNT].[MOVNotasCartera] CHECK CONSTRAINT [FK_MOVNotasCartera_Usuarios]
GO
ALTER TABLE [dbo].[MOVEntradasItemsTemp] ADD  CONSTRAINT [DF_MOVEntradasItemsTemp_fleteund]  DEFAULT ((0)) FOR [fleteund]
GO
ALTER TABLE [dbo].[MOVEntradasItemsTemp] ADD  CONSTRAINT [DF_MOVEntradasItemsTemp_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[MOVEntradasItemsTemp] ADD  CONSTRAINT [DF_MOVEntradasItemsTemp_selected]  DEFAULT ((0)) FOR [selected]
GO
ALTER TABLE [CNT].[MOVComprobantesEgresosConcepto] ADD  CONSTRAINT [DF_MOVComprobantesEgresosConcepto_created]  DEFAULT (getdate()) FOR [created]
GO

--changeset kmartinez:1 dbms:mssql endDelimiter:GO
/****** Object:  Table [FIN].[Financiero_lineacreditos]    Script Date: 10/11/2020 4:33:58 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [FIN].[Financiero_lineacreditos](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_financiero] [bigint] NOT NULL,
	[id_lineascredito] [bigint] NOT NULL,
	[porcentaje] [numeric](18, 2) NOT NULL,
 CONSTRAINT [PK_Financiero_lineacreditos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [FIN].[LineasCreditos]    Script Date: 10/11/2020 4:33:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [FIN].[LineasCreditos](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Codigo] [varchar](50) NOT NULL,
	[id_ctacredito] [bigint] NOT NULL,
	[id_ctaintcorriente] [bigint] NOT NULL,
	[id_ctamora] [bigint] NOT NULL,
	[Porcentaje] [numeric](18, 0) NULL,
	[iva] [bit] NOT NULL,
	[id_ctaiva] [bigint] NOT NULL,
	[id_user] [int] NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_LineasCreditos_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_LineasCreditos_updated]  DEFAULT (getdate()),
 CONSTRAINT [PK_LineasCreditos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [FIN].[ServiciosFinanciero]    Script Date: 10/11/2020 4:33:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [FIN].[ServiciosFinanciero](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[codigo] [varchar](50) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[id_cuenta] [bigint] NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_ServiciosFinanciero_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_ServiciosFinanciero_updated]  DEFAULT (getdate()),
	[id_user] [int] NOT NULL,
 CONSTRAINT [PK_ServiciosFinanciero] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [FIN].[Financiero_lineacreditos]  WITH CHECK ADD  CONSTRAINT [FK_Financiero_lineacreditos_LineasCreditos] FOREIGN KEY([id_lineascredito])
REFERENCES [FIN].[LineasCreditos] ([id])
GO
ALTER TABLE [FIN].[Financiero_lineacreditos] CHECK CONSTRAINT [FK_Financiero_lineacreditos_LineasCreditos]
GO
ALTER TABLE [FIN].[Financiero_lineacreditos]  WITH CHECK ADD  CONSTRAINT [FK_Financiero_lineacreditos_ServiciosFinanciero] FOREIGN KEY([id_financiero])
REFERENCES [FIN].[ServiciosFinanciero] ([id])
GO
ALTER TABLE [FIN].[Financiero_lineacreditos] CHECK CONSTRAINT [FK_Financiero_lineacreditos_ServiciosFinanciero]
GO

/****** Object:  Table [dbo].[MOVFacturaRecurrentesItems]    Script Date: 10/11/2020 4:41:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOVFacturaRecurrentesItems](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_factura] [bigint] NOT NULL,
	[id_producto] [bigint] NOT NULL,
	[id_bodega] [bigint] NULL,
	[serie] [bit] NOT NULL,
	[lote] [bit] NOT NULL,
	[cantidad] [numeric](18, 2) NOT NULL,
	[costo] [numeric](18, 4) NOT NULL,
	[precio] [numeric](18, 4) NOT NULL,
	[preciodesc] [numeric](18, 4) NOT NULL,
	[descuentound] [decimal](18, 4) NOT NULL,
	[pordescuento] [numeric](5, 2) NOT NULL,
	[descuento] [numeric](18, 4) NOT NULL,
	[id_ctaiva] [bigint] NULL,
	[poriva] [numeric](4, 2) NOT NULL,
	[iva] [numeric](18, 4) NOT NULL,
	[id_ctainc] [bigint] NULL,
	[porinc] [numeric](4, 2) NOT NULL,
	[inc] [numeric](18, 4) NOT NULL,
	[total] [numeric](18, 4) NOT NULL,
	[formulado] [bit] NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVFacturaRecurrentesItems_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVFacturaRecurrentesItems_update]  DEFAULT (getdate()),
	[id_user] [int] NOT NULL,
	[inventarial] [bit] NOT NULL,
	[id_itemtemp] [bigint] NOT NULL,
 CONSTRAINT [PK_MOVFacturaRecurrentesItems_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MOVFacturasRecurrentes]    Script Date: 10/11/2020 4:41:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOVFacturasRecurrentes](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_tipodoc] [bigint] NOT NULL,
	[id_centrocostos] [bigint] NULL,
	[id_formapagos] [bigint] NULL,
	[fechafac] [smalldatetime] NOT NULL,
	[estado] [int] NULL,
	[id_tercero] [bigint] NOT NULL,
	[iva] [numeric](18, 2) NOT NULL,
	[inc] [numeric](18, 2) NOT NULL,
	[descuento] [numeric](18, 2) NOT NULL,
	[subtotal] [numeric](18, 2) NOT NULL,
	[total] [numeric](18, 2) NOT NULL,
	[isFe] [bit] NOT NULL,
	[estadoFE] [int] NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVFacturasRecurrentes_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_MOVFacturasRecurrentes_updated]  DEFAULT (getdate()),
	[id_user] [int] NOT NULL,
	[id_vendedor] [bigint] NOT NULL,
 CONSTRAINT [PK_MOVFacturasRecurrentes_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [CNT].[SaldoTercero]    Script Date: 22/11/2020 10:09:29 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [CNT].[SaldoTercero](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[anomes] [varchar](6) NOT NULL,
	[id_tercero] [bigint] NOT NULL,
	[id_cuenta] [bigint] NULL,
	[fechaactual] [smalldatetime] NOT NULL,
	[saldoanterior] [numeric](18, 2) NOT NULL,
	[movDebito] [numeric](18, 2) NOT NULL,
	[movCredito] [numeric](18, 2) NOT NULL,
	[saldoActual] [numeric](18, 2) NOT NULL,
	[changed] [bit] NULL CONSTRAINT [DF_SaldoTercero_changed]  DEFAULT ((0)),
	[before] [bit] NULL CONSTRAINT [DF_SaldoTercero_before]  DEFAULT ((0)),
	[id_user] [bigint] NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_SaldoTercero_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_SaldoTercero_updated]  DEFAULT (getdate()),
 CONSTRAINT [PK_SaldoTercero] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [CNT].[SaldoTercero]  WITH CHECK ADD  CONSTRAINT [FK_SaldoTercero_CNTCuentas] FOREIGN KEY([id_cuenta])
REFERENCES [dbo].[CNTCuentas] ([id])
GO

ALTER TABLE [CNT].[SaldoTercero] CHECK CONSTRAINT [FK_SaldoTercero_CNTCuentas]
GO

ALTER TABLE [CNT].[SaldoTercero]  WITH CHECK ADD  CONSTRAINT [FK_SaldoTercero_TipoTerceros] FOREIGN KEY([id_tercero])
REFERENCES [CNT].[TipoTerceros] ([id])
GO

ALTER TABLE [CNT].[SaldoTercero] CHECK CONSTRAINT [FK_SaldoTercero_TipoTerceros]
GO

ALTER TABLE [CNT].[SaldoTercero]  WITH CHECK ADD  CONSTRAINT [FK_SaldoTercero_Usuarios] FOREIGN KEY([id_user])
REFERENCES [dbo].[Usuarios] ([id])
GO

ALTER TABLE [CNT].[SaldoTercero] CHECK CONSTRAINT [FK_SaldoTercero_Usuarios]
GO


--changeset jteheran:2 dbms:mssql endDelimiter:GO
IF NOT EXISTS ( SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 WHERE c1.table_schema='CNT' And  c1.table_name = 'SaldoAnticipos' And c1.column_name = 'changed')
BEGIN
    ALTER TABLE CNT.SaldoAnticipos Add [changed] BIT NOT NULL DEFAULT(0);
END
GO 