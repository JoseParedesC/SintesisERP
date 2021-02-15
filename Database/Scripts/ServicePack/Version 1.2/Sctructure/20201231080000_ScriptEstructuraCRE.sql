--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
/*Cabecera de Crear SCHEMA que no Existe*/
IF NOT EXISTS (SELECT 1 FROM SYS.SCHEMAS WHERE NAME = 'CRE')
BEGIN
     EXEC sp_executesql N'CREATE SCHEMA CRE AUTHORIZATION dbo;';
END
GO

If NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CRE].[Personas_Adicionales]') and OBJECTPROPERTY(id, N'IsTable') = 1)
CREATE TABLE [CRE].[Personas_Adicionales](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_persona] [bigint] NOT NULL,
	[id_solicitud] [bigint] NOT NULL,
	[connombre] [varchar](200) NULL,
	[contipoid] [int] NULL,
	[coniden] [varchar](20) NOT NULL CONSTRAINT [DF_Personas_Adicionales_coniden]  DEFAULT (''),
	[contelefono] [varchar](20) NULL,
	[concorreo] [varchar](120) NULL,
	[conempresa] [varchar](100) NULL,
	[condireccionemp] [varchar](250) NULL,
	[contelefonoemp] [varchar](20) NULL,
	[consalario] [numeric](18, 2) NULL,
	[id_tipoemp] [int] NULL,
	[empresalab] [varchar](250) NULL,
	[direccionemp] [varchar](250) NULL,
	[telefonoemp] [varchar](20) NULL,
	[cargo] [varchar](50) NULL,
	[id_tiempoemp] [int] NULL,
	[salarioemp] [numeric](18, 2) NULL,
	[otroingreso] [numeric](18, 2) NULL,
	[concepto] [varchar](250) NULL,
	[banco] [varchar](50) NULL,
	[id_tipocuenta] [int] NULL,
	[numcuenta] [varchar](50) NULL,
	[created] [datetime2](7) NOT NULL CONSTRAINT [DF_Personas_Adicionales_created]  DEFAULT (getdate()),
	[updated] [datetime2](7) NOT NULL CONSTRAINT [DF_Personas_Adicionales_updated]  DEFAULT (getdate()),
	[id_usercreated] [int] NOT NULL,
	[id_userupdated] [int] NOT NULL,
	[id_sector] [bigint] NULL,
	[id_tipoact] [bigint] NULL,
	[gastos] [numeric](18, 2) NOT NULL CONSTRAINT [DF_Personas_Adicionales_gastos]  DEFAULT ((0)),
	[estado] [bit] NOT NULL CONSTRAINT [DF_Personas_Adicionales_estado]  DEFAULT ((1)),
 CONSTRAINT [PK_Personas_Adicionales] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [CRE].[Personas_Referencias]    Script Date: 23/11/2020 9:53:44 a. m. ******/

If NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CRE].[Personas_Referencias]') and OBJECTPROPERTY(id, N'IsTable') = 1)
CREATE TABLE [CRE].[Personas_Referencias](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_persona] [bigint] NOT NULL,
	[id_solicitud] [bigint] NOT NULL,
	[nombre] [varchar](250) NOT NULL,
	[direccion] [varchar](250) NULL,
	[telefono] [varchar](20) NULL,
	[numero] [varchar](20) NULL,
	[id_tiporef] [bigint] NOT NULL,
	[created] [datetime2](7) NOT NULL CONSTRAINT [DF_Personas_Referencias_created]  DEFAULT (getdate()),
	[updated] [datetime2](7) NOT NULL CONSTRAINT [DF_Personas_Referencias_updated]  DEFAULT (getdate()),
	[id_usercreated] [int] NOT NULL,
	[id_userupdated] [int] NOT NULL,
	[id_parentezco] [int] NOT NULL,
	[estado] [bit] NOT NULL CONSTRAINT [DF_Personas_Referencias_estado]  DEFAULT ((0)),
 CONSTRAINT [PK_Personas_Referencias] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[Solicitud_Seguimientos]    Script Date: 03/12/2020 11:30:13 ******/

IF NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CRE].[Solicitud_Seguimientos]') and OBJECTPROPERTY(id, N'IsTable') = 1)
CREATE TABLE [CRE].[Solicitud_Seguimientos](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_solicitud] [bigint] NOT NULL,
	[seguimiento] [varchar](max) NOT NULL,
	[id_user] [bigint] NOT NULL,
	[created] [datetime2](7) NOT NULL CONSTRAINT [DF_Solicitud_Seguimientos_created]  DEFAULT (getdate()),
	[visible] [bit] NOT NULL CONSTRAINT [DF_Solicitud_Seguimientos_visible]  DEFAULT ((1)),
 CONSTRAINT [PK_Solicitud_Seguimientos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

/****** Object:  Table [dbo].[Solicitud_Evaluacion]    Script Date: 03/12/2020 10:08:35 ******/

If  NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CRE].[Solicitud_Evaluacion]') and OBJECTPROPERTY(id, N'IsTable') = 1)
CREATE TABLE [CRE].[Solicitud_Evaluacion](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_solicitudpersona] [bigint] NOT NULL,
	[evaldatos] [varchar](2) NULL,
	[evallaboral] [varchar](2) NULL,
	[evalbancaria] [varchar](2) NULL,
	[evalreferencia] [varchar](2) NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_SolicitudEvaluacion_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_SolicitudEvaluacion_update]  DEFAULT (getdate()),
	[id_user] [bigint] NOT NULL,
 CONSTRAINT [PK_SolicitudEvaluacion] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

/****** Object:  Table [CRE].[Solicitud_Personas]    Script Date: 03/12/2020 10:14:40 ******/

IF NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CRE].[Solicitud_Personas]') and OBJECTPROPERTY(id, N'IsTable') = 1)
CREATE TABLE [CRE].[Solicitud_Personas](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_persona] [bigint] NOT NULL,
	[id_solicitud] [bigint] NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_Personas_Solicitud_Created]  DEFAULT (getdate()),
 CONSTRAINT [PK_Personas_Solicitud] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [CRE].[Solicitudes]    Script Date: 23/11/2020 9:53:44 a. m. ******/

IF NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CRE].[Solicitudes]') and OBJECTPROPERTY(id, N'IsTable') = 1)
CREATE TABLE [CRE].[Solicitudes](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[consecutivo] [varchar](20) NOT NULL,
	[fechasolicitud] [datetime2](7) NOT NULL,
	[estado] [int] NOT NULL,
	[id_cotizacion] [bigint] NOT NULL,
	[id_estacion] [bigint] NOT NULL,
	[id_userasign] [bigint] NOT NULL,
	[numaprobacion] [varchar](20) NULL,
	[fechaaprobacion] [smalldatetime] NULL,
	[fechaanalisis] [datetime2](7) NULL,
	[created] [smalldatetime] NULL CONSTRAINT [DF_Solicitudes_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NULL CONSTRAINT [DF_Solicitudes_updated]  DEFAULT (getdate()),
	[id_usercreated] [int] NOT NULL,
	[id_userupdated] [int] NOT NULL,
 CONSTRAINT [PK_Solicitudes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [CRE].[Personas]    Script Date: 23/11/2020 9:50:31 a. m. ******/

IF NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CRE].[Personas]') and OBJECTPROPERTY(id, N'IsTable') = 1)
CREATE TABLE [CRE].[Personas](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_tipoiden] [bigint] NOT NULL,
	[tipo_persona] [int] NOT NULL,
	[identificacion] [varchar](20) NOT NULL,
	[primernombre] [varchar](50) NOT NULL,
	[segundonombre] [varchar](50) NULL,
	[primerapellido] [varchar](50) NOT NULL,
	[segundoapellido] [varchar](50) NULL,
	[id_ciudad] [bigint] NOT NULL,
	[direccion] [varchar](100) NOT NULL,
	[telefono] [varchar](50) NULL,
	[celular] [varchar](50) NOT NULL,
	[otrotel] [varchar](20) NULL,
	[correo] [varchar](100) NOT NULL,
	[id_viveinmueble] [bigint] NOT NULL,
	[id_fincaraiz] [bigint] NULL,
	[valorarriendo] [numeric](18, 4) NULL CONSTRAINT [DF_Personas_Adicionales_valorarriendo]  DEFAULT ((0)),
	[cualfinca] [varchar](150) NULL CONSTRAINT [DF_Personas_Adicionales_cualfinca]  DEFAULT (''),
	[digverificacion] [varchar](50) NOT NULL,
	[fechaexpedicion] [smalldatetime] NULL,
	[fechanacimiento] [smalldatetime] NULL,
	[percargo] [int] NOT NULL CONSTRAINT [DF_Personas_percargo]  DEFAULT ((0)),
	[id_genero] [int] NOT NULL,
	[id_estrato] [int] NOT NULL,
	[profesion] [varchar](50) NULL,
	[vehiculo] [varchar](500) NULL,
	[id_estadocivil] [int] NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_Personas_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_Personas_updated]  DEFAULT (getdate()),
	[id_usercreated] [int] NOT NULL,
	[id_userupdated] [int] NOT NULL,
	[urlperfil] [varchar](max) NULL CONSTRAINT [DF_Personas_urlperfil]  DEFAULT (''),
	[urlimgper] [varchar](max) NULL CONSTRAINT [DF_Personas_urlimgper]  DEFAULT (''),
	[id_ciudadexp] [bigint] NULL,
	[id_escolaridad] [bigint] NOT NULL,
	[tipo_tercero] [char](2) NULL,
 CONSTRAINT [PK_Personas] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

/****** Object:  Table [CRE].[Estaciones]    Script Date: 23/11/2020 9:52:10 a. m. ******/

IF NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CRE].[Estaciones]') and OBJECTPROPERTY(id, N'IsTable') = 1)
CREATE TABLE [CRE].[Estaciones](
	[id] [BIGINT] IDENTITY(1,1) NOT NULL,
	[direccion] [VARCHAR](50)NOT NULL,
	[nombre] [VARCHAR](30)NOT NULL
	CONSTRAINT [PK_Estaciones] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

--Tabla de [CRE].[Consecutivo] (lleva el conteo de las solicitudes que se marcan)

IF NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CRE].[Consecutivo]') and OBJECTPROPERTY(id, N'IsTable') = 1)
CREATE TABLE [CRE].[Consecutivo](
	[consecutivo] [int] NOT NULL CONSTRAINT [DF_Consecutivo_consecutivo]  DEFAULT ((0)),
	[id_estacion] [bigint] NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_Consecutivo_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_Consecutivo_updated]  DEFAULT (getdate()),
	[id_user] [bigint] NOT NULL
) ON [PRIMARY]
GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [CRE].[Solicitud_Archivos]    Script Date: 24/12/2020 13:48:19 ******/

IF NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CRE].[Solicitud_Archivos]') and OBJECTPROPERTY(id, N'IsTable') = 1)
CREATE TABLE [CRE].[Solicitud_Archivos](
    [id] [bigint] IDENTITY(1,1) NOT NULL,
    [keyid] [varchar](255) NULL,
    [urlarchivo] [varchar](max) NOT NULL,
    [id_persol] [bigint] NOT NULL,
	[id_user] [bigint] NOT NULL,
    [rutaapp] [varchar](max) NULL,
    [name] [varchar](max) NULL,
    [token] [varchar](255) NOT NULL CONSTRAINT [DF_Archivos_Personas_Solicitud_token]  DEFAULT (newid()),
 CONSTRAINT [PK_ArchivosPersonas_Solicitud] PRIMARY KEY CLUSTERED 
(
    [id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
GO
 
SET ANSI_PADDING OFF
GO


/*-------------------------------------------------------------------CONSTRAINTS-------------------------------------------------------------------*/

--PERSONAS

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_Personas_DivPolitica')
ALTER TABLE [CRE].[Personas]  WITH CHECK ADD  CONSTRAINT [FK_Personas_DivPolitica] FOREIGN KEY([id_ciudadexp])
REFERENCES [Dbo].[DivPolitica] ([id])
GO
ALTER TABLE [CRE].[Personas] CHECK CONSTRAINT [FK_Personas_DivPolitica]
GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_Personas_DivPoliticaP')
ALTER TABLE [CRE].[Personas]  WITH CHECK ADD  CONSTRAINT [FK_Personas_DivPoliticaP] FOREIGN KEY([id_ciudad])
REFERENCES [Dbo].[DivPolitica] ([id])

GO
ALTER TABLE [CRE].[Personas] CHECK CONSTRAINT [FK_Personas_DivPolitica]
GO

-- PERSONAS ADICIONALES
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_Personas_Adicionales_Personas')
ALTER TABLE [CRE].[Personas_Adicionales]  WITH CHECK ADD  CONSTRAINT [FK_Personas_Adicionales_Personas] FOREIGN KEY([id_persona])
REFERENCES [CRE].[Personas] ([id])
GO
ALTER TABLE [CRE].[Personas_Adicionales] CHECK CONSTRAINT [FK_Personas_Adicionales_Personas]
GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_Personas_Adicionales_Solicitudes')
ALTER TABLE [CRE].[Personas_Adicionales]  WITH CHECK ADD CONSTRAINT [FK_Personas_Adicionales_Solicitudes] FOREIGN KEY([id_solicitud])
REFERENCES [CRE].[Solicitudes] ([id])
GO
ALTER TABLE [CRE].[Personas_Adicionales] CHECK CONSTRAINT [FK_Personas_Adicionales_Solicitudes]
GO

-- SOLICITUDES
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_Solicitudes_Cotizaciones')
ALTER TABLE [CRE].[Solicitudes]  WITH CHECK ADD  CONSTRAINT [FK_Solicitudes_Cotizaciones] FOREIGN KEY([id_cotizacion])
REFERENCES [dbo].[MOVCotizacion] ([id])
GO

ALTER TABLE [CRE].[Solicitudes] CHECK CONSTRAINT [FK_Solicitudes_Cotizaciones]
GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_Solicitudes_Usuarios')
ALTER TABLE [CRE].[Solicitudes]  WITH CHECK ADD  CONSTRAINT [FK_Solicitudes_Usuarios] FOREIGN KEY([id_userasign])
REFERENCES [dbo].[Usuarios] ([id])
GO

ALTER TABLE [CRE].[Solicitudes] CHECK CONSTRAINT [FK_Solicitudes_Usuarios]
GO



-- SOLICITUD EVALUACION
GO
SET ANSI_PADDING OFF
GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_Solicitud_Evaluacion_Usuarios')
ALTER TABLE [CRE].[Solicitud_Evaluacion]  WITH CHECK ADD  CONSTRAINT [FK_Solicitud_Evaluacion_Usuarios] FOREIGN KEY([id_user])
REFERENCES [dbo].[Usuarios] ([id])
GO

ALTER TABLE [CRE].[Solicitud_Evaluacion] CHECK CONSTRAINT [FK_Solicitud_Evaluacion_Usuarios]
GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_SolicitudEvaluacion_Persona_Solicitud')
ALTER TABLE [CRE].[Solicitud_Evaluacion]  WITH CHECK ADD  CONSTRAINT [FK_SolicitudEvaluacion_Persona_Solicitud] FOREIGN KEY([id_solicitudpersona])
REFERENCES [CRE].[Solicitud_Personas] ([id])
GO

ALTER TABLE [CRE].[Solicitud_Evaluacion] CHECK CONSTRAINT [FK_SolicitudEvaluacion_Persona_Solicitud]
GO


-- SOLICITUDES SEGUIMIENTO
GO
SET ANSI_PADDING OFF
GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_Solicitud_Seguimientos_Solicitudes')
ALTER TABLE [CRE].[Solicitud_Seguimientos]  WITH CHECK ADD  CONSTRAINT [FK_Solicitud_Seguimientos_Solicitudes] FOREIGN KEY([id_solicitud])
REFERENCES [CRE].[Solicitudes] ([id])
GO

ALTER TABLE [CRE].[Solicitud_Seguimientos] CHECK CONSTRAINT [FK_Solicitud_Seguimientos_Solicitudes]
GO

-- PERSONAS REFERENCIAS
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_Personas_Referencias_Personas')
ALTER TABLE [CRE].[Personas_Referencias]  WITH CHECK ADD  CONSTRAINT [FK_Personas_Referencias_Personas] FOREIGN KEY([id_persona])
REFERENCES [CRE].[Personas] ([id])
GO

ALTER TABLE [CRE].[Personas_Referencias] CHECK CONSTRAINT [FK_Personas_Referencias_Personas]
GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_Personas_Referencias_Solicitudes')
ALTER TABLE [CRE].[Personas_Referencias]  WITH CHECK ADD  CONSTRAINT [FK_Personas_Referencias_Solicitudes] FOREIGN KEY([id_solicitud])
REFERENCES [CRE].[Solicitudes] ([id])
GO

ALTER TABLE [CRE].[Personas_Referencias] CHECK CONSTRAINT [FK_Personas_Referencias_Solicitudes]
GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_Personas_Referencias_ST_Listados')
ALTER TABLE [CRE].[Personas_Referencias]  WITH CHECK ADD  CONSTRAINT [FK_Personas_Referencias_ST_Listados] FOREIGN KEY([id_parentezco])
REFERENCES [dbo].[ST_Listados] ([id])
GO

ALTER TABLE [CRE].[Personas_Referencias] CHECK CONSTRAINT [FK_Personas_Referencias_ST_Listados]
GO

-- PERSONAS_SOLICITUD
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_Personas_SolicitudPersonas')
ALTER TABLE [CRE].[Solicitud_Personas]  WITH CHECK ADD  CONSTRAINT [FK_Personas_SolicitudPersonas] FOREIGN KEY([id_persona])
REFERENCES [CRE].[Personas] ([id])
GO 

ALTER TABLE [CRE].[Solicitud_Personas] CHECK CONSTRAINT [FK_Personas_SolicitudPersonas]
GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_Personas_SolicitudSolicitudes')
ALTER TABLE [CRE].[Solicitud_Personas]  WITH CHECK ADD  CONSTRAINT [FK_Personas_SolicitudSolicitudes] FOREIGN KEY([id_solicitud])
REFERENCES [CRE].[Solicitudes] ([id])
GO

ALTER TABLE [CRE].[Solicitud_Personas] CHECK CONSTRAINT [FK_Personas_SolicitudSolicitudes]
GO

-- PERSONAS SOLICITUD ARCHIVOS

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_Archivos_Personas_Solicitud')
ALTER TABLE [CRE].[Solicitud_Archivos]  WITH CHECK ADD  CONSTRAINT [FK_Archivos_Personas_Solicitud] FOREIGN KEY([id_persol])
REFERENCES [CRE].[Solicitud_Personas] ([id])
GO
 
ALTER TABLE [CRE].[Solicitud_Archivos] CHECK CONSTRAINT [FK_Archivos_Personas_Solicitud]
GO

/*Modificacion de tabla MovCotizaciones*/
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS i WHERE COLUMN_NAME = 'observaciones' AND TABLE_NAME = 'MOVCotizacion')
ALTER TABLE [dbo].[MOVCotizacion] add observaciones VARCHAR(500)
GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS i WHERE COLUMN_NAME = 'numcuotas' AND TABLE_NAME = 'MOVCotizacion')
ALTER TABLE [dbo].[MOVCotizacion] add numcuotas BIGINT
GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS i WHERE COLUMN_NAME = 'total' AND TABLE_NAME = 'MOVCotizacion')
ALTER TABLE [dbo].[MOVCotizacion] add financiacion NUMERIC(18,2)
GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS i WHERE COLUMN_NAME = 'cuotamen' AND TABLE_NAME = 'MOVCotizacion')
ALTER TABLE [dbo].[MOVCotizacion] add cuotamen NUMERIC(18,2)
GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS i WHERE COLUMN_NAME = 'fechaini' AND TABLE_NAME = 'MOVCotizacion')
ALTER TABLE [dbo].[MOVCotizacion] add fechaini SMALLDATETIME
GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS i WHERE COLUMN_NAME = 'credito' AND TABLE_NAME = 'MOVCotizacion')
ALTER TABLE [dbo].[MOVCotizacion] add credito bit
GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS i WHERE COLUMN_NAME = 'lineacredit' AND TABLE_NAME = 'MOVCotizacion')
ALTER TABLE [dbo].[MOVCotizacion] add lineacredit BIGINT
GO


/*Insert Table ST_listados*/
IF NOT EXISTS (SELECT 1 FROM [dbo].[ST_Listados] WHERE [codigogen] = 'ESTCIVIL')
BEGIN
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES ( N'ESTCIVIL', N'', N'', N'Estado Civil', 1, GETDATE(), GETDATE(), 1, 0)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES ( NULL, N'ESTCIVIL', N'SOL', N'Soltero', 1, GETDATE(), GETDATE(), 1, 0)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES ( NULL, N'ESTCIVIL', N'CAS', N'Casado', 1, GETDATE(), GETDATE(), 1, 0)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES ( NULL, N'ESTCIVIL', N'UNL', N'Union Libre', 1, GETDATE(), GETDATE(), 1, 0)
 
END
 
IF NOT EXISTS (SELECT 1 FROM [dbo].[ST_Listados] WHERE [codigogen] = 'FINRAIZ')
BEGIN
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES ( N'FINRAIZ', N'', N'', N'Finca Raiz', 1, GETDATE(), GETDATE(), 1, 0)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'FINRAIZ', N'CAS', N'Casa', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'FINRAIZ', N'APTO', N'Apartamento', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'FINRAIZ', N'LOT', N'Lote', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'FINRAIZ', N'OTR', N'Otro', 1, GETDATE(), GETDATE(), 1, 1)
 
 
END
 
IF NOT EXISTS (SELECT 1 FROM [dbo].[ST_Listados] WHERE [codigogen] = 'VIVEINM')
BEGIN
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (N'VIVEINM', N'', N'', N'Vive Inmueble', 1, GETDATE(), GETDATE(), 1, 0)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'VIVEINM', N'PRP', N'Propio', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'VIVEINM', N'ARRD', N'Arrendado', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'VIVEINM', N'FAM', N'Familiar', 1, GETDATE(), GETDATE(), 1, 1)
 
 
END
 
IF NOT EXISTS (SELECT 1 FROM [dbo].[ST_Listados] WHERE [codigogen] = 'TIMSERVI')
BEGIN
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (N'TIMSERVI', N'', N'', N'Tiempo de Servicio', 1, GETDATE(), GETDATE(), 1, 0)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'TIMSERVI', N'UANO', N'Menor a 1 Año', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'TIMSERVI', N'UTANO', N'Entre 1 - 3 Años', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'TIMSERVI', N'TSANO', N'Entre 3 - 7 Años', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'TIMSERVI', N'MSANO', N'Mayor a 7 Años', 1, GETDATE(), GETDATE(), 1, 1)
 
 
END
 
IF NOT EXISTS (SELECT 1 FROM [dbo].[ST_Listados] WHERE [codigogen] = 'TIPOCTABNC')
BEGIN
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (N'TIPOCTABNC', N'', N'', N'Tipo Cuenta Banco', 1, GETDATE(), GETDATE(), 1, 0)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'TIPOCTABNC', N'AHR', N'Ahorro', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'TIPOCTABNC', N'CORT', N'Corriente', 1, GETDATE(), GETDATE(), 1, 1)
 
 
END
 
IF NOT EXISTS (SELECT 1 FROM [dbo].[ST_Listados] WHERE [codigogen] = 'TIPOREF')
BEGIN
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (N'TIPOREF', N'', N'', N'Tipo Referencias', 1, GETDATE(), GETDATE(), 1, 0)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'TIPOREF', N'RFAM', N'Familiar', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'TIPOREF', N'RPER', N'Personal', 1, GETDATE(), GETDATE(), 1, 1)
 
 
END
 
IF NOT EXISTS (SELECT 1 FROM [dbo].[ST_Listados] WHERE [codigogen] = 'ESTRATO')
BEGIN
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (N'ESTRATO', N'', N'', N'Estratos', 1, GETDATE(), GETDATE(), 1, 0)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'ESTRATO', N'ESTU', N'1', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'ESTRATO', N'ESTD', N'2', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'ESTRATO', N'ESTT', N'3', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'ESTRATO', N'ESTC', N'4', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'ESTRATO', N'ESTI', N'5', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'ESTRATO', N'ESTS', N'6', 1, GETDATE(), GETDATE(), 1, 1)
 
 
END
 
IF NOT EXISTS (SELECT 1 FROM [dbo].[ST_Listados] WHERE [codigogen] = 'GENERO')
BEGIN
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (N'GENERO', N'', N'', N'Género', 1, GETDATE(), GETDATE(), 1, 0)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'GENERO', N'GF', N'Femenino', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'GENERO', N'GM', N'Masculino', 1, GETDATE(), GETDATE(), 1, 1)
 
 
END
 
IF NOT EXISTS (SELECT 1 FROM [dbo].[ST_Listados] WHERE [codigogen] = 'NIVEDUC')
BEGIN
 
INSERT [dbo].[ST_Listados] ( [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES ( N'NIVEDUC', N'', N'', N'Nivel de Educación', 1, GETDATE(), GETDATE(), 1, 0)
 
INSERT [dbo].[ST_Listados] ( [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES ( NULL, N'NIVEDUC', N'NPRI', N'Primaria', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] ( [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES ( NULL, N'NIVEDUC', N'NMED', N'Media', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] ( [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES ( NULL, N'NIVEDUC', N'NTEC', N'Tecnico', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] ( [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES ( NULL, N'NIVEDUC', N'NTCG', N'Tecnologo', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] ( [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES ( NULL, N'NIVEDUC', N'TUNI', N'Universitario', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] ( [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES ( NULL, N'NIVEDUC', N'TPOS', N'Posgrado', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] ( [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES ( NULL, N'NIVEDUC', N'TMASDOC', N'Maestria/Doctorado', 1, GETDATE(), GETDATE(), 1, 1)
 
 
END
 
IF NOT EXISTS (SELECT 1 FROM [dbo].[ST_Listados] WHERE [codigogen] = 'NOMDIREC')
BEGIN
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (N'NOMDIREC', N'', N'', N'Nomenclatura Dirección', 1, GETDATE(), GETDATE(), 1, 0)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'AC', N'Avenida calle', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'AD', N'Administración', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'ADL', N'Adelante', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'AER', N'Aeropuerto', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'AG', N'Agencia', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'AGP', N'Agrupación', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'AK', N'Avenida carrera', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'AL', N'Altillo', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'ALD', N'Al lado', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'ALM', N'Almacén', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'AP', N'Apartamento', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'APTDO', N'Apartado', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'ATR', N'Atrás', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'AUT', N'Autopista', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'AV', N'Avenida', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'AVIAL', N'Anillo vial', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'BG', N'Bodega', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'BL', N'Bloque', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'BLV', N'Boulevard', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'BRR', N'Barrio', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'C', N'Corregimiento', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'CA', N'Casa', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'CAS', N'Caserío', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'CC', N'Centro comercial', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'CEL', N'Célula', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'CEN', N'Centro', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'CIR', N'Circular', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'CL', N'Calle', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'CLJ', N'Callejón', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'CN', N'Camino', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'CON', N'Conjunto residencial', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'CONJ', N'Conjunto', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'CR', N'Carrera', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'CRT', N'Carretera', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'CRV', N'Circunvalar', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'CS', N'Consultorio', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'DG', N'Diagonal', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'DP', N'Depósito', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'DPTO', N'Departamento', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'DS', N'Depósito sótano', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'ED', N'Edificio', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'EN', N'Entrada', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'ES', N'Escalera', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'ESQ', N'Esquina', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'ESTE', N'Este', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'ET', N'Etapa', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'EX', N'Exterior', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'GJ', N'Garaje', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'GS', N'Garaje sótano', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'GT', N'Glorieta', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'HC', N'Hacienda', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'HG', N'Hangar', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'IN', N'Interior', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'IP', N'Inspección de Policía', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'IPD', N'Inspección Departamental', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'IPM', N'Inspección Municipal', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'KM', N'Kilómetro', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'LC', N'Local', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'LM', N'Local mezzanine', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'LT', N'Lote', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'MD', N'Módulo', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'MLL', N'Muelle', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'MN', N'Mezzanine', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'MZ', N'Manzana', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'NOMBRE VIA', N'Vías de nombre común', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'NORTE', N'Norte O Oriente', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'OCC', N'Occidente', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'OESTE', N'Oeste', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'OF', N'Oficina', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'P', N'Piso', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'PA', N'Parcela', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'PAR', N'Parque', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'PD', N'Predio', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'PH', N'Penthouse', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'PJ', N'Pasaje', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'PL', N'Planta', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'PN', N'Puente', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'POR', N'Portería', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'POS', N'Poste', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'PQ', N'Parqueadero', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'PRJ', N'Paraje', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'PS', N'Paseo', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'PT', N'Puesto', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'PW', N'Park Way', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'RP', N'Round Point', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'SA', N'Salón', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'SC', N'Salón comunal', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'SD', N'Salida', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'SEC', N'Sector', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'SL', N'Solar', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'SM', N'Súper manzana', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'SS', N'Semisótano', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'ST', N'Sótano', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'SUR', N'Sur', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'TER', N'Terminal', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'TERPLN', N'Terraplén', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'TO', N'Torre', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'TV', N'Transversal', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'TZ', N'Terraza', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'UN', N'Unidad', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'UR', N'Unidad residencial', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'URB', N'Urbanización', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'VRD', N'Vereda', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'VTE', N'Variante', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'ZF', N'Zona franca', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'ZN', N'Zona', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'NOMDIREC', N'CD', N'Ciudadela', 1, GETDATE(), GETDATE(), 1, 1)
 
 
END
 
IF NOT EXISTS (SELECT 1 FROM [dbo].[ST_Listados] WHERE [codigogen] = 'TIPOEMPLEO')
BEGIN
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (N'TIPOEMPLEO', N'', N'', N'Tipo Empleo', 1, GETDATE(), GETDATE(), 1, 0)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'TIPOEMPLEO', N'INDEPEN', N'Independiente', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'TIPOEMPLEO', N'ASALA', N'Asalariado', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'TIPOEMPLEO', N'COMER', N'Comerciante', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'TIPOEMPLEO', N'EMPPUB', N'Empleado Publico', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'TIPOEMPLEO', N'ESTUDI', N'Estudiante', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'TIPOEMPLEO', N'HOGAR', N'Hogar', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'TIPOEMPLEO', N'INVERSI', N'Inversionista', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'TIPOEMPLEO', N'PENSION', N'Pensionado', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'TIPOEMPLEO', N'RENTISTA', N'Rentista', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'TIPOEMPLEO', N'SOCIO', N'Socio', 1, GETDATE(), GETDATE(), 1, 1)
 
 
END
 
IF NOT EXISTS (SELECT 1 FROM [dbo].[ST_Listados] WHERE [codigogen] = 'ESTADOSCRE')
BEGIN
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (N'ESTADOSCRE', N'', N'', N'Estados del Credito', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'ESTADOSCRE', N'SOLICIT', N'Solicitado', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'ESTADOSCRE', N'REPROCES', N'Reproceso', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'ESTADOSCRE', N'ENANAL', N'En Analisis', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'ESTADOSCRE', N'APROVED', N'Aprobado', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'ESTADOSCRE', N'RECHA', N'Rechazado', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'ESTADOSCRE', N'COTIZ', N'Cotizada', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'ESTADOSCRE', N'GESTION', N'En Gestión', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'ESTADOSCRE', N'EXCEPCI', N'Excepcionado', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'ESTADOSCRE', N'CREATED', N'Creado', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'ESTADOSCRE', N'UTILIZ', N'Utilizada', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'ESTADOSCRE', N'FACTURED', N'Facturado', 1, GETDATE(), GETDATE(), 1, 1)
 
 
END
 
IF NOT EXISTS (SELECT 1 FROM [dbo].[ST_Listados] WHERE [codigogen] = 'TIPOACTIVIDAD')
BEGIN
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (N'TIPOACTIVIDAD', N'', N'', N'Tipo de Actividad', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'TIPOACTIVIDAD', N'AGRICO', N'Agricola', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'TIPOACTIVIDAD', N'CAMPOL', N'Campaña Politica', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'TIPOACTIVIDAD', N'ALIMENT', N'Alimentos', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'TIPOACTIVIDAD', N'CONSTRUC', N'Construcción', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'TIPOACTIVIDAD', N'EDUCACION', N'Educación', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'TIPOACTIVIDAD', N'FARMACE', N'Farmaceutica', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'TIPOACTIVIDAD', N'INFORMA', N'Informatica', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'TIPOACTIVIDAD', N'METALMEC', N'Metalmecanico', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'TIPOACTIVIDAD', N'PETROLEO', N'Petroleo', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'TIPOACTIVIDAD', N'QUIMICO', N'Quimico', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'TIPOACTIVIDAD', N'SALUD', N'Salud', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'TIPOACTIVIDAD', N'SERFIN', N'Servicios Financieros', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'TIPOACTIVIDAD', N'TELECOMU', N'Telecomunicaciones', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'TIPOACTIVIDAD', N'TEXTIL', N'Textiles', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'TIPOACTIVIDAD', N'TURISMO', N'Turismo', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'TIPOACTIVIDAD', N'OTROTA', N'Otro', 1, GETDATE(), GETDATE(), 1, 1)
 
 
END
 
IF NOT EXISTS (SELECT 1 FROM [dbo].[ST_Listados] WHERE [codigogen] = 'PARENTEZCO')
BEGIN
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (N'PARENTEZCO', N'', N'', N'Parentezco', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'PARENTEZCO', N'VECINO', N'Vecino', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'PARENTEZCO', N'HERMANO', N'Hermano', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'PARENTEZCO', N'PADREMADRE', N'Padre o Madre', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'PARENTEZCO', N'TIO', N'Tio o Tia', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'PARENTEZCO', N'ABUELO', N'Abuelo(a)', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'PARENTEZCO', N'AMIGO', N'Amigo(a)', 1, GETDATE(), GETDATE(), 1, 1)
 
INSERT [dbo].[ST_Listados] (  [codigogen], [codigo], [iden], [nombre], [estado], [created], [updated], [id_user], [bloqueo]) VALUES (NULL, N'PARENTEZCO', N'PRIMOPRIMA', N'Primo o Prima', 1, GETDATE(), GETDATE(), 1, 1)
 
 
END

/*Cargar Menus*/
SET IDENTITY_INSERT [dbo].[Menus] OFF
 
GO
 
SET ANSI_PADDING ON
IF NOT EXISTS (SELECT 1 FROM [dbo].[Menus] WHERE [nombrepagina] = 'Credito')
BEGIN 
INSERT INTO [dbo].[Menus] ([nombrepagina],[estado],[pathpagina],[id_padre],[descripcion],[orden],[padre],[icon],[id_usuario]) VALUES('Credito',1,'#',0,'Menu de Credito',3,1,'fa fa-bank',1)    
END
                                                                            
 
IF NOT EXISTS (SELECT 1 FROM [dbo].[Menus] WHERE [nombrepagina] = 'Analisis')
BEGIN 
INSERT INTO [dbo].[Menus] ([nombrepagina],[estado],[pathpagina],[id_padre],[descripcion],[orden],[padre],[icon],[id_usuario]) VALUES('Analisis',1,'analisis.aspx',(select id from Menus where nombrepagina = 'Credito'),'Maestro de analisis',1,0,'fa-th-large',1)
END 
 
IF NOT EXISTS (SELECT 1 FROM [dbo].[Menus] WHERE [nombrepagina] = 'Solicitud credito')
BEGIN 
INSERT INTO [dbo].[Menus] ([nombrepagina],[estado],[pathpagina],[id_padre],[descripcion],[orden],[padre],[icon],[id_usuario]) VALUES('Solicitud credito',1,'Solicitud.aspx',(select id from Menus where nombrepagina = 'Credito'),'Maestro de credito',1,0,'fa-th-large',1)
END

IF NOT EXISTS(SELECT 1 FROM [dbo].[Menus] WHERE nombrepagina = 'Analisis Excepcionado')
BEGIN
INSERT INTO [dbo].[Menus] ([nombrepagina],[estado],[pathpagina],[id_padre],[descripcion],[orden],[padre],[icon],[id_usuario]) VALUES('Analisis Excepcionado',1,'analisisExc.aspx',(select id from Menus where nombrepagina = 'Credito'),'Maestro de analisis Excepcionado',1,0,'fa-th-large',1)
END

GO
 
SET IDENTITY_INSERT [dbo].[MenusPerfiles] OFF
 
GO
 
SET ANSI_PADDING ON
IF NOT EXISTS (SELECT 1 FROM [dbo].[MenusPerfiles] WHERE [id_menu] = (select id from [dbo].[Menus] where nombrepagina = 'Analisis' ))
BEGIN
INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
           ,[id_menu]
           ,[id_user])
     VALUES
           (1,
           (select id from [dbo].[Menus] where nombrepagina = 'Analisis' )
           ,1)

INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
           ,[id_menu]
           ,[id_user])
     VALUES
           (2,
           (select id from [dbo].[Menus] where nombrepagina = 'Analisis' )
           ,1)

INSERT INTO [dbo].[MenusPerfiles] 
			([id_perfil] ,
			[id_menu] ,
			[id_user]) 
	  VALUES (1, 
	  (select id from [dbo].[Menus] where nombrepagina = 'Analisis Excepcionado' ) 
	  ,1)

INSERT INTO [dbo].[MenusPerfiles] 
			([id_perfil] ,
			[id_menu] ,
			[id_user]) 
		VALUES (2, 
		(select id from [dbo].[Menus] where nombrepagina = 'Analisis Excepcionado' ) 
		,1)
END

IF NOT EXISTS (SELECT 1 FROM [dbo].[MenusPerfiles] WHERE [id_menu] = (select id from [dbo].[Menus] where nombrepagina = 'Solicitud credito' ))
BEGIN
INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
           ,[id_menu]
           ,[id_user])
     VALUES
           (1,
           (select id from Menus where  nombrepagina = 'Solicitud credito')
           ,1)

INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
           ,[id_menu]
           ,[id_user])
     VALUES
           (2,
           (select id from Menus where  nombrepagina = 'Solicitud credito')
           ,1)
END
GO


/*Parametros Cantidad Codeudores*/
IF EXISTS(SELECT 1 FROM [dbo].[Parametros] WHERE codigo= 'CANTCODEUDOR')
	DELETE FROM [dbo].[Parametros] WHERE codigo= 'CANTCODEUDOR'
	
INSERT INTO [dbo].[Parametros](codigo, nombre, valor, tipo, created, updated, id_user) VALUES(	'CANTCODEUDOR',	'Cantidad de Codeudores',	'2', 	'TEXT',	'2020-12-04 13:20:00', 	'2020-12-04 13:20:00',	1)


IF NOT EXISTS(SELECT 1 FROM [dbo].[ST_Reportes] WHERE codigo = 'SOLICITCREDITO')
BEGIN 
INSERT INTO [dbo].[ST_Reportes] ([codigo],[nombre],[frx],[listado],[estado],[created],[updated],[id_user],[nombreproce],[paramadicionales]) VALUES ('SOLICITCREDITO', 'Solicitud  de Credito','SolicitudCredito.frx',1,1,GETDATE(),GETDATE(),1,NULL,'')
END
GO
