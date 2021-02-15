--liquibase formatted sql
--changeset ,jteheran:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_Rpt_VentasDiariasTotal]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [dbo].[ST_Rpt_VentasDiariasTotal]
GO

CREATE PROCEDURE [dbo].[ST_Rpt_VentasDiariasTotal] 
@fechaini varchar(10),
@fechafin varchar(10),
@idcaja int

AS
/***************************************
*Nombre:		[Dbo].[ST_Rpt_VentasDiariasTotal]
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
	
	SELECT fechadoc fechafac, SUM(F.total) total, SUM(F.subtotal) subtotal, SUM(F.iva) iva, SUM(F.descuento) descuento,SUM(D.totaldevolucion) totaldevol ,F.centrocosto caja
	FROM Dbo.VW_MOVFacturas F LEFT JOIN VW_MOVDevFacturas D ON F.id=D.id_factura AND F.fechadoc=D.fecha
	WHERE fechadoc
		BETWEEN @fechaini  AND @fechafin 
	AND F.estado='PROCESADO'  
	AND( Isnull(@idcaja,0) = 0 OR F.id_centrocostos = @idcaja)
	GROUP BY F.centrocosto, fechadoc,F.consecutivo
	ORDER BY fechadoc ASC
	
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
