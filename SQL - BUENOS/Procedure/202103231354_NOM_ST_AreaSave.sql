--liquibase formatted sql
--changeset ,JARCINIEGAS:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_AreaSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_AreaSave]
GO
CREATE PROCEDURE [NOM].[ST_AreaSave]

@id					BIGINT			= NULL,
@nombre				VARCHAR  (50)		  , --
@sueldo				BIGINT			= NULL,
@hra_ext			BIGINT			= NULL,
@comi				BIGINT			= NULL,
@boni				BIGINT			= NULL,
@auxtrans			BIGINT			= NULL,
@cesan				BIGINT			= NULL,
@intcesan			BIGINT			= NULL,
@prima_ser			BIGINT			= NULL,
@vacas				BIGINT			= NULL,
@arl				BIGINT			= NULL,
@eps				BIGINT			= NULL,
@pension			BIGINT			= NULL,
@fspension			BIGINT			= NULL,--de momento no sirve(no sé si se guarda o no)
@cajacomp			BIGINT			= NULL,
@icbf				BIGINT			= NULL,
@sena				BIGINT			= NULL,

@id_user			INT						--



AS

/*****************************************
*Nombre 		[NOM].[ST_AreaSave]
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
	
	DECLARE   @error VARCHAR(MAX);
	IF(ISNULL(@id,0) = 0) 
	BEGIN

		IF EXISTS(SELECT 1 FROM [NOM].[Area] WHERE nombre = @nombre)
		RAISERROR('Ya existe un area con este nombre',16,0)
					   
			INSERT INTO [NOM].[Area](	nombre, 
										id_cuen_Sueldo,
										id_cuen_Horas_extras,
										id_cuen_Comisiones,
										id_cuen_Bonificaciones,
										id_cuen_Aux_transporte,
										id_cuen_Cesantias,
										id_cuen_Int_cesantias,
										id_cuen_Prima_servicios,
										id_cuen_Vacaciones,
										id_cuen_ARL,
										id_cuen_Aprts_EPS,
										id_cuen_Aprts_AFP,
										id_cuen_FonSolPen,
										id_cuen_Aprts_CCF,
										id_cuen_ICBF,
										id_cuen_SENA,
										id_usercreated,
										id_userupdated)			
			VALUES(	@nombre, 
					@sueldo, 
					@hra_ext, 
					@comi, 
					@boni, 
					@auxtrans, 
					@cesan,		
					@intcesan,	
					@prima_ser,	
					@vacas,		
					@arl,		
					@eps,		
					@pension,
					@fspension,	
					@cajacomp,	
					@icbf,		
					@sena, 
					@id_user,
					@id_user)	
	END
	ELSE
	BEGIN
		
			
		UPDATE  [NOM].[Area]
		SET nombre					=	@nombre			,
			id_cuen_Sueldo			=	@sueldo		 	,
			id_cuen_Horas_extras	=	@hra_ext	 	,
			id_cuen_Comisiones		=	@comi 		 	,
			id_cuen_Bonificaciones	=	@boni 		 	,
			id_cuen_Aux_transporte	=	@auxtrans	 	,
			id_cuen_Cesantias		=	@cesan		 	,
			id_cuen_Int_cesantias	=	@intcesan	 	,
			id_cuen_Prima_servicios	=	@prima_ser	 	,
			id_cuen_Vacaciones		=	@vacas		 	,
			id_cuen_ARL				=	@arl		 	,
			id_cuen_Aprts_EPS		=	@eps		 	,
			id_cuen_Aprts_AFP		=	@pension	 	,
			id_cuen_FonSolPen		=	@fspension	 	,
			id_cuen_Aprts_CCF		=	@cajacomp		,
			id_cuen_ICBF			=	@icbf		 	,
			id_cuen_SENA			=	@sena 		 	,
			updated					= GETDATE()			,
			id_userupdated		= @id_user
		WHERE id = @id;;	
		
	END

	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	SET @error = 'Error '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);		
	ROLLBACK TRANSACTION;
END CATCH

--SELECT @id_return id ;
