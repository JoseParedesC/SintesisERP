--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_DiagnosticoState]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_DiagnosticoState]
GO
CREATE PROCEDURE [NOM].[ST_DiagnosticoState]

@id BIGINT, 
@id_user BIGINT

AS

/***************************************
*Nombre:		[NOM].[ST_DiagnosticoState]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		30/03/2021
*Desarrollador:  JPAREDES
*Descripcion:	Cambia el estado del Juzgado
***************************************/

DECLARE @error VARCHAR(MAX)
BEGIN TRY

	IF(ISNULL(@id,0) = 0)
		RAISERROR('No se encontró el registro', 16, 0)

		UPDATE D
			SET D.estado = CASE WHEN D.estado = 1 THEN 0 ELSE 1 END, 
				D.updated = GETDATE()
		FROM [NOM].[Diagnostico] D WHERE id = @id
	

END TRY
BEGIN CATCH	
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);	
END CATCH
