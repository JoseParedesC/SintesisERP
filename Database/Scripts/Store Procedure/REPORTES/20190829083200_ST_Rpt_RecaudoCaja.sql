--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_Rpt_RecaudoCaja]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_Rpt_RecaudoCaja]
GO
CREATE PROCEDURE [Dbo].[ST_Rpt_RecaudoCaja] 
@id BIGINT,
@id_factura BIGINT
 
AS
/***************************************
*Nombre:		[Dbo].[ST_Rpt_RecaudoCaja]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		28/08/2019
*Desarrollador:  Jose Luis Tous Pérez (jtous)
*Descripcion:	Se realizan la consulta de la informacion del reporte de factura de pago caja tirilla
***************************************/
BEGIN
Declare @error varchar(max), @saldo Numeric(18,2)
BEGIN TRY		
SET LANGUAGE Spanish
	
		SELECT @saldo = ISNULL(SUM(saldoactual),0) FROM MovFacturaCuotas WHERE id_factura = @id_factura;

		SELECT id, cliente, valor, fecha, factura, usuario, caja, descripcion, @saldo saldo
		FROM dBO.VW_MOVRecaudos R		
		WHERE R.id = @id;

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
