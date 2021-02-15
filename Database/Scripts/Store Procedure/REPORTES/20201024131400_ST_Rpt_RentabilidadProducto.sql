--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[ST_Rpt_RentabilidadProducto]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [Dbo].[ST_Rpt_RentabilidadProducto]
GO


CREATE PROCEDURE [dbo].[ST_Rpt_RentabilidadProducto] 
@fechaini SMALLDATETIME,
@fechafinal SMALLDATETIME,
@id_user BIGINT,
@id_producto BIGINT=NULL
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_Rpt_VentasxProductoConLotes]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		13/05/2020
*Desarrollador:  Jeteheran
***************************************/
BEGIN
Declare @error varchar(max)
BEGIN TRY		
SET LANGUAGE Spanish
	SELECT @id_producto=IIF(@id_producto=0,NULL,@id_producto)

	
		SELECT codigo,
		p.nombre,
		presentacion,
		nombreTipoProducto,
		sum(E.costo*i.cantidad) costototal,
		SUM(i.precio*i.cantidad) totalvendido,
		(SUM(i.precio*i.cantidad)-sum(E.costo*i.cantidad)) Rentabilidad,
		concat(cast(round(((SUM(i.precio*i.cantidad)-sum(E.costo*i.cantidad))/sum(E.costo*i.cantidad)*100),2) as numeric(18,2)),' %') margen,
		@id_user id_user
		FROM dbo.VW_Productos p inner join MOVFacturaItems i ON
		p.id=i.id_producto 
		INNER JOIN MOVFactura F ON F.id=I.id_factura  LEFT OUTER JOIN 
		dbo.Usuarios U ON U.id=1 INNER JOIN dbo.Existencia E ON I.id_producto=E.id_articulo
		where F.fechafac BETWEEN @fechaini and @fechafinal AND( Isnull(@id_producto,0) = 0 OR P.id=@id_producto)
		GROUP BY codigo,p.nombre,nombreTipoProducto,presentacion,U.nombre,i.serie
		
		
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


