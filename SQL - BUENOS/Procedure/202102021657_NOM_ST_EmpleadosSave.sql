--liquibase formatted sql
--changeset ,JARCINIEGAS:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_EmpleadosSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_EmpleadosSave]
GO
CREATE PROCEDURE [NOM].[ST_EmpleadosSave]

@id					BIGINT			= NULL,
@id_tipoiden		INT					  , --
@iden				VARCHAR	 (50)		  , --
@verificacion		CHAR	 (1)		  , --
@fechaexp			VARCHAR	 (10)	= NULL, --
@pnombre			VARCHAR  (50)		  , --
@snombre			VARCHAR  (50)		  , --
@papellido			VARCHAR  (50)		  , --
@sapellido			VARCHAR  (50)		  , --
@fechanaci			VARCHAR  (10)		  , --
@profesion			VARCHAR  (120)		  , --
@universidad		VARCHAR  (80)		  , --
@id_escolaridad		INT					  , --
--@	soporteestudio	VARCHAR (MAX)		  , -- tipo file, no sé como lo voy a hacer
@correo				VARCHAR	 (100)		  , --
@nacionalidad		VARCHAR  (100)		  , --
@direccion			VARCHAR  (120)		  , --
@ciudad				BIGINT				  , --
@estrato			INT					  , --
@genero				INT					  , --
@estadocivil		INT					  , --
@hijos				INT					  , --
@id_tiposangre		INT					  , --
@celular			VARCHAR	 (20)		  , --
@fijo				VARCHAR  (20)	= NULL, --
@discapasidad		BIT					  , --


--Extranjero
--@	extfechaexp		SMALLDATETIME	= NULL, --
@extfechaven		VARCHAR	 (10)	= NULL, --
--@	extcertijudi	VARCHAR  (100)	= NULL, -- tipo file, no sé como lo voy a hacer


--conyuge
@congenero			INT				= NULL, --
@confechanaci		VARCHAR  (10)	= NULL, --
@conprofesion		VARCHAR  (120)	= NULL, --
@connombres			VARCHAR  (100)	= NULL, --
@conapellidos		VARCHAR  (100)	= NULL, --
@coniden			VARCHAR  (20)	= NULL, --


--Discapasidad
@id_distipo			INT				= NULL, --
@porcentajedis		INT				= NULL, --
@disgrado			INT				= NULL, --
@discarnet			VARCHAR  (30)	= NULL, --
@disfechaexp		VARCHAR  (10)	= NULL, --
@disvencimiento		VARCHAR  (10)	= NULL, --


--hijos
@xmlhijos			XML				= NULL, --


@id_user			INT						--



AS

/*****************************************
*Nombre 		[NOM].[ST_EmpleadosSave]
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
	
	DECLARE  @id_return INT, @error VARCHAR(MAX), @temp int;



	DECLARE @tipoper INT, @tel VARCHAR(20), @tipoter VARCHAR (max), @razon VARCHAR (100);
	DECLARE @manejador INT;
	DECLARE @hijostab TABLE (id INT IDENTITY(1,1), id_ INT, id_tercero INT, identificacion VARCHAR(20), nombres VARCHAR (30), apellidos VARCHAR (40), genero INT, profesion INT, id_usercreated INT, id_userupdated INT);


	SET @tipoper = CONVERT(INT,(SELECT id FROM ST_Listados WHERE iden = 'NATURAL'));
	SET	@tel = (SELECT (CASE WHEN @fijo = NULL THEN '0' ELSE @fijo END));
	SET @tipoter = '<tipoterceros></tipoterceros>';
	SET @razon = (SELECT @pnombre+' '+@snombre+' '+@papellido+' '+@sapellido)

	DECLARE @catfis BIGINT = 0;

	--IF NOT EXISTS (SELECT 1 FROM [dbo].[MOVCotizacion] C INNER JOIN [CNT].[Terceros] CC ON C.id_cliente = CC.id WHERE C.id = @id_cotizacion AND CC.iden = @iden) AND @tipo = 'CL'
	--BEGIN
	--	RAISERROR('La cotizaci�n no pertenece al solicitante.', 16, 0);
	--END

	--EJECUTA EL PROCEDIMIENTO DE PERSONAS SAVE
	set @fechaexp = REPLACE(@fechaexp, '-','')
	set @fechanaci = REPLACE(@fechanaci, '-','')
	set @extfechaven = REPLACE(@extfechaven, '-','')
	set @confechanaci = REPLACE(@confechanaci, '-','')
	set @disfechaexp = REPLACE(@disfechaexp, '-','')
	set @disvencimiento = REPLACE(@disfechaexp, '-','')
	--declare @fecha11 smalldatetime = convert(smalldatetime, @fechaexp,112), @fecha22 smalldatetime = convert(smalldatetime, @fechanaci,112)
	--select @fecha11, @fecha22 
	 

	EXECUTE [CNT].[TercerosSave]  
			--Datos Personales
			@id					= @id			,
			@tipoperso			= @tipoper		,
			@iden				= @iden			,
			@tipoiden			= @id_tipoiden	,
			@digitoveri			= @verificacion	,
			@id_catfiscal		= @catfis,
			@primernombre		= @pnombre		,
			@segundonombre		= @snombre		,
			@primerapellido		= @papellido	,
			@segundoapellido	= @sapellido	,
			@razonsocial		= @razon		,
			@sucursal			= '  '			,
			@tiporegimen		= 0				,
			@nombrecomercio		= '  '			,
			@pageweb			= '  '			,
			@fechaexpedicion	= @fechaexp		,
			@fechanacimiento	= @fechanaci	,
			@direccion			= @direccion	,
			@telefono			= @tel			,
			@celular			= @celular		,
			@email				= @correo		,
			@id_ciudad			= @ciudad		,
			@nombrecontacto		= '  '			,
			@telefonocontacto	= '  '			,
			@emailcontacto		= '  '			,
			@tiposTercero		= @tipoter		,
			@id_user			= @id_user		,
			@id_tercero			= @temp OUTPUT;

			
			

		--UPDATE C
		--	SET C.observaciones = @detalleobser
		--FROM [dbo].[MOVCotizacion] C INNER JOIN 
		--	 [CRE].[Solicitudes] S ON S.id_cotizacion = C.id
		--WHERE S.id = @id_solicitud
	
	--VERIFICA QUE EN LA SOLICITUD EL CLIENTE NO SEA EL MISMO CODEUDOR 
	IF NOT EXISTS (SELECT 1 FROM [CNT].[TerceroAdicionales] TA 
				WHERE id_tercero = @temp)
	BEGIN
					   
			INSERT INTO [CNT].[TerceroAdicionales]
           (id_tercero
           ,id_estrato
           ,id_genero
           ,profesion
           ,id_estadocivil
           ,universidad

           ,id_escolaridad
           ,nacionalidad
           ,cant_hijos
           ,id_tiposangre
           ,discapasidad
           ,fechavenci_extran
           ,congenero
           ,confecha_naci
           ,conprofesion
           ,connombres
           ,conapellidos
           ,coniden
           ,tipodiscapasidad
           ,porcentajedis
           ,gradodis
           ,carnetdis
           ,fechaexpdis
           ,vencimientodis
		   ,id_usercreated
		   ,id_userupdated)

			VALUES((SELECT (CASE WHEN ISNULL(@id,0) = 0 THEN @temp ELSE @id END)), @estrato, 
			@genero, @profesion, @estadocivil, @universidad, @id_escolaridad, 
			@nacionalidad, @hijos, @id_tiposangre, @discapasidad, @extfechaven, 
			@congenero, @confechanaci, @conprofesion, @connombres, @conapellidos,
			@coniden,@id_distipo, @porcentajedis, @disgrado, @discarnet,
			@disfechaexp, @disvencimiento, @id_user,@id_user)

		
			--SET @id = SCOPE_IDENTITY();
	
	END
	ELSE
	BEGIN
		
			
		UPDATE  [CNT].[TerceroAdicionales]
		SET id_estrato			= @estrato			,
			id_genero			= @genero			,
			profesion			= @profesion		,
			id_estadocivil		= @estadocivil		,
			universidad			= @universidad		,
			id_escolaridad		= @id_escolaridad	,
			nacionalidad		= @nacionalidad		,
			cant_hijos			= @hijos			,
			id_tiposangre		= @id_tiposangre	,
			discapasidad		= @discapasidad		,
			fechavenci_extran	= @extfechaven		,
			congenero			= @congenero		,
			confecha_naci		= @confechanaci		,
			conprofesion		= @conprofesion		,
			connombres			= @connombres		,
			conapellidos		= @conapellidos		,
			coniden				= @coniden			,
			tipodiscapasidad	= @id_distipo		,
			porcentajedis		= @porcentajedis	,
			gradodis			= @disgrado			,
			carnetdis			= @discarnet		,
			fechaexpdis			= @disfechaexp		,
			vencimientodis		= @disvencimiento	,
			updated				= GETDATE()			,
			id_userupdated		= @id_user
		WHERE id_tercero = (SELECT (CASE WHEN ISNULL(@id,0) = 0 THEN @temp ELSE @id END));;

		set @id_return = @id;		


	END


	--IF (EXISTS(SELECT 1 FROM [CRE].[Solicitud_Personas] PS 
	--			INNER JOIN [CRE].[Personas] P ON P.id = PS.id_persona
	--			WHERE id_solicitud = @id_solicitud AND id_persona != @id AND P.identificacion = @iden AND P.tipo_tercero = 'CO') AND @tipo = 'CO')
	--BEGIN
	--RAISERROR('No puede meter al mismo codeudor 2 veces.',16,0);
	--END


	----GUARDA O ACTUALIZA INFORMACION EN LA TABLA DE SOLICITUDES 
	--IF(ISNULL(@id_solicitud,0) = 0)
	--BEGIN			   



	--	--VERIFICA QUE EL CLIENTE NO SE GUARDE 2 VECES CON LA MISMA SOLICITUD
	--	IF EXISTS (SELECT 1 FROM [CRE].[Solicitud_Personas] PR
	--	LEFT JOIN [CRE].[Personas] P ON P.id = PR.id_persona
	--	WHERE ( id_persona = ISNULL(@id,0)) AND P.tipo_tercero = 'CL' AND PR.id_solicitud = @id_solicitud)
	--	BEGIN
	--		RAISERROR('Verifique ID, ya existe esta Solicitud con este cliente...', 16,0);
	--	END
		

	--	--GUARDA INFORMACION EN LA TABLA DE SOLICITUDES 
	--	INSERT INTO [CRE].[Solicitudes] (consecutivo, fechasolicitud, estado, id_cotizacion, id_estacion, id_userasign,id_usercreated, id_userupdated)
	--	VALUES([CRE].[ST_FnConsecutivoSolicitud](1), GETDATE(), (SELECT dbo.ST_FnGetIdList('SOLICIT')), @id_cotizacion, 3, @id_user, @id_user, @id_user)

	--	SET @id_solicitud = SCOPE_IDENTITY();

	--	IF NOT EXISTS (SELECT 1 FROM [CRE].[Consecutivo])
	--	INSERT INTO [CRE].[Consecutivo] (consecutivo, id_estacion, id_user) VALUES (0, 1, @id_user)
	--	UPDATE [CRE].[Consecutivo] SET consecutivo = consecutivo + 1;

	--	--GUARDA LA CONEXION CON LAS TABLAS PERSONAS Y SOLICITUDES
	--	INSERT INTO [CRE].[Solicitud_Personas] (id_persona, id_solicitud)
	--	VALUES (@id, @id_solicitud)


	--END ELSE
	--BEGIN
	
	--	--ACTUALIZA INFORMACION EN LA TABLA DE SOLICITUDES
	--	UPDATE  [CRE].[Solicitudes]
	--	SET   
	--		id_estacion = 1, 
	--		id_userasign = @id_user, 
	--		id_userupdated = @id_user,
	--		updated			= GETDATE()
	--	WHERE id = @id_solicitud;;



	--	--GUARDA LA CONEXION CON LAS TABLAS PERSONAS Y SOLICITUDES
	--	IF EXISTS(SELECT 1 FROM [CRE].[Solicitud_Personas] PS 
	--	RIGHT JOIN CRE.Personas P ON P.id = PS.id_persona
	--	WHERE PS.id_persona = @id AND PS.id_solicitud != @id_solicitud AND P.tipo_tercero = 'CL')
	--	BEGIN
	--	RAISERROR ('Este cliente ya Existe en una solicitud',16,0)
	--	END

	--	IF NOT EXISTS(SELECT 1 FROM [CRE].[Solicitud_Personas] WHERE id_persona = @id AND id_solicitud = @id_solicitud)
	--	BEGIN
	--	INSERT INTO [CRE].[Solicitud_Personas] (id_persona, id_solicitud)
	--	VALUES (@id, @id_solicitud)
	--	END


	--END
	
	
	--IF NOT EXISTS(SELECT 1 FROM [CRE].[Personas_Adicionales] WHERE id_persona = @id)
	--BEGIN
	--	--GUARDA INFORMACION EN LA TABLA DE PERSONAS ADICIONALES (validar los if, brindar mejor proteccion)
	--	INSERT INTO [CRE].[Personas_Adicionales] (id_persona, 
	--											 id_solicitud, 
	--											 connombre, 
	--											 contelefono, 
	--											 conempresa, 
	--											 consalario, 
	--											 id_tipoemp, 
	--											 empresalab, 
	--											 direccionemp, 
	--											 telefonoemp,
	--											 cargo, 
	--											 id_tiempoemp, 
	--											 salarioemp, 
	--											 otroingreso, 
	--											 concepto, 
	--											 estado, 
	--											 id_usercreated, 
	--											 id_userupdated)
	--	VALUES( @id, 
	--			@id_solicitud, 
	--			@connombre, 
	--			@contelefono, 
	--			@conempresa, 
	--			@consalario, 
	--			@tipoempleo, 
	--			@empresalab, 
	--			@direccionem, 
	--			@telefonoemp, 
	--			@cargoempr, 
	--			@tiempoemp, 
	--			@salarioemp, 
	--			@otrosing, 
	--			@concepto, 
	--			(SELECT dbo.ST_FnGetIdList('SOLICIT')), 
	--			@id_user, 
	--			@id_user)
	--	END
	--	ELSE 
	--BEGIN
	--	--ACTUALIZA INFORMACION EN LA TABLA DE PERSONAS ADICIONALES (validar los if, brindar mejor proteccion)
	--	UPDATE  [CRE].[Personas_Adicionales]
	--	SET	[id_solicitud]		= @id_solicitud,
	--		[connombre]			= @connombre,
	--		[contelefono]		= @contelefono,
	--		[conempresa]		= @conempresa,
	--		[consalario]		= @consalario,
	--		[empresalab]		= @empresalab,
	--		[direccionemp]		= @direccionem,
	--		[telefonoemp]		= @telefonoemp,
	--		[cargo]				= @cargoempr,
	--		[id_tiempoemp]		= @tiempoemp,
	--		[salarioemp]		= @salarioemp,
	--		[otroingreso]		= @otrosing,
	--		[concepto]			= @concepto,
	--		[id_userupdated]	= @id_user,
	--		--[id_sector]			=, preguntar a jose por el sector
	--		--[id_tipoact]		=,
	--		updated				= GETDATE()
	--	WHERE id_persona = @id;;

	--	END


if(@xmlhijos is not null)
	BEGIN
	if not exists(select 1 from [cnt].[terceroshijos] where id_tercero = (select (case when ISNULL(@id, 0) = 0 then @temp else @id end)))
	begin
		--guarda informacion en la tabla de personas referencias 

		exec sp_xml_preparedocument @manejador output, @xmlhijos; 				
								
		insert into [CNT].[TercerosHijos] (id_tercero, identificacion, nombres, apellidos, genero, profesion, id_usercreated, id_userupdated)
		select @temp, iden, nombres, apellidos, genero, profesion,  @id_user, @id_user
		from openxml(@manejador, N'items/item') 
		with (  iden varchar(30) '@Identificacion',
				nombres varchar(30) '@Nombres',
		        apellidos varchar(40) '@Apellidos',
				genero INT '@Genero',
				profesion int '@profesion'
		) as p;

		exec sp_xml_removedocument @manejador;

     end
	 else
	 begin
	
	 
		--guarda provisionalmente informacion en la tabla de personas referencias en una tabla temporal   
		exec sp_xml_preparedocument @manejador output, @xmlhijos; 				
								
		insert into @hijostab (id_, id_tercero, identificacion, nombres, apellidos, genero, profesion, id_usercreated, id_userupdated)
		select id, @temp, iden, nombres, apellidos, genero, profesion,  @id_user, @id_user
		from openxml(@manejador, N'items/item') 
		with (  id int '@id',
				iden varchar(30) '@Identificacion',
				nombres varchar(30) '@Nombres',
		        apellidos varchar(40) '@Apellidos',
				genero INT '@Genero',
				profesion int '@profesion'
		) as p;

		exec sp_xml_removedocument @manejador;

	--elimina todos los campos que tiene la tabla iguales a los que se mandaron
	delete TH from [CNT].[TercerosHijos] TH left join @hijostab tab on TH.id = tab.id_ 
	where TH.id_tercero = @temp and tab.id is null;

	--agrega la informacion de la tabla temporal en la tabla
	insert into [CNT].[TercerosHijos] (id_tercero, identificacion, nombres, apellidos, genero, profesion, id_usercreated, id_userupdated)
	select @temp, identificacion, nombres, apellidos, genero, profesion, @id_user, @id_user
	from @hijostab where id_ = 0

	
	
	end

	END


	--UPDATE [dbo].[MOVCotizacion] SET estado = (SELECT [dbo].[ST_FnGetIdList] ('UTILIZ')) WHERE id = @id_cotizacion;


	--SELECT S.id, (CONVERT(VARCHAR(10),C.id)+' - '+C.cliente) cotizacion, S.estado, CONVERT(VARCHAR(10), fechasolicitud,120) fecha, consecutivo, 
	--p.id clavesolicitud , P.id_persona
	--FROM [CRE].[Solicitudes] S
	--INNER JOIN dbo.VW_MOVCotizaciones C ON C.id = S.id_cotizacion
	--INNER JOIN [CRE].[Solicitud_Personas] P ON P.id_solicitud = S.id
	--WHERE S.id = @id_solicitud AND P.id_persona = (@id);


	--declare @s varchar(max) = '1' +  convert(varchar (max),@temp)
	-- raiserror(@s,16,0);
	-- raiserror('1',16,0);

	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	SET @error = 'Error '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);		
	ROLLBACK TRANSACTION;
END CATCH

--SELECT @id_return id ;
