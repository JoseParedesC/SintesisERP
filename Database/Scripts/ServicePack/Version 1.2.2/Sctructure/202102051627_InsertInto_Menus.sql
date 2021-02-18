--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
SET IDENTITY_INSERT [dbo].[Menus] OFF
GO
SET ANSI_PADDING ON

IF NOT EXISTS (SELECT 1 FROM [dbo].[Menus] WHERE [nombrepagina] = 'Obsequios y Consumos')
BEGIN
INSERT INTO [dbo].[Menus] ([nombrepagina],[estado],[pathpagina],[id_padre],[descripcion],[orden],[padre],[icon],[id_usuario]) 
		VALUES('Obsequios y Consumos',1,'obsequiosProductos.aspx',(SELECT id FROM dbo.Menus WHERE nombrepagina = 'Facturación'),'Facturacion de obsequios y consumos',(SELECT TOP 1 SUM(1) orden FROM dbo.Menus WHERE id_padre = (SELECT id FROM dbo.Menus WHERE nombrepagina = 'Facturación') ORDER BY orden DESC ),0,'fa fa-bank',1)


SET IDENTITY_INSERT [dbo].[MenusPerfiles] OFF


SET ANSI_PADDING ON
INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
		   ,[id_menu]
           ,[id_user])
     VALUES
           (1
		   ,(SELECT id FROM [dbo].[Menus] WHERE nombrepagina = 'Obsequios y Consumos')
           ,1)

INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
		   ,[id_menu]
           ,[id_user])
     VALUES
           (2
		   ,(SELECT id FROM [dbo].[Menus] WHERE nombrepagina = 'Obsequios y Consumos')
           ,1)
END