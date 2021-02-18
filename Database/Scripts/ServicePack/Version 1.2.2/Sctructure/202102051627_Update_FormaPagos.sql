--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
IF NOT EXISTS(SELECT 1 FROM FormaPagos F INNER JOIN CNTCuentas C ON C.id = F.id_cuenta WHERE F.nombre = 'EFECTIVO CAJAS' AND C.codigo = 5235)
UPDATE F 
	SET F.id_cuenta = (SELECT id FROM CNTCuentas WHERE codigo = 5235)
FROM FormaPagos AS F WHERE nombre = 'EFECTIVO CAJAS'