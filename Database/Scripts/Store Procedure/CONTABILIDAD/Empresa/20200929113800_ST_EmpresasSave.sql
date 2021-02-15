--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_EmpresasSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_EmpresasSave]
GO

CREATE PROCEDURE [dbo].[ST_EmpresasSave]
@id				BIGINT = null,
@razon			VARCHAR(200),
@nit			VARCHAR(200),
@direccion		VARCHAR(200),
@telefono		VARCHAR(200),
@ciudad			BIGINT,
@email			VARCHAR(200),
@urlimg			VARCHAR(200),
@urlimgrpt		VARCHAR(200),
@softid			VARCHAR(100),
@softpin		VARCHAR(100),
@softtecnikey	VARCHAR(200),
@digveri		INT,
@carpeta		VARCHAR(100),
@certificado	VARCHAR(100),
@clavecer		VARCHAR(100),
@tipoamb		INT, 
@testid			VARCHAR(100),
@id_tipoid		BIGINT,
@nombrecomercial VARCHAR(250) = '',
@id_user		INT

--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_EmpresasSave]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		14/01/19
*Desarrollador: (JTOUS)
***************************************/
BEGIN TRANSACTION
BEGIN TRY

	DECLARE @id_return INT, @error VARCHAR(MAX);
	IF EXISTS (SELECT 1 FROM dbo.Empresas A WHERE A.razonsocial = @razon AND id <> ISNULL(@id,0))
	BEGIN
		RAISERROR('Ya existe Empresa con este nombre...', 16,0);
	END
	
	IF(Isnull(@id,0) = 0)
	BEGIN
		INSERT INTO dbo.Empresas (razonsocial, nit, digverificacion,  id_ciudad, direccion, telefono, email, urlimg, urlimgrpt, softid, softpin, softtecnikey, id_usercreated, id_userupdated,
		carpetaname, certificatename, passcertificate, tipoambiente, testid, id_tipoid)--, nombrecomercial)
		VALUES(@razon, @nit, @digveri, @ciudad, @direccion, @telefono, @email, @urlimg, @urlimgrpt, @softid, @softpin, @softtecnikey, @id_user, @id_user,
		@carpeta, @certificado, @clavecer, @tipoamb, @testid, @id_tipoid)--, @nombrecomercial)
		
		SET @id_return = SCOPE_IDENTITY();

	END
	ELSE
	BEGIN
		UPDATE dbo.Empresas 
		SET 
			razonsocial		= @razon,
			nit				= @nit,
			digverificacion	= @digveri,
			carpetaname		= @carpeta, 
			certificatename	= @certificado, 
			passcertificate = @clavecer, 
			tipoambiente	= @tipoamb, 
			testid			= @testid,
			telefono		= @telefono,
			direccion		= @direccion,
			email			= @email,
			id_ciudad		= @ciudad,
			urlimg			= CASE WHEN @urlimg = '' THEN urlimg ELSE @urlimg END,
			urlimgrpt		= CASE WHEN @urlimgrpt = '' THEN urlimg ELSE @urlimgrpt END,
			softid			= @softid,
			softpin			= @softpin,
			softtecnikey	= @softtecnikey,
			id_userupdated	= @id_user,
			updated			= GETDATE(),
			id_tipoid		= @id_tipoid,
			nombrecomercial = @nombrecomercial
		WHERE id = @id;
			
		set @id_return = @id
	END	

	SET @nit += '-'+@digveri;

	EXECUTE [Dbo].ST_EmpresaSave	@razon = @razon,
									@nit = @nit,
									@direccion = @direccion,
									@telefono = @telefono,
									@ciudad = @ciudad,
									@admin = '',
									@teladmin = '',
									@mailadmin = '',
									@urlimg = @urlimg,
									@urlimgrpt = @urlimgrpt,
									@id_user = @id_user,
									@nombrecomercial = @nombrecomercial
	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);		
	ROLLBACK TRANSACTION;
END CATCH

SELECT @id_return;
	
	
	
			