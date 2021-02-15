--liquibase formatted sql
--changeset ,CZULBARAN:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovConversionGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1) 
DROP PROCEDURE dbo.ST_MovConversionGet
GO
CREATE PROCEDURE [dbo].[ST_MovConversionGet] 
	@id [int]

AS
BEGIN
/***************************************
*Nombre:		[dbo].[ST_MovConversionGet]
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
		SET @id_entra = (SELECT Top 1 CASE WHEN Dbo.ST_FnGetIdList('REVON') = estado THEN id_reversion ELSE id END FROM Dbo.MOVConversiones T Where T.id = @id);
		
		Select 
			M.id, 
			M.fechadocumen,
			M.estado,
			M.costo [Ttotal],
			M.id_centrocosto,
			M.centrocosto,
			M.id_bodegadef,
			M.bodega,
			M.id_tipodoc
		From 
			Dbo.VW_MOVConversiones M
		Where 
			id = @id;

		Select 
				id,	
				codigo, 
				nombre, 
				bodega, 
				cantidad, 
				costo, 
				costototal, 
				serie, 
				CASE WHEN config>0 THEN 1 ELSE 0 END config
		From 
			Dbo.VW_MOVConversionesItems M
		Where 
			id_conversion = @id_entra;
		
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
