--liquibase formatted sql
--changeset ,jeteme:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[CNT].[VW_MOVSaldoCliente_Cuotas]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [CNT].[VW_MOVSaldoCliente_Cuotas]
END
GO

CREATE VIEW [CNT].[VW_MOVSaldoCliente_Cuotas]
AS
		SELECT 
			P.id,
			P.id_cliente,
			P.nrofactura factura,
			P.id_cuenta,
			P.cuota,
			P.saldoAnterior,
			P.movdebito,
			P.movCredito,
			P.saldoActual,	
			P.vencimiento_cuota,
			p.cancelada,
			p.id_devolucion,
			p.anomes,
			P.changed,
			P.before,
			p.id_nota
			
			
		FROM   
			CNT.SaldoCliente_Cuotas	AS P




GO


