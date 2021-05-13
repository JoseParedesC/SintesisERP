--liquibase formatted sql
--changeset ,JPAREDES 1 dbms mssql runOnChange true ENDDelimiter GO stripComments false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_ParamsAnualSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_ParamsAnualSave]
GO
CREATE PROCEDURE [NOM].[ST_ParamsAnualSave]

	 @id BIGINT,
	 @fecha_vigencia DATE,

	-- INFORMACION GENERAL
	@salarioMinimoLegal NUMERIC(18,2),
	@salIntegral NUMERIC(18,2),
	@auxTrans NUMERIC(18,2),
	@int_Ces BIGINT,
	@exonerado BIT,

	-- PRESTACIONES SOCIALES (Total)
	@porcen_salud_total NUMERIC(4,2), 
	@porcen_pension_total NUMERIC(4,2),

	-- PRESTACIONES SOCIALES (Empleados)
	@porcen_salud_empleado NUMERIC(4,2),
	@porcen_pension_empleado NUMERIC(4,2),
	@num_salmin_icbf BIGINT, 
	@num_salmin_sena BIGINT,
	@porcen_icbf NUMERIC(4,2),
	@porcen_sena NUMERIC(4,2),
	@num_max_seguridasocial BIGINT,

	-- PRESTACIONES SOCIALES (Empleador)
	@porcen_salud_empleador NUMERIC(4,2),
	@porcen_pension_empleador NUMERIC(4,2),
	@num_salmin_salud_empleador BIGINT,

	-- HORAS EXTRA
	@hediurnas NUMERIC(18,2),
	@henoctur NUMERIC(18,2),
	@hefdiurnas NUMERIC(18,2),
	@hefnoctur NUMERIC(18,2),
	@recnocturno NUMERIC(18,2),
	@recdomfest NUMERIC(18,2),
	@recnocdomfest NUMERIC(18,2),

	-- SOLIDARIDAD PESIONAL
	@fondo_solidaridad XML,

	-- RETEFUENTE
	@uvt NUMERIC(18,6),

	@id_user BIGINT
AS

/***************************************
*Nombre 		[NOM].[ST_ParamsAnualSave]
-----------------------------------------------------------
*Tipo 			Procedimiento almacenado
*creaci�n 		30/03/2021
*Desarrollador   JPAREDES
*Descripcion 	Guarda o Actualiza la informacion de los Parametros Anuales
***************************************/


DECLARE @error VARCHAR(MAX), @id_solidaridad BIGINT, @id_empleado BIGINT, @id_empleador BIGINT, @id_horas BIGINT, @id_RETURN BIGINT, @idxml INT;
DECLARE @tbl_solid TABLE(id_record INT IDENTITY, desde BIGINT, hasta BIGINT, porcen NUMERIC(6,2));
BEGIN TRY

	IF(ISNULL(@id,0) = 0)
	BEGIN

		IF(@fondo_solidaridad IS NULL)
			RAISERROR('Hubo un error con la tabla de prestaciones sociales', 16,0)

		EXEC sp_xml_preparedocument @idxml OUTPUT, @fondo_solidaridad

		INSERT INTO @tbl_solid (desde, hasta, porcen)
		SELECT 
			desde,
			IIF(UPPER(hasta) = 'X', 0, CAST(hasta AS NUMERIC)),
			porcen
		FROM OPENXML(@idxml, N'items/item') 
		WITH (  desde		NUMERIC		'@desde',
				hasta		VARCHAR(10)	'@hasta',
				porcen		NUMERIC(4,2)'@porcen'
		) AS V

		INSERT INTO [NOM].[ParamsAnual_HrsExtras] (extra_diurna, extra_nocturna, extra_fesDiurna, extra_fesNoct, recargoNocturno, HraDomDiurno, recarg_DomNoct, id_usercreated, id_userupdated)
			SELECT @hediurnas, @henoctur,  @hefdiurnas, @hefnoctur, @recnocturno, @recdomfest, @recnocdomfest, @id_user, @id_user

		SET @id_horas = SCOPE_IDENTITY()


		INSERT INTO [NOM].[ParamsAnual_Empleador] (porcen_salud, porcen_pension, num_salariosMinSalud, id_usercreated, id_userupdated)
			SELECT @porcen_salud_empleador, @porcen_pension_empleador * 100, @num_salmin_salud_empleador, @id_user, @id_user

		SET @id_empleador = SCOPE_IDENTITY()


		INSERT INTO [NOM].[ParamsAnual_Empleado] (porcen_salud, porcen_pension,num_salariosMinICBF, num_salariosMinSENA, porcen_icbf, porcen_sena, num_salariosMinSegSocial, id_usercreated, id_userupdated)
			SELECT (@porcen_salud_empleado * 100), (@porcen_pension_empleado * 100), @num_salmin_icbf, @num_salmin_sena, (@porcen_icbf * 100), (@porcen_sena * 100), @num_max_seguridasocial, @id_user, @id_user

		SET @id_empleado = SCOPE_IDENTITY()


		INSERT INTO [NOM].[ParamsAnual] (salario_MinimoLegal, salario_Integral, aux_transporte, id_interesCesantias, uvt, porcen_saludTotal, porcen_pencionTotal, id_horasExt, id_parametrosEmpleado, id_parametrosEmpleador,exonerado , id_usercreated, id_userupdated, fecha_vigencia)
			SELECT @salarioMinimoLegal, @salIntegral, @auxTrans, @int_Ces, @uvt, @porcen_salud_total * 100, @porcen_pension_total * 100, @id_horas, @id_empleado, @id_empleador, @exonerado, @id_user, @id_user, @fecha_vigencia

		SET @id_RETURN = SCOPE_IDENTITY()


		INSERT INTO [NOM].[ParamsAnual_Solid] (desde, hasta, porcentaje, id_usercreated, id_userupdated, id_parametros)
			SELECT desde, hasta, porcen * 100, @id_user, @id_user, @id_RETURN FROM @tbl_solid

		SET @id_solidaridad = SCOPE_IDENTITY()

	END
	ELSE
	BEGIN

		IF(@fondo_solidaridad IS NULL)
			RAISERROR('Hubo un error con la tabla de prestaciones sociales', 16,0)


		SET @id_solidaridad = (SELECT TOP 1 id FROM [NOM].[ParamsAnual_Solid] WHERE id_parametros = @id)
		SET @id_horas = (SELECT TOP 1 id_horasExt FROM [NOM].[ParamsAnual] WHERE id = @id)
		SET @id_empleador = (SELECT TOP 1 id_parametrosEmpleador FROM [NOM].[ParamsAnual] WHERE id = @id)
		SET @id_empleado = (SELECT TOP 1 id_parametrosEmpleado FROM [NOM].[ParamsAnual] WHERE id = @id)


		EXEC sp_xml_preparedocument @idxml OUTPUT, @fondo_solidaridad

		INSERT INTO @tbl_solid (desde, hasta, porcen)
		SELECT 
			desde,
			IIF(UPPER(hasta) = 'X', 0, CAST(hasta AS NUMERIC)),
			porcen
		FROM OPENXML(@idxml, N'items/item') 
		WITH (  desde		NUMERIC		'@desde',
				hasta		VARCHAR(10)	'@hasta',
				porcen		NUMERIC(4,2)'@porcen'
		) AS V

		DELETE FROM [NOM].[ParamsAnual_Solid] WHERE id_parametros = @id

		INSERT INTO [NOM].[ParamsAnual_Solid] (desde, hasta, porcentaje, id_usercreated, id_userupdated, id_parametros)
			SELECT desde, hasta, porcen * 100, @id_user, @id_user, @id FROM @tbl_solid

		UPDATE [NOM].[ParamsAnual_HrsExtras]
			SET extra_diurna = @hediurnas, 
				extra_nocturna = @henoctur, 
				extra_fesDiurna = @hefdiurnas, 
				extra_fesNoct = @hefnoctur, 
				recargoNocturno = @recnocturno, 
				HraDomDiurno = @recdomfest, 
				recarg_DomNoct = @recnocdomfest, 
				id_userupdated = @id_user
			WHERE id = @id_horas


		UPDATE [NOM].[ParamsAnual_Empleador] 
			SET porcen_salud = @porcen_salud_empleador * 100, 
				porcen_pension = @porcen_pension_empleador * 100, 
				num_salariosMinSalud =@num_salmin_salud_empleador,
				id_userupdated = @id_user
			WHERE id = @id_empleador


		UPDATE [NOM].[ParamsAnual_Empleado] 
			SET porcen_salud = @porcen_salud_empleado * 100, 
			porcen_pension = @porcen_pension_empleado * 100,
			num_salariosMinICBF = @num_salmin_icbf, 
			num_salariosMinSENA = @num_salmin_sena, 
			porcen_icbf = @porcen_icbf * 100, 
			porcen_sena = @porcen_sena * 100, 
			num_salariosMinSegSocial = @num_max_seguridasocial, 
			id_userupdated = @id_user
		WHERE id = (SELECT id_parametrosEmpleado FROM [NOM].[ParamsAnual] WHERE id = @id)


		UPDATE [NOM].[ParamsAnual] 
			SET salario_MinimoLegal = @salarioMinimoLegal, 
			salario_Integral = @salIntegral, 
			aux_transporte = @auxTrans, 
			id_interesCesantias = @int_Ces, 
			exonerado = @exonerado,
			porcen_saludTotal = @porcen_salud_total * 100,
			porcen_pencionTotal = @porcen_pension_total * 100, 
			id_horasExt = @id_horas, 
			id_parametrosEmpleado = @id_empleado, 
			id_parametrosEmpleador = @id_empleador, 
			uvt = @uvt,
			id_userupdated = @id_user
		WHERE id = @id

		SET @id_RETURN = SCOPE_IDENTITY()

	END
	

END TRY
BEGIN CATCH	
	SET @error = 'Error  '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);	
END CATCH
