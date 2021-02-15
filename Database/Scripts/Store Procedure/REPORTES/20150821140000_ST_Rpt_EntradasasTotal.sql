--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_Rpt_EntradasasTotal]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_Rpt_EntradasasTotal]
GO

CREATE PROCEDURE [Dbo].[ST_Rpt_EntradasasTotal] 
@fechaini varchar(10),
@fechafin varchar(10)
 
AS
/***************************************
*Nombre:		[Dbo].[ST_Rpt_EntradasasTotal]
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
	
	SELECT fechadocumen, fechafactura, numfactura, proveedor, costo, iva, descuento, flete, valor,retefuente, reteica, reteiva
	FROM Dbo.VW_MOVEntradas
	WHERE fechadocumen
		BETWEEN @fechaini  AND @fechafin 
	AND estado='PROCESADO' 
	ORDER BY fechadocumen ASC
	
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
