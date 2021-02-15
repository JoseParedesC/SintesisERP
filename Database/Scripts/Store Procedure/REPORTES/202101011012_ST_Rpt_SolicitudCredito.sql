--liquibase formatted sql
--changeset ,JPREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[ST_Rpt_SolicitudCredito]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_Rpt_SolicitudCredito]
GO
CREATE PROCEDURE [dbo].[ST_Rpt_SolicitudCredito]

@id_solicitud BIGINT,
@op VARCHAR(2),
@id_user BIGINT

AS 
/******************************************************************
*Nombre:		[dbo].[ST_Rpt_SolicitudCredito]
-------------------------------------------------------------------
*Tipo:			 Procedimiento almacenado
*creación:		 24/12/2020
*Desarrollador:  JPAREDES
*Descripcion:	 Consulta la ifnromacion de la solicitud, 
				 el deudor y los codeudores, todos con 
				 sus referencias
******************************************************************/

DECLARE @error VARCHAR(MAX),@codeudoruno BIGINT, @codeudordos BIGINT

BEGIN TRY
	

	IF(@op = 'SO')
	BEGIN

		DECLARE @user VARCHAR(50) = (SELECT nombre From [dbo].[Usuarios] WHERE id = @id_user)

		DECLARE @cod1nom VARCHAR(50) = (SELECT TOP 1 Per.primernombre+' '+Per.segundonombre+' '+Per.primerapellido+' '+Per.segundoapellido nombrecod FROM [CRE].[Personas] Per INNER JOIN 
			 [CRE].[Solicitud_Personas] PS ON PS.id_persona = Per.id 
		WHERE Per.tipo_tercero = 'CO' AND PS.id_solicitud = @id_solicitud)

		DECLARE @cod1iden VARCHAR(50) = (SELECT TOP 1 Per.identificacion idencod FROM [CRE].[Personas] Per INNER JOIN 
			 [CRE].[Solicitud_Personas] PS ON PS.id_persona = Per.id 
		WHERE Per.tipo_tercero = 'CO' AND PS.id_solicitud = @id_solicitud)
		

		SELECT
		ISNULL(@cod1nom,'') codnom,
		ISNULL(@cod1iden,'') codiden,
		@user usuario,
		PS.id id_persol,
		S.id id_sol,
		-- CABECERA
		E.nombre nombreemp,
		E.direccion,
		S.consecutivo,
		(SELECT DAY(S.fechasolicitud)) dia,
		(SELECT MONTH(S.fechasolicitud)) mes,
		(SELECT YEAR(S.fechasolicitud)) ano,
		P.nombre nombreart,
		C.inc,
		C.descuento,
		C.numcuotas,
		C.subtotal,
		C.cuotamen,
		C.total,
		CONVERT(VARCHAR(10),C.fechacot,120) fechapago
		FROM [CRE].[Solicitud_Personas] PS INNER JOIN 
		[CRE].[Solicitudes] S ON S.id = PS.id_solicitud LEFT JOIN
		[CRE].[Estaciones] E ON E.id = S.id_estacion LEFT JOIN
		[dbo].[MOVCotizacion] C ON C.id = S.id_cotizacion LEFT JOIN 
		[dbo].[MOVCotizacionItems] CI ON CI.id_Cotizacion= C.id INNER JOIN
		[DBO].[Productos] P ON P.id = ci.id_articulo
		WHERE PS.id_solicitud = @id_solicitud

	END
	ELSE IF(@op = 'CL')
	BEGIN

		SELECT
		-- INFORMACION PERSONAL
		P.id id_per,
		P.primernombre+' '+P.segundonombre+' '+P.primerapellido+' '+P.segundoapellido nombre,
		P.identificacion,
		CONVERT(VARCHAR(10),P.fechaexpedicion,120) fechaexpedicion,
		P.direccion,
		P.telefono,
		P.correo,
		(SELECT nombre FROM [dbo].[ST_Listados] WHERE id = P.id_estadocivil) estadocivil,
		P.percargo,
		(SELECT nombre FROM [dbo].[ST_Listados] WHERE id = P.id_escolaridad) escolaridad,
		DATEDIFF(YEAR, P.fechanacimiento,GETDATE()) edad,
		(SELECT nombre FROM [dbo].[ST_Listados] WHERE id = P.id_genero) genero,
		(SELECT nombre FROM [ST_Listados] WHERE id = P.id_estrato) estrato,
		(SELECT nombre FROM [ST_Listados] WHERE id = P.id_viveinmueble) viveinmueble,
		P.valorarriendo,
		P.profesion,
		(SELECT nombre FROM [ST_Listados] WHERE id = P.id_fincaraiz) fincaraiz,
		P.vehiculo,
		--INFORMACION CONYUGE
		PA.connombre,
		PA.coniden,
		PA.contelefono,
		PA.conempresa,
		PA.condireccionemp,
		PA.contelefonoemp,
		PA.consalario,
		-- INFORMACION LABORAL
		PA.empresalab,
		PA.direccionemp,
		PA.telefonoemp,
		PA.cargo,
		(SELECT nombre FROM [dbo].[ST_Listados] WHERE id = PA.id_tiempoemp) tiemposervicio,
		PA.salarioemp,
		PA.otroingreso,
		PA.concepto,
		-- REFERENCIAS BANCARIAS
		PA.banco,
		(SELECT nombre FROM [dbo].[ST_Listados] WHERE id = PA.id_tipocuenta) tipocuenta,
		PA.numcuenta,
		-- REFERENCIAS PERSONALES/FAMILIARES
		(SELECT nombre FROM [dbo].[ST_Listados] WHERE id = PR.id_tiporef) tiporef,
		PR.nombre ref_nombre,
		PR.direccion ref_dir,
		PR.telefono ref_tel
		FROM [CRE].[Solicitud_Personas] PS INNER JOIN 
		[CRE].[Personas] P ON PS.id_persona = P.id INNER JOIN
		[CRE].[Personas_Adicionales] PA ON PA.id_persona = P.id INNER JOIN
		[CRE].[Personas_Referencias] PR ON PR.id_persona = P.id
		WHERE ((PS.id_solicitud = @id_solicitud) AND 
			  (PS.id_persona = PR.id_persona AND PS.id_solicitud = PR.id_solicitud)) AND P.tipo_tercero = 'CL'

	END

	ELSE IF(@op = 'CD')
	BEGIN

		SELECT 
		-- INFORMACION PERSONAL
		P.id,
		P.primernombre+' '+P.segundonombre+' '+P.primerapellido+' '+P.segundoapellido nombre,
		P.identificacion,
		CONVERT(VARCHAR(10),P.fechaexpedicion,120) fechaexpedicion,
		P.direccion,
		P.telefono,
		P.correo,
		(SELECT nombre FROM [dbo].[ST_Listados] WHERE id = P.id_estadocivil) estadocivil,
		P.percargo,
		DATEDIFF(YEAR, P.fechanacimiento,GETDATE()) edad,
		(SELECT nombre FROM [dbo].[ST_Listados] WHERE id = P.id_genero) genero,
		(SELECT nombre FROM [ST_Listados] WHERE id = P.id_estrato) estrato,
		(SELECT nombre FROM [ST_Listados] WHERE id = P.id_viveinmueble) viveinmueble,
		P.valorarriendo,
		P.profesion,
		(SELECT nombre FROM [ST_Listados] WHERE id = P.id_fincaraiz) fincaraiz,
		P.vehiculo,
		PA.connombre,
		PA.coniden,
		PA.contelefono,
		PA.conempresa,
		PA.condireccionemp,
		PA.contelefonoemp,
		PA.consalario,
		ROW_NUMBER() OVER(PARTITION BY PS.id_solicitud ORDER BY P.id) AS counted
		FROM [CRE].[Solicitud_Personas] PS INNER JOIN 
		[CRE].[Personas] P ON PS.id_persona = P.id LEFT JOIN
		[CRE].[Personas_Adicionales] PA ON PA.id_persona = P.id
		WHERE PS.id_solicitud = @id_solicitud AND P.tipo_tercero = 'CO'
		
	END
	ELSE IF(@op = 'CR')
	BEGIN 
		SELECT 
		(SELECT nombre FROM [dbo].[ST_Listados] WHERE id = PR.id_tiporef) tiporef,
		PR.nombre ref_nombre,
		PR.direccion ref_dir,
		PR.telefono ref_tel
		FROM
		[CRE].[Personas_Referencias] PR INNER JOIN
		[CRE].[Personas] P ON P.id = PR.id_persona
		WHERE PR.id_persona = @id_solicitud -- En este caso @id_solicitud es el id de la pesona que tiene las referencias
	END 
	ELSE IF(@op = 'CI')
	BEGIN

		DECLARE @temp TABLE (id_record BIGINT IDENTITY, nombre VARCHAR(100), iden BIGINT,counted BIGINT)

		INSERT INTO @temp
		SELECT
		P.primernombre+' '+P.segundonombre+' '+P.primerapellido+' '+P.segundoapellido nombre,
		P.identificacion,
		ROW_NUMBER() OVER(PARTITION BY PS.id_solicitud ORDER BY P.id) AS counted
		FROM [CRE].[Solicitud_Personas] PS INNER JOIN 
		[CRE].[Personas] P ON PS.id_persona = P.id
		WHERE P.tipo_tercero = 'CO' AND PS.id_solicitud = @id_solicitud

		SELECT 
		tm.counted coun, tm.iden ide, tm.nombre nom 
		FROM @temp tm WHERE tm.counted > 1 AND tm.counted%2 != 0

	END
	ELSE IF(@op = 'CP')
	BEGIN
		DECLARE @temp2 TABLE (id_record BIGINT IDENTITY, nombre VARCHAR(100), iden BIGINT,counted BIGINT)

		INSERT INTO @temp2
		SELECT
		P.primernombre+' '+P.segundonombre+' '+P.primerapellido+' '+P.segundoapellido nombre,
		P.identificacion,
		ROW_NUMBER() OVER(PARTITION BY PS.id_solicitud ORDER BY P.id) AS counted
		FROM [CRE].[Solicitud_Personas] PS INNER JOIN 
		[CRE].[Personas] P ON PS.id_persona = P.id
		WHERE P.tipo_tercero = 'CO' AND PS.id_solicitud = @id_solicitud

		SELECT 
		tm.counted coun, tm.iden ide, tm.nombre nom 
		FROM @temp2 tm WHERE tm.counted%2 = 0 
	END
END TRY
BEGIN CATCH
	--Getting the error description
	SELECT @error   =  ERROR_PROCEDURE() + 
				';  ' + CONVERT(VARCHAR,ERROR_LINE()) + 
				'; ' + ERROR_MESSAGE()
	-- save the error in a Log file
	RAISERROR(@error,16,1)
	RETURN
END CATCH