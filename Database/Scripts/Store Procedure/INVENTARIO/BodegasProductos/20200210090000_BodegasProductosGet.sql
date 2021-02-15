--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[BodegasProductosGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE Dbo.BodegasProductosGet
GO

CREATE PROCEDURE [dbo].[BodegasProductosGet]
	@id [int] = null,
	@id_user [int]
--WITH ENCRYPTION
AS
BEGIN
/***************************************
*Nombre:		[dbo].[BodegasProductosGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		10/02/20
*Desarrollador: (Jeteme)
***************************************/
	Declare @ds_error varchar(max)
	
	Begin Try
		Select  id, [id_producto], [producto], [id_bodega], [bodega],[stockmin],[stockmax] ,
				[updated], [id_usercreated], [id_userupdated]
						From  dbo.VW_BodegasProductos
		Where id =@id;
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


