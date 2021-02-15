--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[CNT].[VW_MOVNotasCarteraSaldos]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [CNT].[VW_MOVNotasCarteraSaldos]
END
GO

CREATE VIEW [CNT].[VW_MOVNotasCarteraSaldos]
--WITH ENCRYPTION
AS
	SELECT nrodocumento id,
		nrofactura,
		id_cuenta,
		CU.codigo cuenta ,
		iif(descripcion like '%proveedor%',1,  RTRIM(LTRIM(substring(descripcion,LEN(descripcion)-1,5)))) cuota,
		valor vlrcuota,
		convert(varchar(10), fechavencimiento,120) vencimiento
		FROM CNT.Transacciones T  JOIN CNTCuentas CU on T.id_cuenta=CU.id WHERE 
		tipodocumento='NC'

GO
