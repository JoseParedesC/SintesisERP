--liquibase formatted sql
--changeset ,JARCINIEGAS:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_ContratoSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_ContratoSave]
GO
CREATE PROCEDURE [NOM].[ST_ContratoSave]

@id					BIGINT			= NULL,
@id_empleado		BIGINT				  , --
@contratacion		INT					  , --
@id_tipocontra		INT					  , --
@cot_ext			BIT					  , --
@tipo_cot			VARCHAR(20)			  , --
@tiposalario		VARCHAR(10)			  , --
@salario			NUMERIC (18,2) 		  , --
@tipo_nom			INT					  , --
@fechaini			VARCHAR(10)			  , --
@jefe				BIT					  , --
@area				INT					  , --
@cargo				INT					  , --
@id_horario			INT					  , --
@eps				INT					  , --
@cesantias			INT					  , --
@pension			INT					  , --
@cajacomp			INT					  , --
@forma_pago			INT					  , --
@tipo_jornada		INT					  , --
@lugar_contrato		INT					  , --
@lugar_laborar		INT					  , --
@convenio			BIT					  , --
@ley50				BIT					  , --
@procedimiento		INT					  , --



@fechafin			VARCHAR (10)	= NULL, --

@diaspago			INT				= NULL, --

@funciones_esp		VARCHAR	(MAX)	= NULL, --

@jefedirect			INT				= NULL, --

@num_cuenta			VARCHAR(20)		= NULL, --
@banco				INT				= NULL, --
@tipo_cuenta		INT				= NULL, --


@id_user			INT						--



AS

/*****************************************
*Nombre 		[NOM].[ST_ContratoSave]
----------------------------------------
*Tipo 			Procedimiento almacenado
*creaci n 		21/11/2020
*Desarrollador  (JARCINIEGAS)
*DESCRIPCI N 	Guarda y/o la informaci n capt-
				ada en el formulario de sol-
				icitud en las tablas 
				CRE.Solicitudes, 
				CRE.Solicitud_Personas, 
				CRE.Personas_Adicionales, 
				CRE.Personas_Referencias, 
				CRE.Consecutivo y envia los 
				datos a el procedimiento 
				CRE.ST_PersonasSave para gua-
				rdar la informaci n en 
				CRE.Personas
*****************************************/

BEGIN TRANSACTION
BEGIN TRY
	
	DECLARE   @error VARCHAR(MAX), @id_contrato BIGINT;
	DECLARE @tablatemp TABLE (id INT IDENTITY(1,1), id_periodo BIGINT);
	IF(ISNULL(@id,0) = 0) 
	BEGIN

	SET @fechaini = REPLACE(@fechaini, '-', '');
	SET @fechafin = REPLACE(@fechafin, '-', '');
	IF(ISNULL(@fechafin,'')!='')
	SET @fechafin = REPLACE(@fechafin, '-', '');


	IF NOT EXISTS(SELECT 1 FROM [NOM].[ParamsAnual] WHERE DATEPART ( YY ,fecha_vigencia) = DATEPART ( YY , GETDATE()))
	BEGIN
		DECLARE @ERROR1 VARCHAR(MAX) = 'Los parametros nominales del año '+ CONVERT(VARCHAR(4), DATEPART ( YY , GETDATE())) +
		' NO han sido ingresados'
		RAISERROR(@ERROR1,16,0);
	END


	--IF EXISTS (SELECT 1 FROM [NOM].[Contrato] WHERE id_empleado = @id_empleado AND estado = dbo.ST_FnGetIdList('VIG'))
	--BEGIN 

	--	IF (@fechaini = CONVERT(VARCHAR, GETDATE(), 112))
	--	BEGIN
	--		UPDATE [NOM].[Contrato]
	--			SET estado = dbo.ST_FnGetIdList('CAN'),
	--				fecha_final = GETDATE()

	--			WHERE id_empleado = @id_empleado AND estado = dbo.ST_FnGetIdList('VIG')
	--	END
	--	ELSE IF (@fechaini > CONVERT(VARCHAR, GETDATE(), 112))
	--	BEGIN
	--		UPDATE [NOM].[Contrato]
	--			SET estado = dbo.ST_FnGetIdList('CAN'),
	--				fecha_final = @fechafin

	--			WHERE id_empleado = @id_empleado AND estado = dbo.ST_FnGetIdList('VIG')

	--	END
	--END 

	

					   
			INSERT INTO [NOM].[Contrato]([consecutivo],[id_empleado],[id_contratacion],[id_tipo_contrato],[coti_extranjero],[id_tipo_cotizante],[tipo_salario],[salario],[tipo_nomina],[diasapagar],[convenio],[fecha_inicio],[fecha_final],[area],[cargo],[id_horario],[funciones_esp],[jefe],[cual_jefe],[id_eps],[id_cesantias],[id_pension],[id_cajacomp],[id_formapago],[ncuenta],[tipo_cuenta],[banco],[tipo_jornada],[sede_contratacion],[centrocosto],ley50,procedimiento,[estado],[id_usercreated],[id_userupdated])
				VALUES([CRE].[ST_FnConsecutivoSolicitud](1,'contrato'),@id_empleado,@contratacion,@id_tipocontra,@cot_ext,@tipo_cot,dbo.ST_FnGetIdList('SALFIJO'),@salario,@tipo_nom,@diaspago,@convenio,@fechaini,@fechafin,@area,@cargo,@id_horario,@funciones_esp,@jefe,@jefedirect,@eps,@cesantias,@pension,@cajacomp,@forma_pago,@num_cuenta,@tipo_cuenta,@banco,@tipo_jornada,@lugar_contrato,@lugar_laborar,@ley50,@procedimiento,(CASE  WHEN @fechaini > CONVERT(VARCHAR, GETDATE(), 112) THEN  dbo.ST_FnGetIdList('ESP') ELSE dbo.ST_FnGetIdList('VIG') end),@id_user,@id_user)	
	
	SET @id_contrato = SCOPE_IDENTITY();
	INSERT INTO @tablatemp (id_periodo)
	EXEC [NOM].[ST_PeriodoSave] @id_contrato, @id_user;

	UPDATE [NOM].[Contrato] SET id_periodo = (SELECT id_periodo FROM @tablatemp) WHERE id = @id_contrato


	IF NOT EXISTS (SELECT 1 FROM [CRE].[Consecutivo]where tipo = 'contrato')
		INSERT INTO [CRE].[Consecutivo] (consecutivo, id_estacion, id_user, tipo) VALUES (0, 1, @id_user, 'contrato')
		UPDATE [CRE].[Consecutivo] SET consecutivo = consecutivo + 1 where tipo= 'contrato';;
	
	
	SELECT consecutivo	FROM [NOM].[Contrato] WHERE id = @id_contrato




	END
	ELSE
	BEGIN
		
		RAISERROR('Verifique, el contrato ya existe',16,0)
	END

	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	SET @error = 'Error '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);		
	ROLLBACK TRANSACTION;
END CATCH

--SELECT @id_return id ;
