--liquibase formatted sql
--changeset ,JPAREDES 1 dbms mssql runOnChange true endDelimiter GO stripComments false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_PrestacionesDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_PrestacionesDelete]
GO
CREATE PROCEDURE [NOM].[ST_PrestacionesDelete]

	@id BIGINT, 
	@id_user BIGINT

AS

/***************************************
*Nombre 		[NOM].[ST_PrestacionesDelete]
-----------------------------------------------------------
*Tipo 			Procedimiento almacenado
*creaci�n 		08/05/2021
*Desarrollador   JPAREDES
*Descripcion 	Guarda la informacion de la seguridad social
***************************************/


DECLARE @error VARCHAR(MAX);
BEGIN TRY

	IF(ISNULL(@id,0) = 0)
		RAISERROR('No se encontró el tipo de Prestacion', 16, 0)

	--IF EXISTS(SELECT 1 FROM [NOM].[Contrato] WHERE id_restacion = @id)
	--	RAISERROR('No se puede eliminar porque existe una referencia', 16, 0)

	DELETE FROM [NOM].[Prestaciones] WHERE id = @id
	

END TRY
BEGIN CATCH	
	SET @error = 'Error  '+ ERROR_MESSAGE();
	RAISERROR(@error,16,0);	
END CATCH
