----liquibase formatted sql
----changeset ,JARCINIEGAS:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
--If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_ContratoUpdate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
--DROP PROCEDURE [NOM].[ST_ContratoUpdate]
--GO
--CREATE PROCEDURE [NOM].[ST_ContratoUpdate]

--@id					BIGINT			= NULL,
--@estado				BIGINT				  , --


--@id_user			INT						--



--AS

--/*****************************************
--*Nombre 		[NOM].[ST_ContratoUpdate]
------------------------------------------
--*Tipo 			Procedimiento almacenado
--*creaci n 		21/11/2020
--*Desarrollador  (JARCINIEGAS)
--*DESCRIPCI N 	Guarda y/o la informaci n capt-
--				ada en el formulario de sol-
--				icitud en las tablas 
--				CRE.Solicitudes, 
--				CRE.Solicitud_Personas, 
--				CRE.Personas_Adicionales, 
--				CRE.Personas_Referencias, 
--				CRE.Consecutivo y envia los 
--				datos a el procedimiento 
--				CRE.ST_PersonasSave para gua-
--				rdar la informaci n en 
--				CRE.Personas
--*****************************************/

--BEGIN TRANSACTION
--BEGIN TRY
	
--	DECLARE   @error VARCHAR(MAX), @id_contrato BIGINT;
--	IF(ISNULL(@id,0) = 0) 
--	BEGIN

--	SET @fechaini = REPLACE(@fechaini, '-', '');
--	SET @fechafin = REPLACE(@fechafin, '-', '');
--	IF(ISNULL(@fechafin,'')!='')
--	SET @fechafin = REPLACE(@fechafin, '-', '');


--	IF EXISTS (SELECT 1 FROM [NOM].[Contrato] WHERE id_empleado = @id_empleado AND estado = dbo.ST_FnGetIdList('VIG'))
--	BEGIN 
--	UPDATE [NOM].[Contrato]
--		SET estado = dbo.ST_FnGetIdList('CAN'),
--			fecha_final = GETDATE()

--		WHERE id_empleado = @id_empleado AND estado = dbo.ST_FnGetIdList('VIG')
--	END 



					   
--			INSERT INTO [NOM].[Contrato]([consecutivo],[id_empleado],[tipo_contrato],[salario],[tipo_salario],[diasapagar],[convenio],[fecha_inicio],[fecha_final],[cargo],[funciones_esp],[jefe],[cual_jefe],[formapago],[ncuenta],[tipo_cuenta],[banco],[tipo_jornada],[sede_contratacion],[centrocosto],[estado],[id_usercreated],[id_userupdated])
--				VALUES([CRE].[ST_FnConsecutivoSolicitud](1,'contrato'),@id_empleado,@id_tipocontra,@salario,@tipo_sal,@diaspago,@convenio,@fechaini,@fechafin,@cargo,@funciones_esp,@jefe,@jefedirect,@forma_pago,@num_cuenta,@tipo_cuenta,@banco,@tipo_jornada,@lugar_contrato,@lugar_laborar,(CASE  WHEN @fechaini < CONVERT(VARCHAR, GETDATE(), 112) THEN  dbo.ST_FnGetIdList('ESP') ELSE dbo.ST_FnGetIdList('VIG') end),@id_user,@id_user)	
	
--	SET @id_contrato = SCOPE_IDENTITY();

--	IF NOT EXISTS (SELECT 1 FROM [CRE].[Consecutivo]where tipo = 'contrato')
--		INSERT INTO [CRE].[Consecutivo] (consecutivo, id_estacion, id_user, tipo) VALUES (0, 1, @id_user, 'contrato')
--		UPDATE [CRE].[Consecutivo] SET consecutivo = consecutivo + 1 where tipo= 'contrato';;
	
	
--	SELECT consecutivo	FROM [NOM].[Contrato] WHERE id = @id_contrato
--	END
--	ELSE
--	BEGIN
		
--		RAISERROR('Verifique, el contrato ya existe',16,0)
--	END

--	COMMIT TRANSACTION;
--END TRY
--BEGIN CATCH
--	SET @error = 'Error '+ERROR_MESSAGE();
--	RAISERROR(@error,16,0);		
--	ROLLBACK TRANSACTION;
--END CATCH

----SELECT @id_return id ;
