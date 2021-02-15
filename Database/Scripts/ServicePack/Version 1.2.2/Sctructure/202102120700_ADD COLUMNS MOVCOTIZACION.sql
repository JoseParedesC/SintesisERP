--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS i WHERE COLUMN_NAME = 'cuota_ini' AND TABLE_NAME = 'MOVCotizacion')
ALTER TABLE [dbo].[MOVCotizacion] add cuota_ini [NUMERIC](18,2) NULL 
GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS i WHERE COLUMN_NAME = 'financiero' AND TABLE_NAME = 'MOVCotizacion')
ALTER TABLE [dbo].[MOVCotizacion] add financiero [BIT] NULL  DEFAULT ((0))
GO

IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS i WHERE COLUMN_NAME = 'porce_fin' AND TABLE_NAME = 'MOVCotizacion')
ALTER TABLE [dbo].[MOVCotizacion] add porce_fin [NUMERIC](18,2) NULL 
GO

--JESID
IF COL_LENGTH('[CNT].[MOVReciboCajasItems]', 'id_cuenta') IS NULL
BEGIN
     Alter Table
         [CNT].[MOVReciboCajasItems]
     Add
         [id_cuenta] BIGINT;
END
GO

update I SET I.id_cuenta=S.id_cuenta from [CNT].[MOVReciboCajasItems] I 
JOIN [CNT].[MOVReciboCajas] R ON I.id_recibo=R.id
join cnt.saldocliente_cuotas S ON I.id_factura=S.nrofactura and S.anomes=CONVERT(VARCHAR(6),R.fecha,112) and S.id_cliente=R.id_cliente and S.vencimiento_cuota=CONVERT(SMALLDATETIME,I.vencimiento_interes,120)

IF COL_LENGTH('[DBO].[MOVFactura]', 'id_faccau') IS NULL
BEGIN
     Alter Table
         [DBO].[MOVFactura]
     Add
         [id_faccau] BIGINT;
END
GO