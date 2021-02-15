--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_Rpt_VentasxCliente]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [dbo].[ST_Rpt_VentasxCliente]
GO
CREATE PROCEDURE [dbo].[ST_Rpt_VentasxCliente] 
@fechaini SMALLDATETIME,
@fechafinal SMALLDATETIME,
@id_user BIGINT
 
AS
/***************************************
*Nombre:		[Dbo].[ST_Rpt_VentasxCliente]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		13/05/2020
*Desarrollador:  Jeteheran
***************************************/
BEGIN
Declare @error varchar(max)
BEGIN TRY		
SET LANGUAGE Spanish
		SELECT CONCAT(te.iden,IIF(te.digitoverificacion is null,'',CONCAT('-',te.digitoverificacion))) Identificacion,
		razonsocial,
		COUNT(*)  NumComprobante,
		SUM(f.subtotal) subtotal,
		SUM(f.descuento) descuento,
		ISNULL(SUM(iva),0) totalIva,
		ISNULL(SUM(inc),0) totalInc,
		SUM(total) total,
		U.nombre usuario
		FROM MOVFactura F  INNER JOIN
		CNT.Terceros TE ON TE.id=F.id_tercero left outer join 
		dbo.Usuarios U ON U.id=@id_user
		where F.fechafac BETWEEN @fechaini and @fechafinal 
		GROUP BY te.iden,te.digitoverificacion,te.razonsocial,U.nombre
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


