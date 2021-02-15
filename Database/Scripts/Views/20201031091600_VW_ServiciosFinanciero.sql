--liquibase formatted sql
--changeset ,kmartinez:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[FIN].[VW_ServiciosFinanciero]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [FIN].[VW_ServiciosFinanciero]
END
GO

CREATE VIEW [FIN].[VW_ServiciosFinanciero]
AS

/***************************************
*Nombre:		[FIN].[VW_ServiciosFinanciero]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		27/10/2020
*Desarrollador: (Kmartinez)
*Descripcion: Este SP tiene como funcionalidad de unir la tabla servicio financiero con la tabla cuenta para obtener la cuenta asignada al momento de la insercion
***************************************/

SELECT        t.id, t.codigo, t.nombre, t.id_cuenta, A.codigo AS cuenta, t.created, t.updated, t.id_user
FROM            FIN.ServiciosFinanciero AS t INNER JOIN
                         dbo.CNTCuentas AS A ON t.id_cuenta = A.id



GO


