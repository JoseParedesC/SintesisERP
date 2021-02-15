--liquibase formatted sql
--changeset ,JTOUS:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
IF COL_LENGTH('[FIN].[RecaudocarteraItems]', 'cuotaVencimiento') IS NULL
BEGIN
   ALTER TABLE 
		[FIN].[RecaudocarteraItems]
   ADD 
	[cuotaVencimiento] smalldatetime NULL
END
GO


IF COL_LENGTH('[FIN].[SaldoCliente_Cuotas]', 'abonoIntMora') IS NULL
BEGIN
   ALTER TABLE 
   	[FIN].[SaldoCliente_Cuotas]
   ADD 
	[AbonoIntMora] [NUMERIC](18, 2) NOT NULL DEFAULT(0)
END
GO
IF COL_LENGTH('[dbo].[MOVDevFactura]', 'keyid') IS NULL
BEGIN
   ALTER TABLE 
   	[dbo].[MOVDevFactura] 
   ADD 
	[keyid] [varchar](255) NOT NULL DEFAULT(NEWID())
END
GO

IF COL_LENGTH('[dbo].[MOVDevFactura]', 'cufe') IS NULL
BEGIN
	ALTER TABLE 
		[dbo].[MOVDevFactura] 
	ADD 
		[cufe] [varchar](255)
END
GO

IF COL_LENGTH('[dbo].[MOVDevFactura]', 'isFe') IS NULL
BEGIN
	ALTER TABLE 
		[dbo].[MOVDevFactura] 
	ADD 
		[isFe] [bit] NOT NULL DEFAULT(0)
END
GO

IF COL_LENGTH('[dbo].[MOVDevFactura]', 'iscausacion') IS NULL
BEGIN
	ALTER TABLE 
		[dbo].[iscausacion] 
	ADD 
		[iscausacion] [bit] NOT NULL DEFAULT(0)
END
GO

IF COL_LENGTH('[dbo].[MOVDevFactura]', 'estadoFE') IS NULL
BEGIN
	ALTER TABLE 
		[dbo].[MOVDevFactura] 
	ADD 
		[estadoFE] [INT] NOT NULL DEFAULT([dbo].[ST_FnGetIdList]('PREVIA'))
END
GO
 
IF NOT EXISTS (SELECT 1 FROM [dbo].[Menus] WHERE [nombrepagina] = 'Facturacion Electronica')
BEGIN 
	INSERT INTO [dbo].[Menus] ([nombrepagina],[estado],[pathpagina],[id_padre],[descripcion],[orden],[padre],[icon],[id_usuario]) VALUES('Facturacion Electronica',1,'facturacionelectronica.aspx',(select id from Menus where CAST(descripcion AS VARCHAR) = 'Menu  de Funcionalidad' AND nombrepagina like 'facturaci%'), 'Facturacion Electronica',5,0,'fa-th-large',1)

	INSERT INTO [dbo].[MenusPerfiles] ([id_perfil] ,[id_menu] ,[id_user])
    VALUES  (1,(select id from [dbo].[Menus] where nombrepagina = 'Facturacion Electronica' ), 1), 
			(2,(select id from [dbo].[Menus] where nombrepagina = 'Facturacion Electronica' ), 1)
END 
GO

IF COL_LENGTH('[dbo].[ST_Reportes]', 'tipo') IS NULL
BEGIN
	ALTER TABLE 
		[dbo].[ST_Reportes] 
	ADD 
		[tipo] [VARCHAR](20) NOT NULL DEFAULT('')
END
GO

IF NOT EXISTS(SELECT 1 FROM [dbo].[ST_Reportes] WHERE codigo = 'MOVFACTURAE')
BEGIN 
	INSERT INTO [dbo].[ST_Reportes] ([codigo],[nombre],[frx],[listado],[estado],[created],[updated],[id_user],[nombreproce],[paramadicionales], tipo) 
	VALUES ('MOVFACTURAE', 'Factura Electronica','FacturaElectronicaInt.frx',1,1,GETDATE(),GETDATE(),1,NULL,'', 'XML')
END
GO

IF NOT EXISTS(SELECT 1 FROM [dbo].[ST_Reportes] WHERE codigo = 'MOVDEVFACTURAE')
BEGIN 
	INSERT INTO [dbo].[ST_Reportes] ([codigo],[nombre],[frx],[listado],[estado],[created],[updated],[id_user],[nombreproce],[paramadicionales], tipo) 
	VALUES ('MOVDEVFACTURAE', 'Nota Credito Electronica','CreditoElectronicaInt.frx',1,1,GETDATE(),GETDATE(),1,NULL,'', 'XML')
END
GO

IF COL_LENGTH('[dbo].[MOVDevFactura]', 'fechaautorizacion') IS NULL
BEGIN
	ALTER TABLE 
		[dbo].[MOVDevFactura] 
	ADD 
		[fechaautorizacion] [SMALLDATETIME]
END
GO

IF COL_LENGTH('[dbo].[MOVFactura]', 'nrofactura') IS NULL
BEGIN
	ALTER TABLE 
		[dbo].[MOVFactura] 
	ADD 
		[nrofactura] [VARCHAR] (30)
END
GO

UPDATE ST_Reportes set listado = 0 where codigo IN ('MOVAJUSTE', 'SOLICITCREDITO', 'MOVFACTURAE', 'MOVDEVFACTURAE')
GO
