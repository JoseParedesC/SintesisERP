--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CRE].[ST_AnalisisPersonaReferenciaDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CRE].[ST_AnalisisPersonaReferenciaDelete]
GO
CREATE PROCEDURE [CRE].[ST_AnalisisPersonaReferenciaDelete]



@id BIGINT

AS 

/*********************************************************
*Nombre:		[CRE].[ST_AnalisisPersonaReferenciaDelete]
----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		20201202
*Desarrollador: JPAREDES
*Descripcion:	Eliminar la referencia de la persona tabla 
				PersonasRefrencias segun el id
***********************************************************/

DECLARE @error VARCHAR(MAX)

BEGIN TRY

	DELETE FROM [CRE].[Personas_Referencias] WHERE  id = @id

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