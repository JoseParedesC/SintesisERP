USE [SintesisCloudMotAburra]
GO
/****** Object:  StoredProcedure [dbo].[ST_CargarListado]    Script Date: 29/01/2021 9:53:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER  PROCEDURE [dbo].[ST_CargarListado]
@c_op		VARCHAR(20),
@v_param	VARCHAR(50) = null,
@id_user	INT,
@id_otro	VARCHAR(50) = null

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
	DECLARE @error VARCHAR(MAX);
	
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
		WHERE F.estado = 1 and L.codigo = 'FORMAPAGOCONT' AND iden = @v_param
	END 
	ELSE IF(@c_op = 'VENCREDITO')
	BEGIN	
		SELECT id, nombre [name]
		FROM ST_Listados
		WHERE codigo = 'VENCREDITO' AND estado = 1;
	END ELSE IF(@c_op = 'VENCREDITONOTAS')
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
		SELECT id, nombre [name], iden [data-iden]
		FROM ST_Listados L 
		WHERE L.iden IN ('CL', 'PR')
	END ELSE IF(@c_op='CATEGORIA')
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

	ELSE IF(@c_op = 'PAGOCREDI')
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

	--JARCINIEGAS NOMINA
	ELSE IF(@c_op = 'EMP')
	BEGIN
		SELECT id, nombre [name], iden FROM ST_Listados	WHERE codigo = 'TIPOSANGRE';--0

		SELECT id, nombre [name], iden [param] FROM ST_Listados	WHERE codigo = 'TIPOCONTRA';--1
		
		SELECT id, nombre [name], iden [param] FROM ST_Listados	WHERE codigo = 'TIPOSAL';--2
		
		SELECT id, nombre [name], iden [param] FROM ST_Listados	WHERE codigo = 'FORMAPAGONOM';--3
		
		SELECT id, nombre [name], iden [param] FROM ST_Listados	WHERE codigo = 'TIPOJORNADA';--4

		SELECT id, nombre [name], funciones_esp [param] FROM [NOM].[Cargo]--5

		SELECT id, codigo +'-'+ nombre [name] FROM [CNT].[CentroCosto]--6

		--SELECT  EM.id,CAR.nombre +' - '+  (EM.razonsocial) [name]			  
		--	FROM [NOM].[VW_Empleados] EM 
		--	INNER JOIN [NOM].Contrato C ON C.id_empleado = EM.id
		--	INNER JOIN [NOM].Cargo CAR ON  CAR.id = C.cargo
		--	WHERE C.jefe = 1 AND C.estado = dbo.ST_FnGetIdList('VIG') --7----

		SELECT id, nombre [name] FROM ST_Listados WHERE codigo = 'ESTADOCONTRATO' AND iden IN ('FIN','CAN')--7++8

		SELECT id, nombre [name] FROM [NOM].[Cesantias]--8++10

		SELECT id, nombre [name], iden [param] FROM ST_Listados	WHERE codigo = 'TIPOHORARIO';--9++14 

		SELECT  C.id, EM.razonsocial [name]			  
			FROM [NOM].[VW_Empleados] EM 
			INNER JOIN [NOM].Contrato C ON C.id_empleado = EM.id
			WHERE C.jefe = 1 AND C.estado = dbo.ST_FnGetIdList('VIG') --10++15

		SELECT id, nombre [name], iden [param] FROM ST_Listados	WHERE codigo = 'CONTRATACION';--11++16 

		SELECT id, nombre [name], iden [param] FROM ST_Listados	WHERE codigo = 'PROCEDIMIENTO';--12++17
		
		SELECT id, nombre [name], iden [param] FROM ST_Listados	WHERE codigo = 'TIPOCUENTABANCO';--13++18 

		SELECT id, nombre [name] FROM [NOM].[Horario] WHERE ISNULL(id_padre,0) = 0;--14++19 

		SELECT id, nombre name, iden [data-iden] FROM ST_Listados WHERE codigo = 'TIPOPRESTACION'--15


	END

	--JARCINIEGAS
	ELSE IF(@c_op = 'VERISAL')
	BEGIN
		SELECT salario_MinimoLegal valor FROM [NOM].[ParamsAnual] WHERE DATEPART( YY ,fecha_vigencia) = DATEPART( YY , getdate());

		SELECT salario_Integral valor FROM [NOM].[ParamsAnual] WHERE DATEPART( YY ,fecha_vigencia) = DATEPART( YY , getdate());

	END 

	/*JARCINIEGAS -> CONSULTA LOS DÍAS FESTIVOS*/
     ELSE IF (@c_op = 'FECHAFES')
     BEGIN
         SELECT 'F' id, 'FESTIVO' [name]
     END
	 --JARCINIEGAS
	ELSE IF(@c_op = 'TIPOCONTRAT')
	BEGIN
		IF(CAST(@v_param AS BIGINT) = (SELECT id FROM ST_Listados WHERE codigo='CONTRATACION' AND iden='EST'))
		SELECT id, nombre [name], iden [param] FROM ST_Listados WHERE codigo = 'TIPOCONTRA' AND iden IN('APRENDIZ','SENALECT','SENAPRODUCT');

		ELSE		
		SELECT id, nombre [name], iden [param] FROM ST_Listados WHERE codigo = 'TIPOCONTRA' AND iden NOT IN('APRENDIZ','SENALECT','SENAPRODUCT');
	END 
	ELSE IF(@c_op = 'LIQUIDACION')
	BEGIN

	SELECT id, nombre [name], iden [param] FROM ST_Listados	WHERE codigo = 'LIQUID';

	SELECT DISTINCT PP.id, CONVERT(VARCHAR, C.diasapagar)+' días - '+CONVERT(VARCHAR(10),PC.fecha_pago, 101) [name] FROM [NOM].[Contrato] C 
	INNER JOIN [NOM].[Periodos_Por_Contrato] PC ON PC.id_contrato = C.id 
	INNER JOIN [NOM].[Periodos_Pago] PP ON PP.id = PC.id_periodo 
	WHERE PC.estado = 0;

	END
	ELSE IF(@c_op = 'TIPOINC')
	BEGIN
		SELECT id, nombre name FROM [dbo].[ST_Listados]  WHERE codigo = 'TIPOINC'
	END

	ELSE IF (@c_op = 'TIPOSCOT')
	BEGIN
		SELECT id, codigo [name] FROM [NOM].[SubtiposCotizante] WHERE estado != 1
	END
	ELSE IF(@c_op = 'TAU')
	BEGIN
		SELECT id, nombre [name], iden [data-iden] FROM [dbo].[ST_Listados] WHERE codigo = 'TIPOAUSENCIA'
	END
	ELSE IF (@c_op = 'TIPOSEGSOCIAL')
	BEGIN
		SELECT id, nombre [name], iden [param] FROM ST_Listados	WHERE codigo = 'SEG_SOCIAL';
	END--TIPO DE INCAPACIDAD

	IF NOT EXISTS(SELECT 1 FROM ST_Listados WHERE codigogen = 'TIPOINC')
	BEGIN
		INSERT INTO ST_Listados (codigogen, codigo, iden, nombre, estado, bloqueo) VALUES ('TIPOINC','', '','Tipo de Incapacidad', 1,1)

		INSERT INTO ST_Listados (codigo, iden, nombre, estado, bloqueo) VALUES ('TIPOINC', 'INC1','66,67% del dia 1 al 90', 1,1)
		INSERT INTO ST_Listados (codigo, iden, nombre, estado, bloqueo) VALUES ('TIPOINC', 'INC2','100% primeros 2 dias y del 3 al 90 al 66,67%', 1,1)
		INSERT INTO ST_Listados (codigo, iden, nombre, estado, bloqueo) VALUES ('TIPOINC', 'INC3','100% del dia 1 al 90', 1,1)
	END

	-- TIPO DE AUSENCIA
	IF NOT EXISTS(SELECT 1 FROM ST_Listados WHERE codigogen = 'TIPOAUSENCIA')
	BEGIN
		INSERT INTO ST_Listados (codigogen, codigo, iden, nombre, estado, bloqueo) VALUES ('TIPOAUSENCIA','', '','Tipo de Ausencia', 1,1)

		INSERT INTO ST_Listados (codigo, iden, nombre, estado, bloqueo) VALUES ('TIPOAUSENCIA', 'VAC','Vacaciones', 1,1)
		INSERT INTO ST_Listados (codigo, iden, nombre, estado, bloqueo) VALUES ('TIPOAUSENCIA', 'LIC','Licencia', 1,1)
		INSERT INTO ST_Listados (codigo, iden, nombre, estado, bloqueo) VALUES ('TIPOAUSENCIA', 'INC','Incapacidad', 1,1)

	END




END TRY
BEGIN CATCH
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);		
	ROLLBACK TRANSACTION;
END CATCH
