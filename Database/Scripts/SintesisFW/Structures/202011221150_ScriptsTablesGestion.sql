--liquibase formatted sql
--changeset jtous:1 dbms:mssql endDelimiter:GO
/*Creacion de schema de gestión*/
/****** Object:  Schema [GSC]    Script Date: 25/09/2020 8:23:36 a. m. ******/
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'GSC')
BEGIN
	EXEC ('CREATE SCHEMA [GSC]')
END
GO

/****** Object:  Table [GSC].[GestionSeguimientos]    Script Date: 22/11/2020 11:46:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [GSC].[GestionSeguimientos](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_cliente] [bigint] NOT NULL,
	[tipo] [varchar](20) NULL,
	[fechaProgramacion] [datetime2](7) NULL,
	[programado] [bit] NOT NULL,
	[id_user] [bigint] NOT NULL,
	[created] [datetime2](7) NOT NULL CONSTRAINT [DF_GestionSeguimientos_created]  DEFAULT (getdate()),
 CONSTRAINT [PK_GestioSeguimientos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [GSC].[GestionSeguimientosHistorial]    Script Date: 22/11/2020 11:46:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [GSC].[GestionSeguimientosHistorial](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_seguimiento] [bigint] NOT NULL,
	[fechaProgramacion] [datetime2](7) NULL,
	[seguimiento] [varchar](max) NOT NULL,
	[tipo] [varchar](20) NULL,
	[programado] [bit] NOT NULL CONSTRAINT [DF_GestionSeguimientosHistorial_programado]  DEFAULT ((0)),
	[id_user] [bigint] NOT NULL,
	[created] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_GestioSeguimientosHistorial] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [GSC].[GestionSeguimientos]  WITH CHECK ADD  CONSTRAINT [FK_GestionSeguimientos_TipoTerceros] FOREIGN KEY([id_cliente])
REFERENCES [CNT].[TipoTerceros] ([id])
GO
ALTER TABLE [GSC].[GestionSeguimientos] CHECK CONSTRAINT [FK_GestionSeguimientos_TipoTerceros]
GO
ALTER TABLE [GSC].[GestionSeguimientosHistorial]  WITH CHECK ADD  CONSTRAINT [FK_GestionSeguimientosHistorial_GestionSeguimientos] FOREIGN KEY([id_seguimiento])
REFERENCES [GSC].[GestionSeguimientos] ([id])
GO
ALTER TABLE [GSC].[GestionSeguimientosHistorial] CHECK CONSTRAINT [FK_GestionSeguimientosHistorial_GestionSeguimientos]
GO

--changeset jtous:2 dbms:mssql endDelimiter:GO
/*Creacion de schema de gestión*/
/****** Object:  Schema [GSC]    Script Date: 25/09/2020 8:23:36 a. m. ******/
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'FE')
BEGIN
	EXEC ('CREATE SCHEMA [FE]')
END
GO


/****** Object:  Table [FE].[DocumentosSeguimiento]    Script Date: 28/11/2020 2:00:53 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [FE].[DocumentosSeguimiento](
	[id] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[key] [varchar](250) NOT NULL,
	[tipodocumento] [int] NOT NULL,
	[fechaseguimiento] [datetime2](7) NOT NULL,
	[respuesta] [varchar](max) NOT NULL,
	[estado] [int] NOT NULL,
	[error] [bit] NOT NULL,
	[created] [smalldatetime] NOT NULL,
	[coderespuesta] [varchar](10) NOT NULL,
 CONSTRAINT [PK_DocumentosSeguimiento] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [FE].[DocumentosSeguimientoEmails]    Script Date: 28/11/2020 2:00:53 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [FE].[DocumentosSeguimientoEmails](
	[id] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[keyid] [varchar](250) NOT NULL,
	[tipodocumento] [int] NOT NULL,
	[email] [varchar](200) NOT NULL,
	[estado] [int] NOT NULL,
	[created] [datetime2](7) NOT NULL,
	[id_user] [int] NOT NULL,
	[mensaje] [varchar](max) NOT NULL,
	[activo] [bit] NOT NULL,
 CONSTRAINT [PK_DocumentosSeguimientoEmails] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [FE].[DocumentosSeguimiento] ADD  CONSTRAINT [DF_DocumentosSeguimiento_fechaseguimiento]  DEFAULT (getdate()) FOR [fechaseguimiento]
GO
ALTER TABLE [FE].[DocumentosSeguimiento] ADD  CONSTRAINT [DF_DocumentosSeguimiento_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [FE].[DocumentosSeguimiento] ADD  CONSTRAINT [DF_DocumentosSeguimiento_coderespuesta]  DEFAULT ('') FOR [coderespuesta]
GO
ALTER TABLE [FE].[DocumentosSeguimientoEmails] ADD  CONSTRAINT [DF_DocumentosSeguimientoEmails_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [FE].[DocumentosSeguimientoEmails] ADD  CONSTRAINT [DF_DocumentosSeguimientoEmails_id_user]  DEFAULT ((1)) FOR [id_user]
GO
ALTER TABLE [FE].[DocumentosSeguimientoEmails] ADD  CONSTRAINT [DF_DocumentosSeguimientoEmails_mensaje]  DEFAULT ('') FOR [mensaje]
GO
ALTER TABLE [FE].[DocumentosSeguimientoEmails] ADD  CONSTRAINT [DF_DocumentosSeguimientoEmails_activo]  DEFAULT ((1)) FOR [activo]
GO

/****** Object:  Table [dbo].[aspnet_MailConfig]    Script Date: 28/11/2020 2:07:09 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[aspnet_MailConfig](
	[id] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[id_empresa] [bigint] NOT NULL,
	[servermail] [varchar](100) NOT NULL,
	[usermail] [varchar](150) NOT NULL,
	[usertitlemail] [varchar](150) NOT NULL CONSTRAINT [DF_aspnet_MailConfig_usertitlemail]  DEFAULT ('no-responder@sintesistecnologia.co'),
	[passmail] [varchar](100) NOT NULL,
	[portmail] [int] NOT NULL,
	[sslmail] [bit] NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_aspnet_MailConfig_created]  DEFAULT (getdate()),
 CONSTRAINT [PK_aspnet_MailConfig] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

IF NOT EXISTS ( SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 WHERE c1.table_schema='dbo' And  c1.table_name = 'MovFactura' And c1.column_name = 'fechaautorizacion')
BEGIN
    ALTER TABLE dbo.MovFactura Add [fechaautorizacion] SMALLDATETIME ;
END
GO

IF NOT EXISTS ( SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 WHERE c1.table_schema='dbo' And  c1.table_name = 'MovFactura' And c1.column_name = 'fechavence')
BEGIN
    ALTER TABLE dbo.MovFactura Add [fechavence] SMALLDATETIME ;
END
GO

IF NOT EXISTS ( SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 WHERE c1.table_schema='dbo' And  c1.table_name = 'MovFactura' And c1.column_name = 'observaciones')
BEGIN
    ALTER TABLE dbo.MovFactura Add [observaciones]  VARCHAR (MAX) DEFAULT ('');
END
GO

IF NOT EXISTS ( SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 WHERE c1.table_schema='dbo' And  c1.table_name = 'Empresas' And c1.column_name = 'urlfirma')
BEGIN
    ALTER TABLE dbo.Empresas Add [urlfirma] VARCHAR (500) NOT NULL DEFAULT ('');
END
GO

--changeset czulbaran:1 dbms:mssql endDelimiter:GO
IF COL_LENGTH('dbo.Parametros', 'bit') IS NULL
BEGIN
     Alter Table dbo.Parametros Add [default] bit NOT NULL default 1;
END
GO
IF COL_LENGTH('dbo.Parametros', 'varchar') IS NULL
BEGIN
     Alter Table dbo.Parametros Add [icon] varchar(max) NOT NULL DEFAULT ('<i class="fa fa-cog" aria-hidden="true"></i>');
END
GO
IF COL_LENGTH('dbo.Parametros', 'varchar') IS NULL
BEGIN
     Alter Table dbo.Parametros  Add [metadata] varchar(max)  NULL ;
END
GO
IF COL_LENGTH('dbo.Parametros', 'varchar') IS NULL
BEGIN
     Alter Table dbo.Parametros Add [fuente] varchar(100)  NULL ;
END
GO
IF COL_LENGTH('dbo.Parametros', 'bigint') IS NULL
BEGIN
     Alter Table dbo.Parametros Add [ancho] bigint NULL ;
END
GO
IF COL_LENGTH('dbo.Parametros', 'bigint') IS NULL
BEGIN
     Alter Table dbo.Parametros Add [orden] bigint NULL ;
END
GO
IF COL_LENGTH('dbo.Parametros', 'varchar') IS NULL
BEGIN
     Alter Table dbo.Parametros Add [campos] varchar(max) NULL ;
END
GO
IF COL_LENGTH('dbo.Parametros', 'varchar') IS NULL
BEGIN
     Alter Table dbo.Parametros Add [seleccion] varchar(max) NULL ;
END
GO
IF COL_LENGTH('dbo.Parametros', 'varchar') IS NULL
BEGIN
     Alter Table dbo.Parametros Add [params] varchar(max) NULL ;
END
GO
IF COL_LENGTH('dbo.Parametros', 'varchar') IS NULL
BEGIN
     Alter Table dbo.Parametros Add [extratexto] varchar(max) NULL ;
END
GO

--changeset apuello:1 dbms:mssql endDelimiter:GO
IF NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[MenuPermisosUser]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
	CREATE TABLE [dbo].[MenuPermisosUser](
		[id] [bigint] IDENTITY(1,1) NOT NULL,
		[id_menu] [bigint] NULL,
		[id_user] [bigint] NULL,
		[reader] [bit] NOT NULL DEFAULT ((0)),
		[creater] [bit] NOT NULL DEFAULT ((0)),
		[updater] [bit] NOT NULL DEFAULT ((0)),
		[deleter] [bit] NOT NULL DEFAULT ((0)),
		[id_usercreated] [bigint] NULL,
		[id_userupdated] [bigint] NULL,
		[created] [smalldatetime] NULL,
		[updated] [smalldatetime] NULL,
	PRIMARY KEY CLUSTERED 
	(
		[id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
GO


IF COL_LENGTH('dbo.aspnet_Roles', 'estado') IS NULL
BEGIN
     Alter Table dbo.aspnet_Roles Add [estado] BIT NOT NULL DEFAULT(1);
END
GO


--changeset jteheran:2 dbms:mssql endDelimiter:GO
IF COL_LENGTH('[CNT].[SaldoAnticipos]', 'before') IS NULL
BEGIN
     Alter Table  CNT.SaldoAnticipos    Add   [before] BIT NULL  CONSTRAINT [DF_SaldoAnticipos_before] default 0 ;
END
GO
IF COL_LENGTH('[dbo].[MOVDevEntradasItems]', 'id_retefuente') IS NULL
BEGIN
     Alter Table  dbo.MOVDevEntradasItems Add [id_retefuente] BIGINT NULL ;
END
GO
IF COL_LENGTH('[dbo].[MOVDevEntradasItems]', 'porcerefuente') IS NULL
BEGIN
     Alter Table dbo.MOVDevEntradasItems Add [porcerefuente] decimal(5,2) NULL CONSTRAINT [DF_MOVDevEntradasItems_porcerefuente] default 0 ;
END
IF COL_LENGTH('[dbo].[MOVDevEntradasItems]', 'retefuente') IS NULL
BEGIN
     Alter Table dbo.MOVDevEntradasItems  Add [retefuente] decimal(18,4) NULL CONSTRAINT [DF_MOVDevEntradasItems_retefuente] default 0;
END
--Campos de impuesto de reteiva
IF COL_LENGTH('[dbo].[MOVDevEntradasItems]', 'id_reteiva') IS NULL
BEGIN
     Alter Table  dbo.MOVDevEntradasItems  Add [id_reteiva] BIGINT NULL ;
END
IF COL_LENGTH('[dbo].[MOVDevEntradasItems]', 'porcereiva') IS NULL
BEGIN
     Alter Table dbo.MOVDevEntradasItems  Add   [porcereiva] decimal(5,2) NULL CONSTRAINT [DF_MOVDevEntradasItems_porcereiva] default 0 ;
END
IF COL_LENGTH('[dbo].[MOVDevEntradasItems]', 'reteiva') IS NULL
BEGIN
     Alter Table dbo.MOVDevEntradasItems
     Add [reteiva] decimal(18,4) NULL CONSTRAINT [DF_MOVDevEntradasItems_reteiva] default 0;
END
--Campos de impuesto de reteica
IF COL_LENGTH('[dbo].[MOVDevEntradasItems]', 'id_reteica') IS NULL
BEGIN
     Alter Table dbo.MOVDevEntradasItems Add [id_reteica] BIGINT NULL ;
END

IF COL_LENGTH('[dbo].[MOVDevEntradasItems]', 'porcereica') IS NULL
BEGIN
     Alter Table dbo.MOVDevEntradasItems Add [porcereica] decimal(5,2) NULL CONSTRAINT [DF_MOVDevEntradasItems_porcereica]  default 0 ;
END
IF COL_LENGTH('[dbo].[MOVDevEntradasItems]', 'reteica') IS NULL
BEGIN
     Alter Table  dbo.MOVDevEntradasItems Add [reteica] decimal(18,4) NULL CONSTRAINT [DF_MOVDevEntradasItems_reteica] default 0;
END
--RELACIONES
ALTER TABLE [dbo].[MOVDevEntradasItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVDevEntradasItems_Impuestos2] FOREIGN KEY([id_retefuente])
REFERENCES [CNT].[Impuestos] ([id])
GO
ALTER TABLE [dbo].MOVDevEntradasItems CHECK CONSTRAINT [FK_MOVDevEntradasItems_Impuestos2]
GO
ALTER TABLE [dbo].MOVDevEntradasItems  WITH CHECK ADD  CONSTRAINT [FK_MOVDevEntradasItems_Impuestos3] FOREIGN KEY([id_reteica])
REFERENCES [CNT].[Impuestos] ([id])
GO
ALTER TABLE [dbo].MOVDevEntradasItems CHECK CONSTRAINT [FK_MOVDevEntradasItems_Impuestos3]
GO
ALTER TABLE [dbo].MOVDevEntradasItems  WITH CHECK ADD  CONSTRAINT [FK_MOVDevEntradasItems_Impuestos4] FOREIGN KEY([id_reteiva])
REFERENCES [CNT].[Impuestos] ([id])
GO
IF COL_LENGTH('[dbo].[MOVEntradasItems]', 'id_retefuente') IS NULL
BEGIN
     Alter Table dbo.MOVEntradasItems  Add [id_retefuente] BIGINT NULL ;
END
GO
IF COL_LENGTH('[dbo].[MOVEntradasItems]', 'porcerefuente') IS NULL
BEGIN
     Alter Table dbo.MOVEntradasItems Add [porcerefuente] decimal(5,2) NULL CONSTRAINT [DF_MOVEntradasItems_porcerefuente] default 0 ;
END
IF COL_LENGTH('[dbo].[MOVEntradasItems]', 'retefuente') IS NULL
BEGIN
     Alter Table dbo.MOVEntradasItems Add [retefuente] decimal(18,4) NULL CONSTRAINT [DF_MOVEntradasItems_retefuente] default 0;
END
--Campos de impuesto de reteiva
IF COL_LENGTH('[dbo].[MOVEntradasItems]', 'id_reteiva') IS NULL
BEGIN
     Alter Table dbo.MOVEntradasItems Add [id_reteiva] BIGINT NULL ;
END
IF COL_LENGTH('[dbo].[MOVEntradasItems]', 'porcereiva') IS NULL
BEGIN
     Alter Table  dbo.MOVEntradasItems Add [porcereiva] decimal(5,2) NULL CONSTRAINT [DF_MOVEntradasItems_porcereiva] default 0 ;
END
IF COL_LENGTH('[dbo].[MOVEntradasItems]', 'reteiva') IS NULL
BEGIN
     Alter Table dbo.MOVEntradasItems Add [reteiva] decimal(18,4) NULL CONSTRAINT [DF_MOVEntradasItems_reteiva] default 0;
END
--Campos de impuesto de reteica
IF COL_LENGTH('[dbo].[MOVEntradasItems]', 'id_reteica') IS NULL
BEGIN
     Alter Table dbo.MOVEntradasItems Add [id_reteica] BIGINT NULL ;
END
IF COL_LENGTH('[dbo].[MOVEntradasItems]', 'porcereica') IS NULL
BEGIN
     Alter Table  dbo.MOVEntradasItems Add [porcereica] decimal(5,2) NULL CONSTRAINT [DF_MOVEntradasItems_porcereica]  default 0 ;
END
IF COL_LENGTH('[dbo].[MOVEntradasItems]', 'reteica') IS NULL
BEGIN
     Alter Table dbo.MOVEntradasItems Add  [reteica] decimal(18,4) NULL CONSTRAINT [DF_MOVEntradasItems_reteica] default 0;
END
--RELACIONES
ALTER TABLE [dbo].[MOVEntradasItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVEntradasItems_Impuestos2] FOREIGN KEY([id_retefuente])
REFERENCES [CNT].[Impuestos] ([id])
GO
ALTER TABLE [dbo].MOVEntradasItems CHECK CONSTRAINT [FK_MOVEntradasItems_Impuestos2]
GO
ALTER TABLE [dbo].MOVEntradasItems  WITH CHECK ADD  CONSTRAINT [FK_MOVEntradasItems_Impuestos3] FOREIGN KEY([id_reteica])
REFERENCES [CNT].[Impuestos] ([id])
GO
ALTER TABLE [dbo].MOVEntradasItems CHECK CONSTRAINT [FK_MOVEntradasItems_Impuestos3]
GO
ALTER TABLE [dbo].MOVEntradasItems  WITH CHECK ADD  CONSTRAINT [FK_MOVEntradasItems_Impuestos4] FOREIGN KEY([id_reteiva])
REFERENCES [CNT].[Impuestos] ([id])
GO
IF COL_LENGTH('[dbo].[MOVEntradasItemsTemp]', 'id_retefuente') IS NULL
BEGIN
     Alter Table dbo.MOVEntradasItemsTemp
     Add [id_retefuente] BIGINT NULL ;
END
GO
IF COL_LENGTH('[dbo].[MOVEntradasItemsTemp]', 'porcerefuente') IS NULL
BEGIN
     Alter Table  dbo.MOVEntradasItemsTemp
     Add [porcerefuente] decimal(5,2) NULL CONSTRAINT [DF_MOVEntradasItemsTemp_porcerefuente] default 0 ;
END
IF COL_LENGTH('[dbo].[MOVEntradasItemsTemp]', 'retefuente') IS NULL
BEGIN
     Alter Table   dbo.MOVEntradasItemsTemp
     Add [retefuente] decimal(18,4) NULL CONSTRAINT [DF_MOVEntradasItemsTemp_retefuente] default 0;
END
/*Campos de impuesto de reteiva*/
IF COL_LENGTH('[dbo].[MOVEntradasItemsTemp]', 'id_reteiva') IS NULL
BEGIN
     Alter Table dbo.MOVEntradasItemsTemp
     Add  [id_reteiva] BIGINT NULL ;
END
IF COL_LENGTH('[dbo].[MOVEntradasItemsTemp]', 'porcereiva') IS NULL
BEGIN
     Alter Table dbo.MOVEntradasItemsTemp
     Add  [porcereiva] decimal(5,2) NULL CONSTRAINT [DF_MOVEntradasItemsTemp_porcereiva] default 0 ;
END
IF COL_LENGTH('[dbo].[MOVEntradasItemsTemp]', 'reteiva') IS NULL
BEGIN
     Alter Table dbo.MOVEntradasItemsTemp
     Add [reteiva] decimal(18,4) NULL CONSTRAINT [DF_MOVEntradasItemsTemp_reteiva] default 0;
END
/*Campos de impuesto de reteica*/
IF COL_LENGTH('[dbo].[MOVEntradasItemsTemp]', 'id_reteica') IS NULL
BEGIN
     Alter Table dbo.MOVEntradasItemsTemp
     Add [id_reteica] BIGINT NULL ;
END
IF COL_LENGTH('[dbo].[MOVEntradasItemsTemp]', 'porcereica') IS NULL
BEGIN
     Alter Table dbo.MOVEntradasItemsTemp
     Add  [porcereica] decimal(5,2) NULL CONSTRAINT [DF_MOVEntradasItemsTemp_porcereica]  default 0 ;
END
IF COL_LENGTH('[dbo].[MOVEntradasItemsTemp]', 'reteica') IS NULL
BEGIN
     Alter Table dbo.MOVEntradasItemsTemp
     Add [reteica] decimal(18,4) NULL CONSTRAINT [DF_MOVEntradasItemsTemp_reteica] default 0;
END
/*RELACIONES*/
ALTER TABLE [dbo].[MOVEntradasItemsTemp]  WITH CHECK ADD  CONSTRAINT [FK_MOVEntradasItemsTemp_Impuestos2] FOREIGN KEY([id_retefuente])
REFERENCES [CNT].[Impuestos] ([id])
GO
ALTER TABLE [dbo].MOVEntradasItemsTemp CHECK CONSTRAINT [FK_MOVEntradasItemsTemp_Impuestos2]
GO
ALTER TABLE [dbo].MOVEntradasItemsTemp  WITH CHECK ADD  CONSTRAINT [FK_MOVEntradasItemsTemp_Impuestos3] FOREIGN KEY([id_reteica])
REFERENCES [CNT].[Impuestos] ([id])
GO
ALTER TABLE [dbo].MOVEntradasItemsTemp CHECK CONSTRAINT [FK_MOVEntradasItemsTemp_Impuestos3]
GO
ALTER TABLE [dbo].MOVEntradasItemsTemp  WITH CHECK ADD  CONSTRAINT [FK_MOVEntradasItemsTemp_Impuestos4] FOREIGN KEY([id_reteiva])
REFERENCES [CNT].[Impuestos] ([id])
GO

IF NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[CNTCategoriaFiscalServicios]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
	CREATE TABLE [dbo].[CNTCategoriaFiscalServicios](
		[id] [bigint] IDENTITY(1,1) NOT NULL,
		[id_servicio] [bigint] NOT NULL,
		[id_retefuente] [bigint] NULL,
		[id_reteiva] [bigint] NULL,
		[id_reteica] [bigint] NULL,
		[valorfuente] [numeric](18, 2) NULL,
		[valoriva] [numeric](18, 2) NULL,
		[valorica] [numeric](18, 2) NULL,
		[estado] [bit] NOT NULL CONSTRAINT [DF_CNTCategoriaFiscalServicios_estado]  DEFAULT ((1)),
		[created] [smalldatetime] NOT NULL CONSTRAINT [DF_CNTCategoriaFiscalServicios_created]  DEFAULT (getdate()),
		[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_CNTCategoriaFiscalServicios_updated]  DEFAULT (getdate()),
		[id_user] [bigint] NULL,
	 CONSTRAINT [PK_CNTCategoriaFiscalServicios] PRIMARY KEY CLUSTERED 
	(
		[id] ASC,
		[id_servicio] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
GO

ALTER TABLE [dbo].[CNTCategoriaFiscalServicios]  WITH CHECK ADD  CONSTRAINT [FK_CNTCategoriaFiscalServicios_Impuestos] FOREIGN KEY([id_retefuente])
REFERENCES [CNT].[Impuestos] ([id])
GO
ALTER TABLE [dbo].[CNTCategoriaFiscalServicios] CHECK CONSTRAINT [FK_CNTCategoriaFiscalServicios_Impuestos]
GO
ALTER TABLE [dbo].[CNTCategoriaFiscalServicios]  WITH CHECK ADD  CONSTRAINT [FK_CNTCategoriaFiscalServicios_Impuestos1] FOREIGN KEY([id_reteica])
REFERENCES [CNT].[Impuestos] ([id])
GO
ALTER TABLE [dbo].[CNTCategoriaFiscalServicios] CHECK CONSTRAINT [FK_CNTCategoriaFiscalServicios_Impuestos1]
GO
ALTER TABLE [dbo].[CNTCategoriaFiscalServicios]  WITH CHECK ADD  CONSTRAINT [FK_CNTCategoriaFiscalServicios_Impuestos2] FOREIGN KEY([id_reteiva])
REFERENCES [CNT].[Impuestos] ([id])
GO
ALTER TABLE [dbo].[CNTCategoriaFiscalServicios] CHECK CONSTRAINT [FK_CNTCategoriaFiscalServicios_Impuestos2]
GO
ALTER TABLE [dbo].[CNTCategoriaFiscalServicios]  WITH CHECK ADD  CONSTRAINT [FK_CNTCategoriaFiscalServicios_Productos] FOREIGN KEY([id_servicio])
REFERENCES [dbo].[Productos] ([id])
GO
ALTER TABLE [dbo].[CNTCategoriaFiscalServicios] CHECK CONSTRAINT [FK_CNTCategoriaFiscalServicios_Productos]
GO
ALTER TABLE [dbo].[CNTCategoriaFiscalServicios]  WITH CHECK ADD  CONSTRAINT [FK_CNTCategoriaFiscalServicios_Usuarios] FOREIGN KEY([id_user])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [dbo].[CNTCategoriaFiscalServicios] CHECK CONSTRAINT [FK_CNTCategoriaFiscalServicios_Usuarios]
GO


--changeset jteheran:3 dbms:mssql endDelimiter:GO
IF COL_LENGTH('[CNT].[MOVReciboCajasItems]', 'diasinterespagados') IS NULL
BEGIN
     Alter Table CNT.MOVReciboCajasItems
     Add [diasinterespagados] int NULL  CONSTRAINT [DF_MOVRecibocajaitems_diasinterespagados] default 0 ;
END
GO
IF COL_LENGTH('[CNT].[MOVReciboCajasItems]', 'pagototalinteres') IS NULL
BEGIN
     Alter Table CNT.MOVReciboCajasItems
     Add [pagototalinteres] int NULL  CONSTRAINT [DF_MOVRecibocajaitems_pagototalinteres] default 0 ;
END
GO

If EXISTS ( SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 WHERE c1.table_schema='dbo' And  c1.table_name = 'MOVDevFacturaItems' And c1.column_name = 'id_bodega')
BEGIN
     ALTER TABLE [dbo].[MOVDevFacturaItems] ALTER COLUMN [id_bodega] [bigint] NULL;
END
GO

If NOT EXISTS ( SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 WHERE c1.table_schema='CNT' And  c1.table_name = 'MOVComprobantesItemsTemp' And c1.column_name = 'id_saldocuota')
BEGIN
     ALTER TABLE [CNT].[MOVComprobantesItemsTemp] 
	 ADD [id_saldocuota] [bigint] NULL;
END
GO

If NOT EXISTS ( SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 WHERE c1.table_schema='CNT' And  c1.table_name = 'MOVComprobantesContablesItems' And c1.column_name = 'id_saldocuota')
BEGIN
     ALTER TABLE [CNT].[MOVComprobantesContablesItems] 
	 ADD [id_saldocuota] [bigint] NULL;
	 
END
GO

IF NOT EXISTS ( SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 WHERE c1.table_schema='dbo' And  c1.table_name = 'FormaPagos' And c1.column_name = 'default')
BEGIN
    ALTER TABLE [dbo].[FormaPagos] 
	ADD [default] [bit] NOT NULL DEFAULT(0);	
END
GO

IF NOT EXISTS ( SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 WHERE c1.table_schema='dbo' And  c1.table_name = 'MOVCotizacion' And c1.column_name = 'inc')
BEGIN
     ALTER TABLE [dbo].[MOVCotizacion] 
	 ADD [inc] [NUMERIC] (18,2) NOT NULL DEFAULT(0);	 
END
GO

IF NOT EXISTS ( SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 WHERE c1.table_schema='dbo' And  c1.table_name = 'MOVCotizacionItems' And c1.column_name = 'inc')
BEGIN
     ALTER TABLE [dbo].[MOVCotizacionItems] 
	 ADD [inc] [NUMERIC] (18,2) NOT NULL DEFAULT(0);	 
END
GO
