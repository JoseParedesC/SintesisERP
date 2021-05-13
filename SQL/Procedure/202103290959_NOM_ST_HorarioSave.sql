--liquibase formatted sql
--changeset ,JARCINIEGAS:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_HorarioSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_HorarioSave]
GO
CREATE PROCEDURE [NOM].[ST_HorarioSave]

@id					BIGINT			= NULL	,
@nombre				VARCHAR  (60)			, --
@tipo_Horario		BIGINT					, --
@identipo_horario	VARCHAR	 (5)			, --
@cadaxdia			VARCHAR  (60)	= NULL	, --lo puedo omitir, ahora que mande los datos del js voy a intentar hacerlo sin esto 
@diastrab			INT				= NULL	, --
@diasdesc			INT				= NULL	, --
@sabado				BIT				= NULL	, --

@hinicio			VARCHAR  (5)	= NULL  , --
@hiniciodesc		VARCHAR  (5)	= NULL	, --
@hfinaldesc			VARCHAR  (5)	= NULL	, --
@hfinal				VARCHAR  (5)	= NULL	, --
@hiniciosab			VARCHAR  (5)	= NULL	, --
@hfinalsab			VARCHAR  (5)	= NULL	, --


@irregular			XML				= NULL	, --


@id_user			INT						  --



AS

/*****************************************
*Nombre 		[NOM].[ST_HorarioSave]
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
	
	DECLARE @hijo BIGINT, @manejador INT, @conta INT, @conta1 INT;
	DECLARE @error VARCHAR(MAX);
	DECLARE @temp TABLE(id INT IDENTITY(1,1), id_ INT NULL, hini VARCHAR(5), hinidesc VARCHAR(5) NULL, hfindesc VARCHAR(5) NULL, hfin VARCHAR (5), htrabajada NUMERIC(8,6), htrabajanoche NUMERIC(8,6));
	IF(ISNULL(@id,0) = 0) 
	BEGIN
					   
		IF (@identipo_horario = 'REG')
		BEGIN 
			IF(ISNULL(@sabado,0)=0)
			BEGIN
				INSERT INTO [NOM].[Horario](nombre,tipo_horario,cantdias,canttrabdias,cantdesdias,Hinicio,Hiniciodesc,Hfindesc,Hfin,HporDia,Hnoche,sab,id_usercreated,id_userupdated)
							VALUES(@nombre,@tipo_Horario,5,5,2,@hinicio,@hiniciodesc,@hfinaldesc,@hfinal,CONVERT(NUMERIC,DATEDIFF(MI, CONVERT(TIME, @hinicio), CONVERT(TIME, @hfinal)))/60,IIF((CONVERT(NUMERIC,DATEDIFF(MI,IIF(CONVERT(TIME, @hinicio)>CONVERT(TIME,'20:00'),CONVERT(TIME, @hinicio),CONVERT(TIME,'20:00')), CONVERT(TIME, @hfinal)))/60) < 0,0,(CONVERT(NUMERIC,DATEDIFF(MI,IIF(CONVERT(TIME, @hinicio)>CONVERT(TIME,'20:00'),CONVERT(TIME, @hinicio),CONVERT(TIME,'20:00')), CONVERT(TIME, @hfinal)))/60)),@sabado,@id_user,@id_user)
			END
			ELSE BEGIN
				INSERT INTO [NOM].[Horario](nombre,tipo_horario,cantdias,canttrabdias,cantdesdias,Hinicio,Hiniciodesc,Hfindesc,Hfin,HporDia,Hnoche,sab,id_usercreated,id_userupdated)
							VALUES(@nombre,@tipo_Horario,6,5,1,@hinicio,@hiniciodesc,@hfinaldesc,@hfinal,CONVERT(NUMERIC,DATEDIFF(MI, CONVERT(TIME, @hinicio), CONVERT(TIME, @hfinal)))/60,IIF((CONVERT(NUMERIC,DATEDIFF(MI,IIF(CONVERT(TIME, @hinicio)>CONVERT(TIME,'20:00'),CONVERT(TIME, @hinicio),CONVERT(TIME,'20:00')), CONVERT(TIME, @hfinal)))/60) < 0,0,(CONVERT(NUMERIC,DATEDIFF(MI,IIF(CONVERT(TIME, @hinicio)>CONVERT(TIME,'20:00'),CONVERT(TIME, @hinicio),CONVERT(TIME,'20:00')), CONVERT(TIME, @hfinal)))/60)),0,@id_user,@id_user)	
				SET @hijo = SCOPE_IDENTITY();

				INSERT INTO [NOM].[Horario](id_padre,nombre,tipo_horario,canttrabdias,Hinicio,Hfin,HporDia,Hnoche,sab,id_usercreated,id_userupdated)
							VALUES(@hijo,@nombre,@tipo_Horario,1,@hiniciosab,@hfinalsab,CONVERT(NUMERIC,DATEDIFF(MI, CONVERT(TIME, @hiniciosab), CONVERT(TIME, @hfinalsab)))/60,IIF((CONVERT(NUMERIC,DATEDIFF(MI,IIF(CONVERT(TIME, @hiniciosab)>CONVERT(TIME,'20:00'),CONVERT(TIME, @hiniciosab),CONVERT(TIME,'20:00')), CONVERT(TIME, @hfinalsab)))/60) < 0,0,(CONVERT(NUMERIC,DATEDIFF(MI,IIF(CONVERT(TIME, @hiniciosab)>CONVERT(TIME,'20:00'),CONVERT(TIME, @hiniciosab),CONVERT(TIME,'20:00')), CONVERT(TIME, @hfinalsab)))/60)),@sabado,@id_user,@id_user)
			END
		END
		ELSE		
		IF (@identipo_horario = 'CXD')
		BEGIN
				INSERT INTO [NOM].[Horario](nombre,tipo_horario,cantdias,canttrabdias,cantdesdias,Hinicio,Hiniciodesc,Hfindesc,Hfin,HporDia,Hnoche,id_usercreated,id_userupdated)
							VALUES(@nombre,@tipo_Horario,1,1,@cadaxdia,@hinicio,@hiniciodesc,@hfinaldesc,@hfinal,CONVERT(NUMERIC,DATEDIFF(MI, CONVERT(TIME, @hinicio), CONVERT(TIME, @hfinal)))/60,IIF((CONVERT(NUMERIC,DATEDIFF(MI,IIF(CONVERT(TIME, @hinicio)>CONVERT(TIME,'20:00'),CONVERT(TIME, @hinicio),CONVERT(TIME,'20:00')), CONVERT(TIME, @hfinal)))/60) < 0,0,(CONVERT(NUMERIC,DATEDIFF(MI,IIF(CONVERT(TIME, @hinicio)>CONVERT(TIME,'20:00'),CONVERT(TIME, @hinicio),CONVERT(TIME,'20:00')), CONVERT(TIME, @hfinal)))/60)),@id_user,@id_user)
		END
		ELSE
		IF (@identipo_horario = 'IREG')
		BEGIN
				EXEC sp_xml_preparedocument @manejador OUTPUT, @irregular; 				
								
				INSERT INTO @temp(hini, hinidesc, hfindesc, hfin, htrabajada, htrabajanoche)
				SELECT horaini, hinidesc, hfindesc, horafin, CONVERT(NUMERIC,DATEDIFF(MI, CONVERT(TIME, horaini), CONVERT(TIME, horafin)))/60, IIF((CONVERT(NUMERIC,DATEDIFF(MI,IIF(CONVERT(TIME, horaini)>CONVERT(TIME,'20:00'),CONVERT(TIME, horaini),CONVERT(TIME,'20:00')), CONVERT(TIME, horafin)))/60) < 0,0,(CONVERT(NUMERIC,DATEDIFF(MI,IIF(CONVERT(TIME, horaini)>CONVERT(TIME,'20:00'),CONVERT(TIME, horaini),CONVERT(TIME,'20:00')), CONVERT(TIME, horafin)))/60))
				FROM OPENXML(@manejador, N'items/item') 
				WITH (  horaini VARCHAR(5)  '@hini',
						hinidesc VARCHAR(5) '@hinidesc',
						hfindesc VARCHAR(5) '@hfindesc',
						horafin VARCHAR(5)  '@hfin'
				) AS P;

				EXEC sp_xml_removedocument @manejador; 
				
				INSERT INTO [NOM].[Horario](nombre,tipo_horario,cantdias,canttrabdias,cantdesdias,	Hinicio,Hiniciodesc,Hfindesc,Hfin,HporDia,Hnoche,id_usercreated,id_userupdated)
							VALUES(@nombre,@tipo_Horario,@diastrab,1,@diasdesc,(SELECT hini FROM @temp WHERE id = 1),(SELECT hinidesc FROM @temp WHERE id = 1),(SELECT hfindesc FROM @temp WHERE id = 1),(SELECT hfin FROM @temp WHERE id = 1),(SELECT htrabajada FROM @temp WHERE id = 1),(SELECT htrabajanoche FROM @temp WHERE id = 1),@id_user,@id_user)
						
				SET @hijo = SCOPE_IDENTITY();

				SET @conta = (SELECT SUM(1) FROM @temp)
				
				if(@conta > 1)
				BEGIN
					INSERT INTO [NOM].[Horario](id_padre,nombre,tipo_horario,canttrabdias,Hinicio,Hiniciodesc,Hfindesc,Hfin,HporDia,Hnoche,id_usercreated,id_userupdated)
								SELECT	@hijo,@nombre,@tipo_Horario,1,hini,hinidesc,hfindesc,hfin,htrabajada,htrabajanoche,@id_user,@id_user 
								FROM @temp WHERE id NOT IN(1) 
				
				END

				
		END
		
	END
	ELSE
	BEGIN

		IF (@identipo_horario = 'REG')
		BEGIN 
			IF(ISNULL(@sabado,0)=0)
			BEGIN
				UPDATE  [NOM].[Horario]
				SET nombre			= @nombre		,
					tipo_horario	= @tipo_Horario	,
					cantdias		= 5				,
					canttrabdias	= 5				,
					cantdesdias		= 2				,
					Hinicio			= @hinicio		,
					Hiniciodesc		= @hiniciodesc	,
					Hfindesc		= @hfinaldesc	,
					Hfin			= @hfinal		,
					HporDia			= CONVERT(NUMERIC,DATEDIFF(MI, CONVERT(TIME, @hinicio), CONVERT(TIME, @hfinal)))/60,
					Hnoche			= IIF((CONVERT(NUMERIC,DATEDIFF(MI,IIF(CONVERT(TIME, @hinicio)>CONVERT(TIME,'20:00'),CONVERT(TIME, @hinicio),CONVERT(TIME,'20:00')), CONVERT(TIME, @hfinal)))/60) < 0,0,(CONVERT(NUMERIC,DATEDIFF(MI,IIF(CONVERT(TIME, @hinicio)>CONVERT(TIME,'20:00'),CONVERT(TIME, @hinicio),CONVERT(TIME,'20:00')), CONVERT(TIME, @hfinal)))/60)),
					sab				= @sabado		,
					updated			= GETDATE()		,
					id_userupdated	= @id_user
				WHERE id = @id;;
				
				SELECT CONVERT(NUMERIC,DATEDIFF(MI, CONVERT(TIME, @hinicio), CONVERT(TIME, @hfinal)))/60
			END
			ELSE BEGIN
				UPDATE  [NOM].[Horario]
					SET nombre			= @nombre		,
						tipo_horario	= @tipo_Horario	,
						cantdias		= 6 			,
						canttrabdias	= 5				,
						cantdesdias		= 1				,
						Hinicio			= @hinicio		,
						Hiniciodesc		= @hiniciodesc	,
						Hfindesc		= @hfinaldesc	,
						Hfin			= @hfinal		,
						HporDia			= CONVERT(NUMERIC,DATEDIFF(MI, CONVERT(TIME, @hinicio), CONVERT(TIME, @hfinal)))/60,
						Hnoche			= IIF((CONVERT(NUMERIC,DATEDIFF(MI,IIF(CONVERT(TIME, @hinicio)>CONVERT(TIME,'20:00'),CONVERT(TIME, @hinicio),CONVERT(TIME,'20:00')), CONVERT(TIME, @hfinal)))/60) < 0,0,(CONVERT(NUMERIC,DATEDIFF(MI,IIF(CONVERT(TIME, @hinicio)>CONVERT(TIME,'20:00'),CONVERT(TIME, @hinicio),CONVERT(TIME,'20:00')), CONVERT(TIME, @hfinal)))/60)),
						sab				= 0				,
						updated			= GETDATE()		,
						id_userupdated	= @id_user
					WHERE id = @id;;
				

				UPDATE  [NOM].[Horario]	
					SET	nombre			= @nombre		,
						tipo_horario	= @tipo_Horario	,
						canttrabdias	= 1				,
						Hinicio			= @hiniciosab	,
						Hfin			= @hfinalsab	,
						HporDia			= CONVERT(NUMERIC,DATEDIFF(MI, CONVERT(TIME, @hiniciosab), CONVERT(TIME, @hfinalsab)))/60,
						Hnoche			= IIF((CONVERT(NUMERIC,DATEDIFF(MI,IIF(CONVERT(TIME, @hiniciosab)>CONVERT(TIME,'20:00'),CONVERT(TIME, @hiniciosab),CONVERT(TIME,'20:00')), CONVERT(TIME, @hfinalsab)))/60) < 0,0,(CONVERT(NUMERIC,DATEDIFF(MI,IIF(CONVERT(TIME, @hiniciosab)>CONVERT(TIME,'20:00'),CONVERT(TIME, @hiniciosab),CONVERT(TIME,'20:00')), CONVERT(TIME, @hfinalsab)))/60)),
						sab				= @sabado		,
						updated			= GETDATE()		,
						id_userupdated	= @id_user
					WHERE id_padre = @id;;
			END
		END
		ELSE		
		IF (@identipo_horario = 'CXD')
		BEGIN
				UPDATE  [NOM].[Horario]
					SET nombre			= @nombre		,
						tipo_horario	= @tipo_Horario	,
						cantdias		= 1 			,
						canttrabdias	= 1				,
						cantdesdias		= @cadaxdia		,
						Hinicio			= @hinicio		,
						Hiniciodesc		= @hiniciodesc	,
						Hfindesc		= @hfinaldesc	,
						Hfin			= @hfinal		,
						HporDia			= CONVERT(NUMERIC,DATEDIFF(MI, CONVERT(TIME, @hinicio), CONVERT(TIME, @hfinal)))/60,
						Hnoche			= IIF((CONVERT(NUMERIC,DATEDIFF(MI,IIF(CONVERT(TIME, @hinicio)>CONVERT(TIME,'20:00'),CONVERT(TIME, @hinicio),CONVERT(TIME,'20:00')), CONVERT(TIME, @hfinal)))/60) < 0,0,(CONVERT(NUMERIC,DATEDIFF(MI,IIF(CONVERT(TIME, @hinicio)>CONVERT(TIME,'20:00'),CONVERT(TIME, @hinicio),CONVERT(TIME,'20:00')), CONVERT(TIME, @hfinal)))/60)),
						updated			= GETDATE()		,
						id_userupdated	= @id_user
					WHERE id = @id;;

		END
		ELSE
		IF (@identipo_horario = 'IREG')
		BEGIN
				EXEC sp_xml_preparedocument @manejador OUTPUT, @irregular; 				
								
				INSERT INTO @temp(id_, hini, hinidesc, hfindesc, hfin, htrabajada, htrabajanoche)
				SELECT id, horaini, hinidesc, hfindesc, horafin, CONVERT(NUMERIC,DATEDIFF(MI, CONVERT(TIME, horaini), CONVERT(TIME, horafin)))/60, IIF((CONVERT(NUMERIC,DATEDIFF(MI,IIF(CONVERT(TIME, horaini)>CONVERT(TIME,'20:00'),CONVERT(TIME, horaini),CONVERT(TIME,'20:00')), CONVERT(TIME, horafin)))/60) < 0,0,(CONVERT(NUMERIC,DATEDIFF(MI,IIF(CONVERT(TIME, horaini)>CONVERT(TIME,'20:00'),CONVERT(TIME, horaini),CONVERT(TIME,'20:00')), CONVERT(TIME, horafin)))/60))
				FROM OPENXML(@manejador, N'items/item') 
				WITH (  id int '@id',
						horaini VARCHAR(5) '@hini',
						hinidesc VARCHAR(5) '@hinidesc',
						hfindesc VARCHAR(5) '@hfindesc',
						horafin VARCHAR(5) '@hfin'
				) AS P;

				EXEC sp_xml_removedocument @manejador; 



				UPDATE  [NOM].[Horario]
					SET nombre			= @nombre		,
						tipo_horario	= @tipo_Horario	,
						cantdias		= @diastrab		,
						canttrabdias	= 1				,
						cantdesdias		= @diasdesc		,
						Hinicio			= (SELECT hini FROM @temp WHERE id = 1)		,
						Hiniciodesc		= (SELECT hinidesc FROM @temp WHERE id = 1)	,
						Hfindesc		= (SELECT hfindesc FROM @temp WHERE id = 1)	,
						Hfin			= (SELECT hfin FROM @temp WHERE id = 1)		,
						HporDia			= (SELECT htrabajada FROM @temp WHERE id = 1),
						Hnoche			= (SELECT htrabajanoche FROM @temp WHERE id = 1),
						updated			= GETDATE()		,
						id_userupdated	= @id_user
					WHERE id = (SELECT id_ FROM @temp WHERE id=1);;
					SET @hijo = (SELECT id_ FROM @temp WHERE id=1)

					

						DELETE H FROM [NOM].[Horario] H WHERE id_padre = @hijo 

						INSERT INTO [NOM].[Horario](id_padre,nombre,tipo_horario,canttrabdias,Hinicio,Hiniciodesc,Hfindesc,Hfin,HporDia,Hnoche,id_usercreated,id_userupdated)
								SELECT	@hijo,@nombre,@tipo_Horario,1,hini,hinidesc,hfindesc,hfin,htrabajada,htrabajanoche,@id_user,@id_user 
								FROM @temp WHERE id NOT IN(1)


						
						
					
				
		END
	END

	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	SET @error = 'Error '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);		
	ROLLBACK TRANSACTION;
END CATCH

--SELECT @id_return id ;
