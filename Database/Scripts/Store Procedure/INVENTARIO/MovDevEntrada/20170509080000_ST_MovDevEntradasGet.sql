--liquibase formatted sql
--changeset ,jteheran:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovDevEntradasGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MovDevEntradasGet]
GO

CREATE PROCEDURE [dbo].[ST_MovDevEntradasGet] 
	@id [int]
--WITH ENCRYPTION
AS
BEGIN
/***************************************
*Nombre:		[dbo].[ST_MovDevEntradasGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		27/03/17
*Desarrollador: (JTOUS)
***************************************/
	------------------------------------------------------------------------------
	-- Declaring variables Page_Nav
	------------------------------------------------------------------------------
	Declare @ds_error varchar(max), @id_entra int
	
	Begin Try
		SET @id_entra = (SELECT Top 1 CASE WHEN Dbo.ST_FnGetIdList('REVON') = estado THEN id_reversion ELSE id END FROM Dbo.MOVDevEntradas T Where T.id = @id);
		
		Select 
			M.id, 
			id_entrada,
			fechadocumen,
			fechacompra,
			fechafactura,	
			fechavence,		
			numfactura,
			estado,
			id_bodega,
			proveedor,
			id_formaPagos,
			M.porfuente, 
			M.poriva, 
			M.porica,
			costo		[Tcosto],
			iva			[Tiva],
			inc			[Tinc],
			descuento	[Tdesc],
			valor		[Ttotal],
			reteiva		[retiva],
			reteica		[retica],
			retefuente	[retfuente],
			M.ctaanticipo,
			ISNULL(M.valoranticipo, 0) valoranticipo,
			M.centrocosto,
			M.id_tipodoc
		From 
			Dbo.VW_MOVDevEntradas M
		Where 
			id = @id;
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


