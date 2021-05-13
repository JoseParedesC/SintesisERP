--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_SedesState]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_SedesState]
GO
CREATE PROCEDURE [NOM].[ST_SedesState]

@id BIGINT, 
@id_user BIGINT

AS

/***************************************
*Nombre:		[NOM].[ST_SedesState]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		30/03/2021
*Desarrollador:  JPAREDES
*Descripcion:	Cambia el estado de la Sede
***************************************/

DECLARE @error VARCHAR(MAX)
BEGIN TRY

	IF(ISNULL(@id,0) = 0)
		RAISERROR('No se encontró el registro', 16, 0)

		UPDATE S
			SET S.estado = CASE WHEN S.estado = 1 THEN 0 ELSE 1 END, 
				S.updated = GETDATE()
		FROM [NOM].[Sedes] S WHERE id = @id
	

END TRY
BEGIN CATCH	
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);	
END CATCH
