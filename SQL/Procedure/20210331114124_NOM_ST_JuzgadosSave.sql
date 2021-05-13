--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_JuzgadosSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_JuzgadosSave]
GO
CREATE PROCEDURE [NOM].[ST_JuzgadosSave]

@id BIGINT, 
@code VARCHAR(20),
@code_externo VARCHAR(20),
@detalle VARCHAR(MAX),
@id_user BIGINT

AS

/***************************************
*Nombre:		[NOM].[ST_JuzgadosSave]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		30/03/2021
*Desarrollador:  JPAREDES
*Descripcion:	Guarda o Actualiza la informacion de los Juzgados
***************************************/

DECLARE @error VARCHAR(MAX)
BEGIN TRY

	IF(ISNULL(@id,0) = 0)
	BEGIN

		INSERT INTO [NOM].[Juzgados] (codigo, codigo_externo, descripcion, estado, id_usercreated, id_userupdated) 
			SELECT @code, @code_externo, @detalle,0 , @id_user, @id_user

	END
	ELSE
	BEGIN

		UPDATE J
			SET J.codigo = @code,
				J.codigo_externo = @code_externo,
				J.descripcion = @detalle,
				J.id_userupdated = @id_user,
				J.updated = GETDATE()
		FROM [NOM].[Juzgados] J WHERE id = @id

	END
	

END TRY
BEGIN CATCH	
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);	
END CATCH
