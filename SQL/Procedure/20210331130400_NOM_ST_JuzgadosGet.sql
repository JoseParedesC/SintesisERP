--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_JuzgadosGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_JuzgadosGet]
GO
CREATE PROCEDURE [NOM].[ST_JuzgadosGet]

@id BIGINT, 
@id_user BIGINT

AS

/***************************************
*Nombre:		[NOM].[ST_JuzgadosGet]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		30/03/2021
*Desarrollador:  JPAREDES
*Descripcion:	Obtiene la informacion del juzgado
***************************************/
DECLARE @error VARCHAR(MAX)

BEGIN TRY

	IF(ISNULL(@id,0) = 0)
		RAISERROR('No se ha encontrado el Juzgado',16,0)

	SELECT J.id, J.codigo, J.codigo_externo codigo_ext, J.descripcion detalle FROM [NOM].[Juzgados] J WHERE id = @id
	

END TRY
BEGIN CATCH	
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);	
END CATCH
