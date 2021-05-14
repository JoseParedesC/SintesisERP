--liquibase formatted sql
--changeset ,JPAREDES 1 dbms mssql runOnChange true endDelimiter GO stripComments false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_PrestacionesGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_PrestacionesGet]
GO
CREATE PROCEDURE [NOM].[ST_PrestacionesGet]

	@id BIGINT, 
	@id_user BIGINT

AS

/***************************************
*Nombre 		[NOM].[ST_PrestacionesGet]
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

	SELECT P.id id_prestacion, P.tipo_prestacion, P.nombre, ISNULL(P.codigo,0) codigo, P.provision, C.id id_cuenta, CONCAT(C.subcodigo, ' - ' , C.nombre) ds_cuenta FROM [NOM].[Prestaciones] P INNER JOIN [dbo].[CNTCuentas] C ON C.id = P.contrapartida WHERE P.id = @id
	

END TRY
BEGIN CATCH	
	SET @error = 'Error  '+ ERROR_MESSAGE();
	RAISERROR(@error,16,0);	
END CATCH
