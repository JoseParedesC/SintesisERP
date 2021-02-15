--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_Rpt_MovOrdenCompra]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_Rpt_MovOrdenCompra]
GO

CREATE PROCEDURE [dbo].[ST_Rpt_MovOrdenCompra] 
@id BIGINT,
@op CHAR (1)
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_Rpt_MovEntrada]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		21/08/2015
*Desarrollador:  Jose Luis Tous P�rez (jtous)
*Descripcion:	Se realizan la consulta de la informacion del reporte de factura de pago caja tirilla
***************************************/
BEGIN
Declare @error varchar(max)
BEGIN TRY		
SET LANGUAGE Spanish
	Declare @id_orden int;
	SET @id_orden = (SELECT Top 1 id  FROM Dbo.MovOrdenCompras T Where T.id = @id);
	IF(@op = 'C')
	BEGIN
		SELECT  id, 
				estado, 
				fechadocumen, 
				proveedor, 
				nombrebodega bodega, 
				tipodocumento, 
				centrocosto,
				costo valor	 
		FROM Dbo.VW_MOVOrdenCompras
		WHERE id = @id;
	END
	ELSE IF(@op = 'B')
	BEGIN
		SELECT 
			I.cantidad,  A.codigo, A.presentacion, A.nombre articulo,  B.nombre bodega, costo, costototal
		FROM 
			[dbo].VW_MOVOrdenComprasItem I
		INNER JOIN Dbo.VW_Productos A ON A.id = I.id_producto
		INNER JOIN Dbo.Bodegas B ON I.id_bodega = B.id	
		WHERE 
			I.id_orden = @id_orden;
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
