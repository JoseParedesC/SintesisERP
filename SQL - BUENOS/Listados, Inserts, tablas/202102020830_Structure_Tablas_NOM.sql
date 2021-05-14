--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Prestaciones' AND TABLE_SCHEMA = 'NOM')
BEGIN
	CREATE TABLE [NOM].[Prestaciones](
		id BIGINT IDENTITY(1,1) NOT NULL,
		codigo BIGINT NULL,
		nombre VARCHAR(60) NOT NULL,
		contrapartida BIGINT NOT NULL,
		provision NUMERIC(18,4) NOT NULL,
		tipo_prestacion INT NOT NULL,
		created SMALLDATETIME NULL CONSTRAINT [DF_Prestaciones_created] DEFAULT GETDATE(),
		updated SMALLDATETIME NULL CONSTRAINT [DF_Prestaciones_updated] DEFAULT GETDATE(),
		id_usercreated BIGINT NOT NULL,
		id_userupdated BIGINT NOT NULL
	)
END


GO


IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Devengos' AND TABLE_SCHEMA = 'NOM')
BEGIN
	CREATE TABLE [NOM].[Devengos](
		id BIGINT NOT NULL IDENTITY(1,1) PRIMARY KEY,
		id_per_cont BIGINT NOT NULL,
		fecha_inicio SMALLDATETIME NULL,
		fecha_fin SMALLDATETIME NULL,
		-- Devengos
		h_extras BIGINT NULL,
		dia BIGINT NULL,
		noche BIGINT NULL,
		dias_festivos BIGINT NULL,
		noches_festivos BIGINT NULL,
		boni BIGINT NULL,
		comi BIGINT NULL,
		created SMALLDATETIME NULL CONSTRAINT [DF_NOMNovedadesD_created] DEFAULT (GETDATE()),
		updated SMALLDATETIME NULL CONSTRAINT [DF_NOMNovedadesD_updated] DEFAULT (GETDATE()),
		id_usercreated BIGINT NOT NULL,
		id_userupdated BIGINT NOT NULL
	)
END

GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Ausencias' AND TABLE_SCHEMA = 'NOM')
BEGIN
	CREATE TABLE [NOM].[Ausencias](
		id BIGINT NOT NULL IDENTITY(1,1) PRIMARY KEY,
		id_per_cont BIGINT NOT NULL,
		-- Ausencias
		fecha_ini SMALLDATETIME NOT NULL,
		fecha_fin SMALLDATETIME NOT NULL, 
		id_diagnostico BIGINT NULL,
		id_tipoausencia BIGINT NULL,
		remunerado BIT NOT NULL DEFAULT 0,
		domingo_suspencion BIT NOT NULL DEFAULT 0,
		created SMALLDATETIME NULL CONSTRAINT [DF_NOMNovedadesA_created] DEFAULT (GETDATE()),
		updated SMALLDATETIME NULL CONSTRAINT [DF_NOMNovedadesA_updated] DEFAULT (GETDATE()),
		id_usercreated BIGINT NOT NULL,
		id_userupdated BIGINT NOT NULL
	)
END

GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Deducciones' AND TABLE_SCHEMA = 'NOM')
BEGIN
	CREATE TABLE [NOM].[Deducciones](
		id BIGINT NOT NULL IDENTITY(1,1) PRIMARY KEY,
		id_per_cont BIGINT NOT NULL,
		-- Deducciones
		prestamos NUMERIC(18,4) NULL,
		libranzas NUMERIC(14,4) NULL,
		id_embargo BIGINT,
		retencion_fuente BIGINT,
		created SMALLDATETIME NULL CONSTRAINT [DF_NOMNovedadesDC_created] DEFAULT (GETDATE()),
		updated SMALLDATETIME NULL CONSTRAINT [DF_NOMNovedadesDC_updated] DEFAULT (GETDATE()),
		id_usercreated BIGINT NOT NULL,
		id_userupdated BIGINT NOT NULL
	)
END

GO


IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Novedades' AND TABLE_SCHEMA = 'NOM')
BEGIN
	CREATE TABLE [NOM].[Novedades] (
		id BIGINT NOT NULL IDENTITY(1,1) PRIMARY KEY,
		id_per_cont BIGINT NOT NULL,
		id_devengo BIGINT NULL,
		id_ausencia BIGINT NULL,
		id_deduccion BIGINT NULL,
		created SMALLDATETIME NULL CONSTRAINT [DF_NOMNovedades_created] DEFAULT (GETDATE()),
		updated SMALLDATETIME NULL CONSTRAINT [DF_NOMNovedades_updated] DEFAULT (GETDATE()),
		id_usercreated BIGINT NOT NULL,
		id_userupdated BIGINT NOT NULL
	)
END

GO


IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Sedes' AND TABLE_SCHEMA = 'NOM')
BEGIN
	CREATE TABLE [NOM].[Sedes] (
		id BIGINT NOT NULL IDENTITY(1,1) PRIMARY KEY,
		nombre VARCHAR(20) NOT NULL,
		id_ciudad BIGINT NOT NULL,
		estado BIT NOT NULL,
		created SMALLDATETIME NULL CONSTRAINT [DF_NOMSedes_created] DEFAULT (GETDATE()),
		updated SMALLDATETIME NULL CONSTRAINT [DF_NOMSedes_updated] DEFAULT (GETDATE()),
		id_usercreated BIGINT NOT NULL,
		id_userupdated BIGINT NOT NULL
	)
END

GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Diagnostico' AND TABLE_SCHEMA = 'NOM')
BEGIN
	CREATE TABLE [NOM].[Diagnostico] (
		id BIGINT NOT NULL IDENTITY(1,1) PRIMARY KEY,
		codigo VARCHAR(20) NOT NULL,
		descripcion VARCHAR(MAX) NOT NULL,
		estado BIT NOT NULL,
		created SMALLDATETIME NULL CONSTRAINT [DF_NOMDescripcion_created] DEFAULT (GETDATE()),
		updated SMALLDATETIME NULL CONSTRAINT [DF_NOMDescripcion_updated] DEFAULT (GETDATE()),
		id_usercreated BIGINT NOT NULL,
		id_userupdated BIGINT NOT NULL
	)
END

GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Juzgados' AND TABLE_SCHEMA = 'NOM')
BEGIN
	CREATE TABLE [NOM].[Juzgados] (
		id BIGINT NOT NULL IDENTITY(1,1) PRIMARY KEY,
		codigo VARCHAR(20) NOT NULL,
		descripcion VARCHAR(MAX) NULL,
		codigo_externo VARCHAR(20) NULL,
		estado BIT NOT NULL,
		created SMALLDATETIME NULL CONSTRAINT [DF_NOMJuzgados_created] DEFAULT (GETDATE()),
		updated SMALLDATETIME NULL CONSTRAINT [DF_NOMJuzgados_updated] DEFAULT (GETDATE()),
		id_usercreated BIGINT NOT NULL,
		id_userupdated BIGINT NOT NULL
	)
END

GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TiposCotizante' AND TABLE_SCHEMA = 'NOM')
BEGIN
	CREATE TABLE [NOM].[TiposCotizante](
		id BIGINT NOT NULL IDENTITY(1,1) PRIMARY KEY,
		codigo VARCHAR(20) NOT NULL,
		descripcion VARCHAR(MAX) NOT NULL,
		detalle BIT NOT NULL DEFAULT(0),
		codigo_externo VARCHAR(20) NOT NULL, 
		estado BIT NOT NULL,
		created SMALLDATETIME NULL CONSTRAINT [DF_NOMTiposCotizante_created] DEFAULT (GETDATE()),
		updated SMALLDATETIME NULL CONSTRAINT [DF_NOMTiposCotizante_updated] DEFAULT (GETDATE()),
		id_usercreated BIGINT NOT NULL,
		id_userupdated BIGINT NOT NULL
	)

END

GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'SubtiposCotizante' AND TABLE_SCHEMA = 'NOM')
BEGIN
	CREATE TABLE [NOM].[SubtiposCotizante](
		id BIGINT NOT NULL IDENTITY(1,1) PRIMARY KEY,
		codigo VARCHAR(20) NOT NULL,
		descripcion VARCHAR(MAX) NOT NULL,
		codigo_externo VARCHAR(20) NOT NULL, 
		estado BIT NOT NULL,
		created SMALLDATETIME NULL CONSTRAINT [DF_NOMSubTiposCotizante_created] DEFAULT (GETDATE()),
		updated SMALLDATETIME NULL CONSTRAINT [DF_NOMSubTiposCotizante_updated] DEFAULT (GETDATE()),
		id_usercreated BIGINT NOT NULL,
		id_userupdated BIGINT NOT NULL
	)

END

GO


IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Tipos_SubtiposCotizantes' AND TABLE_SCHEMA = 'NOM')
BEGIN
	CREATE TABLE [NOM].[Tipos_SubtiposCotizantes](
		id BIGINT NOT NULL IDENTITY(1,1) PRIMARY KEY,
		id_subtipo BIGINT NOT NULL,
		id_tipo BIGINT NOT NULL,
		created SMALLDATETIME NULL CONSTRAINT [DF_NOMTipos_SubtiposCotizante_created] DEFAULT (GETDATE()),
		updated SMALLDATETIME NULL CONSTRAINT [DF_NOMTipos_SubtiposCotizante_updated] DEFAULT (GETDATE()),
		id_usercreated BIGINT NOT NULL,
		id_userupdated BIGINT NOT NULL
	)

END

GO


IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'ParamsAnual_Solid' AND TABLE_SCHEMA = 'NOM')
BEGIN
CREATE TABLE [NOM].[ParamsAnual_Solid](
	id BIGINT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	desde NUMERIC NOT NULL,
	hasta NUMERIC NOT NULL,
	porcentaje NUMERIC(6,2) NOT NULL,
	id_parametros BIGINT NULL,
	created SMALLDATETIME NULL CONSTRAINT [DF_ParamsAnual_Solid_created] DEFAULT (GETDATE()),
	updated SMALLDATETIME NULL CONSTRAINT [DF_ParamsAnual_Solid_updated] DEFAULT (GETDATE()),
	id_usercreated BIGINT NOT NULL,
	id_userupdated BIGINT NOT NULL
)
END

GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'ParamsAnual_Empleado' AND TABLE_SCHEMA = 'NOM')
BEGIN
CREATE TABLE [NOM].[ParamsAnual_Empleado](
	id BIGINT PRIMARY KEY NOT NULL IDENTITY(1,1),
	porcen_salud NUMERIC(6,2) NOT NULL,
	porcen_pension NUMERIC(6,2) NOT NULL,
	num_salariosMinICBF BIGINT NOT NULL,
	num_salariosMinSENA BIGINT NOT NULL,
	num_salariosMinSegSocial BIGINT NOT NULL,
	porcen_icbf NUMERIC(6,2) NOT NULL,
	porcen_sena NUMERIC(6,2) NOT NULL,
	porcen_cajacompensacion NUMERIC(6,2) NOT NULL,
	created SMALLDATETIME NULL CONSTRAINT [DF_ParamsAnual_Empleado_created] DEFAULT (GETDATE()),
	updated SMALLDATETIME NULL CONSTRAINT [DF_ParamsAnual_Empleado_updated] DEFAULT (GETDATE()),
	id_usercreated BIGINT NOT NULL,
	id_userupdated BIGINT NOT NULL
)
END

GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'ParamsAnual_Empleador' AND TABLE_SCHEMA = 'NOM')
BEGIN
CREATE TABLE [NOM].[ParamsAnual_Empleador](
	id BIGINT PRIMARY KEY NOT NULL IDENTITY(1,1),
	porcen_salud NUMERIC(6,2) NOT NULL,
	porcen_pension NUMERIC(6,2) NOT NULL,
	num_salariosMinSalud	NUMERIC(18,2) NOT NULL, -- cuando se cumpla este numero, el empleador paga un porcentaje de la salud
	created SMALLDATETIME NULL CONSTRAINT [DF_ParamsAnual_Empleador_created] DEFAULT (GETDATE()),
	updated SMALLDATETIME NULL CONSTRAINT [DF_ParamsAnual_Empleador_updated] DEFAULT (GETDATE()),
	id_usercreated BIGINT NOT NULL,
	id_userupdated BIGINT NOT NULL
)
END

GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'ParamsAnual_HrsExtras' AND TABLE_SCHEMA = 'NOM')
BEGIN
CREATE TABLE [NOM].[ParamsAnual_HrsExtras](
	id BIGINT PRIMARY KEY NOT NULL IDENTITY(1,1),
	extra_diurna NUMERIC(18,4) NOT NULL,
	extra_nocturna NUMERIC(18,4) NOT NULL,
	extra_fesDiurna NUMERIC(18,4) NOT NULL,
	extra_fesNoct NUMERIC(18,4) NOT NULL,
	recargoNocturno NUMERIC(18,4) NOT NULL,
	HraDomDiurno NUMERIC(18,4) NOT NULL,
	recarg_DomNoct NUMERIC(18,4) NOT NULL,
	created SMALLDATETIME NULL CONSTRAINT [DF_ParamsAnual_HrsExtras_created] DEFAULT (GETDATE()),
	updated SMALLDATETIME NULL CONSTRAINT [DF_ParamsAnual_HrsExtras_updated] DEFAULT (GETDATE()),
	id_usercreated BIGINT NOT NULL,
	id_userupdated BIGINT NOT NULL
)
END

GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'ParamsAnual' AND TABLE_SCHEMA = 'NOM')
BEGIN
CREATE TABLE [NOM].[ParamsAnual] (
	id BIGINT NOT NULL PRIMARY KEY IDENTITY(1,1),
	salario_MinimoLegal NUMERIC(18,4) NOT NULL,
	salario_Integral NUMERIC(18,4) NOT NULL,
	aux_transporte NUMERIC(18,4) NOT NULL,
	id_interesCesantias INT NOT NULL,
	exonerado BIT NOT NULL,
	id_parametrosEmpleado BIGINT NOT NULL,
	id_parametrosEmpleador BIGINT NOT NULL,
	id_horasExt BIGINT NOT NULL,
	porcen_saludTotal NUMERIC(6,2) NOT NULL,
	porcen_pencionTotal NUMERIC(6,2) NOT NULL,
	porcen_cajacompensacion NUMERIC(6,2) NOT NULL,
	uvt NUMERIC(18,4) NOT NULL,
	fecha_vigencia SMALLDATETIME NOT NULL,
	id_cuentacobrar BIGINT NOT NULL,
	id_cuentaarl BIGINT NOT NULL,
	created SMALLDATETIME NULL CONSTRAINT [DF_ParamsAnual_created] DEFAULT (GETDATE()),
	updated SMALLDATETIME NULL CONSTRAINT [DF_ParamsAnual_updated] DEFAULT (GETDATE()),
	id_usercreated BIGINT NOT NULL,
	id_userupdated BIGINT NOT NULL
)
END


GO
-- JPAREDES FIN

If NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[Afiliados]') and OBJECTPROPERTY(id, N'IsTable') = 1)
	CREATE TABLE [NOM].[Afiliados](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_tipoiden] [int] NOT NULL,
	[identificacion] [varchar](20) NOT NULL,
	[primer_nombre] [varchar](30) NOT NULL,
	[segundo_nombre] [varchar](30) NOT NULL,
	[primer_apellido] [varchar](30) NOT NULL,
	[segundo_apellido] [varchar](30) NOT NULL,
	[id_contrato] [bigint] NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_Afiliados_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_Afiliados_updated]  DEFAULT (getdate()),
	[id_usercreated] [int] NOT NULL,
	[id_userupdated] [int] NOT NULL,
 CONSTRAINT [PK_Afiliados] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

If NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[Area]') and OBJECTPROPERTY(id, N'IsTable') = 1)
CREATE TABLE [NOM].[Area](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[id_cuen_Sueldo] [bigint] NOT NULL,
	[id_cuen_Horas_extras] [bigint] NOT NULL,
	[id_cuen_Comisiones] [bigint] NOT NULL,
	[id_cuen_Bonificaciones] [bigint] NOT NULL,
	[id_cuen_Aux_transporte] [bigint] NOT NULL,
	[id_cuen_Cesantias] [bigint] NOT NULL,
	[id_cuen_Int_cesantias] [bigint] NOT NULL,
	[id_cuen_Prima_servicios] [bigint] NOT NULL,
	[id_cuen_Vacaciones] [bigint] NOT NULL,
	[id_cuen_ARL] [bigint] NOT NULL,
	[id_cuen_Aprts_EPS] [bigint] NOT NULL,
	[id_cuen_Aprts_AFP] [bigint] NOT NULL,
	[id_cuen_FonSolPen] [bigint] NOT NULL,
	[id_cuen_Aprts_CCF] [bigint] NOT NULL,
	[id_cuen_ICBF] [bigint] NOT NULL,
	[id_cuen_SENA] [bigint] NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_Area_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_Area_updated]  DEFAULT (getdate()),
	[id_usercreated] [int] NOT NULL,
	[id_userupdated] [int] NOT NULL,
 CONSTRAINT [PK_Area] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


If NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[Cargo]') and OBJECTPROPERTY(id, N'IsTable') = 1)
CREATE TABLE [NOM].[Cargo](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[funciones] [varchar](max) NOT NULL,
	[funciones_esp] [bit] NOT NULL CONSTRAINT [DF_Cargo_funciones_esp]  DEFAULT ((0)),
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_Cargo_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_Cargo_updated]  DEFAULT (getdate()),
	[id_usercreated] [int] NOT NULL,
	[id_userupdated] [int] NOT NULL,
 CONSTRAINT [PK_Cargo] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


If NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[Cesantias]') and OBJECTPROPERTY(id, N'IsTable') = 1)
CREATE TABLE [NOM].[Cesantias](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[codigo] [int] NULL,
	[nombre] [varchar](60) NOT NULL,
	[contrapartida] [bigint] NOT NULL,
	[provision] [numeric](6, 2) NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_Cesantias_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_Cesantias_updated]  DEFAULT (getdate()),
	[id_usercreated] [int] NOT NULL,
	[id_userupdated] [int] NOT NULL,
 CONSTRAINT [PK_Cesantias] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

If NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[Contrato]') and OBJECTPROPERTY(id, N'IsTable') = 1)
CREATE TABLE [NOM].[Contrato](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_periodo] [bigint] NULL,
	[consecutivo] [varchar](10) NOT NULL,
	[id_empleado] [int] NOT NULL,
	[id_contratacion] [int] NOT NULL,
	[id_tipo_contrato] [int] NOT NULL,
	[coti_extranjero] [bit] NOT NULL,
	[id_tipo_cotizante] [int] NOT NULL,
	[tipo_salario] [bigint] NOT NULL,
	[salario] [numeric](18, 2) NOT NULL,
	[tipo_nomina] [int] NOT NULL,
	[diasapagar] [int] NOT NULL,
	[convenio] [bit] NOT NULL,
	[fecha_inicio] [smalldatetime] NOT NULL,
	[fecha_final] [smalldatetime] NULL,
	[area] [bigint] NULL,
	[cargo] [int] NOT NULL,
	[id_horario] [int] NOT NULL,
	[funciones_esp] [varchar](max) NULL,
	[jefe] [bit] NOT NULL,
	[cual_jefe] [int] NULL,
	[id_eps] [int] NOT NULL,
	[id_cesantias] [int] NOT NULL,
	[id_pension] [int] NOT NULL,
	[id_cajacomp] [int] NOT NULL,
	[id_formapago] [int] NOT NULL,
	[ncuenta] [varchar](30) NULL,
	[tipo_cuenta] [int] NULL,
	[banco] [int] NULL,
	[tipo_jornada] [int] NOT NULL,
	[sede_contratacion] [int] NOT NULL,
	[centrocosto] [int] NOT NULL,
	[ley50] [bit] NOT NULL,
	[procedimiento] [int] NOT NULL,
	[estado] [int] NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_Contrato_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_Contrato_updated]  DEFAULT (getdate()),
	[id_usercreated] [int] NOT NULL,
	[id_userupdated] [int] NOT NULL,
 CONSTRAINT [PK_Contrato] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


SET ANSI_PADDING OFF
GO

If NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[Entidades_de_Salud]') and OBJECTPROPERTY(id, N'IsTable') = 1)
CREATE TABLE [NOM].[Entidades_de_Salud](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_tiposeg] [bigint] NOT NULL,
	[codigo] [int] NULL,
	[nombre] [varchar](60) NOT NULL,
	[cod_ext] [varchar](10) NOT NULL,
	[contrapartida] [bigint] NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_Entidades_de_Salud_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_Entidades_de_Salud_updated]  DEFAULT (getdate()),
	[id_usercreated] [int] NOT NULL,
	[id_userupdated] [int] NOT NULL,
 CONSTRAINT [PK_Entidades_de_Salud] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

If NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[FechaFes]') and OBJECTPROPERTY(id, N'IsTable') = 1)
CREATE TABLE [NOM].[FechaFes](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_FechaFes_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_FechaFes_updated]  DEFAULT (getdate()),
	[id_usercreated] [bigint] NOT NULL,
	[id_userupdated] [bigint] NOT NULL,
	[fecha] [smalldatetime] NOT NULL,
	[tipo] [varchar](10) NOT NULL,
 CONSTRAINT [PK_FechaFes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

If NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[fondo_solidario_pensional]') and OBJECTPROPERTY(id, N'IsTable') = 1)
CREATE TABLE [NOM].[fondo_solidario_pensional](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_parametros] [bigint] NOT NULL,
	[sal_min] [int] NOT NULL,
	[sal_max] [int] NULL,
	[porcentaje] [numeric](6, 2) NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_fondo_solidario_pensional_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_fondo_solidario_pensional_updated]  DEFAULT (getdate()),
	[id_usercreated] [int] NOT NULL,
	[id_userupdated] [int] NOT NULL,
 CONSTRAINT [PK_fondo_solidario_pensional] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

If NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[Horario]') and OBJECTPROPERTY(id, N'IsTable') = 1)
CREATE TABLE [NOM].[Horario](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_padre] [bigint] NULL,
	[tipo_horario] [bigint] NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[cantdias] [int] NULL,
	[canttrabdias] [int] NULL,
	[cantdesdias] [int] NULL,
	[Hinicio] [time](5) NOT NULL,
	[Hiniciodesc] [time](5) NULL,
	[Hfindesc] [time](5) NULL,
	[Hfin] [time](5) NOT NULL,
	[HporDia] [numeric](8, 6) NOT NULL,
	[Hnoche] [numeric](8, 6) NULL,
	[sab] [bit] NULL CONSTRAINT [DF_Horario_sab]  DEFAULT ((0)),
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_Horario_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_Horario_updated]  DEFAULT (getdate()),
	[id_usercreated] [int] NOT NULL,
	[id_userupdated] [int] NOT NULL,
 CONSTRAINT [PK_Horario] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

If NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[Int_Cesantias]') and OBJECTPROPERTY(id, N'IsTable') = 1)
CREATE TABLE [NOM].[Int_Cesantias](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](60) NOT NULL,
	[contrapartida] [bigint] NOT NULL,
	[provision] [numeric](6, 2) NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_Int_Cesantias_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_Int_Cesantias_updated]  DEFAULT (getdate()),
	[id_usercreated] [int] NOT NULL,
	[id_userupdated] [int] NOT NULL,
 CONSTRAINT [PK_Int_Cesantias] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


If NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[Pago_por_Contrato]') and OBJECTPROPERTY(id, N'IsTable') = 1)
CREATE TABLE [NOM].[Pago_por_Contrato](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_contrato] [bigint] NOT NULL,
	[id_periodo_contrato] [bigint] NOT NULL,
	[HExtraDia] [numeric](18, 4) NULL,
	[HExtraNoche] [numeric](18, 4) NULL,
	[HExtraDiaDom] [numeric](18, 4) NULL,
	[HExtraNocheDom] [numeric](18, 4) NULL,
	[TotalHExtra] [numeric](18, 4) NULL,
	[Bonificacion] [numeric](18, 4) NULL,
	[Comision] [numeric](18, 4) NULL,
	[DiasAusentes] [int] NOT NULL CONSTRAINT [DF_Pago_por_Contrato_DiasAusentes]  DEFAULT ((0)),
	[Prestamo] [numeric](18, 4) NULL,
	[Libranza] [numeric](18, 4) NULL,
	[id_embargo] [bigint] NULL,
	[Retefuente] [numeric](18, 4) NULL,
	[DiasPeriodo] [int] NOT NULL,
	[AuxTrans] [numeric](18, 4) NOT NULL,
	[SalarioXdia] [numeric](18, 4) NOT NULL,
	[TotalDeven] [numeric](18, 4) NOT NULL,
	[PensionEmpdo] [numeric](18, 4) NOT NULL,
	[PensionEmpdor] [numeric](18, 4) NOT NULL,
	[SaludEmpdo] [numeric](18, 4) NOT NULL,
	[SaludEmpdor] [numeric](18, 4) NOT NULL,
	[ARL] [numeric](18, 0) NULL,
	[Solid_Pensional] [numeric](18, 4) NOT NULL,
	[CajaComp] [numeric](18, 4) NOT NULL,
	[ICBF] [numeric](18, 4) NOT NULL,
	[SENA] [numeric](18, 4) NOT NULL,
	[TotalDeduc] [numeric](18, 4) NOT NULL,
	[TotalPago] [numeric](18, 4) NOT NULL,
	[Cesantias] [numeric](18, 4) NOT NULL,
	[Int_cesan] [numeric](18, 4) NOT NULL,
	[Primas] [numeric](18, 4) NOT NULL,
	[id_cuenta_sueldo] [bigint] NOT NULL,
	[id_cuenta_aux_trans] [bigint] NOT NULL,
	[id_cuenta_horas_extras] [bigint] NOT NULL,
	[id_cuenta_comi] [bigint] NOT NULL,
	[id_cuenta_boni] [bigint] NOT NULL,
	[id_cuenta_cesan] [bigint] NOT NULL,
	[id_cuenta_int_cesan] [bigint] NOT NULL,
	[id_cuenta_primas] [bigint] NOT NULL,
	[id_cuenta_vacas] [bigint] NOT NULL,
	[id_cuenta_arl] [bigint] NOT NULL,
	[id_cuenta_eps] [bigint] NOT NULL,
	[id_cuenta_afp] [bigint] NOT NULL,
	[id_cuenta_solid_pensional] [bigint] NOT NULL,
	[id_cuenta_cajacomp] [bigint] NOT NULL,
	[id_cuenta_ICBF] [bigint] NOT NULL,
	[id_cuenta_SENA] [bigint] NOT NULL,
	[fecha_pago] [smalldatetime] NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_Pago_por_Contrato_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_Pago_por_Contrato_updated]  DEFAULT (getdate()),
	[id_usercreated] [bigint] NOT NULL,
	[id_userupdated] [bigint] NOT NULL,
	[tipo_salario] [int] NOT NULL,
 CONSTRAINT [PK_Pago_por_Contrato] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

If NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[Periodos_Pago]') and OBJECTPROPERTY(id, N'IsTable') = 1)
CREATE TABLE [NOM].[Periodos_Pago](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[diaspago] [varchar](max) NOT NULL,
	[prox_dia_pago] [varchar](10) NOT NULL,
	[cant_dias] [int] NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_Periodos_Pago_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_Periodos_Pago_updated]  DEFAULT (getdate()),
	[id_usercreated] [int] NOT NULL,
	[id_userupdated] [int] NOT NULL,
 CONSTRAINT [PK_Periodos_Pago] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

If NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[Periodos_Por_Contrato]') and OBJECTPROPERTY(id, N'IsTable') = 1)
CREATE TABLE [NOM].[Periodos_Por_Contrato](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_contrato] [bigint] NOT NULL,
	[id_periodo] [bigint] NOT NULL,
	[estado] [bit] NOT NULL CONSTRAINT [DF_Periodos_Por_Contrato_estado]  DEFAULT ((0)),
	[id_novedad] [bigint] NULL,
	[fecha_pago] [smalldatetime] NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_Periodos_Por_Contrato_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_Periodos_Por_Contrato_updated]  DEFAULT (getdate()),
	[id_usercreated] [int] NOT NULL,
	[id_userupdated] [int] NOT NULL,
 CONSTRAINT [PK_Periodos_Por_Contrato] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

If NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[Pila]') and OBJECTPROPERTY(id, N'IsTable') = 1)
CREATE TABLE [NOM].[Pila](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](30) NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_Pila_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_Pila_updated]  DEFAULT (getdate()),
	[id_usercreated] [int] NOT NULL,
	[id_userupdated] [int] NOT NULL,
 CONSTRAINT [PK_Pila] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

If NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[Prestacion_Por_Contrato]') and OBJECTPROPERTY(id, N'IsTable') = 1)
CREATE TABLE [NOM].[Prestacion_Por_Contrato](
	[id] [bigint] NOT NULL,
	[primas_servi] [numeric](18, 4) NOT NULL,
	[aux_cesantias] [numeric](18, 4) NOT NULL,
	[int_cesantias] [numeric](18, 4) NOT NULL,
	[dotacion] [nchar](10) NULL,
	[dias_vacaciones] [numeric](18, 10) NOT NULL,
	[fecha_actualizacion_vacas] [smalldatetime] NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_Prestacion_Por_Contrato_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_Prestacion_Por_Contrato_updated]  DEFAULT (getdate()),
	[id_usercreated] [bigint] NOT NULL,
	[id_userupdated] [bigint] NOT NULL
) ON [PRIMARY]

GO

If NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[Primas]') and OBJECTPROPERTY(id, N'IsTable') = 1)
CREATE TABLE [NOM].[Primas](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](60) NOT NULL,
	[contrapartida] [bigint] NOT NULL,
	[provision] [numeric](6, 2) NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_Primas_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_Primas_updated]  DEFAULT (getdate()),
	[id_usercreated] [int] NOT NULL,
	[id_userupdated] [int] NOT NULL,
 CONSTRAINT [PK_Primas] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

If NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[SubtiposCotizante]') and OBJECTPROPERTY(id, N'IsTable') = 1)
CREATE TABLE [NOM].[SubtiposCotizante](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[codigo] [varchar](20) NOT NULL,
	[descripcion] [varchar](max) NOT NULL,
	[codigo_externo] [varchar](20) NOT NULL,
	[estado] [bit] NOT NULL,
	[created] [smalldatetime] NULL CONSTRAINT [DF_NOMSubTiposCotizante_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NULL CONSTRAINT [DF_NOMSubTiposCotizante_updated]  DEFAULT (getdate()),
	[id_usercreated] [bigint] NOT NULL,
	[id_userupdated] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


If NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[TiposCotizante]') and OBJECTPROPERTY(id, N'IsTable') = 1)
CREATE TABLE [NOM].[TiposCotizante](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[codigo] [varchar](20) NOT NULL,
	[descripcion] [varchar](max) NOT NULL,
	[detalle] [bit] NOT NULL DEFAULT ((0)),
	[codigo_externo] [varchar](20) NOT NULL,
	[estado] [bit] NOT NULL,
	[created] [smalldatetime] NULL CONSTRAINT [DF_NOMTiposCotizante_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NULL CONSTRAINT [DF_NOMTiposCotizante_updated]  DEFAULT (getdate()),
	[id_usercreated] [bigint] NOT NULL,
	[id_userupdated] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

If NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[Vacaciones]') and OBJECTPROPERTY(id, N'IsTable') = 1)
CREATE TABLE [NOM].[Vacaciones](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](60) NOT NULL,
	[contrapartida] [bigint] NOT NULL,
	[provision] [numeric](6, 2) NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_Vacaciones_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_Vacaciones_updated]  DEFAULT (getdate()),
	[id_usercreated] [int] NOT NULL,
	[id_userupdated] [int] NOT NULL,
 CONSTRAINT [PK_Vacaciones] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


SET ANSI_PADDING OFF
GO

If NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[Bancos]') and OBJECTPROPERTY(id, N'IsTable') = 1)
CREATE TABLE [CNT].[Bancos](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[codigo_compensacion] [varchar](4) NOT NULL,
	[estado] [bit] NOT NULL CONSTRAINT [DF_Bancos_estado]  DEFAULT ((0)),
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_Bancos_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_Bancos_updated]  DEFAULT (getdate()),
	[id_usercreated] [int] NOT NULL,
	[id_userupdated] [int] NOT NULL,
 CONSTRAINT [PK_Bancos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

If NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[TercerosHijos]') and OBJECTPROPERTY(id, N'IsTable') = 1)
CREATE TABLE [CNT].[TercerosHijos](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_tercero] [bigint] NOT NULL,
	[identificacion] [varchar](20) NOT NULL,
	[nombres] [varchar](30) NOT NULL,
	[apellidos] [varchar](40) NOT NULL,
	[genero] [int] NOT NULL,
	[profesion] [int] NOT NULL,
	[id_usercreated] [bigint] NOT NULL,
	[id_userupdated] [bigint] NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_TercerosHijos_created]  DEFAULT (getdate()),
 CONSTRAINT [PK_TercerosHijos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_Cesantias_CNTCuentas1')
ALTER TABLE [NOM].[Cesantias]  WITH CHECK ADD  CONSTRAINT [FK_Cesantias_CNTCuentas1] FOREIGN KEY([contrapartida])
REFERENCES [dbo].[CNTCuentas] ([id])
GO
ALTER TABLE [NOM].[Cesantias] CHECK CONSTRAINT [FK_Cesantias_CNTCuentas1]
GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_Entidades_de_Salud_CNTCuentas1')
ALTER TABLE [NOM].[Entidades_de_Salud]  WITH CHECK ADD  CONSTRAINT [FK_Entidades_de_Salud_CNTCuentas1] FOREIGN KEY([contrapartida])
REFERENCES [dbo].[CNTCuentas] ([id])
GO
ALTER TABLE [NOM].[Entidades_de_Salud] CHECK CONSTRAINT [FK_Entidades_de_Salud_CNTCuentas1]
GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_PagoContrato_TipoSalario')
ALTER TABLE [NOM].[Pago_por_Contrato]  WITH CHECK ADD  CONSTRAINT [FK_PagoContrato_TipoSalario] FOREIGN KEY([tipo_salario])
REFERENCES [dbo].[ST_Listados] ([id])
GO
ALTER TABLE [NOM].[Pago_por_Contrato] CHECK CONSTRAINT [FK_PagoContrato_TipoSalario]
GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_Parametros_Cuentas')
ALTER TABLE [NOM].[ParamsAnual]  WITH CHECK ADD  CONSTRAINT [FK_Parametros_Cuentas] FOREIGN KEY([id_cuentacobrar])
REFERENCES [dbo].[CNTCuentas] ([id])
GO
ALTER TABLE [NOM].[ParamsAnual] CHECK CONSTRAINT [FK_Parametros_Cuentas]
GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_Parametros_Cuentas_ARL')
ALTER TABLE [NOM].[ParamsAnual]  WITH CHECK ADD  CONSTRAINT [FK_Parametros_Cuentas_ARL] FOREIGN KEY([id_cuentaarl])
REFERENCES [dbo].[CNTCuentas] ([id])
GO
ALTER TABLE [NOM].[ParamsAnual] CHECK CONSTRAINT [FK_Parametros_Cuentas_ARL]
GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_TercerosHijos_Terceros')
ALTER TABLE [CNT].[TercerosHijos]  WITH CHECK ADD  CONSTRAINT [FK_TercerosHijos_Terceros] FOREIGN KEY([id_tercero])
REFERENCES [CNT].[Terceros] ([id])
GO
ALTER TABLE [CNT].[TercerosHijos] CHECK CONSTRAINT [FK_TercerosHijos_Terceros]
GO




-- JPAREDES INICIO


-- CONSTRAINTS FOREING KEY'S

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_ParamsAnual_Empleado')
	ALTER TABLE [NOM].[ParamsAnual] WITH CHECK ADD CONSTRAINT [FK_ParamsAnual_Empleado] FOREIGN KEY ([id_parametrosEmpleado]) REFERENCES [NOM].[ParamsAnual_Empleado] (id)

GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_ParamsAnual_Empleador')
	ALTER TABLE [NOM].[ParamsAnual] WITH CHECK ADD CONSTRAINT [FK_ParamsAnual_Empleador] FOREIGN KEY ([id_parametrosEmpleador]) REFERENCES [NOM].[ParamsAnual_Empleador] (id)

GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_ParamsAnual_Solid')
	ALTER TABLE [NOM].[ParamsAnual_Solid] WITH CHECK ADD CONSTRAINT [FK_ParamsAnual_Solid] FOREIGN KEY ([id_parametros]) REFERENCES [NOM].[ParamsAnual] (id)

GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_ParamsAnual_Intereses')
	ALTER TABLE [NOM].[ParamsAnual] WITH CHECK ADD CONSTRAINT [FK_ParamsAnual_Intereses] FOREIGN KEY ([id_interesCesantias]) REFERENCES [dbo].[ST_Listados] (id)

GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_ParamsAnual_HrsExtras')
	ALTER TABLE [NOM].[ParamsAnual] WITH CHECK ADD CONSTRAINT [FK_ParamsAnual_HrsExtras] FOREIGN KEY ([id_horasExt]) REFERENCES [NOM].[ParamsAnual_HrsExtras] (id)

GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_Sedes_DivPolitica')
	ALTER TABLE [NOM].[Sedes] WITH CHECK ADD CONSTRAINT [FK_Sedes_DivPolitica] FOREIGN KEY ([id_ciudad]) REFERENCES [dbo].[DivPolitica] (id)

GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_NOMTipoSubCotizante_TiposCotizante')
	ALTER TABLE [NOM].[Tipos_SubtiposCotizantes] WITH CHECK ADD CONSTRAINT [FK_NOMTipoSubCotizante_TiposCotizante] FOREIGN KEY (id_tipo) REFERENCES [NOM].[TiposCotizante] ([id])

GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_NOMTipoSubCotizante_SubtipoCotizante')
	ALTER TABLE [NOM].[Tipos_SubtiposCotizantes] WITH CHECK ADD CONSTRAINT [FK_NOMTipoSubCotizante_SubtipoCotizante] FOREIGN KEY (id_subtipo) REFERENCES [NOM].[SubtiposCotizante] ([id])

GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_Prestaciones_Cuentas')
	ALTER TABLE [NOM].[Prestaciones]  WITH CHECK ADD  CONSTRAINT [FK_Prestaciones_Cuentas] FOREIGN KEY([contrapartida]) REFERENCES [dbo].[CNTCuentas] ([id])

GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_Parametros_Cuentas')
	ALTER TABLE [NOM].[ParamsAnual]  WITH CHECK ADD  CONSTRAINT [FK_Parametros_Cuentas] FOREIGN KEY([id_cuentacobrar]) REFERENCES [dbo].[CNTCuentas] ([id])

GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = 'FK_Parametros_Cuentas_ARL')
	ALTER TABLE [NOM].[ParamsAnual]  WITH CHECK ADD  CONSTRAINT [FK_Parametros_Cuentas_ARL] FOREIGN KEY([id_cuentaarl]) REFERENCES [dbo].[CNTCuentas] ([id])

GO

--JPAREEDS FIN