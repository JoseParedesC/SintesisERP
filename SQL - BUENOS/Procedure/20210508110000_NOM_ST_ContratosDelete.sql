--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_ContratoDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_ContratoDelete]
GO
CREATE PROCEDURE [NOM].[ST_ContratoDelete]

@id_contrato BIGINT, 
@id_user BIGINT

AS

/********************************************
*Nombre:		[NOM].[ST_ContratoDelete]
---------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		30/03/2021
*Desarrollador:  JPAREDES
*Descripcion:	Elimina el Contrato
********************************************/

DECLARE @error VARCHAR(MAX)
BEGIN TRY

	DECLARE @id_periodo_contrato BIGINT = (SELECT id FROM [NOM].[Periodos_Por_Contrato] WHERE id_contrato = @id_contrato)
	DECLARE @dias_laborales BIGINT = (SELECT CASE WHEN fecha_final > GETDATE() THEN SUM(DATEDIFF(DAY, fecha_inicio, GETDATE())) ELSE SUM(DATEDIFF(DAY, fecha_inicio, fecha_final)) END FROM [NOM].[Contrato] WHERE id = @id_contrato GROUP BY fecha_final);
	DECLARE @dias_no_laborados BIGINT = (SELECT SUM(DATEDIFF(DAY, fecha_ini, fecha_fin)) FROM [NOM].[Ausencias] WHERE id_per_cont = @id_periodo_contrato AND remunerado = 0);
	DECLARE @festivos bigint;



		SET @festivos = (SELECT SUM(1) FROM [NOM].[FechaFes] AS F INNER JOIN [NOM].[Contrato] C ON F.fecha BETWEEN C.fecha_inicio AND GETDATE() WHERE C.id = @id_contrato)	

		SET @dias_laborales = @dias_laborales - @festivos

		SET @festivos = (SELECT SUM(1) FROM [NOM].[FechaFes] AS F INNER JOIN [NOM].[Ausencias] A ON F.fecha BETWEEN A.fecha_ini AND A.fecha_fin WHERE A.id_per_cont = @id_periodo_contrato)

		SET @dias_no_laborados = ISNULL(@dias_no_laborados,0) - ISNULL(@festivos,0)


	IF EXISTS(SELECT 1 FROM [NOM].[Contrato] C INNER JOIN [DBO].[ST_Listados] L ON C.estado = L.id WHERE C.id = @id_contrato AND ((L.iden = 'ESP') OR (L.iden = 'VIG' AND (@dias_laborales - @dias_no_laborados) < 0)) AND NOT EXISTS(SELECT 1 FROM [NOM].[Periodos_Por_Contrato] WHERE id_contrato = @id_contrato AND estado = 1))
	BEGIN
		DELETE FROM [NOM].[Devengos] WHERE id_per_cont = @id_periodo_contrato
		DELETE FROM [NOM].[Ausencias] WHERE id_per_cont = @id_periodo_contrato
		DELETE FROM [NOM].[Deducciones] WHERE id_per_cont = @id_periodo_contrato
		DELETE FROM [NOM].[Periodos_Por_Contrato] WHERE id_contrato = @id_contrato
		DELETE FROM [NOM].[Contrato] WHERE id = @id_contrato
	END
	ELSE
	BEGIN
		RAISERROR('No se puede eliminar', 16, 0)
	END


END TRY
BEGIN CATCH	
	IF (ERROR_NUMBER() = 547)
		SET @error =  'Error: No se puede eliminar porque hay una referencia hacia él.'
	ELSE
		SET @error =  'Error: '+ERROR_MESSAGE() + '; ' + CONVERT(VARCHAR(20),ERROR_NUMBER());

	RAISERROR(@error,16,0);	
END CATCH
