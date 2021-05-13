--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_SubtiposCotizanteSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_SubtiposCotizanteSave]
GO
CREATE PROCEDURE [NOM].[ST_SubtiposCotizanteSave]

@id BIGINT, 
@code VARCHAR(20),
@code_externo VARCHAR(20),
@detalle VARCHAR(MAX),
@id_user BIGINT

AS


/***************************************************
*Nombre:		[NOM].[ST_SubtiposCotizanteSave]
----------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		30/03/2021
*Desarrollador:  JPAREDES
*Descripcion:	Guarda o Actualiza la informacion 
				de los Tipos de Cotiznte
***************************************************/

DECLARE @error VARCHAR(MAX)
BEGIN TRY

	
	IF EXISTS(SELECT 1 FROM [NOM].[TiposCotizante] WHERE codigo = @code AND id != ISNULL(@id,0))
			RAISERROR('El codigo ya se encuentra registrado', 16, 0)


	IF EXISTS(SELECT 1 FROM [NOM].[TiposCotizante] WHERE codigo_externo = @code_externo AND id != ISNULL(@id,0))
		RAISERROR('El codigo externo ya se encuentra registrado', 16, 0)


	IF(ISNULL(@id,0) = 0)
	BEGIN

		INSERT INTO [NOM].[SubtiposCotizante] (codigo, codigo_externo, descripcion, estado, id_usercreated, id_userupdated) 
			SELECT @code, @code_externo, @detalle, 1, @id_user, @id_user

	END
	ELSE
	BEGIN

		UPDATE T
			SET T.codigo = @code,
				T.codigo_externo = @code_externo,
				T.descripcion = @detalle,
				T.id_userupdated = @id_user,
				T.updated = GETDATE()
		FROM [NOM].[SubtiposCotizante] T WHERE T.id = @id

	END
	

END TRY
BEGIN CATCH	
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);	
END CATCH
