--liquibase formatted sql
--changeset ,jarciniegas:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
IF COL_LENGTH('[CNT].[TerceroAdicionales]', 'universidad') IS NULL
BEGIN
    Alter Table
        [CNT].[TerceroAdicionales]
    Add
        [universidad] [varchar](50) NULL;
END
GO

IF COL_LENGTH('[CNT].[TerceroAdicionales]', 'id_escolaridad') IS NULL
BEGIN
    Alter Table
        [CNT].[TerceroAdicionales]
    Add
        [id_escolaridad] [int]  NULL;

	Alter Table 
		[CNT].[TerceroAdicionales]
	alter column
		[id_escolaridad] [int]  NOT NULL

END
GO

IF COL_LENGTH('[CNT].[TerceroAdicionales]', 'nacionalidad') IS NULL
BEGIN
    Alter Table
        [CNT].[TerceroAdicionales]
    Add
        [nacionalidad] [varchar](50) NULL;
END
GO

IF COL_LENGTH('[CNT].[TerceroAdicionales]', 'cant_hijos') IS NULL
BEGIN
    Alter Table
        [CNT].[TerceroAdicionales]
    Add
        [cant_hijos] [int]  NULL;

	Alter Table
        [CNT].[TerceroAdicionales]
    ALTER COLUMN
		[cant_hijos] [int] NOT NULL
END
GO

IF COL_LENGTH('[CNT].[TerceroAdicionales]', 'id_tiposangre') IS NULL
BEGIN
    Alter Table
        [CNT].[TerceroAdicionales]
    Add
        [id_tiposangre] [int]  NULL;

	Alter Table
        [CNT].[TerceroAdicionales]
    ALTER COLUMN
		[id_tiposangre] [int] NOT NULL

END
GO

IF COL_LENGTH('[CNT].[TerceroAdicionales]', 'discapasidad') IS NULL
BEGIN
    Alter Table
        [CNT].[TerceroAdicionales]
    Add
        [discapasidad] [bit]  NULL;

	Alter Table
        [CNT].[TerceroAdicionales]
    ALTER COLUMN
		[discapasidad] [bit] NOT NULL

END
GO

IF COL_LENGTH('[CNT].[TerceroAdicionales]', 'fechavenci_extran') IS NULL
BEGIN
    Alter Table
        [CNT].[TerceroAdicionales]
    Add
        [fechavenci_extran] [smalldatetime] NULL;
END
GO

IF COL_LENGTH('[CNT].[TerceroAdicionales]', 'congenero') IS NULL
BEGIN
    Alter Table
        [CNT].[TerceroAdicionales]
    Add
        [congenero] [int] NULL;
END
GO

IF COL_LENGTH('[CNT].[TerceroAdicionales]', 'confecha_naci') IS NULL
BEGIN
    Alter Table
        [CNT].[TerceroAdicionales]
    Add
        [confecha_naci] [smalldatetime] NULL;
END
GO

IF COL_LENGTH('[CNT].[TerceroAdicionales]', 'conprofesion') IS NULL
BEGIN
    Alter Table
        [CNT].[TerceroAdicionales]
    Add
        [conprofesion] [varchar](50) NULL;
END
GO

IF COL_LENGTH('[CNT].[TerceroAdicionales]', 'connombres') IS NULL
BEGIN
    Alter Table
        [CNT].[TerceroAdicionales]
    Add
        [connombres] [varchar](100) NULL;
END
GO

IF COL_LENGTH('[CNT].[TerceroAdicionales]', 'conapellidos') IS NULL
BEGIN
    Alter Table
        [CNT].[TerceroAdicionales]
    Add
        [conapellidos] [varchar](100) NULL;
END
GO

IF COL_LENGTH('[CNT].[TerceroAdicionales]', 'coniden') IS NULL
BEGIN
    Alter Table
        [CNT].[TerceroAdicionales]
    Add
        [coniden] [varchar](20) NULL;
END
GO

IF COL_LENGTH('[CNT].[TerceroAdicionales]', 'tipodiscapasidad') IS NULL
BEGIN
    Alter Table
        [CNT].[TerceroAdicionales]
    Add
        [tipodiscapasidad] [int] NULL;
END
GO

IF COL_LENGTH('[CNT].[TerceroAdicionales]', 'porcentajedis') IS NULL
BEGIN
    Alter Table
        [CNT].[TerceroAdicionales]
    Add
        [porcentajedis] [int] NULL;
END
GO

IF COL_LENGTH('[CNT].[TerceroAdicionales]', 'gradodis') IS NULL
BEGIN
    Alter Table
        [CNT].[TerceroAdicionales]
    Add
        [gradodis] [int] NULL;
END
GO

IF COL_LENGTH('[CNT].[TerceroAdicionales]', 'carnetdis') IS NULL
BEGIN
    Alter Table
        [CNT].[TerceroAdicionales]
    Add
        [carnetdis] [varchar](50) NULL;
END
GO

IF COL_LENGTH('[CNT].[TerceroAdicionales]', 'fechaexpdis') IS NULL
BEGIN
    Alter Table
        [CNT].[TerceroAdicionales]
    Add
        [fechaexpdis] [smalldatetime] NULL;
END
GO

IF COL_LENGTH('[CNT].[TerceroAdicionales]', 'vencimientodis') IS NULL
BEGIN
    Alter Table
        [CNT].[TerceroAdicionales]
    Add
        [vencimientodis] [smalldatetime] NULL;
END
GO

IF COL_LENGTH('[CNT].[TerceroAdicionales]', 'created') IS NULL
BEGIN
    Alter Table
        [CNT].[TerceroAdicionales]
    Add
        [created] [smalldatetime]  NULL CONSTRAINT [DF_TerceroAdicionales_created_1]  DEFAULT (getdate());


	Alter Table
        [CNT].[TerceroAdicionales]
    ALTER COLUMN
		[created] [smalldatetime] NOT NULL

END
GO

IF COL_LENGTH('[CNT].[TerceroAdicionales]', 'updated') IS NULL
BEGIN
    Alter Table
        [CNT].[TerceroAdicionales]
    Add
        [updated] [smalldatetime]  NULL CONSTRAINT [DF_TerceroAdicionales_updated_1]  DEFAULT (getdate());

	Alter Table
        [CNT].[TerceroAdicionales]
    ALTER COLUMN
		[updated] [smalldatetime] NOT NULL
END
GO

IF COL_LENGTH('[CNT].[TerceroAdicionales]', 'id_usercreated') IS NULL
BEGIN
    Alter Table
        [CNT].[TerceroAdicionales]
    Add
        [id_usercreated] [bigint]  NULL;

	Alter Table
        [CNT].[TerceroAdicionales]
    ALTER COLUMN
		[id_usercreated] [bigint] NOT NULL

END
GO

IF COL_LENGTH('[CNT].[TerceroAdicionales]', 'id_userupdated') IS NULL
BEGIN
    Alter Table
        [CNT].[TerceroAdicionales]
    Add
        [id_userupdated] [bigint]  NULL;

	Alter Table
        [CNT].[TerceroAdicionales]
    ALTER COLUMN
		[id_userupdated] [bigint] NOT NULL
END
GO


IF COL_LENGTH('[CRE].[Consecutivo]', 'tipo') IS NULL
BEGIN
    Alter Table
        [CRE].[Consecutivo]
    Add
        [tipo] [varchar](20)  NULL;
	
END
GO

IF EXISTS (SELECT 1 FROM [CRE].[Consecutivo] WHERE ISNULL(tipo, '') = '' )
	BEGIN
	UPDATE [CRE].[Consecutivo]
		SET tipo = 'credito'
		WHERE ISNULL(tipo, '') = '' ;;

		Alter Table
        [CRE].[Consecutivo]
    ALTER COLUMN
		[tipo] [varchar](20) NOT NULL
	END
GO


IF NOT EXISTS(SELECT 1 FROM dbo.SYSOBJECTS WHERE id =
OBJECT_ID(N'[dbo].[aspnet_MailConfig]') and OBJECTPROPERTY(id, N'IsTable') = 1)
CREATE TABLE aspnet_MailConfig (
	id BIGINT PRIMARY KEY IDENTITY (1, 1),
	id_empresa BIGINT,
	servermail VARCHAR(100),
	usermail VARCHAR(150),
	usertitlemail VARCHAR(150),
	passmail VARCHAR(100),
	portmail INT,
	sslmail BIT,
	created SMALLDATETIME DEFAULT GETDATE(),
	updated SMALLDATETIME
)
GO
	
