--liquibase formatted sql
--changeset ,apuello:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id =
OBJECT_ID(N'[CNT].[ST_Rpt_AuxiliaresImpuestos]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_Rpt_AuxiliaresImpuestos]
GO
CREATE PROCEDURE [CNT].[ST_Rpt_AuxiliaresImpuestos]
    @fechaini smalldatetime=NULL,
    @fechafinal smalldatetime=NULL,
    @Impuesto BIGINT=NULL,
    @codigoini BIGINT=NULL,
    @codigoFin BIGINT=NULL
--WITH ENCRYPTION
AS
/***************************************
*Nombre:        [CNT].[ST_Rpt_AuxiliaresImpuestos]
-----------------------------------------------------------
*Tipo:            Procedimiento almacenado
*creaci�n:        28/11/2020
*Desarrollador:  Jesid Teheran Meza (jeteme)
*Descripcion:    Informe de movimiento de Impuestos
***************************************/
BEGIN
Declare @error varchar(max),@saldoanterior numeric(18,2),@saldoanteriorGlobal numeric(18,2);
Declare @miCTE TABLE(id int,tipodoc varchar(2) ,nrodocumento varchar(50), id_cuenta Varchar(20),fechadcto varchar(10),descripcion varchar(500),iden_tercero varchar(50),debito numeric(18,2),credito numeric(18,2),saldo numeric(18,2),tercero VARCHAR(100)) 
BEGIN TRY        
SET LANGUAGE Spanish
    select CONVERT(VARCHAR(10),T.fechadcto,120) fechadcto,T.nrodocumento,T.tipodocumento,t.nrofactura,TER.iden,CONCAT(UPPER(SUBSTRING(Ter.razonsocial,1,1)),LOWER(SUBSTRING(TER.razonsocial,2,len(razonsocial)))) tercero,T.descripcion,iif(T.valor<0,T.valor+(T.baseimp*-1),T.valor+T.baseimp) importetotal ,T.valor,T.porceimp,iif(T.valor<0,T.baseimp*-1,T.baseimp) importeneto,c.codigo from cnt.Transacciones T join cnt.Impuestos i 
    on (t.id_cuenta=I.id_ctacompra or t.id_cuenta=I.id_ctadevcompra or T.id_cuenta=I.id_ctaventa or T.id_cuenta=I.id_ctadevVenta) JOIN CNTCuentas C ON T.id_cuenta=C.id  JOIN CNT.Terceros TER ON T.id_tercero=TER.id  where T.fechadcto between @fechaini and @fechafinal and (ISNULL(@impuesto,0)=0 or I.id=@impuesto) and (ISNULL(@codigoini,0)=0 or c.codigo between @codigoini and @codigoFin)
 
END TRY
BEGIN Catch
        --Getting the error description
        Select @error   =  ERROR_PROCEDURE() + 
                    ';  ' + convert(varchar,ERROR_LINE()) + 
                    '; ' + ERROR_MESSAGE()
        -- save the error in a Log file
        RaisError(@error,16,1)
        Return  
    End Catch
END