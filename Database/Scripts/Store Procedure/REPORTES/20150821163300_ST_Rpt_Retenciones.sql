--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_Rpt_Retenciones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_Rpt_Retenciones]
GO
CREATE PROCEDURE dbo.ST_Rpt_Retenciones
@fechaini varchar(10),
@fechafin varchar(10),
@id_proveedor int,
@op VARCHAR(10)

 
AS
/***************************************
*Nombre:		[Dbo].[ST_Rpt_Retenciones]
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
	
	IF(@op = 'FUENTE')
	BEGIN
		SELECT fechadocumen, (costo - descuento) base, proveedor, numfactura, id consecutivo, retefuente
		FROM Dbo.VW_MOVEntradas
		WHERE CONVERT(VARCHAR(16),rptfechadocumen,120) BETWEEN  @fechaini+' 00:00'  AND @fechafin+' 23:59'  
		AND (ISNULL(@id_proveedor,0) = 0 OR id_proveedor = @id_proveedor)
		AND Estado = 'PROCESADO' 
	END
	ELSE IF(@op = 'IVA')
	BEGIN
		SELECT fechadocumen, (costo - descuento) base, proveedor, numfactura, id consecutivo, reteiva
		FROM Dbo.VW_MOVEntradas
		WHERE CONVERT(VARCHAR(16),rptfechadocumen,120) BETWEEN  @fechaini+' 00:00'  AND @fechafin+' 23:59'
		AND (ISNULL(@id_proveedor,0) = 0 OR id_proveedor = @id_proveedor)
		AND Estado = 'PROCESADO' 
	END
	ELSE IF(@op = 'ICA')
	BEGIN
		SELECT fechadocumen, (costo - descuento) base, proveedor, numfactura, id consecutivo, reteica
		FROM Dbo.VW_MOVEntradas
		WHERE CONVERT(VARCHAR(16),rptfechadocumen,120) BETWEEN  @fechaini+' 00:00'  AND @fechafin+' 23:59'
		AND (ISNULL(@id_proveedor,0) = 0 OR id_proveedor = @id_proveedor)
		AND Estado = 'PROCESADO' 
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
