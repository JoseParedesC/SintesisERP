--liquibase formatted sql
--changeset ,kmartinez:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovFacturasRecurrGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [dbo].[ST_MovFacturasRecurrGet]
GO

CREATE PROCEDURE [dbo].[ST_MovFacturasRecurrGet]
	@id [int],
	@id_temp VARCHAR(255),
	@op CHAR(1)
--WITH ENCRYPTION
AS
BEGIN
/***************************************
*Nombre:		[dbo].[ST_MovFacturasRecurrGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:	    16/10/2020 9:23:50
*Desarrollador: (Kmartinez) Kevin Jose Martinez Teheran
***************************************/
	------------------------------------------------------------------------------
	-- Declaring variables Page_Nav
	------------------------------------------------------------------------------
	Declare @ds_error varchar(max), @id_fact int
	
	Begin Try
		--SET @id_fact = (SELECT Top 1 CASE WHEN Dbo.ST_FnGetIdList('REVON') = estado THEN id_reversion ELSE id END FROM [dbo].[MOVFacturasRecurrentes] T Where T.id = @id);
		
		Select 			
			P.id, 
			P.fechadoc fechafac,
			P.iva Tiva,
			P.inc Tinc,
			P.descuento Tdctoart,
			P.subtotal Tprecio,
			P.total Ttotal,
			P.cliente,
			P.id_cliente,
			P.estado,
			P.id_vendedor,
			P.vendedor,
		    0 valoranticipo,
			--P.id_ctaant,
			--P.cuentaant,
			P.id_tipodoc,
			P.id_centrocostos,
			P.centrocosto,
			P.isfe,
			p.id_formapagos,
			'' id_bodega
		From 
			Dbo.VW_MOVFacturasRecurrentes P
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