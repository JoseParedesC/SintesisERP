--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_Rpt_SaldoCliente]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[ST_Rpt_SaldoCliente]
GO
CREATE PROCEDURE [dbo].[ST_Rpt_SaldoCliente]
@idcliente int
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_Rpt_SaldoCliente]
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
	
	SELECT razonsocial cliente, S.nrofactura, id_documento documento,  T.iden, telefono, celular,email correo, S.saldoActual saldo
	FROM CNT.VW_Terceros T inner join CNT.VW_TercerosTipo TI ON T.id=TI.id_tercero
	INNER JOIN CNT.SaldoCliente S ON S.id_cliente=TI.id
	WHERE S.saldoActual > 0
	AND( Isnull(@idcliente,0) = 0 OR TI.id = @idcliente)
	ORDER BY cliente ASC

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


