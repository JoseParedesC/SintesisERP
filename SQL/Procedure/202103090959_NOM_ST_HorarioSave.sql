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
@cadaxdia			INT				= NULL	, --lo puedo omitir, ahora que mande los datos del js voy a intentar hacerlo sin esto 
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
	
	DECLARE @hijo BIGINT, @manejador INT;
	DECLARE @error VARCHAR(MAX);
	DECLARE @temp TABLE(id INT IDENTITY(1,1), hini VARCHAR(5), hinidesc VARCHAR(5) NULL, hfindesc VARCHAR(5) NULL, hfin VARCHAR (5));
	IF(ISNULL(@id,0) = 0) 
	BEGIN
					   
		IF (@identipo_horario = 'REG')
		BEGIN 
			IF(ISNULL(@sabado,0)=0)
			BEGIN
				INSERT INTO [NOM].[Horario](nombre,tipo_horario,cantdias,canttrabdias,cantdesdias,Hinicio,Hiniciodesc,Hfindesc,Hfin,sab,id_usercreated,id_userupdated)
							VALUES(@nombre,@tipo_Horario,5,5,2,@hinicio,@hiniciodesc,@hfinaldesc,@hfinal,ISNULL(@sabado,0),@id_user,@id_user)
			END
			ELSE BEGIN
				INSERT INTO [NOM].[Horario](nombre,tipo_horario,cantdias,canttrabdias,cantdesdias,Hinicio,Hiniciodesc,Hfindesc,Hfin,sab,id_usercreated,id_userupdated)
							VALUES(@nombre,@tipo_Horario,6,5,1,@hinicio,@hiniciodesc,@hfinaldesc,@hfinal,0,@id_user,@id_user)	
				SET @hijo = SCOPE_IDENTITY();

				INSERT INTO [NOM].[Horario](id_padre,nombre,tipo_horario,canttrabdias,Hinicio,Hfin,sab,id_usercreated,id_userupdated)
							VALUES(@hijo,@nombre,@tipo_Horario,1,@hiniciosab,@hfinalsab,@sabado,@id_user,@id_user)
			END
		END
		ELSE		
		IF (@identipo_horario = 'CXD')
		BEGIN
				INSERT INTO [NOM].[Horario](nombre,tipo_horario,cantdias,canttrabdias,cantdesdias,Hinicio,Hiniciodesc,Hfindesc,Hfin,id_usercreated,id_userupdated)
							VALUES(@nombre,@tipo_Horario,1,1,@cadaxdia,@hinicio,@hiniciodesc,@hfinaldesc,@hfinal,@id_user,@id_user)
		END
		ELSE
		IF (@identipo_horario = 'IREG')
		BEGIN
				EXEC sp_xml_preparedocument @manejador OUTPUT, @irregular; 				
								
				INSERT INTO @temp(hini, hinidesc, hfindesc, hfin)
				SELECT horaini, hinidesc, hfindesc, horafin  
				FROM OPENXML(@manejador, N'items/item') 
				WITH (  horaini VARCHAR(5) '@hini',
						hinidesc VARCHAR(5) '@hinidesc',
						hfindesc VARCHAR(5) '@hfindesc',
						horafin VARCHAR(5) '@hfin'
				) AS P;
				
				EXEC sp_xml_removedocument @manejador; 


				INSERT INTO [NOM].[Horario](nombre,tipo_horario,cantdias,canttrabdias,cantdesdias,Hinicio,Hiniciodesc,Hfindesc,Hfin,id_usercreated,id_userupdated)
							VALUES(@nombre,@tipo_Horario,@diastrab,1,@diasdesc,(SELECT hini FROM @temp WHERE id = 1),(SELECT hinidesc FROM @temp WHERE id = 1),(SELECT hfindesc FROM @temp WHERE id = 1),(SELECT hfin FROM @temp WHERE id = 1),@id_user,@id_user)

				SET @hijo = SCOPE_IDENTITY();
				select * from [NOM].[Horario] where id = @hijo

				INSERT INTO [NOM].[Horario](
						id_padre,
						nombre,
						tipo_horario,
						canttrabdias,
						--Hinicio,
						--Hiniciodesc,
						--Hfindesc,
						--Hfin,
						id_usercreated,
						id_userupdated)
				SELECT	
						@hijo,
						@nombre,
						@tipo_Horario,
						1,
						--hini,
						--hinidesc,
						--hfindesc,
						--hfin,
						@id_user,
						@id_user 
				FROM @temp WHERE id > 1 AND ISNULL(hini,0)!= 0
				
							
		END

	END
	--ELSE
	--BEGIN
		
			
	--	UPDATE  [NOM].[Entidades_de_Salud]
	--	SET nombre				= @nombre		,
	--		cod_ext				= @codext		,
	--		cuenta_gasto		= @cuenta_gasto	,
	--		contrapartida		= @contrapartida,
	--		updated				= GETDATE()		,
	--		id_userupdated		= @id_user
	--	WHERE id = @id;;	
		
	--END

	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	SET @error = 'Error '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);		
	ROLLBACK TRANSACTION;
END CATCH

--SELECT @id_return id ;
