--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_NovedadesSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_NovedadesSave]
GO
CREATE PROCEDURE [NOM].[ST_NovedadesSave]

	@id_contrato BIGINT,
	@id_per_cont BIGINT,
	@xmlDeven XML = NULL,
	@xmlAusen XML = NULL,
	@xmlDeduc XML = NULL,
	@id_user BIGINT
AS

/***************************************
*Nombre:		[NOM].[ST_NovedadesSave]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		30/03/2021
*Desarrollador:  JPAREDES
*Descripcion:	Guarda o Actualiza la informacion de los Juzgados
***************************************/
DECLARE @devengo TABLE(id_pk BIGINT IDENTITY, id_fk BIGINT, fecha_ini SMALLDATETIME, fecha_fin SMALLDATETIME, bonificacion NUMERIC(18,4), comision NUMERIC(18,4));
DECLARE @ausencia TABLE(id_pk BIGINT IDENTITY, fecha_ini SMALLDATETIME, fecha_fin SMALLDATETIME, id_ausencia BIGINT, id_diagnostico BIGINT, remunerado BIT, suspension BIT);
DECLARE @deduccion TABLE(id_pk BIGINT IDENTITY, prestamo NUMERIC(18,4), libranza NUMERIC(18,4), retencion NUMERIC(18,4), id_embargo BIGINT);
DECLARE @idxml INT, @id_devengo BIGINT, @id_deduccion BIGINT, @id_ausencia BIGINT
BEGIN TRY

	BEGIN TRANSACTION

		IF(ISNULL(@id_per_cont,0) = 0)
			RAISERROR('No se ha encontrado un contrato asociado con el periodo',16,0)

			-- XML AUSENCIA INFORMATION
		IF(@xmlDeven IS NULL)
			RAISERROR('Error con la informacion de la Ausencia',16,0)
		ELSE
		BEGIN
	
			EXEC sp_xml_preparedocument @idxml OUTPUT, @xmlDeven

			INSERT INTO @devengo (fecha_ini, fecha_fin, bonificacion, comision)
			SELECT 
				CASE WHEN fecha_ini = '' THEN NULL ELSE fecha_ini END, 
				CASE WHEN fecha_fin = '' THEN NULL ELSE fecha_fin END, 
				bonificacion, 
				comision
			FROM OPENXML(@idxml, N'items/item')
			WITH (  fecha_ini		SMALLDATETIME	'@fecha_ini',
					fecha_fin		SMALLDATETIME	'@fecha_fin',
					bonificacion	NUMERIC(18,4)	'@bonifi',
					comision		NUMERIC(18,4)	'@comi'
			) AS D 

			EXEC sp_xml_removedocument @idxml;
		END
	
	
		-- XML DEVENGOS INFORMATION
		IF(@xmlAusen IS NULL)
			RAISERROR('Error con la informacion de los Devengos',16,0)
		ELSE
		BEGIN
			EXEC sp_xml_preparedocument @idxml OUTPUT, @xmlAusen

			INSERT INTO @ausencia (fecha_ini, fecha_fin, id_ausencia, id_diagnostico, remunerado, suspension)
			SELECT 
				fecha_ini, 
				fecha_fin, 
				id_ausencia, 
				id_diagnostico, 
				remunerado, 
				suspension
			FROM OPENXML(@idxml, N'items/item')
			WITH (  fecha_ini		SMALLDATETIME	'@fecha_ini',
					fecha_fin		SMALLDATETIME	'@fecha_fin',
					id_ausencia		BIGINT			'@id_ausen',
					id_diagnostico	BIGINT			'@id_inca',
					remunerado		BIT				'@remun',
					suspension		BIT				'@suspen'
			) AS A

			EXEC sp_xml_removedocument @idxml;
		END


		-- XML DEDUCCIONES INFORMATION
		IF(@xmlDeduc IS NULL)
			RAISERROR('Error con la informacion de las Deducciones',16,0)
		ELSE
		BEGIN
			EXEC sp_xml_preparedocument @idxml OUTPUT, @xmlDeduc

			INSERT INTO @deduccion (prestamo, libranza, retencion, id_embargo)
			SELECT 
				prestamo, 
				libranza, 
				retefuente, 
				id_embargo
			FROM OPENXML(@idxml, N'items/item')
			WITH (  prestamo		NUMERIC(18,4)	'@prestamo',
					libranza		NUMERIC(18,4)	'@libranza',
					retefuente		NUMERIC(18,4)	'@retefuente',
					id_embargo		BIGINT			'@id_embargo'
			) AS D

			EXEC sp_xml_removedocument @idxml;
		END


			IF EXISTS(SELECT 1 FROM @devengo D INNER JOIN @ausencia A ON (D.fecha_ini BETWEEN A.fecha_ini AND A.fecha_fin) OR (D.fecha_fin BETWEEN A.fecha_ini AND A.fecha_fin))
				RAISERROR('Fechas de horas extra coinciden con fechas de ausencias',16,0)

			IF ((SELECT tipo_salario FROM [NOM].[Contrato] WHERE id = @id_contrato) = [DBO].[ST_FnGetIdList]('SALINT')) AND ((SELECT SUM(D.bonificacion) FROM @devengo D) > 0)
				RAISERROR('No se pueen agregar bonificaciones a este Contrato', 16, 0)

			DELETE FROM [NOM].[Devengos] WHERE id_per_cont = @id_per_cont

			INSERT INTO [NOM].[Devengos] (boni, comi, id_per_cont, fecha_inicio, fecha_fin, created, id_usercreated, updated, id_userupdated)
				SELECT bonificacion, comision, @id_per_cont, D.fecha_ini, D.fecha_fin, GETDATE(), @id_user, GETDATE(), @id_user FROM @devengo D 


			EXECUTE [NOM].[ST_NovedadesSaveExtras] @id_periodo_contrato = @id_per_cont, @id_contrato = @id_contrato


			SET @id_devengo = SCOPE_IDENTITY();


			DELETE FROM [NOM].[Ausencias] WHERE id_per_cont = @id_per_cont

			INSERT INTO [NOM].[Ausencias] (fecha_ini, fecha_fin, id_diagnostico, id_tipoausencia, id_per_cont, remunerado, domingo_suspencion, created, id_usercreated, updated, id_userupdated)
				SELECT fecha_ini, fecha_fin, id_diagnostico, id_ausencia, @id_per_cont,remunerado, suspension, GETDATE(), @id_user, GETDATE(), @id_user FROM @ausencia
			
			SET @id_ausencia = SCOPE_IDENTITY();


			DELETE FROM [NOM].[Deducciones] WHERE id_per_cont = @id_per_cont

			INSERT INTO [NOM].[Deducciones] (id_embargo, prestamos, libranzas, retencion_fuente, id_per_cont, created, id_usercreated, updated, id_userupdated)
				SELECT id_embargo, prestamo, libranza, retencion, @id_per_cont, GETDATE(), @id_user, GETDATE(), @id_user FROM @deduccion 

			SET @id_deduccion = SCOPE_IDENTITY();

			
			INSERT INTO [NOM].[Novedades] (id_devengo, id_ausencia, id_deduccion, id_per_cont, created, id_usercreated, updated, id_userupdated)
				SELECT @id_devengo, @id_ausencia, @id_deduccion, @id_per_cont, GETDATE(), @id_user, GETDATE(), @id_user

		
			IF(SELECT SUM(comi) FROM [NOM].[Devengos] WHERE id_per_cont = @id_per_cont) > 0.00
				UPDATE [NOM].[Contrato] SET tipo_salario = [DBO].[ST_FnGetIdList]('SALVARIABLE') WHERE id = @id_contrato AND tipo_salario = [DBO].[ST_FnGetIdList]('SALFIJO')

			ELSE IF NOT EXISTS(SELECT 1 FROM NOM.Pago_por_Contrato PC WHERE PC.id_contrato = @id_contrato AND PC.tipo_salario = [DBO].[ST_FnGetIdList]('SALVARIABLE'))
				UPDATE [NOM].[Contrato] SET tipo_salario = [DBO].[ST_FnGetIdList]('SALFIJO') WHERE id = @id_contrato AND tipo_salario = [DBO].[ST_FnGetIdList]('SALVARIABLE')


			IF ((SELECT tipo_salario FROM [NOM].[Contrato] WHERE id = @id_contrato) = [DBO].[ST_FnGetIdList]('SALINT')) AND ((SELECT SUM(H_EXTRAS) FROM [NOM].[Devengos] D) > 0)
				RAISERROR('No se pueen agregar horas extras a este Contrato', 16, 0)

	COMMIT TRANSACTION
END TRY
BEGIN CATCH	
	ROLLBACK TRANSACTION
	--ROLLBACK TRANSACTION
	DECLARE @error VARCHAR(MAX) = 'Error: '+ ERROR_MESSAGE() + '; ';
	RAISERROR(@error,16,0);	
END CATCH
