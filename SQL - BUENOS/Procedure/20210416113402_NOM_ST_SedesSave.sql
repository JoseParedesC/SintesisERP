--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_SedesSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_SedesSave]
GO
CREATE PROCEDURE [NOM].[ST_SedesSave]

@id BIGINT, 
@nombre VARCHAR(20),
@id_ciudad BIGINT,
@id_user BIGINT

AS

/***************************************
*Nombre:		[NOM].[ST_SedesSave]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		30/03/2021
*Desarrollador:  JPAREDES
*Descripcion:	Guarda o Actualiza la informacion de las Sedes
***************************************/

DECLARE @error VARCHAR(MAX)
BEGIN TRY

	IF(ISNULL(@id,0) = 0)
	BEGIN

		INSERT INTO [NOM].[Sedes] (nombre, id_ciudad, estado, id_usercreated, id_userupdated) 
			SELECT @nombre, @id_ciudad, 0, @id_user, @id_user

	END
	ELSE
	BEGIN

		UPDATE S
			SET S.nombre = @nombre,
				S.id_ciudad = @id_ciudad,
				S.id_userupdated = @id_user,
				S.updated = GETDATE()
		FROM [NOM].[Sedes] S WHERE id = @id

	END
	

END TRY
BEGIN CATCH	
	SET @error = 'Error: '+ ERROR_MESSAGE();
	RAISERROR(@error,16,0);	
END CATCH
