--liquibase formatted sql
--changeset ,JTOUS:4 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[GSC].[VW_Clientes]') and OBJECTPROPERTY(id, N'IsView') = 1)
	DROP VIEW GSC.VW_Clientes
GO

CREATE VIEW [GSC].[VW_Clientes]
-- =============================================
--*Nombre:		[GSC].[VW_Clientes]
----------------------------------------
--*Tipo:			VISTA
--*creación:		20/10/20
--*Desarrollador: (CZULBARAN)
--*Descripción:    VISTA QUE MUESTRA LOS CLIENTES QUE ESTAN EN MORA TENIENDO EN CUENTA EL AÑO-MES
-- =============================================
AS
	

			SELECT DISTINCT  
					TER.id as id, 
					t.tercero as cliente, 
					m.id_tercero, 
					CN.codigo AS cuenta,
				CASE WHEN DATEDIFF(DAY, GETDATE(), SLD.fechavencimiento) <= 0 THEN 'PV'
				WHEN DATEDIFF(DAY, GETDATE(), SLD.fechavencimiento) < 30 THEN '30'
				WHEN DATEDIFF(DAY, GETDATE(), SLD.fechavencimiento) < 60 THEN '60'
				WHEN DATEDIFF(DAY, GETDATE(), SLD.fechavencimiento) < 90 THEN '90'
				WHEN DATEDIFF(DAY, GETDATE(), SLD.fechavencimiento) > 90 THEN '+90' 
				END vencimiento,
				GSH.tipo,
				GSH.programado,
				SLD.anomes
			FROM CNT.VW_Terceros TER
			INNER JOIN CNT.VW_TercerosTipo T ON TER.id = T.id_tercero AND T.codigo = 'CL'
			INNER JOIN MOVFactura m ON TER.id = m.id_tercero
			INNER JOIN [CNT].[SaldoCliente] SLD on m.id_tercero = SLD.id_cliente
			INNER JOIN CNTCuentas CN ON CN.id = SLD.id_cuenta
			LEFT JOIN [GSC].[GestionSeguimientos] GSH ON GSH.id_cliente = m.id_tercero			
GO


