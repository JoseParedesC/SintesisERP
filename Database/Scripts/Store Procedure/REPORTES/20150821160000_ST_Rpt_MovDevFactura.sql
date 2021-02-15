--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_Rpt_MovDevFactura]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_Rpt_MovDevFactura]
GO
CREATE PROCEDURE [Dbo].[ST_Rpt_MovDevFactura] 
@id BIGINT,
@op CHAR (1)
 
AS
/***************************************
*Nombre:		[Dbo].[ST_Rpt_MovDevFactura]
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
	Declare @id_dev int;
	SET @id_dev = (SELECT Top 1 CASE WHEN Dbo.ST_FnGetIdList('REVON') = estado THEN id_reversion ELSE id END FROM Dbo.MOVDevFactura T Where T.id = @id);
	IF(@op = 'C')
	BEGIN
		SELECT id, fecha, id_factura, estado, consecutivo, subtotal, iva, descuento, total, caja, username		
		FROM Dbo.VW_MOVDevFacturas
		WHERE id = @id;
	END
	ELSE IF(@op = 'B')
	BEGIN
		SELECT 
			codigo, presentacion, nombre, cantidad, precio, iva, descuento, total, bodega
		FROM 
			[dbo].[VW_MOVDevFacturaItems] I
		WHERE 
			I.id_devolucion = @id_dev
		
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
