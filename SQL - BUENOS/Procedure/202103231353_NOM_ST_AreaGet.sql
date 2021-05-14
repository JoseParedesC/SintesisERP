--liquibase formatted sql
--changeset ,JARCINIEGAS:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_AreaGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_AreaGet]
GO
CREATE PROCEDURE [NOM].[ST_AreaGet]
	
	@id INT ,
	@id_user INT 
AS

/***************************************
*Nombre:		[CRE].[ST_AreaGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		24/11/2020
*Desarrollador: JPAREDES
*Descripcion:	
***************************************/

DECLARE @error VARCHAR(MAX)

BEGIN TRY


	SELECT	id, --
			nombre, --
			id_cuen_Sueldo sueldo,
			(SELECT CU.codigo+' - '+ CU.nombre FROM dbo.VW_CNTCuentas CU WHERE CU.id = id_cuen_Sueldo) id_sueldo,
			id_cuen_Horas_extras hextra,
			(SELECT CU.codigo+' - '+ CU.nombre FROM dbo.VW_CNTCuentas CU WHERE CU.id = id_cuen_Horas_extras) id_hextra,
			id_cuen_Bonificaciones boni,
			(SELECT CU.codigo+' - '+ CU.nombre FROM dbo.VW_CNTCuentas CU WHERE CU.id = id_cuen_Bonificaciones) id_boni,
			id_cuen_Comisiones comi,
			(SELECT CU.codigo+' - '+ CU.nombre FROM dbo.VW_CNTCuentas CU WHERE CU.id = id_cuen_Comisiones) id_comi,
			id_cuen_Aux_transporte auxtransporte,
			(SELECT CU.codigo+' - '+ CU.nombre FROM dbo.VW_CNTCuentas CU WHERE CU.id = id_cuen_Aux_transporte) id_auxtransporte,
			id_cuen_Cesantias cesan,
			(SELECT CU.codigo+' - '+ CU.nombre FROM dbo.VW_CNTCuentas CU WHERE CU.id = id_cuen_Cesantias) id_cesan,
			id_cuen_Int_cesantias int_cesan,
			(SELECT CU.codigo+' - '+ CU.nombre FROM dbo.VW_CNTCuentas CU WHERE CU.id = id_cuen_Int_cesantias) id_int_cesan,
			id_cuen_Prima_servicios prima_ser,
			(SELECT CU.codigo+' - '+ CU.nombre FROM dbo.VW_CNTCuentas CU WHERE CU.id = id_cuen_Prima_servicios) id_prima_ser,
			id_cuen_Vacaciones vacas,
			(SELECT CU.codigo+' - '+ CU.nombre FROM dbo.VW_CNTCuentas CU WHERE CU.id = id_cuen_Vacaciones) id_vacas,
			id_cuen_ARL arl,
			(SELECT CU.codigo+' - '+ CU.nombre FROM dbo.VW_CNTCuentas CU WHERE CU.id = id_cuen_ARL) id_arl,
			id_cuen_Aprts_EPS eps,
			(SELECT CU.codigo+' - '+ CU.nombre FROM dbo.VW_CNTCuentas CU WHERE CU.id = id_cuen_Aprts_EPS) id_eps,
			id_cuen_Aprts_AFP afp,
			(SELECT CU.codigo+' - '+ CU.nombre FROM dbo.VW_CNTCuentas CU WHERE CU.id = id_cuen_Aprts_AFP) id_afp,
			id_cuen_Aprts_CCF ccf,
			(SELECT CU.codigo+' - '+ CU.nombre FROM dbo.VW_CNTCuentas CU WHERE CU.id = id_cuen_Aprts_CCF) id_ccf,
			id_cuen_ICBF icbf,
			(SELECT CU.codigo+' - '+ CU.nombre FROM dbo.VW_CNTCuentas CU WHERE CU.id = id_cuen_ICBF) id_icbf,
			id_cuen_SENA sena,
			(SELECT CU.codigo+' - '+ CU.nombre FROM dbo.VW_CNTCuentas CU WHERE CU.id = id_cuen_SENA) id_sena,
			id_cuen_FonSolPen fspension,
			(SELECT CU.codigo+' - '+ CU.nombre FROM dbo.VW_CNTCuentas CU WHERE CU.id = id_cuen_FonSolPen) id_fspension
	
	FROM [NOM].[Area] 
	WHERE id = @id
	

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