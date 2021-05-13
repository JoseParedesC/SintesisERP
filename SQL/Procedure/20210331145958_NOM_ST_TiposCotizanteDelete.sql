--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_TiposCotizanteDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_TiposCotizanteDelete]
GO
CREATE PROCEDURE [NOM].[ST_TiposCotizanteDelete]

@id BIGINT, 
@id_user BIGINT

AS

/***************************************
*Nombre:		[NOM].[ST_TiposCotizanteDelete]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		30/03/2021
*Desarrollador:  JPAREDES
*Descripcion:	Elimina el Tipo de Cotizante
***************************************/

DECLARE @error VARCHAR(MAX)
BEGIN TRY


	IF(ISNULL(@id,0) = 0)
		RAISERROR('No se ha seleccionado ningun Tipo de Cotizante', 16, 0)


	IF EXISTS(SELECT 1 FROM [NOM].[VW_Contratos] C INNER JOIN [NOM].[Tipos_SubtiposCotizantes] T ON C.id_tipo_subtipo = T.id WHERE T.id_tipo = @id)
			RAISERROR('No se puede modificar, se está haciendo referencia hacia él', 16, 0)


	DELETE FROM [NOM].[TiposCotizante] WHERE id = @id
	

END TRY
BEGIN CATCH	
	IF (ERROR_NUMBER() = 3726)
		SET @error =  'Error: No se puede eliminar porque hay una referencia hacia él.'
	ELSE
		SET @error =  'Error: '+ERROR_MESSAGE();

	RAISERROR(@error,16,0);	
END CATCH
