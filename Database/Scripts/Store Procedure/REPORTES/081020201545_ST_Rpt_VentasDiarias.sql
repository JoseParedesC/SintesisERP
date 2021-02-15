--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[ST_Rpt_VentasDiarias]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
 DROP PROCEDURE [Dbo].[ST_Rpt_VentasDiarias] 
GO
CREATE PROCEDURE [Dbo].[ST_Rpt_VentasDiarias] 
@fechaini varchar(10),
@fechafin varchar(10),
@idcaja int = 0
 
AS
/***************************************
*Nombre:		[Dbo].[ST_Rpt_VentasDiarias]
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
	
	SELECT rptconsecutivo consecutivo, fechadoc, cliente, username, total, subtotal, iva, descuento, centrocosto caja
	FROM Dbo.VW_MOVFacturas
	WHERE fechadoc
		BETWEEN @fechaini  AND @fechafin 
	AND estado='PROCESADO'  
	AND( Isnull(@idcaja,0) = 0 OR id_centrocostos = @idcaja)
	
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
