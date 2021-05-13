--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_TiposCotizanteGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_TiposCotizanteGet]
GO
CREATE PROCEDURE [NOM].[ST_TiposCotizanteGet]

@id BIGINT, 
@id_user BIGINT

AS


/***************************************
*Nombre:		[NOM].[ST_TiposCotizanteGet]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		30/03/2021
*Desarrollador:  JPAREDES
*Descripcion:	Obtiene la informacion del Tipo  decotizante
***************************************/
DECLARE @error VARCHAR(MAX)
--DECLARE @subtipos VARCHAR(MAX), @valores VARCHAR(MAX);
BEGIN TRY

	IF(ISNULL(@id,0) = 0)
		RAISERROR('No se ha encontrado el Tipo de Cotizante',16,0)

	DECLARE @subtipos VARCHAR(MAX), @valores VARCHAR(MAX);
	SELECT @subtipos = COALESCE(@subtipos +',', '') + CAST(id_subtipo AS VARCHAR) FROM [NOM].[Tipos_SubtiposCotizantes] WHERE id_tipo = @id

	SELECT T.id, 
		   T.codigo, 
		   T.codigo_externo codigo_ext, 
		   T.descripcion descr, 
		   CAST(ISNULL(T.detalle,0) AS BIT) detalle, 
		   ISNULL(@subtipos,'') id_subtipo
	FROM [NOM].[TiposCotizante] T
	WHERE T.id = @id
	

END TRY
BEGIN CATCH	
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);	
END CATCH
