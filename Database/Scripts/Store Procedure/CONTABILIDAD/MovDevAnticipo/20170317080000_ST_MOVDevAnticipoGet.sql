--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovDevAnticipoGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MovDevAnticipoGet]
GO
CREATE PROCEDURE dbo.ST_MovDevAnticipoGet
	@id [int]
--WITH ENCRYPTION
AS
BEGIN
/***************************************
*Nombre:		[dbo].[ST_MovDevAnticipoGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		27/03/17
*Desarrollador: (JTOUS)
***************************************/
	------------------------------------------------------------------------------
	-- Declaring variables Page_Nav
	------------------------------------------------------------------------------
	Declare @ds_error varchar(max);
	
	Begin Try
		
		Select 
			id, valor, tercero, id_tercero, tipotercero,descripcion, fecha, estado,T.id_cta,cuenta,T.id_tipodoc,T.id_centrocostos,T.centrocostos,T.id_formapago,T.formapago
		From Dbo.VW_MOVDevAnticipos T		
		Where 
			T.id = @id;
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
