--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_Rpt_VentasxItems]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_Rpt_VentasxItems]
GO

CREATE PROCEDURE [dbo].[ST_Rpt_VentasxItems]
@fechaini VARCHAR(10),
@fechafin VARCHAR(10),
@idcaja int = 0

--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_Rpt_MovEntrada]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		21/08/2015
*Desarrollador:  JTEHERAN
*Descripcion:	Se realizan la consulta de la informacion del reporte de factura de pago caja tirilla
***************************************/
BEGIN
Declare @error varchar(max)
BEGIN TRY		
SET LANGUAGE Spanish

--select convert(smalldatetime,@fechaini,120),CONVERT(smalldatetime,@fechafinal,120)
--raiserror('16',16,0)	

SELECT f.id,
		CONCAT(f.prefijo,'-',f.consecutivo) nrofactura,
		fechadoc,
		F.cliente,
		f.direccion direccioncliente,
		f.telefono,
		F.correo email,
		CONCAT(f.id_centrocostos,' - ',f.centrocosto) caja,
		F.subtotal,
		F.descuento desctoproducto,
		isnull(f.dsctoFinanciero,0) dsctofinanciero,
		F.iva,
		F.total,
		F.vendedor,
		f.valoranticipo,
		f.dsctoFinanciero,
		ISNULL(DF.total,0) totaldevuelto,
		f.Modalidadventa,
		ISNULL(B.nombre,'') Bodega,
		CONCAT(P.codigo,' - ',P.nombre) Producto,
		ISNULL(Se.serie,'') serie,
		I.cantidad,
		I.precio,
		I.descuentound,
		I.iva,
		I.total
		from VW_MOVFacturas f left join (SELECT D.id_factura,SUM(total) total FROM VW_MOVDevFacturas D where D.fecha between @fechaini  AND @fechafin group by d.id_factura) DF ON DF.ID_FACTURA=F.ID 
						  JOIN  MOVFacturaItems I ON I.id_factura=F.id  JOIN Productos P ON I.id_producto=P.id LEFT JOIN MovFacturaSeries SE ON SE.id_items=I.id LEFT JOIN Bodegas B ON I.id_bodega=B.id 
						  WHERE F.fechadoc BETWEEN @fechaini  AND @fechafin AND F.estado='PROCESADO'
						  AND( Isnull(@idcaja,0) = 0 OR F.id_centrocostos = @idcaja) 
						  order by F.id_centrocostos,F.fechadoc
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

