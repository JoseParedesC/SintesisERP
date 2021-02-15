--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[ST_Rpt_MovimientoArticulos]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [Dbo].[ST_Rpt_MovimientoArticulos]
GO

CREATE PROCEDURE [dbo].[ST_Rpt_MovimientoArticulos] 
@fechaini varchar(10),
@fechafin varchar(10),
@idarticulo int,
@idbodega int = NULL
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo][ST_Rpt_MovimientoArticulos]
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
	
	SELECT id_factura Consecutvo, F.Codigo, Presentacion, F.Nombre, B.nombre bodega, Cantidad, Costo, Precio, op Movimiento, Fechamov Fecha
	FROM VW_MOVArticulosTrans F 
	LEFT JOIN Bodegas B ON B.id = F.id_bodega
	WHERE F.ESTADO =dbo.ST_FnGetIdList('PROCE')
	AND ( Isnull(@idarticulo,0) = 0 OR F.id_articulo = @idarticulo)
	AND ( Isnull(@idbodega,0) = 0 OR F.id_bodega = @idbodega)	
	AND F.Fechamov BETWEEN @fechaini  AND @fechafin  
	ORDER BY fechamov ASC
	
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


