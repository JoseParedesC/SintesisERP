--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[NOM].[VW_ParametrosAnuales]') AND OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
DROP VIEW [NOM].[VW_ParametrosAnuales]
END
GO
CREATE VIEW [NOM].[VW_ParametrosAnuales]
AS

		SELECT  PA.id id_paramAnuales
			,PA.salario_MinimoLegal
			,PA.salario_Integral
			,PA.aux_transporte
			,PA.fecha_vigencia
			,PA.exonerado
			,PE.porcen_sena
			,PE.porcen_icbf
			,S.id id_interesCesan
			,PE.porcen_salud porcen_salud_Empleado
			,PE.porcen_pension porcen_pension_Empleado
			,PR.porcen_salud porcen_salud_Empleador
			,PR.porcen_pension porcen_pension_Empleador
			,PA.porcen_saludTotal
			,PA.porcen_pencionTotal
			,PR.num_salariosMinSalud
			,PE.num_salariosMinICBF
			,PE.num_salariosMinSegSocial
			,PE.num_salariosMinSENA
	FROM [NOM].[ParamsAnual] PA INNER JOIN 
	[NOM].[ParamsAnual_Empleado] PE ON PE.id = PA.id_parametrosEmpleado INNER JOIN
	[NOM].[ParamsAnual_Empleador] PR ON PR.id = PA.id_parametrosEmpleador INNER JOIN
	[NOM].[ParamsAnual_HrsExtras] HR ON HR.id = PA.id_horasExt INNER JOIN
	--[NOM].[ParametrosAnuales_Solidaridad] PS ON PS.id = PA.id_solidaridad INNER JOIN
	[DBO].[ST_Listados] S ON S.id = PA.id_interesCesantias
GO