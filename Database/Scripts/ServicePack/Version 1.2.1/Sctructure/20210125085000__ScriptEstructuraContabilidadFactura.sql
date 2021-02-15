--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[MOVNotasCarteraItems]') and OBJECTPROPERTY(id, N'IsTable') = 1)


CREATE TABLE [CNT].[MOVNotasCarteraItems](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_nota] [bigint] NOT NULL,
	[nrofactura] [varchar](50) NULL,
	[cuota] [bigint] NULL,
	[valorCuota] [numeric](18, 2) NULL,
	[id_cuenta] [BIGINT] NULL,
	[new] BIT NULL,
	[vencimiento] [varchar](10) NULL,
	[created] [smalldatetime] NOT NULL,
	[id_user] [bigint] NOT NULL,
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [CNT].[MOVNotasCarteraItems] ADD  CONSTRAINT [DF_MOVNotasCarteraItems_created]  DEFAULT (getdate()) FOR [created]
GO


ALTER TABLE [CNT].[MOVNotasCarteraItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVNotasCarteraItems_MOVNotasCartera] FOREIGN KEY([id_nota])
REFERENCES [CNT].[MOVNotasCartera] ([id])
GO

ALTER TABLE [CNT].[MOVNotasCarteraItems] CHECK CONSTRAINT [FK_MOVNotasCarteraItems_MOVNotasCartera]
GO

ALTER TABLE [CNT].[MOVNotasCarteraItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVNotasCarteraItems_Usuarios] FOREIGN KEY([id_user])
REFERENCES [dbo].[Usuarios] ([id])
GO

ALTER TABLE [CNT].[MOVNotasCarteraItems] CHECK CONSTRAINT [FK_MOVNotasCarteraItems_Usuarios]
GO

/*ADICION DE CAMPOS*/
IF COL_LENGTH('[dbo].[MOVFacturaItemsTemp]', 'isfinanciero') IS NULL
BEGIN
     Alter Table
         [dbo].[MOVFacturaItemsTemp]
     Add
         [isfinanciero] BIT NOT NULL DEFAULT(0);
END
GO

/*ADICION DE CAMPOS*/
IF COL_LENGTH('[dbo].[MOVFactura]', 'dsctoFinanciero') IS NULL
BEGIN
     Alter Table
         [dbo].[MOVFactura]
     Add
         [dsctoFinanciero] NUMERIC(18,2) NOT NULL DEFAULT(0);
END
GO
IF COL_LENGTH('[dbo].[MOVFactura]', 'ctadescuento') IS NULL
BEGIN
     Alter Table
         [dbo].[MOVFactura]
     Add
         [ctadescuento] BIGINT;
END
GO
/*ADICION DE CAMPOS*/
IF COL_LENGTH('[dbo].[MOVDevFactura]', 'dsctoFinanciero') IS NULL
BEGIN
     Alter Table
         [dbo].[MOVDevFactura]
     Add
         [dsctoFinanciero] NUMERIC(18,2) NOT NULL DEFAULT(0);
END
GO
IF COL_LENGTH('[dbo].[MOVDevFactura]', 'ctadescuento') IS NULL
BEGIN
     Alter Table
         [dbo].[MOVDevFactura]
     Add
         [ctadescuento] BIGINT;
END
GO

If NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[MovDevFacturaCuotas]') and OBJECTPROPERTY(id, N'IsTable') = 1)

CREATE TABLE [dbo].[MovDevFacturaCuotas](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[id_devolucion] [bigint] NOT NULL,
	[cuota] [int] NOT NULL,
	[valorcuotadev] [decimal](18, 4) NOT NULL,
	[vencimiento] [smalldatetime] NOT NULL,
	[id_cuenta] [bigint] NOT NULL,
	[id_user] [bigint] NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_MovDevFacturaCuotas_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_MovDevFacturaCuotas_updated]  DEFAULT (getdate()),
 CONSTRAINT [PK_MovDevFacturaCuotas] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MovDevFacturaCuotas]  WITH CHECK ADD  CONSTRAINT [FK_MovDevFacturaCuotas_MOVDevFactura] FOREIGN KEY([id_devolucion])
REFERENCES [dbo].[MOVDevFactura] ([id])
GO

ALTER TABLE [dbo].[MovDevFacturaCuotas] CHECK CONSTRAINT [FK_MovDevFacturaCuotas_MOVDevFactura]
GO

If NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[MOVCierreContableSaldoCosto]') and OBJECTPROPERTY(id, N'IsTable') = 1)

CREATE TABLE [CNT].[MOVCierreContableSaldoCosto](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[anomes] [varchar](6) NOT NULL,
	[id_cierrecontable] [bigint] NOT NULL,
	[id_centrocosto] [bigint] NOT NULL,
	[id_cuenta] [bigint] NOT NULL,
	[valor] [bigint] NOT NULL,
	[created] [smalldatetime] NOT NULL,
	[updated] [smalldatetime] NOT NULL,
	[user_created] [bigint] NOT NULL,
	[user_updated] [bigint] NOT NULL,
 CONSTRAINT [PK_MOVCierreContableSaldoCosto] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [CNT].[MOVCierreContableSaldoCosto] ADD  CONSTRAINT [DF__MOVCierre__creat__58C70E7C]  DEFAULT (getdate()) FOR [created]
GO

ALTER TABLE [CNT].[MOVCierreContableSaldoCosto] ADD  CONSTRAINT [DF_MOVCierreContableSaldoCosto_updated]  DEFAULT (getdate()) FOR [updated]
GO

ALTER TABLE [CNT].[MOVCierreContableSaldoCosto]  WITH CHECK ADD  CONSTRAINT [FK_CierreContableCentrocosto_id] FOREIGN KEY([id_cierrecontable])
REFERENCES [CNT].[MOVCierreContable] ([id])
GO

ALTER TABLE [CNT].[MOVCierreContableSaldoCosto] CHECK CONSTRAINT [FK_CierreContableCentrocosto_id]
GO

If NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[SaldoCentroCosto]') and OBJECTPROPERTY(id, N'IsTable') = 1)

CREATE TABLE [CNT].[SaldoCentroCosto](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[anomes] [varchar](6) NOT NULL,
	[id_centrocosto] [bigint] NOT NULL,
	[id_cuenta] [bigint] NULL,
	[saldoanterior] [numeric](18, 2) NOT NULL,
	[movDebito] [numeric](18, 2) NOT NULL,
	[movCredito] [numeric](18, 2) NOT NULL,
	[saldoActual] [numeric](18, 2) NOT NULL,
	[changed] [bit] NULL CONSTRAINT [DF_SaldoCentroCosto_changed]  DEFAULT ((0)),
	[before] [bit] NULL CONSTRAINT [DF_SaldoCentroCosto_before]  DEFAULT ((0)),
	[id_user] [bigint] NOT NULL,
	[created] [smalldatetime] NOT NULL CONSTRAINT [DF_SaldoCentroCosto_created]  DEFAULT (getdate()),
	[updated] [smalldatetime] NOT NULL CONSTRAINT [DF_SaldoCentroCosto_updated]  DEFAULT (getdate()),
	[cierre] [bit] NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_SaldoCentroCosto] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [CNT].[SaldoCentroCosto]  WITH CHECK ADD  CONSTRAINT [FK_SaldoCentroCosto_CNTCuentas] FOREIGN KEY([id_cuenta])
REFERENCES [dbo].[CNTCuentas] ([id])
GO

ALTER TABLE [CNT].[SaldoCentroCosto] CHECK CONSTRAINT [FK_SaldoCentroCosto_CNTCuentas]
GO

ALTER TABLE [CNT].[SaldoCentroCosto]  WITH CHECK ADD  CONSTRAINT [FK_SaldoCentroCosto_CentroCosto] FOREIGN KEY([id_centrocosto])
REFERENCES [CNT].[Centrocosto] ([id])
GO

ALTER TABLE [CNT].[SaldoCentroCosto] CHECK CONSTRAINT [FK_SaldoCentroCosto_CentroCosto]
GO

ALTER TABLE [CNT].[SaldoCentroCosto]  WITH CHECK ADD  CONSTRAINT [FK_SaldoCentroCosto_Usuarios] FOREIGN KEY([id_user])
REFERENCES [dbo].[Usuarios] ([id])
GO

ALTER TABLE [CNT].[SaldoCentroCosto] CHECK CONSTRAINT [FK_SaldoCentroCosto_Usuarios]
GO


INSERT INTO cnt.SaldoCentroCosto(anomes,id_centrocosto,id_cuenta,saldoanterior,movDebito,movCredito,saldoActual,id_user)
SELECT ANOMES,  ID_CENTROCOSTO    , id_cuenta      ,0,SUM(IIF(VALOR>0,VALOR,0)) DEBITO      ,SUM(IIF(VALOR<0,VALOR*-1,0)) CREDITO,SUM(IIF(VALOR>0,VALOR,0))-SUM(IIF(VALOR<0,VALOR*-1,0)),1 from CNT.Transacciones AS T INNER JOIN CNTCUENTAS C ON C.id=T.id_cuenta where id_centrocosto!=0  group by id_cuenta,id_centrocosto,anomes order by anomes

EXEC [CNT].[ST_MOVRecalculoSaldo] @SALDO='CENTROCOSTO',@anomes='202012'

/*
Agregar campo de id_centrocosto en comprobantesitemstemp
*/
IF COL_LENGTH('[CNT].[MOVComprobantesItemsTemp]', 'id_centrocosto') IS NULL
BEGIN
     Alter Table
         [CNT].[MOVComprobantesItemsTemp]
     Add
         [id_centrocosto] BIGINT;
END
GO
/*
Agregar campo de id_centrocosto en MOVComprobantesContablesItems
*/
IF COL_LENGTH('[CNT].[MOVComprobantesContablesItems]', 'id_centrocosto') IS NULL
BEGIN
     Alter Table
         [CNT].[MOVComprobantesContablesItems]
     Add
         [id_centrocosto] BIGINT;
END
GO
/*Creacion de relacion de tablas centrocosto con MOVComprobantesContablesItems*/

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS  WHERE CONSTRAINT_NAME = 'FK_MOVComprobantesContablesItems_idcentrocosto'  )
BEGIN
ALTER TABLE [CNT].[MOVComprobantesContablesItems]
DROP CONSTRAINT [FK_MOVComprobantesContablesItems_idcentrocosto];   
END

ALTER TABLE [CNT].[MOVComprobantesContablesItems]  WITH CHECK ADD  CONSTRAINT [FK_MOVComprobantesContablesItems_idcentrocosto] FOREIGN KEY([id_centrocosto])
REFERENCES [CNT].[CentroCosto] ([id])
GO

ALTER TABLE [CNT].[MOVComprobantesContablesItems] CHECK CONSTRAINT [FK_MOVComprobantesContablesItems_idcentrocosto]
GO

/*ACTUALIZO EL CAMPO CENTRO DE COSTO DE COMPROBANTESITEMS CON EL CENTRO DE COSTO QUE TIENE ACTUAL EL ENCABEZADO DE COMPROBANTECONTABLE*/
UPDATE I SET I.ID_CENTROCOSTO= CASE WHEN ISNULL(C.ID_CENTROCOSTO, 0) = 0 THEN NULL ELSE C.ID_CENTROCOSTO END FROM CNT.MOVComprobantesContablesItems I JOIN CNT.MOVComprobantesContables C ON I.id_comprobante=C.id

/*Eliminar Campo id_centrocosto en [CNT].[MOVComprobantesContables]*/
IF COL_LENGTH('[CNT].[MOVComprobantesContables]', 'id_centrocosto') IS NULL
BEGIN
     Alter Table
         [CNT].[MOVComprobantesContablesItems]
     DROP
         [id_centrocosto] ;
END
GO

