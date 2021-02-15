--liquibase formatted sql
--changeset ,jteheran:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovEntradaDelArticulo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [dbo].[ST_MovEntradaDelArticulo]
GO
CREATE PROCEDURE [dbo].[ST_MovEntradaDelArticulo]
   @id_articulo [INT],
	@id_proveedor	[int] = null,
	@id_proveedorfle	[int] = null,
	@id_entrada		[int],
	@flete			[NUMERIC] (18,2) = 0,
	@anticipo		[NUMERIC] (18,2) = 0
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_MovEntradaDelArticulo]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		09/05/2017
*Desarrollador: (JTOUS)
***************************************/
DECLARE @error VARCHAR(MAX), @id int,@id_catFiscal int,@id_cat int,@retiene bit;
BEGIN TRY
BEGIN TRAN

	DELETE [dbo].[MovEntradasSeriesTemp] WHERE id_itemstemp = @id_articulo
	DELETE [dbo].[MOVEntradaLotesTemp] WHERE id_itemtemp = @id_articulo
	DELETE [dbo].[MOVEntradasItemsTemp] Where  id			= @id_articulo;
	SET @id_catFiscal = (SELECT id_catfiscal FROM CNT.Terceros T  WHERE T.id = @id_proveedor);
	SELECT @id_cat = F.id, @retiene =  F.retiene FROM  CNTCategoriaFiscal F WHERE F.id = @id_catFiscal AND F.retiene != 0

	SELECT 		
		R.porfuente, R.retfuente, R.poriva, R.retiva, R.porica, R.retica, R.costo Tcosto, R.iva+R.ivaFlete Tiva ,R.tinc Tinc,R.descuento Tdesc, R.total Ttotal, @anticipo valoranticipo
	FROM 
		Dbo.ST_FnCalRetenciones(@id_proveedor, @id_entrada, @flete,'EN', 0, @id_proveedorfle,@id_catFiscal,@id_cat,@retiene) R;	

COMMIT TRAN;
END TRY
BEGIN CATCH
		ROLLBACK TRAN;
	    --Getting the error description
	    SELECT @error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	    -- save the error in a Log file
	    RAISERROR(@error,16,1);
	    RETURN  
END CATCH