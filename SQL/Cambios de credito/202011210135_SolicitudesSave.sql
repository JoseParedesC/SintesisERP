--liquibase formatted sql
--changeset ,jarciniegas:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id =
OBJECT_ID(N'[CRE].[ST_SolicitudesSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1) DROP PROCEDURE [CRE].[ST_SolicitudesSave]
GO
CREATE PROCEDURE [CRE].[ST_SolicitudesSave]
@id					BIGINT = null,
@id_cotizacion		BIGINT  , --
@id_empresa			BIGINT = 0, --
@connombre			VARCHAR  (250)  , --
@contelefono		VARCHAR  (20)  ,--
@conempresa			VARCHAR  (150)  , --
@consalario			NUMERIC  , --
@tipoempleo			INT, --
@empresalab			VARCHAR  (120)  ,--
@direccionem		VARCHAR  (120)  , --
@telefonoemp		VARCHAR  (20)  , --
@cargoempr			VARCHAR  (50)  , --
@tiempoemp			INT  , --
@salarioemp			NUMERIC  , --
@otrosing			NUMERIC  , --
@concepto			VARCHAR  (50) =null , --
@referencias		XML = NULL , --
@id_solicitud		BIGINT,--
@tipo				char(2) ,
@tipoper			int , --
@pnombre			VARCHAR (50) ,--
@snombre			VARCHAR (50) = NULL, --
@papellido			VARCHAR (50) , --
@sapellido			VARCHAR (50) = NULL, --
@id_tipoiden		INT , --
@iden				VARCHAR (20) , --
@genero				INT , --
@estrato			INT , --
@estadocivil		INT , --
@percargo			INT , --
@celular			VARCHAR (20) , --
@otro				VARCHAR (20) = NULL, --
@ciudad				INT , --
@direccion			VARCHAR (120) ,--
@correo				VARCHAR (120) , --
@viveinmu			INT , --
@valorinm			NUMERIC = NULL,--
@verificacion		CHAR (1) ,--
@urlperfil			VARCHAR (MAX) = NULL ,--
@urlimgper			VARCHAR (MAX) = NULL ,--
@observaciones		VARCHAR (MAX), --	
@id_user			BIGINT, --
@id_escolaridad		BIGINT,
@detalleobser		VARCHAR(500)



AS

/*****************************************
*Nombre 		[CRE].[ST_SolicitudesSave]
----------------------------------------
*Tipo 			Procedimiento almacenado
*creaci�n 		21/11/2020
*Desarrollador  (JARCINIEGAS)
*DESCRIPCI�N 	Guarda y/o la informaci�n capt-
				ada en el formulario de sol-
				icitud en las tablas 
				CRE.Solicitudes, 
				CRE.Solicitud_Personas, 
				CRE.Personas_Adicionales, 
				CRE.Personas_Referencias, 
				CRE.Consecutivo y envia los 
				datos a el procedimiento 
				CRE.ST_PersonasSave para gua-
				rdar la informaci�n en 
				CRE.Personas
*****************************************/

BEGIN TRANSACTION
BEGIN TRY
	DECLARE @manejador INT, @existe BIT= 0;
	DECLARE  @id_return INT, @error VARCHAR(MAX);
	DECLARE @reftab TABLE (id INT IDENTITY(1,1), id_ INT, id_solicitud INT, nombre VARCHAR(100), direccion VARCHAR(150), telefono VARCHAR(20), id_tiporef INT, id_usercreated INT, id_userupdated INT, id_parentezco INT);


	IF NOT EXISTS (SELECT 1 FROM [dbo].[MOVCotizacion] C INNER JOIN [CNT].[Terceros] CC ON C.id_cliente = CC.id WHERE C.id = @id_cotizacion AND CC.iden = @iden) AND @tipo = 'CL'
	BEGIN
		RAISERROR('La cotizaci�n no pertenece al solicitante.', 16, 0);
	END
	IF EXISTS (SELECT 1 FROM CRE.Personas WHERE id = @id)
	BEGIN
	SET @existe = 1
	END

	EXECUTE [CRE].[ST_PersonasSave]  
			--Datos Personales
			@id_solicitud	= @id_solicitud, 
			@id				= @id OUTPUT, 
			@tipo			= @tipo, 
			@tipoper		= @tipoper, 
			@pnombre		= @pnombre, 
			@snombre		= @snombre, 
			@papellido		= @papellido, 
			@sapellido		= @sapellido,
			@id_tipoiden	= @id_tipoiden, 
			@iden			= @iden, 
			@genero			= @genero, 
			@estrato		= @estrato, 
			@estadocivil	= @estadocivil, 
			@percargo		= @percargo, 
			@celular		= @celular, 
			@otro			= @otro, 
			@ciudad			= @ciudad, 
			@direccion		= @direccion, 
			@correo			= @correo, 
			@viveinmu		= @viveinmu, 
			@valorinm		= @valorinm, 
			@verificacion	= @verificacion, 
			@urlperfil		= @urlperfil, 
			@urlimgper		= @urlimgper, 
			@observaciones	= @observaciones, 
			@id_user		= @id_user, 
			@id_escolaridad = @id_escolaridad;
	
		
		UPDATE C
			SET C.observaciones = @detalleobser
		FROM [dbo].[MOVCotizacion] C INNER JOIN 
			 [CRE].[Solicitudes] S ON S.id_cotizacion = C.id
		WHERE S.id = @id_solicitud
	
	--VERIFICA QUE EN LA SOLICITUD EL CLIENTE NO SEA EL MISMO CODEUDOR 
	IF (EXISTS (SELECT 1 FROM [CRE].[Solicitud_Personas] PS 
				LEFT JOIN [CRE].[Personas] P ON P.id = PS.id_persona 
				WHERE id_solicitud = @id_solicitud AND P.identificacion = @iden AND P.tipo_tercero = 'CL') AND @tipo = 'CO')
	BEGIN
	RAISERROR('No puede meter al mismo cliente como codeudor.',16,0);
	END


	IF (EXISTS(SELECT 1 FROM [CRE].[Solicitud_Personas] PS 
				INNER JOIN [CRE].[Personas] P ON P.id = PS.id_persona
				WHERE id_solicitud = @id_solicitud AND id_persona != @id AND P.identificacion = @iden AND P.tipo_tercero = 'CO') AND @tipo = 'CO')
	BEGIN
	RAISERROR('No puede meter al mismo codeudor 2 veces.',16,0);
	END


	--GUARDA O ACTUALIZA INFORMACION EN LA TABLA DE SOLICITUDES 
	IF(ISNULL(@id_solicitud,0) = 0)
	BEGIN			   



		--VERIFICA QUE EL CLIENTE NO SE GUARDE 2 VECES CON LA MISMA SOLICITUD
		IF EXISTS (SELECT 1 FROM [CRE].[Solicitud_Personas] PR
		LEFT JOIN [CRE].[Personas] P ON P.id = PR.id_persona
		WHERE ( id_persona = ISNULL(@id,0)) AND P.tipo_tercero = 'CL' AND PR.id_solicitud = @id_solicitud)
		BEGIN
			RAISERROR('Verifique ID, ya existe esta Solicitud con este cliente...', 16,0);
		END
		

		--GUARDA INFORMACION EN LA TABLA DE SOLICITUDES 
		INSERT INTO [CRE].[Solicitudes] (consecutivo, fechasolicitud, estado, id_cotizacion, id_estacion, id_userasign,id_usercreated, id_userupdated)
		VALUES([CRE].[ST_FnConsecutivoSolicitud](1,'credito'), GETDATE(), (SELECT dbo.ST_FnGetIdList('SOLICIT')), @id_cotizacion, 3, @id_user, @id_user, @id_user)

		SET @id_solicitud = SCOPE_IDENTITY();

		IF NOT EXISTS (SELECT 1 FROM [CRE].[Consecutivo]where tipo = 'credito')
		INSERT INTO [CRE].[Consecutivo] (consecutivo, id_estacion, id_user, tipo) VALUES (0, 1, @id_user, 'credito')
		UPDATE [CRE].[Consecutivo] SET consecutivo = consecutivo + 1 where tipo = 'credito';;

		--GUARDA LA CONEXION CON LAS TABLAS PERSONAS Y SOLICITUDES
		INSERT INTO [CRE].[Solicitud_Personas] (id_persona, id_solicitud)
		VALUES (@id, @id_solicitud)


	END ELSE
	BEGIN
	
		--ACTUALIZA INFORMACION EN LA TABLA DE SOLICITUDES
		UPDATE  [CRE].[Solicitudes]
		SET   
			id_estacion = 1, 
			id_userasign = @id_user, 
			id_userupdated = @id_user,
			updated			= GETDATE()
		WHERE id = @id_solicitud;;



		IF NOT EXISTS(SELECT 1 FROM [CRE].[Solicitud_Personas] WHERE id_persona = @id AND id_solicitud = @id_solicitud)
		BEGIN
			INSERT INTO [CRE].[Solicitud_Personas] (id_persona, id_solicitud)
			VALUES (@id, @id_solicitud)
		END

		
		IF (@existe = 1 and @tipo = 'CL')
		BEGIN
			--GUARDA LA CONEXION CON LAS TABLAS PERSONAS Y SOLICITUDES
			IF EXISTS(SELECT 1 FROM [CRE].[Solicitud_Personas] PS 
			RIGHT JOIN CRE.Personas P ON P.id = PS.id_persona
			WHERE PS.id_persona != @id AND PS.id_solicitud = @id_solicitud AND P.tipo_tercero = 'CL')
			BEGIN
				RAISERROR ('Esta Solicitud ya tiene un cliente',16,0)
			END
		END
	END
	
	
	IF NOT EXISTS(SELECT 1 FROM [CRE].[Personas_Adicionales] WHERE id_persona = @id)
	BEGIN
		--GUARDA INFORMACION EN LA TABLA DE PERSONAS ADICIONALES (validar los if, brindar mejor proteccion)
		INSERT INTO [CRE].[Personas_Adicionales] (id_persona, 
												 id_solicitud, 
												 connombre, 
												 contelefono, 
												 conempresa, 
												 consalario, 
												 id_tipoemp, 
												 empresalab, 
												 direccionemp, 
												 telefonoemp,
												 cargo, 
												 id_tiempoemp, 
												 salarioemp, 
												 otroingreso, 
												 concepto, 
												 estado, 
												 id_usercreated, 
												 id_userupdated)
		VALUES( @id, 
				@id_solicitud, 
				@connombre, 
				@contelefono, 
				@conempresa, 
				@consalario, 
				@tipoempleo, 
				@empresalab, 
				@direccionem, 
				@telefonoemp, 
				@cargoempr, 
				@tiempoemp, 
				@salarioemp, 
				@otrosing, 
				@concepto, 
				(SELECT dbo.ST_FnGetIdList('SOLICIT')), 
				@id_user, 
				@id_user)
		END
		ELSE 
	BEGIN
		--ACTUALIZA INFORMACION EN LA TABLA DE PERSONAS ADICIONALES (validar los if, brindar mejor proteccion)
		UPDATE  [CRE].[Personas_Adicionales]
		SET	[id_solicitud]		= @id_solicitud,
			[connombre]			= @connombre,
			[contelefono]		= @contelefono,
			[conempresa]		= @conempresa,
			[consalario]		= @consalario,
			[empresalab]		= @empresalab,
			[direccionemp]		= @direccionem,
			[telefonoemp]		= @telefonoemp,
			[cargo]				= @cargoempr,
			[id_tiempoemp]		= @tiempoemp,
			[salarioemp]		= @salarioemp,
			[otroingreso]		= @otrosing,
			[concepto]			= @concepto,
			[id_userupdated]	= @id_user,
			--[id_sector]			=, preguntar a jose por el sector
			--[id_tipoact]		=,
			updated				= GETDATE()
		WHERE id_persona = @id;;

		END



	IF NOT EXISTS(SELECT 1 FROM [CRE].[Personas_Referencias] WHERE id_persona = @id AND id_solicitud = @id_solicitud)
	BEGIN
		EXEC sp_xml_preparedocument @manejador OUTPUT, @referencias; 				
								
		INSERT INTO [CRE].[Personas_Referencias](id_persona, id_solicitud, nombre, direccion, telefono, id_tiporef, id_usercreated, id_userupdated, id_parentezco)
		SELECT @id, @id_solicitud, nombre, direccion, telefono, tipo,  @id_user, @id_user, parentezco  
		FROM OPENXML(@manejador, N'items/item') 
		WITH (  nombre VARCHAR(250) '@nombre',
				direccion VARCHAR(250) '@direccion',
				telefono VARCHAR(20) '@telefono',
				tipo [BIGINT] '@tipo',
				parentezco [BIGINT] '@parentezco'
		) AS P;

		EXEC sp_xml_removedocument @manejador;

     END
	 ELSE
	 BEGIN
	
	 
		--GUARDA PROVISIONALMENTE INFORMACION EN LA TABLA DE PERSONAS REFERENCIAS EN UNA TABLA TEMPORAL   
		EXEC sp_xml_preparedocument @manejador OUTPUT, @referencias; 				
								
		INSERT INTO @reftab(id_, id_solicitud, nombre, direccion, telefono, id_tiporef, id_usercreated, id_userupdated, id_parentezco)
		SELECT id, @id_solicitud, nombre, direccion, telefono, tipo,  @id_user, @id_user, parentezco  
		FROM OPENXML(@manejador, N'items/item') 
		WITH (  id int '@id',
				nombre VARCHAR(250) '@nombre',
				direccion VARCHAR(250) '@direccion',
				telefono VARCHAR(20) '@telefono',
				tipo [BIGINT] '@tipo',
				parentezco [BIGINT] '@parentezco'
		) AS P;

		EXEC sp_xml_removedocument @manejador;

	--ELIMINA TODOS LOS CAMPOS QUE TIENE LA TABLA IGUALES A LOS QUE SE MANDARON
	DELETE RF FROM [CRE].[Personas_Referencias] RF LEFT JOIN @reftab TAB ON RF.id = TAB.id_ 
	WHERE id_persona = @id AND RF.id_solicitud = @id_solicitud AND TAB.id IS NULL;

	--AGREGA LA INFORMACION DE LA TABLA TEMPORAL EN LA TABLA
	INSERT INTO [CRE].[Personas_Referencias] (id_persona, id_solicitud, nombre, direccion, telefono, id_tiporef, id_usercreated, id_userupdated, id_parentezco)
	SELECT @id, @id_solicitud, nombre, direccion, telefono, id_tiporef,  @id_user, @id_user, id_parentezco 
	FROM @reftab WHERE id_ = 0

	
	
	END




	UPDATE [dbo].[MOVCotizacion] SET estado = (SELECT [dbo].[ST_FnGetIdList] ('UTILIZ')) WHERE id = @id_cotizacion;


	SELECT top 1 S.id, (CONVERT(VARCHAR(10),C.id)+' - '+C.cliente) cotizacion, S.estado, CONVERT(VARCHAR(10), fechasolicitud,120) fecha, consecutivo, 
	p.id clavesolicitud , P.id_persona
	FROM [CRE].[Solicitudes] S
	INNER JOIN dbo.VW_MOVCotizaciones C ON C.id = S.id_cotizacion
	INNER JOIN [CRE].[Solicitud_Personas] P ON P.id_solicitud = S.id
	WHERE S.id = @id_solicitud AND P.id_persona = (@id)
	ORDER BY P.id_solicitud DESC


	


	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	SET @error = 'Error '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);		
	ROLLBACK TRANSACTION;
END CATCH

--SELECT @id_return id ;
