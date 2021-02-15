--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[ST_Rpt_EntradasBodegas]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [Dbo].[ST_Rpt_EntradasBodegas]
GO

CREATE PROCEDURE [dbo].[ST_Rpt_EntradasBodegas] 
@fechaini varchar(10),
@fechafin varchar(10),
@id_bodega int
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_Rpt_EntradasBodegas]
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
	
	SELECT 
		E.id, fechadocumen, fechafactura, numfactura, proveedor, valor, I.bodega--count(1)-- 
	FROM	VW_MOVEntradas E INNER JOIN 
			Dbo.VW_MOVEntradasitems I On E.id = I.id_entrada
	WHERE 
	fechadocumen BETWEEN @fechaini  AND @fechafin 
	AND	(isnull(@id_bodega,0) = 0 or I.id_bodega = @id_bodega) 
	AND E.estado='PROCESADO' 
	GROUP BY E.id, fechadocumen, fechafactura, numfactura, proveedor, valor, I.bodega
	ORDER BY fechadocumen,I.bodega ASC
	
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


