--liquibase formatted sql
--changeset ,JARCINIEGAS:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
SET IDENTITY_INSERT [dbo].[Menus] OFF

GO

SET ANSI_PADDING ON
IF NOT EXISTS (SELECT 1 FROM [dbo].[Menus] WHERE [nombrepagina] = 'Recursos Humanos')
BEGIN 
INSERT INTO [dbo].[Menus] ([nombrepagina],[estado],[pathpagina],[id_padre],[descripcion],[orden],[padre],[icon],[id_usuario]) VALUES('Recursos Humanos',1,'#',0,'Menu de Recursos Humanos',2,1,'fa-pencil-square-o',1)	
END

IF NOT EXISTS (SELECT 1 FROM [dbo].[Menus] WHERE [nombrepagina] = 'Empleados')
BEGIN 
INSERT INTO [dbo].[Menus] ([nombrepagina],[estado],[pathpagina],[id_padre],[descripcion],[orden],[padre],[icon],[id_usuario]) VALUES('Empleados',1,'Empleados.aspx',(select id from Menus where nombrepagina = 'Recursos Humanos'),'Maestro de Empleados',3,0,'fa-th-large',1)
END 

IF NOT EXISTS (SELECT 1 FROM [dbo].[Menus] WHERE [nombrepagina] = 'Maestros de Nomina')
BEGIN 
INSERT INTO [dbo].[Menus] ([nombrepagina],[estado],[pathpagina],[id_padre],[descripcion],[orden],[padre],[icon],[id_usuario]) VALUES('Maestros de Nomina',1,'#',(select id from Menus where nombrepagina = 'Recursos Humanos'),'Submenu de Maestros',1,0,'fa-th-large',1)
END 

IF NOT EXISTS (SELECT 1 FROM [dbo].[Menus] WHERE [nombrepagina] = 'Cargos')
BEGIN 
INSERT INTO [dbo].[Menus] ([nombrepagina],[estado],[pathpagina],[id_padre],[descripcion],[orden],[padre],[icon],[id_usuario]) VALUES('Cargos',1,'Cargos.aspx',(select id from Menus where nombrepagina = 'Maestros de Nomina'),'Maestro de Cargos',2,0,'fa-th-large',1)
END

IF NOT EXISTS (SELECT 1 FROM [dbo].[Menus] WHERE [nombrepagina] = 'Convenios')
BEGIN 
INSERT INTO [dbo].[Menus] ([nombrepagina],[estado],[pathpagina],[id_padre],[descripcion],[orden],[padre],[icon],[id_usuario]) VALUES('Convenios',1,'Convenio.aspx',(select id from Menus where nombrepagina = 'Maestros de Nomina'),'Maestro de Convenios',2,0,'fa-th-large',1)
END

IF NOT EXISTS (SELECT 1 FROM [dbo].[Menus] WHERE [nombrepagina] = 'Fechas Festivas')
BEGIN 
INSERT INTO [dbo].[Menus] ([nombrepagina],[estado],[pathpagina],[id_padre],[descripcion],[orden],[padre],[icon],[id_usuario]) VALUES('Fechas Festivas',1,'FechaFes.aspx',(select id from Menus where nombrepagina = 'Maestros de Nomina'),'Maestro de Fechas Festivas',2,0,'fa-th-large',1)
END

IF NOT EXISTS (SELECT 1 FROM [dbo].[Menus] WHERE [nombrepagina] = 'Parametros Anuales')
BEGIN 
INSERT INTO [dbo].[Menus] ([nombrepagina],[estado],[pathpagina],[id_padre],[descripcion],[orden],[padre],[icon],[id_usuario]) VALUES('Parametros Anuales',1,'parametrosnom.aspx',(select id from Menus where nombrepagina = 'Maestros de Nomina'),'Maestro de Parametros Anuales',1,0,'fa-th-large',1)
END 

IF NOT EXISTS (SELECT 1 FROM [dbo].[Menus] WHERE [nombrepagina] = 'Liquidacion de Nomina')
BEGIN 
INSERT INTO [dbo].[Menus] ([nombrepagina],[estado],[pathpagina],[id_padre],[descripcion],[orden],[padre],[icon],[id_usuario]) VALUES('Liquidacion de Nomina',1,'liquidacionnom.aspx',(select id from Menus where nombrepagina = 'Maestros de Nomina'),'Maestro de Liquidacion de Nomina',3,0,'fa-th-large',1)
END 

IF NOT EXISTS (SELECT 1 FROM [dbo].[Menus] WHERE [nombrepagina] = 'Area')
BEGIN 
INSERT INTO [dbo].[Menus] ([nombrepagina],[estado],[pathpagina],[id_padre],[descripcion],[orden],[padre],[icon],[id_usuario]) VALUES('Area',1,'area.aspx',(select id from Menus where nombrepagina = 'Maestros de Nomina'),'Maestro de Area',2,0,'fa-th-large',1)
END 

IF NOT EXISTS (SELECT 1 FROM [dbo].[Menus] WHERE [nombrepagina] = 'Horario')
BEGIN 
INSERT INTO [dbo].[Menus] ([nombrepagina],[estado],[pathpagina],[id_padre],[descripcion],[orden],[padre],[icon],[id_usuario]) VALUES('Horario',1,'horario.aspx',(select id from Menus where nombrepagina = 'Maestros de Nomina'),'Maestro de Horario',2,0,'fa-th-large',1)
END 

IF NOT EXISTS (SELECT 1 FROM [dbo].[Menus] WHERE [nombrepagina] = 'Afiliados')
BEGIN 
INSERT INTO [dbo].[Menus] ([nombrepagina],[estado],[pathpagina],[id_padre],[descripcion],[orden],[padre],[icon],[id_usuario]) VALUES('Afiliados',1,'afiliados.aspx',(select id from Menus where nombrepagina = 'Maestros de Nomina'),'Maestro de Afiliados',2,0,'fa-th-large',1)
END

IF NOT EXISTS (SELECT 1 FROM [dbo].[Menus] WHERE [nombrepagina] = 'Seguridad Social')
BEGIN 
INSERT INTO [dbo].[Menus] ([nombrepagina],[estado],[pathpagina],[id_padre],[descripcion],[orden],[padre],[icon],[id_usuario]) VALUES('Seguridad Social',1,'seg_social.aspx',(select id from Menus where nombrepagina = 'Maestros de Nomina'),'Maestro de Seguridad Social',1,0,'fa-th-large',1)
END

IF NOT EXISTS (SELECT 1 FROM [dbo].[Menus] WHERE [nombrepagina] = 'Prestaciones Sociales')
BEGIN 
INSERT INTO [dbo].[Menus] ([nombrepagina],[estado],[pathpagina],[id_padre],[descripcion],[orden],[padre],[icon],[id_usuario]) VALUES('Prestaciones Sociales',1,'pres_social.aspx',(select id from Menus where nombrepagina = 'Maestros de Nomina'),'Maestro de Prestaciones Sociales',1,0,'fa-th-large',1)
END

IF NOT EXISTS (SELECT 1 FROM [dbo].[Menus] WHERE [nombrepagina] = 'Pila')
BEGIN 
INSERT INTO [dbo].[Menus] ([nombrepagina],[estado],[pathpagina],[id_padre],[descripcion],[orden],[padre],[icon],[id_usuario]) VALUES('Pila',1,'pila.aspx',(select id from Menus where nombrepagina = 'Maestros de Nomina'),'Maestro de Pila',2,0,'fa-th-large',1)
END

IF NOT EXISTS (SELECT 1 FROM [dbo].[Menus] WHERE [nombrepagina] = 'Bancos')
BEGIN 
INSERT INTO [dbo].[Menus] ([nombrepagina],[estado],[pathpagina],[id_padre],[descripcion],[orden],[padre],[icon],[id_usuario]) VALUES('Bancos',1,'bancos.aspx',(select id from Menus where nombrepagina = 'Maestros'),'Maestro de Bancos',15,0,'fa-th-large',1)
END

IF NOT EXISTS (SELECT 1 FROM [dbo].[Menus] WHERE [nombrepagina] = 'Embargos')
BEGIN 
INSERT INTO [dbo].[Menus] ([nombrepagina],[estado],[pathpagina],[id_padre],[descripcion],[orden],[padre],[icon],[id_usuario]) VALUES('Embargos',1,'embargos.aspx',(select id from Menus where nombrepagina = 'Maestros de Nomina'),'Maestro de Embargos',2,0,'fa-th-large',1)
END

SET IDENTITY_INSERT [dbo].[MenusPerfiles] OFF

GO

SET ANSI_PADDING ON
IF NOT EXISTS (SELECT 1 FROM [dbo].[MenusPerfiles] WHERE [id_menu] = (select id from [dbo].[Menus] where nombrepagina = 'Empleados' ))
BEGIN
INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
		   ,[id_menu]
           ,[id_user])
     VALUES
           (1,
		   (select id from [dbo].[Menus] where nombrepagina = 'Empleados' )
           ,1)

INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
		   ,[id_menu]
           ,[id_user])
     VALUES
           (2,
		   (select id from Menus where  nombrepagina = 'Empleados')
           ,1)
END


IF NOT EXISTS (SELECT 1 FROM [dbo].[MenusPerfiles] WHERE [id_menu] = (select id from [dbo].[Menus] where nombrepagina = 'Maestros de Nomina' ))
BEGIN
INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
		   ,[id_menu]
           ,[id_user])
     VALUES
           (1,
		   (select id from [dbo].[Menus] where nombrepagina = 'Maestros de Nomina' )
           ,1)

INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
		   ,[id_menu]
           ,[id_user])
     VALUES
           (2,
		   (select id from Menus where  nombrepagina = 'Maestros de Nomina')
           ,1)
END


IF NOT EXISTS (SELECT 1 FROM [dbo].[MenusPerfiles] WHERE [id_menu] = (select id from [dbo].[Menus] where nombrepagina = 'Cargos' ))
BEGIN
INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
		   ,[id_menu]
           ,[id_user])
     VALUES
           (1,
		   (select id from [dbo].[Menus] where nombrepagina = 'Cargos' )
           ,1)

INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
		   ,[id_menu]
           ,[id_user])
     VALUES
           (2,
		   (select id from Menus where  nombrepagina = 'Cargos')
           ,1)
END


IF NOT EXISTS (SELECT 1 FROM [dbo].[MenusPerfiles] WHERE [id_menu] = (select id from [dbo].[Menus] where nombrepagina = 'Convenios' ))
BEGIN
INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
		   ,[id_menu]
           ,[id_user])
     VALUES
           (1,
		   (select id from [dbo].[Menus] where nombrepagina = 'Convenios' )
           ,1)

INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
		   ,[id_menu]
           ,[id_user])
     VALUES
           (2,
		   (select id from Menus where  nombrepagina = 'Convenios')
           ,1)
END


IF NOT EXISTS (SELECT 1 FROM [dbo].[MenusPerfiles] WHERE [id_menu] = (select id from [dbo].[Menus] where nombrepagina = 'Fechas Festivas' ))
BEGIN
INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
		   ,[id_menu]
           ,[id_user])
     VALUES
           (1,
		   (select id from [dbo].[Menus] where nombrepagina = 'Fechas Festivas' )
           ,1)

INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
		   ,[id_menu]
           ,[id_user])
     VALUES
           (2,
		   (select id from Menus where  nombrepagina = 'Fechas Festivas')
           ,1)
END


IF NOT EXISTS (SELECT 1 FROM [dbo].[MenusPerfiles] WHERE [id_menu] = (select id from [dbo].[Menus] where nombrepagina = 'Parametros Anuales' ))
BEGIN
INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
		   ,[id_menu]
           ,[id_user])
     VALUES
           (1,
		   (select id from [dbo].[Menus] where nombrepagina = 'Parametros Anuales' )
           ,1)

INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
		   ,[id_menu]
           ,[id_user])
     VALUES
           (2,
		   (select id from Menus where  nombrepagina = 'Parametros Anuales')
           ,1)
END


IF NOT EXISTS (SELECT 1 FROM [dbo].[MenusPerfiles] WHERE [id_menu] = (select id from [dbo].[Menus] where nombrepagina = 'Liquidacion de Nomina' ))
BEGIN
INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
		   ,[id_menu]
           ,[id_user])
     VALUES
           (1,
		   (select id from [dbo].[Menus] where nombrepagina = 'Liquidacion de Nomina' )
           ,1)

INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
		   ,[id_menu]
           ,[id_user])
     VALUES
           (2,
		   (select id from Menus where  nombrepagina = 'Liquidacion de Nomina')
           ,1)
END


IF NOT EXISTS (SELECT 1 FROM [dbo].[MenusPerfiles] WHERE [id_menu] = (select id from [dbo].[Menus] where nombrepagina = 'Area' ))
BEGIN
INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
		   ,[id_menu]
           ,[id_user])
     VALUES
           (1,
		   (select id from [dbo].[Menus] where nombrepagina = 'Area' )
           ,1)

INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
		   ,[id_menu]
           ,[id_user])
     VALUES
           (2,
		   (select id from Menus where  nombrepagina = 'Area')
           ,1)
END


IF NOT EXISTS (SELECT 1 FROM [dbo].[MenusPerfiles] WHERE [id_menu] = (select id from [dbo].[Menus] where nombrepagina = 'Horario' ))
BEGIN
INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
		   ,[id_menu]
           ,[id_user])
     VALUES
           (1,
		   (select id from [dbo].[Menus] where nombrepagina = 'Horario' )
           ,1)

INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
		   ,[id_menu]
           ,[id_user])
     VALUES
           (2,
		   (select id from Menus where  nombrepagina = 'Horario')
           ,1)
END


IF NOT EXISTS (SELECT 1 FROM [dbo].[MenusPerfiles] WHERE [id_menu] = (select id from [dbo].[Menus] where nombrepagina = 'Afiliados' ))
BEGIN
INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
		   ,[id_menu]
           ,[id_user])
     VALUES
           (1,
		   (select id from [dbo].[Menus] where nombrepagina = 'Afiliados' )
           ,1)

INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
		   ,[id_menu]
           ,[id_user])
     VALUES
           (2,
		   (select id from Menus where  nombrepagina = 'Afiliados')
           ,1)
END


IF NOT EXISTS (SELECT 1 FROM [dbo].[MenusPerfiles] WHERE [id_menu] = (select id from [dbo].[Menus] where nombrepagina = 'Seguridad Social' ))
BEGIN
INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
		   ,[id_menu]
           ,[id_user])
     VALUES
           (1,
		   (select id from [dbo].[Menus] where nombrepagina = 'Seguridad Social' )
           ,1)

INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
		   ,[id_menu]
           ,[id_user])
     VALUES
           (2,
		   (select id from Menus where  nombrepagina = 'Seguridad Social')
           ,1)
END


IF NOT EXISTS (SELECT 1 FROM [dbo].[MenusPerfiles] WHERE [id_menu] = (select id from [dbo].[Menus] where nombrepagina = 'Prestaciones Sociales' ))
BEGIN
INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
		   ,[id_menu]
           ,[id_user])
     VALUES
           (1,
		   (select id from [dbo].[Menus] where nombrepagina = 'Prestaciones Sociales' )
           ,1)

INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
		   ,[id_menu]
           ,[id_user])
     VALUES
           (2,
		   (select id from Menus where  nombrepagina = 'Prestaciones Sociales')
           ,1)
END


IF NOT EXISTS (SELECT 1 FROM [dbo].[MenusPerfiles] WHERE [id_menu] = (select id from [dbo].[Menus] where nombrepagina = 'Pila' ))
BEGIN
INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
		   ,[id_menu]
           ,[id_user])
     VALUES
           (1,
		   (select id from [dbo].[Menus] where nombrepagina = 'Pila' )
           ,1)

INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
		   ,[id_menu]
           ,[id_user])
     VALUES
           (2,
		   (select id from Menus where  nombrepagina = 'Pila')
           ,1)
END


IF NOT EXISTS (SELECT 1 FROM [dbo].[MenusPerfiles] WHERE [id_menu] = (select id from [dbo].[Menus] where nombrepagina = 'Bancos' ))
BEGIN
INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
		   ,[id_menu]
           ,[id_user])
     VALUES
           (1,
		   (select id from [dbo].[Menus] where nombrepagina = 'Bancos' )
           ,1)

INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
		   ,[id_menu]
           ,[id_user])
     VALUES
           (2,
		   (select id from Menus where  nombrepagina = 'Bancos')
           ,1)
END


IF NOT EXISTS (SELECT 1 FROM [dbo].[MenusPerfiles] WHERE [id_menu] = (select id from [dbo].[Menus] where nombrepagina = 'Embargos' ))
BEGIN
INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
		   ,[id_menu]
           ,[id_user])
     VALUES
           (1,
		   (select id from [dbo].[Menus] where nombrepagina = 'Embargos' )
           ,1)

INSERT INTO [dbo].[MenusPerfiles]
           ([id_perfil]
		   ,[id_menu]
           ,[id_user])
     VALUES
           (2,
		   (select id from Menus where  nombrepagina = 'Embargos')
           ,1)
END

GO
