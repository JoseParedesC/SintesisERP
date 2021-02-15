--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CRE].[ST_AnalisisPersonaReferenciaEstado]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CRE].[ST_AnalisisPersonaReferenciaEstado]
GO
CREATE PROCEDURE [CRE].[ST_AnalisisPersonaReferenciaEstado]
	
	@estado BIT = 0,
	@id_referencia BIGINT = 0,
	@id_user BIGINT = 0
	

AS 

/*********************************************************
*Nombre:		[CRE].[AnalisisPersonaReferenciaEstado]
----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		28/11/2020
*Desarrollador: JPAREDES
*Descripcion:	Cambia el estado de analisis de la 
				referencia de una persona, de 
				'no analizado' a 'analizado'
***********************************************************/

DECLARE @error VARCHAR(MAX);

BEGIN TRY

		UPDATE [CRE].[Personas_Referencias]
			SET estado = CASE estado WHEN 0 THEN 1 ELSE 0 END,
				id_userupdated = @id_user
			WHERE id = @id_referencia

	SELECT estado,id FROM [CRE].[Personas_Referencias] WHERE id = @id_referencia

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