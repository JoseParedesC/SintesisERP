--liquibase formatted sql
--changeset ,JARCINIEGAS:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_AfiliadosSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_AfiliadosSave]
GO
CREATE PROCEDURE [NOM].[ST_AfiliadosSave]

@id					BIGINT			= NULL,
@tipoiden			INT					  , --
@identificacion		VARCHAR  (20)		  , --
@pnombre			VARCHAR  (30)		  , --
@snombre			VARCHAR  (30)		  , --
@papellido			VARCHAR  (30)		  , --
@sapellido			VARCHAR  (30)		  , --
@contrato			BIGINT			= null, --


@id_user			INT						--



AS

/*****************************************
*Nombre 		[NOM].[ST_AfiliadosSave]
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
					   
			INSERT INTO [NOM].[Afiliados](id_tipoiden,identificacion,primer_nombre,segundo_nombre,primer_apellido,segundo_apellido,id_contrato,id_usercreated,id_userupdated)
			VALUES(@tipoiden, @identificacion, @pnombre, @snombre, @papellido, @sapellido, 2, @id_user,@id_user)	
	END
	ELSE
	BEGIN
		
			
		UPDATE  [NOM].[Afiliados]
		SET identificacion		= @identificacion	,
			id_tipoiden			= @tipoiden			,
			primer_nombre		= @pnombre			,
			segundo_nombre		= @snombre			,
			primer_apellido		= @papellido		,
			segundo_apellido	= @sapellido		,
			id_contrato			= 2			,
			updated				= GETDATE()			,
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
