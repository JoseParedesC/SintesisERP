--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[ST_Rpt_IvaDescontable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [Dbo].[ST_Rpt_IvaDescontable]
GO


CREATE PROCEDURE [dbo].[ST_Rpt_IvaDescontable] 
@fechaini varchar(10),
@fechafin varchar(10),
@idprove int
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_Rpt_IvaDescontable]
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
	
	SELECT F.fechadocumen, proveedor, numfactura factura, id conseint, (F.costo - descuento) base, iva, F.valor 
	FROM  Dbo.VW_MOVEntradas F 
	WHERE estado = 'PROCESADO' 
	AND F.fechadocumen BETWEEN @fechaini  AND @fechafin  AND iva>0
	AND( Isnull(@idprove,0) = 0 OR F.id_proveedor = @idprove)
	
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


