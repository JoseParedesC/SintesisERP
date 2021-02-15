--liquibase formatted sql
--changeset ,apuello:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id =
OBJECT_ID(N'[CNT].[ST_ListaCuentasCierre]') and OBJECTPROPERTY(id, N'IsTableFunction') = 1)
DROP FUNCTION [CNT].[ST_ListaCuentasCierre]
GO
CREATE Function [CNT].[ST_ListaCuentasCierre] (@saldo varchar(50),@anomes VARCHAR(6))
/***************************************
*Nombre: [CNT].[ST_ListaCuentasCierre]
----------------------------------------
*Tipo: Funcion
*creaci?n: 8/01/21
*Desarrollador: APUELLO
*Descripcion: Devuelve una lista con las cuentas que est?n en la 4, 5 y 6 
junto con sus movimientos en debito, credito y saldoactual de la tabla SaldoCuenta
***************************************/
RETURNS @TblResultante  TABLE ( id_tercero INT,id_cuenta INT,saldoActual INT, debito INT, credito INT)

--With Encryption 
As
BEGIN
	
			
	IF(@saldo='CUENTA')	
	BEGIN
		Insert Into @TblResultante (id_cuenta,  saldoActual, debito, credito)
		SELECT
			C.id,
			S.movDebito,
			S.movCredito,
			S.saldoActual
		FROM [CNT].[SaldoCuenta] S
		INNER JOIN [dbo].[CNTCuentas] C ON C.id = S.id_cuenta
		WHERE (SUBSTRING(codigo, 1, 1) IN (4, 5, 6)) AND tipo = 1 and anomes=@anomes
	END
	ELSE
	BEGIN
		Insert Into @TblResultante (id_tercero,id_cuenta,  saldoActual, debito, credito)
		SELECT
			S.id_tercero,
			C.id,
			S.saldoActual,
			S.movCredito,
			S.movDebito
		FROM [CNT].[SaldoTercero] S
		INNER JOIN [dbo].[CNTCuentas] C ON C.id = S.id_cuenta
		WHERE (SUBSTRING(codigo, 1, 1) IN (4, 5, 6)) AND tipo = 1 and anomes=@anomes
	END
	RETURN

End