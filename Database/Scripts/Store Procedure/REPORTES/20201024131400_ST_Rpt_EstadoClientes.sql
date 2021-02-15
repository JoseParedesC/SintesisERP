--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_Rpt_EstadoClientes]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [CNT].[ST_Rpt_EstadoClientes]
GO
CREATE PROCEDURE [CNT].[ST_Rpt_EstadoClientes]
	@id_cliente BIGINT,
	@fecha Smalldatetime
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[CNT].[ST_Rpt_EstadoCliente]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		01/09/2020
*Desarrollador:  Jesid Teheran Meza (jeteme)
*Descripcion:	Se realizan la consulta de saldo por cuenta anidadas
***************************************/
BEGIN
Declare @error varchar(max),@anomes VARCHAR(6),@fechadoc VARCHAR(10)
BEGIN TRY		
SET LANGUAGE Spanish
			SET @anomes = CONVERT(VARCHAR(6), @fecha, 112);
			SET @fechadoc = CONVERT(VARCHAR(10), @fecha, 120);
	 
 SELECT  
			A.factura,
			A.cuota,
			convert(varchar, CAST(s.fechaactual as date), 23) fechafac,convert(varchar, CAST(vencimiento_cuota as date), 23) vencimiento_cuota,
 			A.saldoActual,
			datediff(day,A.vencimiento_cuota,@fecha)  dias,
			T.tercero cliente
 			FROM CNT.VW_MOVSaldoCliente_Cuotas A  JOIN CNT.VW_Terceros T ON A.id_cliente=T.id JOIN Cnt.SaldoCliente S ON A.factura=S.nrofactura and A.id_cliente=S.id_cliente AND A.id_cuenta=S.id_cuenta AND A.anomes=S.anomes  WHERE (ISNULL(@id_cliente,0)=0 OR A.id_cliente=@id_cliente)  and 
			A.id_devolucion is null and A.id_nota is null AND A.anomes=@anomes and A.saldoActual>0 ORDER BY   T.tercero,A.factura,A.cuota
			
	

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


