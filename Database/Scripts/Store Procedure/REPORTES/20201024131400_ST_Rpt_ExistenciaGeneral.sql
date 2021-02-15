--liquibase formatted sql
--changeset ,jteheran:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_Rpt_ExistenciaGeneral]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_Rpt_ExistenciaGeneral]
GO


CREATE PROCEDURE [dbo].[ST_Rpt_ExistenciaGeneral] 
@id_bodega int = null,
@id_articulo BIGINT = NULL,
@op char(1),
@id_existencia BIGINT=NULL
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_Rpt_ExistenciaGeneral]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		21/08/2015
*Desarrollador:  Jose Luis Tous P�rez (jtous)
*Descripcion:	Se realizan la consulta de la informacion del reporte de factura de pago caja tirilla
***************************************/
BEGIN
Declare @error varchar(max), @id_traslado Int
BEGIN TRY		
SET LANGUAGE Spanish
		if (@op='B')
		SELECT 
			A.codigo, 
			A.presentacion, 
			A.nombre articulo, 
			B.codigo codbodega, 
			B.nombre bodega,
			E.costo,
			SUM(CASE WHEN ELS.existencia IS NULL THEN E.existencia ELSE ELS.existencia END) disponibilidad, 
			(E.costo * SUM(CASE WHEN ELS.existencia IS NULL THEN E.existencia ELSE ELS.existencia END)) costototal,
			ISNULL(L.lote, '') lote,
			E.id id_existencia
		FROM Dbo.Existencia E
			INNER JOIN Dbo.VW_Productos A ON A.id = E.id_articulo
			INNER JOIN Dbo.VW_Bodegas B ON B.id = E.id_bodega		
			LEFT JOIN ExistenciaLoteSerie ELS ON E.id = ELS.id_existencia
			LEFT JOIN Dbo.LotesProducto L ON L.id = ELS.id_lote
		WHERE 
				(isnull(@id_bodega,0) = 0 or E.id_bodega = @id_bodega)
			AND	(isnull(@id_articulo,0) = 0 or E.id_articulo = @id_articulo)
		GROUP BY A.codigo, 
			A.presentacion, 
			A.nombre, 
			B.codigo, 
			B.nombre,
			E.costo,
			L.lote,E.id
		ORDER BY A.nombre ASC;

	IF(@op = 'S')
	BEGIN
		SELECT serie,existencia
		FROM Dbo.ExistenciaLoteSerie 
		WHERE id_existencia = @id_existencia;
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


