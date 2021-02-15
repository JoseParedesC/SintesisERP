--liquibase formatted sql
--changeset ,JTOUS:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_CargarListado]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_CargarListado]
GO

CREATE PROCEDURE [dbo].[ST_CargarListado]
@c_op		VARCHAR(20),
@v_param	VARCHAR(50) = null,
@id_user	INT,
@id_otro 	BIGINT = 0

--WITH ENCRYPTION
AS

/***************************************
*Nombre:		[Dbo].[ST_CargarListado]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		25/03/17
*Desarrollador: (JTOUS)
***************************************/

BEGIN TRY
	DECLARE @error VARCHAR(MAX), @otroparams VARCHAR(200) = '';
	
	/*Lista las Categorias de Productos activas*/
	IF(@c_op = 'CATPRO')
	BEGIN		
		SELECT id, nombre [name] 
		FROM Dbo.CategoriasProductos
		WHERE estado = 1;
	END		
	ELSE IF(@c_op = 'AMBIENTE')
	BEGIN		
		SELECT '1' id, 'PRODUCCIÓN'  [name] 
		UNION
		SELECT '2' id, 'PRUEBA' [name]
	END	
	/*Lista las Categorias de Bodegas activas*/
	ELSE IF(@c_op = 'BODEGAS')
	BEGIN		
		SELECT Id, Nombre [name] 
		FROM Dbo.Bodegas
		WHERE estado = 1;
	END

	ELSE IF(@c_op = 'CITY')
	BEGIN		
		SELECT D.id, nombre + ' - ' +nombredep [name]
		FROM Dbo.DivPolitica D 	
		ORDER BY nombre	
	END

	ELSE IF(@c_op = 'TYPEID')
	BEGIN		
		SELECT id, nombre [name]
		FROM ST_Listados
		WHERE codigo = 'TIPOSID' ORDER BY nombre;
	END
	
	ELSE IF(@c_op = 'TYPEACCOUNT')
	BEGIN		
		SELECT 'G' id, 'General' [name] 
		UNION
		SELECT 'D' id, 'Detalle' [name] 
	END
	
	ELSE IF(@c_op = 'BOXES')
	BEGIN		
		SELECT id, nombre [name] 
		FROM Dbo.Cajas 
		WHERE estado = 1;
	END

	ELSE IF(@c_op = 'PROFILES')
	BEGIN		
		SELECT id, RoleName [name]
		FROM Dbo.aspnet_Roles
		WHERE UPPER(RoleName) != 'SUPER ADMINISTRADOR';
	END

	ELSE IF(@c_op = 'SHIFTS')
	BEGIN		
		SELECT id, horainicio + ' - ' + horafin [name]
		FROM Dbo.Turnos 
		WHERE estado = 1;
	END

	ELSE IF(@c_op = 'TYPEIN')
	BEGIN		
		SELECT 1 ID, 'Factura' [name];
	END

	ELSE IF(@c_op = 'CATFISCAL')
	BEGIN		
		SELECT  id, descripcion [name]
		From CNTCategoriaFiscal 
		WHERE estado = 1;
	END

	ELSE IF(@c_op = 'TIPOFAC')
	BEGIN		
		SELECT  id, nombre [name]
		From ST_Listados 
		WHERE codigo = 'FORMAPAGO';
	END
	
	ELSE IF(@c_op = 'TIPOMOVIMIENTO')
	BEGIN		
		SELECT  id, nombre [name]
		From ST_Listados 
		WHERE codigo = 'TIPOMOVIMIENTO';
	END

	ELSE IF(@c_op = 'USERCAJA')
	BEGIN	
		SELECT C.id, nombre [name] 
		FROM Dbo.Cajas C
		Inner JOIN [dbo].[aspnet_UsersInCajas] UC ON UC.id_caja = C.id
		WHERE estado = 1 AND UC.[user_id] = @id_user;
	END
	
	ELSE IF(@c_op = 'REPORTES')
	BEGIN	
		SELECT R.id, R.nombre [name] 
		FROM Dbo.ST_Reportes R
		INNER JOIN Dbo.aspnet_RolesInReports RR ON R.id = RR.id_reporte
		INNER JOIN Dbo.Usuarios U ON U.id_perfil = RR.id_perfil
		WHERE R.estado = 1 AND U.id = @id_user AND R.listado = 1;
	END
	ELSE IF(@c_op = 'FORMAPAGOS')
	BEGIN	
		SELECT F.id, F.nombre name, voucher [data-voucher], iden
		FROM [dbo].[FormaPagos] F inner join dbo.ST_Listados L on F.id_tipo=L.id
		WHERE F.estado = 1 and L.codigo = 'FORMAPAGOCONT' AND iden = @v_param AND F.[default] = 0
	END 
	ELSE IF(@c_op = 'FORMAPAGOSPOS')
	BEGIN	
		SELECT F.id, F.nombre name, voucher [data-voucher], iden
		FROM [dbo].[FormaPagos] F inner join dbo.ST_Listados L on F.id_tipo=L.id
		WHERE F.estado = 1 and L.codigo = 'FORMAPAGOCONT' AND iden = 'CONVENCIO'
		ORDER BY F.[default] DESC, F.nombre ASC
	END 
	ELSE IF(@c_op = 'VENCREDITO')
	BEGIN	
		SELECT id, nombre [name]
		FROM ST_Listados
		WHERE codigo = 'VENCREDITO' AND estado = 1;
	END
	ELSE IF(@c_op = 'VENCREDITONOTAS')
	BEGIN        
		SELECT id, nombre [name]
		FROM ST_Listados
		WHERE codigo = 'VENCREDITO' AND estado = 1 AND id=dbo.ST_FnGetIdList('XDV');
	END
	ELSE IF(@c_op = 'FORMAPAGOCONT')
	BEGIN
		SELECT id, nombre [name], iden [data-tipo]
		FROM ST_Listados
		WHERE codigo='FORMAPAGOCONT' AND estado = 1;
	END
	ELSE IF(@c_op = 'TIPOREGIMEN')
	BEGIN
		SELECT id,nombre [name]
		FROM ST_Listados
		WHERE codigo='TIPOREGIMEN' and estado=1
	END
	ELSE IF(@c_op ='TIPOPRODUCTO')
		BEGIN
		SELECT id, nombre[name], iden [data-tipo]
		FROM ST_Listados 
		WHERE codigo='TIPOPRODUCTO' AND estado = 1
	END
	ELSE IF(@c_op ='PERSONERIA')
	BEGIN
		SELECT id, nombre [name], iden [data-option]
		FROM ST_Listados 
		WHERE codigo = 'PERSONERIA' AND estado = 1
	END
	ELSE IF(@c_op='TIPODOCUMENTOS')
	BEGIN
		SELECT T.id, T.nombre [name], CAST(T.isccosto AS VARCHAR) +'|~|'+CAST(ISNULL(id_centrocosto, 0) AS VARCHAR) + '|~|' + ISNULL(T.centrocosto,'') [data-centro]
		FROM [CNT].[VW_TipoDocumentos] T
		INNER JOIN ST_Listados L ON T.id_tipo = L.id
		WHERE L.iden = @v_param
		ORDER BY T.id ASC
	END 

	ELSE IF(@c_op='TIPODOCU')
	BEGIN
		SELECT  id,nombre [name]
		FROM CNT.TipoDocumentos 
	END 

	ELSE IF(@c_op='NATUCONCEPTO')
	BEGIN
		SELECT id,nombre [name] FROM ST_Listados
		WHERE codigo='NATURALEZA' AND ESTADO=1
	END 

	ELSE IF (@c_op='TIPOSTER')
	BEGIN
		SELECT id,nombre [name], iden [data-option]
		FROM ST_Listados
		WHERE codigo='TIPOSTER' AND ESTADO=1
	END 

	ELSE IF (@c_op='TIPOIMP')
	BEGIN
		SELECT id,nombre [name] FROM ST_Listados
		WHERE codigo='TIPOIMP' AND ESTADO=1
	END 

	ELSE IF (@c_op='IVAPROD')
	BEGIN
		SELECT id,nombre [name] FROM CNT.VW_Impuestos
		WHERE nomtipoimpuesto='IVA' AND ESTADO=1
	END 

	ELSE IF (@c_op='INCPROD')
	BEGIN
		SELECT id,nombre [name] FROM CNT.VW_Impuestos
		WHERE nomtipoimpuesto='INC'  AND ESTADO=1
	END 

	ELSE IF (@c_op='DOCTIPOC')
	BEGIN
		SELECT id,nombre [name] FROM ST_Listados
		WHERE codigo='DOCTIPO' AND ESTADO=1
	END 

	ELSE IF (@c_op='TYPEFORMPAY')
	BEGIN
		SELECT id,nombre [name] FROM ST_Listados
		WHERE codigo='TYPEFORMPAY' AND ESTADO=1
	END 

	ELSE IF (@c_op='RETEFNT')
	BEGIN
		SELECT id,nombre [name] FROM CNT.VW_Impuestos
		WHERE nomtipoimpuesto='RETEFUENTES' AND ESTADO=1
	END 

	ELSE IF (@c_op='RETEIVA')
	BEGIN
		SELECT id,nombre [name] FROM CNT.VW_Impuestos
		WHERE nomtipoimpuesto='RETEIVA' AND ESTADO=1
	END 

	ELSE IF (@c_op='RETEICA')
	BEGIN
		SELECT id,nombre [name] FROM CNT.VW_Impuestos
		WHERE nomtipoimpuesto='RETEICA' AND ESTADO != 0
	END 	
	ELSE IF(@c_op='RESOLUCIONES')
	BEGIN
		SELECT  id, resolucion + '   '+ prefijo +' ('+CAST(+rangoini AS VARCHAR) +' - '+CAST(+rangofin AS VARCHAR)+')'  [name], *
		FROM VW_resoluciones
		WHERE estado != 0
	END
	ELSE IF(@c_op='TIPOCUENTA')
	BEGIN		
		SELECT id, nombre [name] 
		FROM ST_Listados
		WHERE codigo = 'TIPOCTA' AND ESTADO = 1
	END
	ELSE IF(@c_op='CENTROCOSTOS')
	BEGIN		
		SELECT id, codigo + ' - ' + nombre [name]
		FROM CNT.CentroCosto
		WHERE estado = 1 AND detalle != 0
	END
	ELSE IF(@c_op='TIPOTERCEROANT')
	BEGIN		
		SELECT id, nombre [name], iden [data-iden], iden [data-option]
		FROM ST_Listados L 
		WHERE codigo = 'TIPOSTER' AND L.iden IN ('CL', 'PR')
	 END 
	ELSE IF(@c_op='CATEGORIA')
	BEGIN                
		SELECT id, nombre [name], iden [data-iden]
		FROM ST_Listados L
		WHERE codigo = 'CATEGORIA' AND ESTADO = 1
	END
	ELSE IF(@c_op='BODEGASUSER')
	BEGIN	
		IF EXISTS(SELECT 1 FROM VW_usuarios WHERE id = @id_user AND srole = 'VENDEDOR')
		BEGIN	
			SELECT id_bodega id, bodega name
			FROM VW_Cajas C INNER JOIN [dbo].[aspnet_UsersInCajas] UC ON C.id = UC.id_caja
			WHERE UC.[user_id] = @id_user
		END
		ELSE 
		BEGIN
			SELECT Id, Nombre [name] 
			FROM Dbo.Bodegas
			WHERE estado = 1;
		END
	END
	IF(@c_op='SERVICESFINAN')
	BEGIN		
		SELECT id, nombre [name]
		FROM [FIN].[ServiciosFinanciero]
	END
	ELSE IF(@c_op='SERVICIOCREDITO')
	BEGIN	
		IF(@id_otro = Dbo.ST_FnGetIdList('CREDI'))
		BEGIN
			SELECT F.id, F.nombre name, voucher [data-voucher], F.id_tipo
			FROM [dbo].[FormaPagos] F WHERE F.id_tipo = Dbo.ST_FnGetIdList('CARTERA') AND F.[default] = 0
		END
		ELSE IF(@id_otro = Dbo.ST_FnGetIdList('FINAN'))
		BEGIN
			SELECT id, Nombre [name] FROM [FIN].[LineasCreditos]
		 END

		ELSE IF(@id_otro = Dbo.ST_FnGetIdList('CONV'))
		BEGIN
			SELECT F.id, F.nombre name, voucher [data-voucher], F.id_tipo
			FROM [dbo].[FormaPagos] F WHERE F.id_tipo = Dbo.ST_FnGetIdList('CONVENCIO')
		END
	END
	ELSE IF (@c_op = 'GESTIONCLI')
	BEGIN
		SELECT L.Id, L.nombre [name]
		FROM ST_Listados L
		WHERE L.codigo = 'GESTIONCLI'
	END
	ELSE IF (@c_op = 'CUENTA')
	BEGIN
		SELECT id, CNT.codigo name
		FROM CNTCuentas CNT where tipo != 0
	END
	ELSE IF (@c_op = 'APP')
	BEGIN 
		SELECT ApplicationId id, ApplicationName name 
		FROM aspnet_Applications 
		
		SELECT id, nombrepagina name 
		FROM [dbo].[Menus]
		WHERE estado = 1 AND nombrepagina != 'Inicio' AND id_padre != 0 
		
		SELECT R.id, R.nombre [name] 
		FROM Dbo.ST_Reportes R
		WHERE R.estado = 1 AND R.listado = 1;
	END
	
	--JPAREDES 
	ELSE IF(@c_op = 'SOLICREDIT')
	BEGIN	
		
		SELECT id, nombre [name], iden [param] FROM ST_Listados WHERE codigo = 'ESTCIVIL';--0
		
		SELECT id, nombre [name], iden [param] FROM ST_Listados WHERE codigo = 'VIVEINM';--1

		SELECT id, nombre [name], iden [param] FROM ST_Listados WHERE codigo = 'TIMSERVI';--2

		SELECT id, nombre [name], iden [param] FROM ST_Listados WHERE codigo = 'TIPOREF';--3

		SELECT id, nombre [name], iden [param] FROM ST_Listados WHERE codigo = 'ESTRATO';--4

		SELECT id, nombre [name], iden [param] FROM ST_Listados WHERE codigo = 'GENERO';--5

		SELECT id, nombre [name], iden [param] FROM ST_Listados WHERE codigo = 'TIPOEMPLEO';--6

		SELECT id, nombre [name], iden [param] FROM ST_Listados WHERE codigo = 'PERSONERIA';--7

		SELECT id, nombre [name], iden [param] FROM ST_Listados WHERE codigo = 'NIVEDUC';--8

		SELECT id, nombre [name], iden [param] FROM ST_Listados WHERE codigo = 'TIPOSID'; --9

		SELECT id, nombre [name], iden [param] FROM ST_Listados WHERE codigo = 'FINRAIZ'; --10

		SELECT id, nombre [name], iden [param] FROM ST_Listados WHERE codigo = 'TIPOCTABNC'; --11

		SELECT id, nombre+' - '+nombredep [name] FROM DivPolitica ORDER BY nombre; -- 12

		SELECT id, nombre [name], iden [param] FROM ST_Listados WHERE codigo = 'PARENTEZCO';--13

		SELECT id, nombre [name] FROM ST_Listados WHERE codigo = 'TIPOSID' ;--14

		SELECT id, nombre [name], iden [param] FROM ST_Listados WHERE codigo = 'TIPOACTIVIDAD';	-- 15

	END
	
	--JARCINIEGAS
	ELSE IF(@c_op = 'SELTIPOIDEN')
	BEGIN
		IF(CAST(@v_param AS BIGINT) = (SELECT id FROM ST_Listados WHERE codigo='PERSONERIA' AND iden='NATURAL'))
		SELECT id, nombre [name] FROM ST_Listados WHERE codigo = 'TIPOSID' AND iden != 'NIT';--9

		ELSE IF(CAST(@v_param AS BIGINT) = (SELECT id FROM ST_Listados WHERE codigo='PERSONERIA' AND iden='JURIDICA'))
		SELECT id, nombre [name] FROM ST_Listados WHERE codigo = 'TIPOSID' AND iden != 'RC' AND iden != 'TI';--10
	END 

	--JPAREDES
	ELSE IF(@c_op = 'ESTACIONES')
	BEGIN
		SELECT id, nombre name
		FROM [CRE].[Estaciones]
	END

	ELSE IF(@c_op ='ASESORESESTA')
	BEGIN
		SELECT id, nombre name FROM [DBO].[Usuarios]
	END

	ELSE IF(@c_op = 'PAGOCREDIT')
	BEGIN		
		SELECT id, nombre [name], iden FROM ST_Listados
		WHERE codigo = 'FORMACREDI' AND iden = 'FINAN';
	END

	ELSE IF(@c_op = 'LINEACREDIT')
	BEGIN
		SELECT id, Nombre name FROM [FIN].[LineasCreditos]
	END

	--JARCINIEGAS
	ELSE IF(@c_op = 'SELTIPOREF')
	BEGIN
		IF(CAST(@v_param AS BIGINT) = (SELECT id FROM ST_Listados WHERE codigo='TIPOREF' AND iden='RFAM'))
		SELECT id, nombre [name] FROM ST_Listados WHERE codigo = 'PARENTEZCO' AND iden != 'VECINO' AND iden != 'AMIGO';--9

		ELSE IF(CAST(@v_param AS BIGINT) = (SELECT id FROM ST_Listados WHERE codigo='TIPOREF' AND iden='RPER'))
		SELECT id, nombre [name] FROM ST_Listados WHERE codigo = 'PARENTEZCO' AND iden IN ('VECINO', 'AMIGO');--10
	END 


	--JARCINIEGAS
	ELSE IF(@c_op = 'VERICOD')
	BEGIN
		SELECT valor FROM [dbo].[Parametros] WHERE codigo = 'CANTCODEUDOR'
	END 
	
	ELSE IF(@c_op = 'PAGOCREDI')
	BEGIN		
		SELECT id, nombre [name], iden [data-op]
		FROM ST_Listados
		WHERE codigo = 'FORMACREDI' ORDER BY nombre;
	END

END TRY
BEGIN CATCH
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);		
	ROLLBACK TRANSACTION;
END CATCH


GO


