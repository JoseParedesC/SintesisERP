--liquibase formatted sql
--changeset ,jtous:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_Cajas]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [dbo].[VW_Cajas]
END
GO
CREATE VIEW [dbo].[VW_Cajas]
AS
/***************************************
*Nombre:		[dbo].[VW_Cajas]
----------------------------------------
*Tipo:			Vista
*creación:		28/03/17
*Desarrollador: (JTOUS)
***************************************/
		SELECT        
				A.id, 
				A.codigo,
				A.nombre nombre,
				A.id_bodega, 
				A.id_cliente,
				C.razonsocial cliente,
				A.id_centrocosto,
				UPPER(CC.codigo + ' - ' + CC.nombre) centrocosto,
				A.id_cuenta,
				A.id_ctaant,
				A.cabecera,
				A.piecera,
				A.estado,
				W.nombre bodega,
				U.nombre codecuenta,
				U.codigo cuentacod,
				CU.codigo cuentacodant,
				A.id_vendedor,
				V.codigo+' - '+V.nombre vendedor,
				A.userproceso
		FROM    dbo.Cajas AS A 
		LEFT OUTER JOIN dbo.Bodegas AS W ON W.id = A.id_bodega
		LEFT OUTER JOIN CNT.TipoTerceros TT ON TT.id = A.id_cliente
		LEFT OUTER JOIN CNT.Terceros AS C ON C.id = TT.id_tercero
		LEFT OUTER JOIN dbo.Vendedores AS V ON V.id = A.id_vendedor
		LEFT OUTER JOIN dbo.CNTCuentas AS U ON U.id = A.id_cuenta
		LEFT OUTER JOIN dbo.CNTCuentas AS CU ON CU.id = A.id_ctaant
		LEFT OUTER JOIN CNT.CentroCosto AS CC ON CC.id = A.id_centrocosto

GO


