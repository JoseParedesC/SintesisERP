--liquibase formatted sql
--changeset ,JARCINIEGAS:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_ContratoGetPersona]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_ContratoGetPersona]
GO
CREATE PROCEDURE [NOM].[ST_ContratoGetPersona]
	
	@id_empleado INT ,
	@iden VARCHAR (20) = NULL,
	@id_user INT 
AS

/***************************************
*Nombre:		[NOM].[ST_ContratoGetPersona]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		24/11/2020
*Desarrollador: JPAREDES
*Descripcion:	
***************************************/

DECLARE @error VARCHAR(MAX)

BEGIN TRY

	SELECT	id, --
			iden+' - '+CONVERT(CHAR(1),digitoverificacion) iden,  --//
			razonsocial  --

	FROM [NOM].[VW_Empleados] EM
	WHERE EM.id = @id_empleado 


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