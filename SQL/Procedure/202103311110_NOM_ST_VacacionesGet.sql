--liquibase formatted sql
--changeset ,JARCINIEGAS:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_VacacionesGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_VacacionesGet]
GO
CREATE PROCEDURE [NOM].[ST_VacacionesGet]
	
	@id INT ,
	@id_user INT 
AS

/***************************************
*Nombre:		[CRE].[ST_VacacionesGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		24/11/2020
*Desarrollador: JPAREDES
*Descripcion:	
***************************************/

DECLARE @error VARCHAR(MAX)

BEGIN TRY


	SELECT	id, --
			nombre,  --//
			contrapartida id_contrapartida,
			(SELECT CU.codigo+' - '+ CU.nombre FROM dbo.VW_CNTCuentas CU WHERE CU.id = contrapartida) contrapartida,
			provision


	FROM [NOM].[Vacaciones]
	WHERE id = @id
	

END TRY
BEGIN CATCH
--Getting the error description
	Set @error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	-- save the error in a Log file
	RAISERROR(@error,16,1)
	RETURN
END CATCH