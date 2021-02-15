--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_Rpt_MovFactura]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_Rpt_MovFactura]
GO
CREATE PROCEDURE [Dbo].[ST_Rpt_MovFactura] 
@id BIGINT,
@op CHAR (1)
 
AS
/***************************************
*Nombre:		[Dbo].[ST_Rpt_MovFactura]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		21/08/2015
*Desarrollador:  Jose Luis Tous Pérez (jtous)
*Descripcion:	Se realizan la consulta de la informacion del reporte de factura de pago caja tirilla
***************************************/
BEGIN
Declare @error varchar(max)
Declare @id_fact int;
BEGIN TRY		
SET LANGUAGE Spanish
	SET @id_fact = (SELECT Top 1 CASE WHEN Dbo.ST_FnGetIdList('REVON') = estado THEN id_reversion ELSE id END FROM Dbo.MOVFactura T Where T.id = @id);

	IF(@op = 'C')
	BEGIN
		SELECT F.id, F.consecutivo, F.fechadoc, F.estado, F.iva, F.descuento, 
		F.subtotal, F.total, F.valorpagado, F.rptconsecutivo, F.cliente, F.id_caja, F.turno, F.username, F.cambio,
		C.cabecera, C.piecera, R.resolucion +' - '+R.leyenda recolucion
		FROM Dbo.VW_MOVFacturas F
		LEFT JOIN Dbo.Cajas C ON F.id_caja = C.id
		LEFT JOIN Dbo.VW_Resoluciones R ON F.id_centrocostos = R.id_ccosto and R.resolucion=F.resolucion
		WHERE F.id = @id;
	END
	ELSE IF(@op = 'B')
	BEGIN
		SELECT codigo, nombre, cantidad, precio
		FROM 
			[dbo].[VW_MOVFacturaItems] I
		WHERE 
			I.id_factura = @id_fact
		
	END
	ELSE IF(@op = 'F')
	BEGIN		
		SELECT FP.nombre, SUM(F.valor) valor, F.voucher
		FROM Dbo.MOVFacturaFormaPago F
		LEFT JOIN Dbo.FormaPagos FP ON F.id_formapago = FP.id
		WHERE F.id_factura = @id_fact
		GROUP BY FP.nombre, F.voucher
		UNION ALL
		SELECT 'Anticipo', F.valoranticipo, ''
		FROM Dbo.MOVFactura F 
		WHERE F.id = @id_fact;

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
