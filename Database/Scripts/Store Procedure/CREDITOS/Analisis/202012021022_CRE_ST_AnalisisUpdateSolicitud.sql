--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CRE].[ST_AnalisisUpdateSolicitud]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CRE].[ST_AnalisisUpdateSolicitud]
GO
CREATE PROCEDURE [CRE].[ST_AnalisisUpdateSolicitud]

@id_user			BIGINT,
@id_persona			BIGINT,

--DEUDOR
@id_solicitud		BIGINT,
@tipoper			BIGINT,
@id_tipoiden		INT,
@iden				VARCHAR(20),
@pnombre			VARCHAR(50),
@snombre			VARCHAR(50),
@papellido			VARCHAR(50),
@sapellido			VARCHAR(50),
@fechanacimiento	SMALLDATETIME,
@fechaexpedicion	SMALLDATETIME,
@ciudad				BIGINT,
@id_ciudadexped		BIGINT,
@genero				INT,
@estrato			INT,
@estadocivil		INT,
@profesion			VARCHAR(50),
@percargo			INT,
@telefono			VARCHAR(50),	
@celular			VARCHAR(20),
@otro				VARCHAR(20),
@direccion			VARCHAR(120),
@correo				VARCHAR(100),
@valorinm			NUMERIC(18,2),
@viveinmu			BIGINT,
@id_fincaraiz		BIGINT,
@cualfinca			VARCHAR(150),
@vehiculo			VARCHAR(500),
@escolaridad		BIGINT,
@verificacion		VARCHAR(50),
@tipoter			CHAR(2),

--CONYUGE
@connombre			VARCHAR(200),
@id_contipo			BIGINT,
@con_iden			VARCHAR(20),
@contelefono		VARCHAR(20),
@concorreo			VARCHAR(120),
@conempresa			VARCHAR(100),
@condireccionemp	VARCHAR(250),
@contelefonoemp		VARCHAR(20),
@consalario			NUMERIC(18,2),

--INFORMACION LABORAL
@tipoempleo			INT,
@tipoact			INT,
@empresalab			VARCHAR(250),
@direccionem		VARCHAR(250),
@telefonoemp		VARCHAR(20),
@cargoempr			VARCHAR(50),
@tiempoemp			INT,
@salarioemp			NUMERIC(18,2),
@otrosing			NUMERIC(18,2),
@gastos				NUMERIC(18,2),
@concepto			VARCHAR(250),

--REFERENCIA BANCARIA
@banco				VARCHAR(50),
@tipocuenta			BIGINT,
@numcuenta			VARCHAR(50),

--COITIZACION
@id_cotizacion		BIGINT,

-- REFERENCIAS PERSONALES
@xml_id				BIGINT,
@xml				XML

AS

/***************************************
*Nombre:		[CRE].[AnalisisGetCredito]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		24/11/2020
*Desarrollador: JPAREDES
*Descripcion:	Actualiza los datos de 
				las solicitudes
***************************************/

DECLARE @error VARCHAR(MAX),@idper INT
DECLARE @personas_adicionales TABLE(id_record INT IDENTITY, nombre VARCHAR(50), direccion VARCHAR(50), telefono VARCHAR(50), tipo_ref BIGINT, tipo_paren BIGINT,estado BIT, referencia BIGINT)

BEGIN TRY
	
	
	IF(@fechaexpedicion < @fechanacimiento)
	BEGIN
		RAISERROR( 'La fecha de expedicion no puede ser menor a la de nacimiento',16,0);
	END

	UPDATE P -- UPDATE PERSONAS INFORMATION FROM [CRE].[Personas]
	SET P.primernombre		= @pnombre,
		P.segundonombre		= @snombre,
		P.primerapellido	= @papellido,
		P.segundoapellido	= @sapellido,
		P.celular			= @celular,
		P.correo			= @correo,
		P.cualfinca			= @cualfinca,
		P.digverificacion	= @verificacion,
		P.direccion			= @direccion,
		P.fechaexpedicion	= @fechaexpedicion,
		P.fechanacimiento	= @fechanacimiento,
		P.id_ciudad			= @ciudad,
		P.id_ciudadexp		= @id_ciudadexped,
		P.id_escolaridad	= @escolaridad,
		P.id_estadocivil	= @estadocivil,
		P.id_estrato		= @estrato,
		P.id_fincaraiz		= @id_fincaraiz,
		P.id_genero			= @genero,
		P.id_tipoiden		= @id_tipoiden,
		P.id_userupdated	= @id_user,
		P.id_viveinmueble	= @viveinmu,
		P.identificacion	= @iden,
		P.otrotel			= @otro,
		P.percargo			= @percargo,
		P.profesion			= @profesion,
		P.telefono			= @telefono,
		P.tipo_persona		= @tipoper,
		P.tipo_tercero		= @tipoter,
		P.updated			= GETDATE(),
		P.valorarriendo		= @valorinm,
		P.vehiculo			= @vehiculo
	FROM [CRE].[Personas] P
	WHERE P.id = @id_persona


	UPDATE PA --UPDATE 'CONYUGE' AND 'PERSONA' AND 'BANCO' INFORMATION FROM [CRE].[PersonasAdicionales]
	SET -- REF CONYU
		PA.connombre		= @connombre,
		PA.contipoid		= @id_contipo,
		PA.coniden			= @con_iden,
		PA.contelefono		= @contelefono,
		PA.concorreo		= @concorreo,
		PA.conempresa		= @conempresa,
		PA.condireccionemp	= @condireccionemp,
		PA.contelefonoemp	= @contelefonoemp,
		PA.consalario		= @consalario,
		-- REF LAB
		PA.id_tipoact		= @tipoact,
		PA.id_tipoemp		= @tipoempleo,
		PA.empresalab		= @empresalab,
		PA.direccionemp		= @direccionem,
		PA.telefonoemp		= @telefonoemp,
		PA.cargo			= @cargoempr,
		PA.id_tiempoemp		= @tiempoemp,
		PA.salarioemp		= @salarioemp,
		PA.otroingreso		= @otrosing,
		PA.concepto			= @concepto,
		PA.gastos			= @gastos,
		-- REF BANC
		PA.banco			= @banco,
		PA.id_tipocuenta	= @tipocuenta,
		PA.numcuenta		= @numcuenta
	FROM [CRE].[Personas_Adicionales] PA
	WHERE PA.id_persona = @id_persona



	-- UPDATE REFERENCIAS PERSONALES (IF IS NOT NULL)
	IF(@xml IS NOT NULL AND @xml_id != 0)
	BEGIN
	EXEC sp_xml_preparedocument @idper OUTPUT, @xml

	INSERT INTO @personas_adicionales (nombre,direccion,telefono,tipo_ref,tipo_paren, estado, referencia)
	SELECT 
		nombre,
		direccion,
		telefono,
		tipo_ref,
		tipo_paren,
		estado,
		referencia
	FROM OPENXML(@idper, N'items/item') 
	WITH (  nombre		VARCHAR(50) '@nombre',
			direccion	VARCHAR(50) '@direccion',
			telefono	VARCHAR(50)	'@telefono',
			tipo_ref	BIGINT		'@tiporef',
			tipo_paren	BIGINT		'@parent',
			referencia	BIGINT		'@referencia',
			estado		BIT			'@estado'
	) AS P 
	
	UPDATE PR SET 
		PR.nombre			= p.nombre,
		PR.direccion		= P.direccion,
		PR.telefono			= P.telefono,
		PR.id_tiporef		= P.tipo_ref,
		PR.id_parentezco	= P.tipo_paren,
		PR.estado			= P.estado
	FROM [CRE].[Personas_Referencias] PR
	INNER JOIN @personas_adicionales P ON PR.id = P.id_record
	WHERE PR.id_persona = @id_persona
	

	INSERT INTO [CRE].[Personas_Referencias] (nombre,id_persona ,direccion,telefono,id_tiporef,id_parentezco,created,id_usercreated,updated,id_userupdated,id_solicitud,estado)
	SELECT	 
		P.nombre,  
		@xml_id,	
		P.direccion,
		P.telefono, 
		P.tipo_ref, 
		P.tipo_paren,
		GETDATE(),
		@id_user,
		GETDATE(),
		@id_user,
		@id_solicitud,
		P.estado
	FROM @personas_adicionales P WHERE P.referencia != 0
	END -- FINAL DEL UPDATE PERSONAS REFERENCIAS


END TRY
BEGIN CATCH
--Getting the error description
	Set @error   =  ERROR_MESSAGE()
	-- save the error in a Log file
	RAISERROR(@error,16,1)
	RETURN
END CATCH