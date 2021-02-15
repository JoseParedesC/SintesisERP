--liquibase formatted sql
--changeset ,CZULBARAN:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovCotizacionGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MovCotizacionGet]
GO
CREATE PROCEDURE dbo.ST_MovCotizacionGet
	@id [int]
 
AS
BEGIN
/***************************************
*Nombre:		[dbo].[ST_MovCotizacionGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		27/03/17
*Desarrollador: (JTOUS)
***************************************/
	------------------------------------------------------------------------------
	-- Declaring variables Page_Nav
	------------------------------------------------------------------------------
	Declare @ds_error varchar(max)
	
	Begin Try
		
		Select 
			P.id, 
			P.fechacot,
			P.iva Tiva,
			P.inc Tinc,
			P.subtotal Tprecio,
			P.total Ttotal,
			P.cliente,
			P.vendedor,
			P.id_bodega,
			P.id_cliente,
			P.estado,
			P.descuento Tdctoart,
			B.nombre
		From 
			Dbo.VW_MOVCotizaciones P
			LEFT JOIN dbo.Bodegas B ON B.id = P.id_bodega
		Where 
			P.id = @id;
		
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
