--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[TercerosSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE CNT.TercerosSave
GO
CREATE PROCEDURE [CNT].[TercerosSave]
@id					BIGINT = null,
@tipoperso			INT, 
@iden				VARCHAR(50), 
@tipoiden			INT, 
@digitoveri			char(1),
@id_catfiscal		BIGINT,
@primernombre		VARCHAR(50), 
@segundonombre		VARCHAR(50), 
@primerapellido		VARCHAR(50), 
@segundoapellido	VARCHAR(50), 
@razonsocial		VARCHAR(100),
@sucursal			VARCHAR(50),
@tiporegimen		BIT,
@nombrecomercio		VARCHAR(50),
@pageweb			VARCHAR(50),
@fechaexpedicion	varchar(10),
@fechanacimiento	varchar(10),
@direccion			VARCHAR(100), 
@telefono			VARCHAR(50), 
@celular			VARCHAR(50), 
@email				VARCHAR(100),
@id_ciudad			BIGINT,
@nombrecontacto		VARCHAR(200),
@telefonocontacto	VARCHAR(20),
@emailcontacto		VARCHAR(100),
@tiposTercero		VARCHAR(MAX),
@id_user			int

--WITH ENCRYPTION
AS

/***************************************
*Nombre:		[dbo].[TercerosSave]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		04/11/19
*Desarrollador: (Jeteme)
***************************************/

BEGIN TRANSACTION
BEGIN TRY

	DECLARE @id_return INT, @error VARCHAR(MAX),@index int,@mydoc xml,@idoc INT,@id_Tipoterce bigint, @coderror int;
	If EXISTS (SELECT 1 FROM CNT.Terceros WHERE iden = @iden and id != ISNULL(@id,0))
		RAISERROR('Ya existe tercero con esta identificación.', 16, 0);
	
	SET @mydoc = @tiposTercero;
	EXEC sp_xml_preparedocument @idoc OUTPUT, @mydoc

	IF(ISNULL(@id,0) = 0)
	BEGIN		
		INSERT INTO CNT.Terceros(id_personeria,tipoiden, iden,digitoverificacion,id_catfiscal ,primernombre, segundonombre, primerapellido, segundoapellido,razonsocial,sucursal,tiporegimen,nombrecomercial,paginaweb,fechaexpedicion,fechanacimiento, direccion,email, telefono, celular, id_ciudad,nombrescontacto,telefonocontacto,emailcontacto, id_usercreated,id_userupdated)
		VALUES(@tipoperso,@tipoiden, @iden,@digitoveri,CASE WHEN @id_catfiscal = 0 THEN NULL ELSE @id_catfiscal END, @primernombre, @segundonombre, @primerapellido, @segundoapellido,REPLACE(@razonsocial, '  ',' '), @sucursal,@tiporegimen,@nombrecomercio,@pageweb,@fechaexpedicion,@fechanacimiento,@direccion,@email, @telefono, @celular, @id_ciudad,@nombrecontacto,@telefonocontacto,@emailcontacto, @id_user,@id_user);
				
		SET @id_return = SCOPE_IDENTITY();
		
		INSERT INTO CNT.TipoTerceros(id_tercero,id_tipotercero,id_usercreated,id_userupdated)
		SELECT @id_return, id, @id_user, @id_user
		FROM ST_Listados WHERE id = dbo.ST_FnGetIdList('TC')
	END	
	ELSE
	BEGIN
		UPDATE CNT.Terceros
		SET
			id_personeria		= @tipoperso,
			tipoiden			= @tipoiden, 
			iden				= @iden, 
			digitoverificacion	= @digitoveri,
			id_catfiscal		= CASE WHEN @id_catfiscal = 0 THEN NULL ELSE @id_catfiscal END,
			primernombre		= @primernombre, 
			segundonombre		= @segundonombre, 
			primerapellido		= @primerapellido, 
			segundoapellido		= @segundoapellido,
			razonsocial			= @razonsocial,
			sucursal			= @sucursal,
			tiporegimen			= @tiporegimen,
			nombrecomercial		= @nombrecomercio,
			paginaweb			= @pageweb,
			fechaexpedicion		= @fechaexpedicion,
			fechanacimiento		= @fechanacimiento,
			direccion			= @direccion, 
			email				= @email,
			telefono			= @telefono, 
			celular				= @celular, 
			id_ciudad			= @id_ciudad,
			nombrescontacto		= @nombrecontacto,
			@telefonocontacto	= @telefonocontacto,
			@emailcontacto		= @emailcontacto,	
			id_userupdated		= @id_user,
			updated				= GETDATE()
		WHERE id = @id;
			
		SET @id_return = @id;			

	END
	
	INSERT INTO CNT.TipoTerceros(id_tercero,id_tipotercero,id_usercreated,id_userupdated)	
	SELECT @id_return, id_tipo, @id_user, @id_user
	FROM OPENXML(@idoc,N'tipoterceros/tipo') 
	WITH (id_tipo INT '@id_tipo') TT
	LEFT JOIN CNT.TipoTerceros T ON T.id_tipotercero = TT.id_tipo AND T.id_tercero = @id
	WHERE T.id IS NULL
	

COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);		
	ROLLBACK TRANSACTION;
END CATCH

SELECT @id_return;