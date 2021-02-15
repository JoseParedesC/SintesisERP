--liquibase formatted sql
--changeset ,apuello:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[CNT].[VW_SaldoCuenta]') and
OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [CNT].[VW_SaldoCuenta]
END
GO
CREATE VIEW [CNT].[VW_SaldoCuenta]
/***************************************
*Nombre: [CNT].[VW_SaldoCuenta]
----------------------------------------
*Tipo: Vista
*creación: 09/01/21
*Descripción: 
***************************************/
AS
		SELECT 
			P.*,
			c.codigo codigocuenta
			
		FROM   
			CNT.SaldoCuenta	AS P join CNTCUENTAS C ON P.id_cuenta=c.id
GO


