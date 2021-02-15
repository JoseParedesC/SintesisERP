--liquibase formatted sql
--changeset jtous:2 dbms:mssql endDelimiter:GO

/*Modificacion del menu lineas de credito*/
UPDATE Menus SET pathpagina = 'lineascreditos.aspx' WHERE nombrepagina = 'Lineas Credito'

--changeset jtehean:1 dbms:mssql endDelimiter:GO
DECLARE @id BIGINT;
IF NOT EXISTS (SELECT 1 FROM DBO.ST_Reportes WHERE codigo='AUXILIARCONTABLE'  )
BEGIN
	INSERT [dbo].[ST_Reportes] ([codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES ( N'AUXILIARCONTABLE', N'Contabilidad - Auxiliar Contable', N'AuxiliaresContable.frx', 1, 1, CAST(N'20201130 09:03:00' AS SmallDateTime), CAST(N'20201130 09:03:00' AS SmallDateTime), 1, NULL, N'')

	SET @id=SCOPE_IDENTITY();

	INSERT [dbo].[aspnet_RolesInReports] ( [id_reporte], [id_perfil], [created], [updated], [id_user]) VALUES ( @id, 1, CAST(N'20201130 09:31:00' AS SmallDateTime), CAST(N'20201130 09:31:00' AS SmallDateTime), 1)
	INSERT [dbo].[aspnet_RolesInReports] ( [id_reporte], [id_perfil], [created], [updated], [id_user]) VALUES ( @id, 2, CAST(N'20201130 09:31:00' AS SmallDateTime), CAST(N'20201130 09:31:00' AS SmallDateTime), 1)
	INSERT [dbo].[aspnet_RolesInReports] ( [id_reporte], [id_perfil], [created], [updated], [id_user]) VALUES ( @id, 3, CAST(N'20201130 09:31:00' AS SmallDateTime), CAST(N'20201130 09:31:00' AS SmallDateTime), 1)
	INSERT [dbo].[ST_CamposReporte] ( [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES ( N'fechaini', N'FECHAINI', N'Fecha Inicio', N'date', N'', 2, 1, N'', N'', N'', @id, 1, 1, CAST(N'20201130 09:10:00' AS SmallDateTime), CAST(N'20201130 09:10:00' AS SmallDateTime), 1, N'')
	INSERT [dbo].[ST_CamposReporte] ( [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES ( N'fechafin', N'FECHAFIN', N'Fecha Final', N'date', N'', 2, 2, N'', N'', N'', @id, 1, 1, CAST(N'20201128 10:09:00' AS SmallDateTime), CAST(N'20201128 10:09:00' AS SmallDateTime), 1, N'')
	INSERT [dbo].[ST_CamposReporte] ( [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES ( N'cuenta', N'CUENTA', N'Cuenta', N'search', N'CNTCuentas', 4, 3, N'CNTCuentasDetalle', N'id,codigo,nombre', N'1,2', @id, 1, 0, CAST(N'20201130 09:17:00' AS SmallDateTime), CAST(N'20201130 09:17:00' AS SmallDateTime), 1, N'')
	INSERT [dbo].[ST_CamposReporte] ( [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES ( N'id_tercero', N'TERCERO', N'Tercero', N'search', N'CNTTerceros', 4, 4, N'CNTTercerosListTipo', N'id,tercompleto', N'1,2', @id, 1, 0, CAST(N'20171125 14:37:00' AS SmallDateTime), CAST(N'20171125 14:37:00' AS SmallDateTime), 1, N'tipoter;TC|')
END

IF NOT EXISTS (SELECT 1 FROM DBO.ST_Reportes WHERE codigo='AUXILIARIMPUESTOS'  )
BEGIN
	INSERT [dbo].[ST_Reportes] ( [codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES ( N'AUXILIARIMPUESTOS', N'Contabilidad - Auxiliar Impuestos', N'AuxiliarImpuestos.frx', 1, 1, CAST(N'20201130 09:05:00' AS SmallDateTime), CAST(N'20201130 09:05:00' AS SmallDateTime), 1, NULL, N'')

	SET @id=SCOPE_IDENTITY();
	INSERT [dbo].[aspnet_RolesInReports] ( [id_reporte], [id_perfil], [created], [updated], [id_user])VALUES ( @id, 1, CAST(N'20201130 10:51:00' AS SmallDateTime), CAST(N'20201130 10:51:00' AS SmallDateTime), 1)
	INSERT [dbo].[aspnet_RolesInReports] ( [id_reporte], [id_perfil], [created], [updated], [id_user]) VALUES ( @id, 2, CAST(N'20201130 10:51:00' AS SmallDateTime), CAST(N'20201130 10:51:00' AS SmallDateTime), 1)
	INSERT [dbo].[aspnet_RolesInReports] ( [id_reporte], [id_perfil], [created], [updated], [id_user]) VALUES ( @id, 3, CAST(N'20201130 10:51:00' AS SmallDateTime), CAST(N'20201130 10:51:00' AS SmallDateTime), 1)

	INSERT [dbo].[ST_CamposReporte] ( [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES ( N'fechaini', N'FECHAINI', N'Fecha Inicio', N'date', N'', 2, 1, N'', N'', N'', @id, 1, 1, CAST(N'20201130 09:10:00' AS SmallDateTime), CAST(N'20201130 09:10:00' AS SmallDateTime), 1, N'')
	INSERT [dbo].[ST_CamposReporte] ( [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES ( N'fechafin', N'FECHAFIN', N'Fecha Final', N'date', N'', 2, 2, N'', N'', N'', @id, 1, 1, CAST(N'20201128 10:09:00' AS SmallDateTime), CAST(N'20201128 10:09:00' AS SmallDateTime), 1, N'')
	INSERT [dbo].[ST_CamposReporte] ( [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES ( N'impuesto', N'IMPUESTO', N'Impuesto', N'search', N'CNTImpuestos', 3, 3, N'CNTImpuestosList', N'id,nombre', N'1,2', @id, 1, 1, CAST(N'20201130 10:25:00' AS SmallDateTime), CAST(N'20201130 10:25:00' AS SmallDateTime), 1, N'')
	INSERT [dbo].[ST_CamposReporte] ( [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES ( N'cuenta', N'CUENTA', N'Cuenta', N'search', N'CNTCuentas', 4, 3, N'CNTCuentasDetalle', N'id,codigo,nombre', N'1,2', @id, 1, 0, CAST(N'20201130 09:17:00' AS SmallDateTime), CAST(N'20201130 09:17:00' AS SmallDateTime), 1, N'impuesto;2|')
END
	
SELECT @id=id from ST_Reportes where codigo='BALANCEGENERAL'
IF not exists(select 1 FROM ST_CamposReporte WHERE id_reporte=@id)
BEGIN
	INSERT [dbo].[ST_CamposReporte] ( [parametro], [codigo], [nombre], [tipo], [fuente], [ancho], [orden], [metadata], [campos], [seleccion], [id_reporte], [estado], [requerido], [created], [updated], [id_user], [params]) VALUES ( N'anomes', N'ANOMES', N'Fecha', N'date', N'', 2, 1, N'', N'', N'', @id, 1, 1, CAST(N'20201001 17:25:00' AS SmallDateTime), CAST(N'20201001 17:25:00' AS SmallDateTime), 1, N'')
END


--changeset czulbaran:1 dbms:mssql endDelimiter:GO
UPDATE [dbo].[Parametros] SET valor = '0', tipo='NUMERO',created=CAST(N'20171125 12:18:00' AS SmallDateTime),updated=CAST(N'20171125 12:18:00' AS SmallDateTime),id_user=1,[default]=0, ancho=3, orden=1 WHERE codigo ='PORCEINTERESMORA';
GO
UPDATE [dbo].[Parametros] SET valor = '', tipo='search', created=CAST(N'20171125 12:18:00' AS SmallDateTime),updated=CAST(N'20171125 12:18:00' AS SmallDateTime),id_user=1,[default]=0, metadata='CNTCuentasDetalle',fuente='CNTCuentas', ancho = 3, orden=2, campos='id,codigo,nombre', seleccion='1,2',params='tipo;TERCE|', extratexto='' WHERE codigo ='CUENTAINTERESMORA';
GO
UPDATE [dbo].[Parametros] SET valor ='N',tipo='checkbox',created=CAST(N'20171125 12:18:00' AS SmallDateTime),updated=CAST(N'20171125 12:18:00' AS SmallDateTime),id_user=1,[default]=0, ancho=3, orden=3 WHERE codigo ='FACTURAELECTRO'
GO
UPDATE [dbo].[Parametros] SET valor='19.00', tipo='NUMERO',created=CAST(N'20171125 12:18:00' AS SmallDateTime),updated=CAST(N'20171125 12:18:00' AS SmallDateTime),id_user=1,[default]=0, ancho=3, orden=4 WHERE codigo ='PORIVAGEN'
GO

SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[aspnet_MailConfig] ON 
GO
INSERT [dbo].[aspnet_MailConfig] ([id], [id_empresa], [servermail], [usermail], [usertitlemail], [passmail], [portmail], [sslmail], [created]) VALUES (1, 1, N'smtp.mailpro.com', N'CO217354@smtp.mailpro.com', N'no-responder@sintesistecnologia.co', N'KpwufZT!b9%1', 587, 0, CAST(N'20190617 23:06:00' AS SmallDateTime))
GO
SET IDENTITY_INSERT [dbo].[aspnet_MailConfig] OFF
GO


IF EXISTS ( SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 WHERE c1.table_schema='dbo' And  c1.table_name = 'FormaPagos' And c1.column_name = 'default')
BEGIN
	DECLARE @idctatfp BIGINT = 0;

	INSERT [dbo].[CNTCuentas] ([subcodigo], [codigo], [nombre], [tipo], [id_padre], [estado], [created], [updated], [id_user], [bloqueada], [indice], [idparent], [id_tipocta], [id_naturaleza], [categoria]) VALUES (N'99', N'53959599', N'Cta Caja Defecto', 1, N'539595', 1, CAST(N'20201204 19:29:00' AS SmallDateTime), CAST(N'20201204 19:29:00' AS SmallDateTime), 1, 1, 5, 492, 78, 39, 91)
	SET @idctatfp = SCOPE_IDENTITY();
	INSERT [dbo].[FormaPagos] ([codigo], [nombre], [id_tipo], [id_typeFE], [categoria], [voucher], [estado], [created], [updated], [id_usercreated], [id_userupdated], [id_cuenta], [default]) VALUES (N'EFE', N'EFECTIVO CAJAS', 23, 60, NULL, 0, 1, CAST(N'20201204 19:43:00' AS SmallDateTime), CAST(N'20201204 19:43:00' AS SmallDateTime), 1, 1, @idctatfp, 1)	
	 
END
GO