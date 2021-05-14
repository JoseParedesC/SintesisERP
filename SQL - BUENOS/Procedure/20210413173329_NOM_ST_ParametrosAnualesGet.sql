--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
IF EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_ParametrosAnualesGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_ParametrosAnualesGet]
GO
CREATE PROCEDURE [NOM].[ST_ParametrosAnualesGet]

@id BIGINT,
@op CHAR(1) = NULL,
@id_user BIGINT

AS


/***************************************
*Nombre:		[NOM].[ST_ParametrosAnualesGet]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		30/03/2021
*Desarrollador:  JPAREDES
*Descripcion:	Retorna los parametros anuales para la nomina
***************************************/

DECLARE  @mensaje VARCHAR(MAX);

BEGIN TRY
	

	IF(@op != '')
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM [NOM].[ParamsAnual] WHERE fecha_vigencia = CONVERT(VARCHAR(4),GETDATE(),120))
			SET @mensaje = 'No hay Parametros relacionados con la fecha vigente';
	END
	ELSE
	BEGIN
		IF(ISNULL(@id,0) = 0)
		RAISERROR('No se encontró resultado',16,0)
	END

	SELECT  PA.id id_param,
			ISNULL(IIF(@op = '',PA.aux_transporte,0),0)aux_transporte,
			CONVERT(VARCHAR(4),IIF(@op = '',PA.fecha_vigencia,PA.fecha_vigencia+366),120) fecha_vigencia,
			porcen_pencionTotal ,
			PA.porcen_saludTotal porcen_saludTotal,
			ISNULL(IIF(@op = '',PA.salario_Integral,0),0)salario_Integral,
			ISNULL(IIF(@op = '', PA.salario_MinimoLegal,0),0)salario_MinimoLegal,
			IIF(@op = '',PA.id_interesCesantias,0) id_interesCesantias,
			PA.exonerado,
			PA.porcen_cajacompensacion caja_compensacion,
			PA.id_cuentacobrar id_cuenta,
			(SELECT CONCAT(C.codigo,' - ', C.nombre) WHERE PA.id_cuentacobrar = C.id) ds_cuenta,
			PA.id_cuentaarl id_cuenta_arl,
			(SELECT CONCAT(C2.codigo,' - ', C2.nombre) FROM CNTCuentas C2 WHERE PA.id_cuentaarl = C2.id) ds_cuenta_arl,
			PE.num_salariosMinICBF,
			PE.num_salariosMinSegSocial,
			PE.num_salariosMinSENA,
			PE.porcen_icbf porcen_icbf,
			PE.porcen_pension porcen_pensionE,
			PE.porcen_salud porcen_saludE,
			PE.porcen_sena porcen_sena,
			PR.num_salariosMinSalud,
			PR.porcen_pension porcen_pensionR,
			PR.porcen_salud porcen_saludR,
			ISNULL(HR.extra_diurna,0)extra_diurna,
			ISNULL(HR.extra_fesDiurna,0)extra_fesDiurna,
			ISNULL(HR.extra_fesNoct,0)extra_fesNoct,
			ISNULL(HR.extra_nocturna,0)extra_nocturna,
			ISNULL(HR.HraDomDiurno,0)recarg_DomDiurno,
			ISNULL(HR.recarg_DomNoct,0)recarg_DomNoct,
			ISNULL(HR.recargoNocturno,0)recargoNocturno,
			PA.uvt
	FROM [NOM].[ParamsAnual] PA INNER JOIN
		 [NOM].[ParamsAnual_Empleado] PE ON PA.id_parametrosEmpleado = PE.id INNER JOIN
		 [NOM].[ParamsAnual_Empleador] PR ON PA.id_parametrosEmpleador = PR.id INNER JOIN
		 [NOM].[ParamsAnual_HrsExtras] HR ON PA.id_horasExt = HR.id INNER JOIN
		 [DBO].[CNTCuentas] C ON C.id = PA.id_cuentacobrar
	WHERE IIF(@op != '', DATEPART(YEAR,fecha_vigencia+366), PA.id) >= IIF(@op != '', DATEPART(YEAR,GETDATE()), @id)


	SELECT  PS.desde,
			PS.hasta,
			PS.porcentaje
	FROM [NOM].[ParamsAnual_Solid] PS INNER JOIN [NOM].[ParamsAnual] PA ON PS.id_parametros = PA.id WHERE IIF(@op != '', CONVERT(VARCHAR(4),fecha_vigencia+366,120), PA.id) >= IIF(@op != '', CONVERT(VARCHAR(4),GETDATE(),120), @id)

END TRY
BEGIN CATCH
	SET @mensaje = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@mensaje,16,0);	
END CATCH