--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[ST_Rpt_ComprasxProductos]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	DROP PROCEDURE  [Dbo].[ST_Rpt_ComprasxProductos]
GO
CREATE PROCEDURE [dbo].[ST_Rpt_ComprasxProductos] 
@fechaini    VARCHAR(10),
@fechafinal  VARCHAR(10),
@id_producto BIGINT=NULL,
@id_user	 BIGINT
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_Rpt_ComprasxProductos]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		15/05/2020
*Desarrollador:  Jeteheran
***************************************/
BEGIN
Declare @error varchar(max)
BEGIN TRY		
SET LANGUAGE Spanish
		SELECT 
		codigo,
		nombre,
		presentacion,
		series,
		serie,
		lote ,
		SUM(cantidad) cantidad,
		SUM(cantidad*valorbruto) costo,
		SUM(descuento*cantidad) descuento,
		SUM(valorbruto*cantidad)+SUM(descuento*cantidad) subtotal,
		SUM(total_iva*cantidad) IVA,
		SUM(total_inc*cantidad) INC,
		@id_user id_user,
		SUM(total) total FROM [VW_Productos_comprados]
		WHERE CONVERT(VARCHAR(10), fechadocumen, 120) BETWEEN @fechaini and @fechafinal  AND( Isnull(@id_producto,0) = 0 OR id_producto=@id_producto)
		GROUP BY codigo,nombre,series, lote,presentacion,serie
	
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


