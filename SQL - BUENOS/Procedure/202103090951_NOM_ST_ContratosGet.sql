--liquibase formatted sql
--changeset ,JARCINIEGAS:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_ContratosGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_ContratosGet]
GO
CREATE PROCEDURE [NOM].[ST_ContratosGet]
	
	@id_contrato INT ,
	@id_empleado INT ,
	@id_user INT = null
AS

/***************************************
*Nombre:		[NOM].[ST_ContratosGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		24/11/2020
*Desarrollador: JARCINIEGAS
*Descripcion:	
***************************************/

DECLARE @error VARCHAR(MAX)

BEGIN TRY


	SELECT	C.id, 
			C.id_empleado,
			EMP.razonsocial,
			EMP.iden,
			consecutivo codigo,
			id_contratacion,
			id_tipo_contrato,
			coti_extranjero,
			id_tipo_cotizante,
			(SELECT 'Cod '+ TC.codigo +''+ T.codigo + '  Pila '+CONVERT(VARCHAR,T.codigo_externo)+'-'+CONVERT(VARCHAR,TC.codigo_externo)FROM [NOM].[VW_TiposCotizante] T INNER JOIN [NOM].[TiposCotizante] TC ON TC.id = T.id_padre WHERE T.id_tipo_subtipo = id_tipo_cotizante) tipo_cotizante,----cambiar cuando implemente el tipo y subtipo de coti
			CONVERT(BIT,(SELECT CASE WHEN tipo_salario = 'INTEGRAL' THEN 1 ELSE 0 END))tipo_salario,
			salario,
			tipo_nomina,
			diasapagar,
			CONVERT(VARCHAR(10),fecha_inicio,120) fecha_inicio,
			CONVERT(VARCHAR(10),fecha_final,120) fecha_final,
			area id_area,
			(SELECT A.nombre FROM [NOM].[Area] A WHERE A.id = area) area,
			cargo,
			id_horario,
			C.funciones_esp,
			jefe,
			cual_jefe id_cual_jefe,
			(SELECT CR.nombre +' - '+  (EMPL.razonsocial) FROM  [NOM].[VW_Empleados] EMPL INNER JOIN [NOM].[Contrato] CN ON EMPL.id = CN.id_empleado INNER JOIN [NOM].Cargo CR ON CR.id = CN.cargo WHERE CN.id_empleado = C.cual_jefe) cual_jefe,
			id_eps,
			(SELECT EPS.nombre FROM [NOM].[Entidades_de_Salud] EPS WHERE EPS.id = id_eps) eps,
			id_cesantias,
			(SELECT CE.nombre FROM [NOM].[Cesantias] CE WHERE CE.id = id_cesantias) cesantias,
			id_pension,
			(SELECT P.nombre FROM [NOM].[Entidades_de_Salud] P WHERE P.id = id_pension) pension,
			id_cajacomp,
			(SELECT CAJA.nombre FROM [NOM].[Entidades_de_Salud] CAJA WHERE CAJA.id = id_cajacomp) cajacomp,
			id_formapago,
			ncuenta,
			tipo_cuenta,
			banco,
			tipo_jornada,
			sede_contratacion,
			centrocosto,
			ley50,
			procedimiento,
			(SELECT iden FROM [dbo].[ST_Listados] WHERE id = C.estado) estado

	FROM [NOM].[Contrato] C 
		INNER JOIN [NOM].[VW_Empleados] EMP ON EMP.id = C.id_empleado
		INNER JOIN [NOM].Cargo CAR ON  CAR.id = C.cargo
	WHERE C.id = @id_contrato AND C.id_empleado = @id_empleado
	

END TRY
BEGIN CATCH
--Getting the error description
	Set @error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	-- save the error in a Log file
	RAISERROR(@error,16,1)
	RETURN
END CATCH