--liquibase formatted sql
--changeset ,apuello:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
IF NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[MOVConciliados]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN
	CREATE TABLE [CNT].[MOVConciliados](
		[id] [bigint] IDENTITY(1,1) NOT NULL,
		[estado] [bigint] NOT NULL CONSTRAINT [DF__MOVConcil__conci__2EF0D041]  DEFAULT ((1)),
		[id_revertido] [bigint] NULL,
		[fecha] [smalldatetime] NULL,
		[fecha_revertido] [smalldatetime] NULL,
		[debito_t] [bigint] NULL,
		[credito_t] [bigint] NULL,
		[created] [smalldatetime] NULL CONSTRAINT [DF__MOVConcil__creat__2FE4F47A]  DEFAULT (getdate()),
		[updated] [smalldatetime] NULL CONSTRAINT [DF__MOVConcil__updat__30D918B3]  DEFAULT (getdate()),
		[user_created] [bigint] NULL,
		[user_updated] [bigint] NULL,
	 CONSTRAINT [PK__MOVConci__3213E83F944A1C69] PRIMARY KEY CLUSTERED 
	(
		[id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[MOVConciliadosItems]') and OBJECTPROPERTY(id, N'IsTable') = 1)
BEGIN	
	CREATE TABLE [CNT].[MOVConciliadosItems](
		[id] [bigint] IDENTITY(1,1) NOT NULL,
		[id_conciliado] [bigint] NULL,
		[id_transaccion] [bigint] NULL,
		[centrocosto] [varchar](50) NULL,
		[documento] [varchar](30) NULL,
		[factura] [varchar](50) NULL,
		[descripcion] [varchar](max) NULL,
		[fecha] [varchar](11) NULL,
		[debito] [int] NULL,
		[credito] [int] NULL,
		[voucher] [int] NULL,
		[estado] [varchar](10) NULL CONSTRAINT [DF_MOVConciliadosItems_estado]  DEFAULT ('1'),
		[created] [smalldatetime] NULL CONSTRAINT [DF__MOVConcil__creat__5E9FE363]  DEFAULT (getdate()),
		[updated] [smalldatetime] NULL,
		[user_created] [bigint] NULL,
		[user_updated] [bigint] NULL,
	 CONSTRAINT [PK__MOVConci__3213E83FE96696A5] PRIMARY KEY CLUSTERED 
	(
		[id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO

DECLARE @id BIGINT
IF NOT EXISTS(SELECT 1 FROM [dbo].[Menus] WHERE nombrepagina = 'Conciliacion')
BEGIN
	INSERT [dbo].[Menus] ([nombrepagina], [estado], [pathpagina], [id_padre], [descripcion], [orden], [padre], [icon], [id_usuario], [created]) 
	VALUES (N'Conciliacion', 1, N'consolidacion.aspx', 1, N'Maestros Consolidacion', 10, 0, N'fa-th-large', 1, CAST(N'20201209 09:54:00' AS SmallDateTime))
	
	SET @id = SCOPE_IDENTITY();
	
	IF NOT EXISTS(SELECT 1 FROM [dbo].[MenusPerfiles] WHERE id_menu = @id)
		INSERT [dbo].[MenusPerfiles] ([id_perfil], [id_menu], [created], [updated], [id_user]) 
		VALUES  (1, @id, CAST(N'20201223 10:05:00' AS SmallDateTime), CAST(N'20201223 10:05:00' AS SmallDateTime), 1), 
				(2, @id, CAST(N'20201223 10:05:00' AS SmallDateTime), CAST(N'20201223 10:05:00' AS SmallDateTime), 1)
	
	UPDATE [dbo].[Menus]
	SET
		id_padre = (SELECT id FROM [dbo].[Menus] WHERE nombrepagina = 'Contabilidad')
	WHERE nombrepagina = 'Conciliacion'
END 
GO

--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
/*AGREGANDO CAMPO EN TABLA DE ENTRADAS*/
IF COL_LENGTH('[dbo].[MOVENTRADAS]', 'id_ctaant') IS NULL
BEGIN
     Alter Table
         [dbo].[MOVENTRADAS]
     Add
         [id_ctaant] BIGINT;
END

IF COL_LENGTH('[dbo].[MOVENTRADAS]', 'valoranticipo') IS NULL
BEGIN
     Alter Table
         [dbo].[MOVENTRADAS]
     Add
         [valoranticipo] NUMERIC(18,2);
END


/*AGREGANDO CAMPO EN TABLA DE DEVOLUCION DE ENTRADAS*/

IF COL_LENGTH('[dbo].[MOVDEVENTRADAS]', 'id_ctaant') IS NULL
BEGIN
     Alter Table
         [dbo].[MOVDEVENTRADAS]
     Add
         [id_ctaant] BIGINT;
END

IF COL_LENGTH('[dbo].[MOVDEVENTRADAS]', 'valoranticipo') IS NULL
BEGIN
     Alter Table
         [dbo].[MOVDEVENTRADAS]
     Add
         [valoranticipo] NUMERIC(18,2);
END


/*AGREGANDO CAMPO EN TABLA DE COMPROBANTES DE EGRESOS*/

IF COL_LENGTH('[CNT].[MOVComprobantesEgresos]', 'id_ctaant') IS NULL
BEGIN
     Alter Table
         [CNT].[MOVComprobantesEgresos]
     Add
         [id_ctaant] BIGINT;
END


IF COL_LENGTH('[CNT].[MOVComprobantesEgresos]', 'valoranticipo') IS NULL
BEGIN
     Alter Table
         [CNT].[MOVComprobantesEgresos]
     Add
         [valoranticipo] NUMERIC(18,2);
END
