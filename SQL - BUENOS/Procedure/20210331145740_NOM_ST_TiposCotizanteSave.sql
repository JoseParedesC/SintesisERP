--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_TiposCotizanteSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_TiposCotizanteSave]
GO
CREATE PROCEDURE [NOM].[ST_TiposCotizanteSave]

@id BIGINT, 
@code VARCHAR(20),
@code_externo VARCHAR(20),
@detalle VARCHAR(MAX),
@id_subtipo VARCHAR(MAX),
@id_user BIGINT

AS


/********************************************
*Nombre:		[NOM].[ST_TiposCotizanteSave]
---------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		30/03/2021
*Desarrollador:  JPAREDES
*Descripcion:	Guarda o Actualiza la 
				informacion de los Tipos 
				de Cotiznte
********************************************/

DECLARE @error VARCHAR(MAX), @id_return BIGINT, @IDsubtipo BIGINT;
DECLARE @temp TABLE (id_pk BIGINT IDENTITY, id_subtipo BIGINT)
BEGIN TRY

	IF EXISTS(SELECT 1 FROM [NOM].[TiposCotizante] WHERE codigo = @code AND id != @id)
			RAISERROR('El codigo ya se encuentra registrado', 16, 0)


	IF EXISTS(SELECT 1 FROM [NOM].[TiposCotizante] WHERE codigo_externo = @code_externo AND id != @id)
		RAISERROR('El codigo externo ya se encuentra registrado', 16, 0)


	IF(ISNULL(@id,0) = 0)
	BEGIN
		
		INSERT INTO [NOM].[TiposCotizante] (codigo, codigo_externo, descripcion, estado, id_usercreated, id_userupdated, detalle)
			SELECT @code, @code_externo, @detalle,1 , @id_user, @id_user, 1

		SET @id_return = SCOPE_IDENTITY()

		INSERT INTO [NOM].[Tipos_SubtiposCotizantes] (id_tipo, id_subtipo, id_usercreated, created, id_userupdated) SELECT @id_return, item, @id_user, GETDATE(), @id_user FROM [dbo].[ST_FnTextToTable](@id_subtipo,',')
	END
	ELSE
	BEGIN

		SET @IDsubtipo = (SELECT TS.id_subtipo FROM [NOM].[Tipos_SubtiposCotizantes] TS INNER JOIN [NOM].[Contrato] C ON C.id_tipo_cotizante = TS.id WHERE TS.id_tipo = @id)

		INSERT INTO @temp (id_subtipo)
			SELECT item FROM [dbo].[ST_FnTextToTable](@id_subtipo,',')


		IF EXISTS(SELECT 1 WHERE ISNULL(@IDsubtipo,0) != 0 AND (CASE WHEN EXISTS(SELECT 1 FROM @temp WHERE id_subtipo = @IDsubtipo OR ISNULL(@IDsubtipo,0) = 0) THEN 0 ELSE 1 END) != 0)
			RAISERROR('Hay un subtipo que se está usando que no se puede eliminar', 16, 0)


		UPDATE [NOM].[TiposCotizante]
			SET codigo = @code,
				codigo_externo = @code_externo,
				descripcion = @detalle,
				id_userupdated = @id_user,
				detalle = 1,
				updated = GETDATE()
		WHERE id = @id

		DELETE FROM [NOM].[Tipos_SubtiposCotizantes] WHERE id_tipo = @id AND (CASE WHEN id_subtipo != ISNULL(@IDsubtipo,0) THEN 0 ELSE 1 END) = 0

		INSERT INTO [NOM].[Tipos_SubtiposCotizantes] (id_tipo, id_subtipo, id_userupdated, updated, id_usercreated) SELECT @id, item, @id_user, GETDATE(), @id_user FROM [dbo].[ST_FnTextToTable](@id_subtipo,',') WHERE (CASE WHEN item != ISNULL(@IDsubtipo,0) THEN 0 ELSE 1 END) = 0
		

	END
	

END TRY
BEGIN CATCH	
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);	
END CATCH

