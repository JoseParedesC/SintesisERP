--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovDevFacturasGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MovDevFacturasGet]
GO

CREATE PROCEDURE [dbo].[ST_MovDevFacturasGet]
	@id [int]
--WITH ENCRYPTION
AS
BEGIN
/***************************************
*Nombre:		[dbo].[ST_MovDevFacturasGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		27/03/17yo tambuen
*Desarrollador: (JTOUS)
***************************************/
	------------------------------------------------------------------------------
	-- Declaring variables Page_Nav
	------------------------------------------------------------------------------
	Declare @ds_error varchar(max), @id_dev int
	
	Begin Try
		SET @id_dev = (SELECT Top 1 CASE WHEN Dbo.ST_FnGetIdList('REVON') = estado THEN id_reversion ELSE id END FROM Dbo.MOVDevFactura T Where T.id = @id);
		
		Select 
			P.id, 
			P.id_tipodoc,
			P.id_centrocostos,
			P.Centrocosto,
			P.id_ctaant,
			P.cuenta_ant,
			P.valoranticipo,
			P.fecha,
			P.id_factura,
			P.consecutivo + ' ('+CAST((id_factura) AS VARCHAR)+')' factura,
			P.iva Tiva,
			P.inc Tinc,
			P.descuento Tdctoart,
			P.subtotal Tprecio,
			P.total Ttotal,			
			P.estado,
			P.isFE,
			P.id_vendedor,
			P.vendedor
		From 
			Dbo.VW_MOVDevFacturas P
		Where 
			P.id = @id;
	
	End Try
    Begin Catch
	--Getting the error description
	Set @ds_error   =  ERROR_MESSAGE()
	-- save the error in a Log file
	RaisError(@ds_error,16,1)
	return
	End Catch
END