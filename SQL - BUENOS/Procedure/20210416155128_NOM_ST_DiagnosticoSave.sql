--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_DiagnosticoSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_DiagnosticoSave]
GO
CREATE PROCEDURE [NOM].[ST_DiagnosticoSave]

@id BIGINT, 
@code VARCHAR(20),
@descripcion VARCHAR(max),
@id_user BIGINT

AS

/***************************************
*Nombre:		[NOM].[ST_DiagnosticoSave]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		30/03/2021
*Desarrollador:  JPAREDES
*Descripcion:	Guarda o Actualiza la informacion de los Diagnosticos
***************************************/

DECLARE @error VARCHAR(MAX)
BEGIN TRY

	IF(ISNULL(@id,0) = 0)
	BEGIN

		INSERT INTO [NOM].[Diagnostico] (codigo, descripcion, estado, id_usercreated, id_userupdated) 
			SELECT @code, @descripcion, 0 , @id_user, @id_user

	END
	ELSE
	BEGIN

		UPDATE D
			SET D.codigo = @code,
				D.descripcion = @descripcion,
				D.id_userupdated = @id_user,
				D.updated = GETDATE()
		FROM [NOM].[Diagnostico] D WHERE id = @id

	END
	

END TRY
BEGIN CATCH	
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);	
END CATCH
