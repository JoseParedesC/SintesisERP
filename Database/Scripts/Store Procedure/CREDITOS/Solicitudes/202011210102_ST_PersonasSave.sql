--liquibase formatted sql
--changeset ,jarciniegas:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id =
OBJECT_ID(N'[CRE].[ST_PersonasSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1) DROP PROCEDURE [CRE].[ST_PersonasSave]
GO
CREATE PROCEDURE [CRE].[ST_PersonasSave]

@id BIGINT OUTPUT,
@id_solicitud BIGINT,
@tipo CHAR (2) ,
@tipoper INT , --
@pnombre VARCHAR (50) , --
@snombre VARCHAR (50) = NULL, --
@papellido VARCHAR (50) , --
@sapellido VARCHAR (50) = NULL,--
@id_tipoiden INT , --
@iden VARCHAR (20) , --
@genero INT , --
@estrato INT , --
@estadocivil INT , --
@percargo INT , --
@celular VARCHAR (20) ,-- 
@otro VARCHAR (20) = NULL, --
@ciudad INT ,--
@direccion VARCHAR (120) ,--
@correo VARCHAR (120) , --
@viveinmu INT , --
@valorinm NUMERIC = NULL,--
@verificacion CHAR (1),--
@urlperfil VARCHAR (MAX) = NULL,--
@urlimgper VARCHAR (MAX) = NULL,--
@observaciones VARCHAR (MAX), 
@id_user BIGINT, --
@id_escolaridad BIGINT --



AS

/***************************************
*Nombre 		[CRE].[ST_PersonasSave]
----------------------------------------
*Tipo 			Procedimiento almacenado
*creaci�n 		21/11/2020
*Desarrollador  (JARCINIEGAS)
*DESCRIPCI�N 	Recibe la informaci�n ba-
				sica de la persona para 
				guardarla o actualizarla 
				en la tabla [CRE].[Personas]
***************************************/

BEGIN TRANSACTION
BEGIN TRY

	DECLARE  @id_return INT, @error VARCHAR(MAX), @error1 VARCHAR(MAX), @imgante VARCHAR(MAX);
	--la validacion se debe hacer  con la tabla intermedia entre solicitud y personas, cosas que si ya la persona tiene 
	--un vinculo con la solicitud, no se cree


	
	
	--IF NOT EXISTS (SELECT 1 FROM [CRE].[Personas_Solicitud]
	--WHERE (id_solicitud != ISNULL(@id_solicitud,0) AND id_persona != ISNULL(@id,0)) OR 
	--	  (id_solicitud = ISNULL(@id_solicitud,0) AND id_persona != ISNULL(@id,0)))

	--IF EXISTS(SELECT 1 FROM [CRE].[Solicitud_Personas] 
	--WHERE (id_persona = ISNULL(@id,0) AND id_solicitud != ISNULL(@id_solicitud,0))) 
	--BEGIN
	--SET @error1 = 'Verifique ID, el cliente '+
	--(select ISNULL(primernombre, '') from cre.Personas where id=@id)+' no tiene solicitud o la solicitud '+
	--(select isnull(consecutivo,'') from cre.Solicitudes where id = @id_solicitud)+' ya tiene un cliente';
	--RAISERROR(@error1,16,0);		
	--END
	
	IF(Isnull(@id,0) = 0)
	BEGIN
					   
			INSERT INTO [CRE].[Personas] (tipo_persona, id_tipoiden, identificacion, primernombre, segundonombre, primerapellido, 
											segundoapellido, id_ciudad, direccion, celular, otrotel, correo, id_viveinmueble, 
											valorarriendo, digverificacion, percargo, id_genero, id_estrato, id_estadocivil, 
											 id_escolaridad,id_usercreated, id_userupdated, tipo_tercero)

			VALUES(@tipoper, @id_tipoiden, @iden, @pnombre, @snombre, @papellido, @sapellido, 
			@ciudad, @direccion, @celular, @otro, @correo, @viveinmu, @valorinm, @verificacion, @percargo, @genero,
			@estrato, @estadocivil, @id_escolaridad, @id_user, @id_user, @tipo)
		
			SET @id = SCOPE_IDENTITY();
	
	END
	ELSE
	BEGIN
		
			
		UPDATE  [CRE].[Personas]
		SET tipo_persona	= @tipoper,
			id_tipoiden		= @id_tipoiden,
			identificacion	= @iden,
			primernombre	= @pnombre,
			segundonombre	= @snombre,
			primerapellido	= @papellido,
			segundoapellido	= @sapellido,
			id_ciudad		= @ciudad,
			direccion		= @direccion,
			celular			= @celular,
			otrotel			= @otro,
			correo			= @correo,
			id_viveinmueble	= @viveinmu,
			valorarriendo	= @valorinm,
			digverificacion	= @verificacion,
			percargo		= @percargo,
			id_genero		= @genero,
			id_estrato		= @estrato,
			id_estadocivil	= @estadocivil,
			id_escolaridad	= @id_escolaridad,
			id_userupdated	= @id_user,
			updated			= GETDATE()
		WHERE id = @id;;

		set @id_return = @id;		


	END

	
	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	SET @error = 'Errors  '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);		
	ROLLBACK TRANSACTION;
END CATCH

--SELECT @id_return id ;
