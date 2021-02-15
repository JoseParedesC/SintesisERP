--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_FormaPago]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
	Drop View [dbo].[VW_FormaPago]
END
GO
CREATE VIEW [dbo].[VW_FormaPago]
AS
SELECT    f.id
		, f.codigo
		, f.nombre
		, f.id_tipo
		, l.nombre AS nombretipo
		, f.id_typeFE
		, S.nombre nombetipoFE
		, f.id_cuenta
		, c.codigo nombrecuenta 
		, f.estado
		, f.voucher
		, f.created
		, f.updated
		, f.id_usercreated
		, f.id_userupdated
		, f.[default]
FROM            
		dbo.FormaPagos	AS f LEFT JOIN
        dbo.ST_Listados AS l ON f.id_tipo = l.id LEFT JOIN
		dbo.ST_Listados AS S ON f.id_typeFE=S.id LEFT JOIN
		dbo.CNTCuentas C ON f.id_cuenta=c.id

GO
