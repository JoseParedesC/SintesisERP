--liquibase formatted sql
--changeset ,kmartinez:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FIN].[RefinanciacionFinanGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [FIN].[RefinanciacionFinanGet] 
GO
CREATE PROCEDURE [FIN].[RefinanciacionFinanGet] 
    @id BIGINT,
    @op char(1)
 
AS
BEGIN
/***************************************
*Nombre:        [FIN].[RefinanciacionFinanGet] 
----------------------------------------
*Tipo:            Procedimiento almacenado
*creaci�n:        25/10/2021
*Desarrollador: (Kmartinez)
 
SP para obtener la refinanciacion realizada
***************************************/
  Declare @ds_error varchar(max)
    
     BEGIN TRY  
        IF(@op = 'Y')
            BEGIN
                SELECT 
                RF.id,
                RF.id_tipodoc, 
                RF.totalcredito,
                CN.nombre centrocosto,
                CONVERT(VARCHAR(10), RF.fechadoc, 120) AS  fecha,
                R.razonsocial id_cliente,
                RF.fechadoc,
                RF.formapago,
                RF.cuotas,
                RI.valorcuota,
                RI.valorFianza AS fianza,
                RI.fecha_inicial,
                CONCAT(RF.numfactura, ' - ', R.razonsocial) numfactura,
                RF.id_factura AS id_fact,
                RF.estado,
                L.nombre estados,
				RF.id_cuenta,
				C.nombre CuentaMora,
				ISNULL(RF.valorintmora,0) interesmora,
				 (RF.totalcredito + ISNULL(RF.valorintmora, 0))total
                FROM [FIN].[RefinanciacionFact] RF  INNER JOIN cnt.VW_Terceros R ON id_cliente = R.id
                INNER JOIN [FIN].[RefinanciacionItems] RI ON RF.id = RI.id_refinan
                LEFT JOIN [dbo].[ST_Listados]  L ON RF.estado = L.id 
                LEFT JOIN CNT.CentroCosto CN    ON CN.id=id_centrocostos 
				LEFT JOIN [dbo].[CNTCuentas] C ON RF.id_cuenta = C.id WHERE  RF.id = @id AND RI.new = 0
				
        
        END  
    END TRY  
    BEGIN CATCH  
    --Getting the error description
    SET @ds_error   =  ERROR_PROCEDURE() + 
                    ';  ' + convert(varchar,ERROR_LINE()) + 
                    '; ' + ERROR_MESSAGE()
    -- save the error in a Log file
    RAISERROR(@ds_error,16,1)
    RETURN
    END CATCH
END