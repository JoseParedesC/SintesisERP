--liquibase formatted sql
--changeset ,JTOUS:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_CNTResolucionesGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_CNTResolucionesGet]
GO
CREATE PROCEDURE [dbo].[ST_CNTResolucionesGet]
	@id [int] = null,
	@id_user [int]
 
AS
BEGIN
/***************************************
*Nombre:		[PV].[SP_CNTResolutionesGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		09/04/17
*Desarrollador: (JTOUS)
***************************************/
	------------------------------------------------------------------------------
	-- Declaring variables Page_Nav
	------------------------------------------------------------------------------
	Declare @ds_error varchar(max)
	
	Begin Try
		Select id, resolucion, leyenda, fechainicio, fechafin, rangoini, rangofin, prefijo, consecutivo, id_ccosto, isfe
		From  VW_resoluciones
		Where id = @id;			
		
	End Try
    Begin Catch
	--Getting the error description
	Set @ds_error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	-- save the error in a Log file
	RaisError(@ds_error,16,1)
	return
	End Catch
END

GO


