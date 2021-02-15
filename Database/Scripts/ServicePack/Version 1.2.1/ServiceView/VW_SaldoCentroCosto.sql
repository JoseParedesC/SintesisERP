--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[CNT].[VW_SaldoCentroCosto]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [CNT].[VW_SaldoCentroCosto]
END
GO


CREATE VIEW [CNT].[VW_SaldoCentroCosto]
/***************************************
*Nombre: [CNT].[VW_SaldoTercero]
----------------------------------------
*Tipo: Vista
*creaci�n: 16/01/21
*Descripci�n: 
*Autor: Jeteme
***************************************/
AS
		SELECT 
			P.*,
			c.codigo codigocuenta
			
		FROM   
			CNT.SaldoCentroCosto	AS P join CNTCUENTAS C ON P.id_cuenta=c.id

GO


