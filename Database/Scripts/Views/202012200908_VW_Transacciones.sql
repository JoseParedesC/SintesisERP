--liquibase formatted sql
--changeset ,apuello:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[CNT].[VW_Transacciones]') and
OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [CNT].[VW_Transacciones]
END
GO
CREATE VIEW [CNT].[VW_Transacciones]
/***************************************
*Nombre: [CNT].[VW_Transacciones]
----------------------------------------
*Tipo: Vista
*creación: 23/12/20
*Desarrollador: APUELLO
*Descripcion: Vista que muestra todas las transacciones que se encuentren en las cuentas bancarias 1110 y 1120
***************************************/
AS
	SELECT
        T.id, 
		CT.nombre AS fuente, 
		T.tipodocumento AS documento, 
		T.nrofactura AS factura, 
		CONVERT(VARCHAR(7), T.fechadcto, 120) AS fecha, 
		T.descripcion AS descrip, 
		CASE WHEN T .valor > 0 THEN T .valor ELSE 0 END AS debito, 
        CASE WHEN T .valor < 0 THEN T .valor ELSE 0 END AS credito, T.estado
	FROM    
        CNT.Transacciones AS T 
		INNER JOIN dbo.CNTCuentas AS C ON C.id = T.id_cuenta 
		INNER JOIN CNT.CentroCosto AS CT ON CT.id = T.id_centrocosto
	WHERE  (C.id_padre = 111005) OR (C.id_padre = 112005)

GO