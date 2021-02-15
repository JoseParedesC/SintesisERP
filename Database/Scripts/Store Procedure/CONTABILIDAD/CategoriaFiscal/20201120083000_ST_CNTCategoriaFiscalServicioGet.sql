--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[ST_CNTCategoriaFiscalServicioGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [Dbo].[ST_CNTCategoriaFiscalServicioGet]
GO
CREATE PROCEDURE [dbo].[ST_CNTCategoriaFiscalServicioGet]
	@id [int] = null,
	@id_user [int]
--WITH ENCRYPTION
AS
BEGIN
/***************************************
*Nombre:		[dbo].[ST_CNTCategoriaFiscalServicioGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		20/11/20
*Desarrollador: (JETEHERAN)
***************************************/
	Declare @ds_error varchar(max)
	
	Begin Try
		Select id, id_servicio, servicio,
		id_retefuente, id_reteica, id_reteiva, fuentebase, icabase, ivabase
		From  Dbo.VW_CNTCategoriaFiscalServicio
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


