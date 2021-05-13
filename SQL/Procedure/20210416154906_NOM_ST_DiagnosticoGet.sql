--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_DiagnosticoGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_DiagnosticoGet]
GO
CREATE PROCEDURE [NOM].[ST_DiagnosticoGet]

@id BIGINT, 
@id_user BIGINT

AS

/***************************************
*Nombre:		[NOM].[ST_DiagnosticoGet]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		30/03/2021
*Desarrollador:  JPAREDES
*Descripcion:	Obtiene la informacion del los Diagnosticos
***************************************/
DECLARE @error VARCHAR(MAX)

BEGIN TRY

	IF(ISNULL(@id,0) = 0)
		RAISERROR('No se ha encontrado el Diagnostico',16,0)

	SELECT J.id, J.codigo, J.descripcion FROM [NOM].[Diagnostico] J WHERE id = @id
	

END TRY
BEGIN CATCH	
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);	
END CATCH
