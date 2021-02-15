--liquibase formatted sql
--changeset ,jeteme:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_MOVFacturasRecurrentes]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [dbo].[VW_MOVFacturasRecurrentes]
END
GO

CREATE VIEW [dbo].[VW_MOVFacturasRecurrentes]
AS

/***************************************
*Nombre: [dbo].[VW_MOVFacturasRecurrentes]
----------------------------------------
*Tipo: Vista
*creación: 15/10/2020
*Desarrollador: (Kmartinez)Kevin Jose Martinez Teheran
*Descripcion: 
***************************************/


SELECT      P.id, 
			CONVERT(VARCHAR(10), P.fechafac, 120) AS fechadoc, 
			L.nombre AS estado, 
			P.iva, 
			P.inc,
			P.descuento, 
			P.subtotal, 
			P.subtotal - P.descuento AS ssubtotal,
			P.total, 
			R.tercero AS cliente,
			R.direccion,
			R.telefono,
			R.ciudad,
			U.username,  
			R.id AS id_cliente, 		
			U.nombre AS nomusuario, 
			P.id_user,
			'' relacionado,
			'EFE' moneda,
			P.id_vendedor,
			V.nombre vendedor,
			P.id_tipodoc,
			P.id_centrocostos,
			O.nombre centrocosto,
			P.isFe,
			p.id_formapagos
FROM    [dbo].[MOVFacturasRecurrentes]	AS P INNER JOIN 
        dbo.ST_Listados					AS L ON L.id = P.estado LEFT OUTER JOIN
        CNT.VW_Terceros					AS R ON P.id_tercero = R.id LEFT JOIN 
        dbo.Usuarios					AS U ON P.id_user = U.id LEFT JOIN
		Vendedores						AS V ON V.id = P.id_vendedor LEFT JOIN
		CNT.VW_CentroCosto				AS O ON O.id = P.id_centrocostos
GO


