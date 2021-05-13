--liquibase formatted sql
--changeset ,jarciniegas:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_PeriodoSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_PeriodoSave]
GO
CREATE PROCEDURE [NOM].[ST_PeriodoSave]

@id_contrato BIGINT,
@id_user int 

AS
/****************************************
*Nombre:		[NOM].[ST_PeriodoSave]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		16/10/2020
*Desarrollador: (JARCINIEGAS)
*DESCRIPCIÓN:	Recoge el id que envia la 
				función FechaFesDelete y
				elimina el registro que 
				coincide con el id
****************************************/
BEGIN

Declare @ds_error varchar(max)
DECLARE @diasdepago VARCHAR(MAX)='', @proxdia VARCHAR(10), @i int = 0, @diasparapagar int , @id_return BIGINT
DECLARE @fechafin VARCHAR(10), @fechainicio VARCHAR(10), @fecha_inicial SMALLDATETIME, @fecha_final SMALLDATETIME
DECLARE @x bit = 0										 
	BEGIN TRY

		SET @diasparapagar = (SELECT diasapagar FROM [NOM].[Contrato] WHERE id = @id_contrato)
		SET @fechafin = ISNULL(CONVERT(VARCHAR,(SELECT fecha_final FROM [NOM].[Contrato] WHERE id = 10011),112),'0') --traer de la tabla contrato, si en null=0  para que  no se agrege
		SET @fechainicio = CONVERT(VARCHAR,(SELECT fecha_inicio FROM [NOM].[Contrato] WHERE id = 10011),112) --traer de la base de datos, para sabar la primera frecha de pago
		IF(@fechainicio<CONVERT(VARCHAR,GETDATE(),112))
			SET @fechainicio = CONVERT(VARCHAR,GETDATE(),112)
		SET @fecha_inicial = CONVERT(SMALLDATETIME,@fechainicio)


		IF NOT EXISTS(SELECT TOP 1 1 FROM [NOM].[Periodos_Pago] WHERE cant_dias = @diasparapagar)
		BEGIN
		--
			IF EXISTS(SELECT 1 FROM [NOM].[Contrato] WHERE id = @id_contrato AND estado = (SELECT id FROM ST_Listados WHERE iden = 'SEM'))
			BEGIN
				
					--SELECT @fecha_inicial, @fecha_final
					SET @fecha_final = CONVERT(SMALLDATETIME,@fechafin)
					WHILE @fecha_inicial < @fechafin
					BEGIN
						IF (DATEPART(WEEKDAY, @fecha_inicial) = 6)
						BEGIN
							
							IF(@x=0)
								IF(@fecha_inicial>CONVERT(SMALLDATETIME, DATEPART(DD,@fechainicio)))
								BEGIN
									SET @proxdia = CONVERT(VARCHAR(10), @fecha_inicial,112); 
									SET @x = 1
								END

							SET @diasdepago +=   CONVERT(VARCHAR(4),DATEPART ( YY , @fecha_inicial )) +
							CASE WHEN DATALENGTH(CONVERT(VARCHAR(2),DATEPART ( MM , @fecha_inicial ))) = 1 THEN '0'+CONVERT(VARCHAR(2),DATEPART ( MM , @fecha_inicial )) ELSE CONVERT(VARCHAR(2),DATEPART ( MM , @fecha_inicial ))END +
							CASE WHEN DATALENGTH(CONVERT(VARCHAR(2),DATEPART ( DD , @fecha_inicial ))) = 1 THEN '0'+CONVERT(VARCHAR(2),DATEPART ( DD , @fecha_inicial )) ELSE CONVERT(VARCHAR(2),DATEPART ( DD , @fecha_inicial ))END +','
   
						END
						SET @fecha_inicial = DATEADD(DAY, 1, @fecha_inicial)

					END
					SELECT @proxdia,@diasdepago


					INSERT INTO [NOM].[Periodos_Pago](
						diaspago,
						prox_dia_pago,
						created,
						updated)
						VALUES(
						@diasdepago,
						@proxdia,
						@id_user,
						@id_user)
						
						SET @id_return = SCOPE_IDENTITY();			
				

				--SELECT (DATEPART(WEEKDAY, GETDATE()))


			END
			ELSE
			 IF EXISTS(SELECT 1 FROM [NOM].[Contrato] WHERE id = @id_contrato)
			BEGIN 
				
					SET @proxdia = (SELECT proxdia FROM [NOM].[ST_FnProxdia](@id_contrato))

					SET @diasdepago = (SELECT diasdepago FROM [NOM].[ST_FnProxdia](@id_contrato))
					
					INSERT INTO [NOM].[Periodos_Pago](
						diaspago,
						prox_dia_pago,
						cant_dias,
						id_usercreated,
						id_userupdated)
					VALUES(
						@diasdepago,
						@proxdia,
						@diasparapagar,
						@id_user,
						@id_user)	
						
					SET @id_return = SCOPE_IDENTITY();
				END 

		END ELSE
		BEGIN

		SET @id_return = (SELECT id FROM [NOM].[Periodos_Pago] WHERE cant_dias = @diasparapagar)
		
		END

		EXEC [NOM].[ST_PeriodoPorContratoSave] @id_contrato, @id_return;


		SELECT @id_return


				
		
	END TRY
    BEGIN CATCH
	--Getting the error description
	SET @ds_error   =  ERROR_PROCEDURE() + 
					';  ' + CONVERT(VARCHAR,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	-- save the error in a Log file
	RAISERROR(@ds_error,16,0)
	RETURN
	END CATCH

END

