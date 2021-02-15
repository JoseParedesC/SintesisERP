--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_Rpt_MovDevEntrada]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_Rpt_MovDevEntrada]
GO
CREATE PROCEDURE [dbo].[ST_Rpt_MovDevEntrada] 
@id BIGINT,
@op CHAR (1)
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_Rpt_MovDevEntrada]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		21/08/2015
*Desarrollador:  Jose Luis Tous Pérez (jtous)
*Descripcion:	Se realizan la consulta de la informacion del reporte de factura de pago caja tirilla
***************************************/
BEGIN
Declare @error varchar(max)
BEGIN TRY		
SET LANGUAGE Spanish
	Declare @id_entra int;
	SET @id_entra = (SELECT TOP 1 CASE WHEN Dbo.ST_FnGetIdList('REVON') = estado THEN id_reversion ELSE id END FROM Dbo.MOVDevEntradas T Where T.id = @id);

	IF(@op = 'C')
	BEGIN
		SELECT id, estado, fechadocumen, fechacompra, fechafactura, numfactura, proveedor, FormaPago, nombrebodega, fechavence, centrocosto, tipodocumento,	
			   costo, iva, descuento, valor, porfuente, poriva, porica, retefuente,reteica,reteiva,inc
		FROM VW_MOVDevEntradas
		WHERE id = @id;
	END
	ELSE IF(@op = 'B')
	BEGIN
		SELECT 
			I.id, I.cantidad, I.costo, I.descuento, I.iva, I.costototal, I.inc, I.serie, I.codigo, 
			I.presentacion, I.nombre articulo, I.lote lote,	I.lote
		FROM 
			[dbo].[VW_MOVDevEntradaItems] I
		--INNER JOIN Dbo.VW_Articulos A ON A.id = I.id_articulo
		--INNER JOIN Dbo.Bodegas B ON I.id_bodega = B.id	
		WHERE 
			I.id_devolucion = @id_entra;
	END
	IF(@op = 'S')
	BEGIN
		SELECT serie
		FROM Dbo.MovDevEntradasSeries
		WHERE id_items = @id;
	END

END TRY
BEGIN Catch
	    --Getting the error description
	    Select @error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	    -- save the error in a Log file
	    RaisError(@error,16,1)
	    Return  
	End Catch
END
GO
