--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_Rpt_MovCotizacion]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_Rpt_MovCotizacion]
GO
CREATE PROCEDURE [Dbo].[ST_Rpt_MovCotizacion] 
@id BIGINT,
@op CHAR (1)
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_Rpt_MovCotizacion]
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
	
		IF(@op = 'C')
	BEGIN
		SELECT F.id, F.fechacot, F.estado, F.iva, F.descuento, 
		F.subtotal, F.total, F.cliente, F.vendedor, F.turno, F.username,F.bodega, F.inc
		FROM Dbo.VW_MOVCotizaciones F
		WHERE F.id = @id;
	END
	ELSE IF(@op = 'B')
	BEGIN
		SELECT codigo, nombre, cantidad, precio,iva,descuento,(cantidad*precio+(iva*cantidad)-descuento) total, inc
		FROM 
			[dbo].[VW_MOVCotizacionItems] I
		WHERE 
			I.id_cotizacion = @id
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
