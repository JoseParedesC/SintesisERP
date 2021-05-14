--liquibase formatted sql
--changeset ,JARCINIEGAS:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_CargosSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_CargosSave]
GO
CREATE PROCEDURE [NOM].[ST_CargosSave]

@id					BIGINT			= NULL,
@nombre				VARCHAR  (50)		  , --
@funcionesgen		VARCHAR  (MAX)		  , --
@funcionesesp		BIT					  , --


@id_user			INT						--



AS

/*****************************************
*Nombre 		[NOM].[ST_EmpleadosSave]
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
					   
			INSERT INTO [NOM].[Cargo](nombre, funciones, funciones_esp,id_usercreated,id_userupdated)
			VALUES(@nombre, @funcionesgen, @funcionesesp, @id_user,@id_user)	
	END
	ELSE
	BEGIN
		
			
		UPDATE  [NOM].[Cargo]
		SET nombre				= @nombre			,
			funciones			= @funcionesgen		,
			funciones_esp		= @funcionesesp		,
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
