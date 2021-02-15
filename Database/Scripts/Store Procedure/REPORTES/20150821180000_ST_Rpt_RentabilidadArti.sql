--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_Rpt_RentabilidadArti]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_Rpt_RentabilidadArti]
GO
CREATE PROCEDURE [Dbo].[ST_Rpt_RentabilidadArti] 
@fechaini varchar(10),
@fechafin varchar(10)--,
--@idcaja int
 
AS
/***************************************
*Nombre:		[Dbo].[ST_Rpt_RentabilidadArti]
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
	
	SELECT F.consecutivo, F.rptconsecutivo, I.codigo, I.presentacion, I.nombre, I.cantidad, precio, costo, 
	(I.precio  * cantidad) preciotot, (I.costo * cantidad) costotot, (precio - costo) * cantidad renta, ((precio - costo) / costo * 100) porrenta		  
	FROM Dbo.VW_MOVFacturaItems I 
	INNER JOIN Dbo.VW_MOVFacturas F ON F.id = I.id_factura
	WHERE I.estado = 12/*estado = 'PROCESADO'and precio != 0*/ 
	AND F.fechadoc BETWEEN @fechaini  AND @fechafin  
	--AND( Isnull(@idcaja,0) = 0 OR F.id_caja = @idcaja)
	
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
