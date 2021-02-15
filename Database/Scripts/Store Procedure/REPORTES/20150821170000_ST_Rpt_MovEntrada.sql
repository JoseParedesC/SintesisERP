--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_Rpt_MovEntrada]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_Rpt_MovEntrada]
GO
CREATE PROCEDURE [dbo].[ST_Rpt_MovEntrada] 
@id BIGINT,
@op CHAR (1)
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_Rpt_MovEntrada]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		21/08/2015
*Desarrollador:  Jose Luis Tous P�rez (jtous)
*Descripcion:	Se realizan la consulta de la informacion del reporte de factura de pago caja tirilla
***************************************/
BEGIN
Declare @error varchar(max)
BEGIN TRY		
SET LANGUAGE Spanish
	Declare @id_entra int;

	SET @id_entra = (SELECT TOP 1 CASE WHEN Dbo.ST_FnGetIdList('REVON') = estado THEN id_reversion ELSE id END FROM Dbo.MOVEntradas T Where T.id = @id);

	IF(@op = 'C')
	BEGIN
		SELECT id, estado, fechadocumen, fechafactura, numfactura, proveedor, inc, FormaPago, nombrebodega, fechavence, centrocosto, tipodocumento,
			   flete, costo, iva+ivaflete iva, descuento, valor, retefuente, reteica, reteiva, poriva, porica, porfuente, ISNULL(valoranticipo, 0) anticipo
		FROM Dbo.VW_MOVEntradas
		WHERE id = @id;
	END

	ELSE IF(@op = 'B')
	BEGIN
		SELECT 
			I.id, I.cantidad, I.costo, I.descuento, I.iva, I.costototal, I.flete, I.inc, I.serie,I.codigo, 
			I.presentacion, I.nombre articulo, I.lote lote,	I.lote
		FROM 
			[dbo].[VW_MOVEntradasItems] I
		WHERE 
			I.id_entrada = @id_entra;
	END

	IF(@op = 'S')
	BEGIN
		SELECT serie
		FROM Dbo.MovEntradasSeries
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