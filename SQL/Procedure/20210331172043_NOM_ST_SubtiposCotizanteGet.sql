--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_SubtiposCotizanteGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_SubtiposCotizanteGet]
GO
CREATE PROCEDURE [NOM].[ST_SubtiposCotizanteGet]

@id BIGINT, 
@id_user BIGINT

AS

/***************************************
*Nombre:		[NOM].[ST_SubtiposCotizanteGet]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		30/03/2021
*Desarrollador:  JPAREDES
*Descripcion:	Obtiene la informacion del Tipo  decotizante
***************************************/
DECLARE @error VARCHAR(MAX)

BEGIN TRY

	IF(ISNULL(@id,0) = 0)
		RAISERROR('No se ha encontrado el Subtipo de Cotizante',16,0)

	SELECT T.id, T.codigo, T.codigo_externo codigo_ext, T.descripcion detalle FROM [NOM].[SubtiposCotizante] T WHERE id = @id
	

END TRY
BEGIN CATCH	
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);	
END CATCH
