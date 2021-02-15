--liquibase formatted sql
--changeset ,apuello:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id =
OBJECT_ID(N'[CNT].[ST_Rpt_BalanceGeneral]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_Rpt_BalanceGeneral]
GO
CREATE PROCEDURE [CNT].[ST_Rpt_BalanceGeneral]
--WITH ENCRYPTION
	@op CHAR(1) ,
	@id_saldocuenta INT=NULL,
	@anomes VARCHAR(12) =NULL
AS
/***************************************
*Nombre:		[CNT].[ST_Rpt_BalanceGeneral]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		03/09/2020
*Desarrollador:  Jesid Teheran Meza (jeteme)
*Descripcion:	Se realizan la consulta de saldo y los lista en formato de balance general
***************************************/
BEGIN
Declare @error varchar(max),@id_cuenta BIGINT,@totalsaldoant numeric(18,2),@totaldebito numeric(18,2),@totalcredito numeric(18,2),@saldoactual numeric(18,2)
BEGIN TRY        
SET LANGUAGE Spanish
    
    SET @anomes= REPLACE(substring(CONVERT(varchar,@anomes, 111), 1, 7), '-', '') 
 
 IF (@op='T')
    BEGIN
        select @totalsaldoant= SUM(saldoanterior), @totaldebito= SUM(movDebito),@totalcredito= sum(movcredito),@saldoactual= sum(saldoactual) from cnt.SaldoCuenta where anomes=@anomes
 
        SELECT  SUBSTRING(D.codigo,1,1) orden,D.nombre,D.codigo,SUM(S.saldoanterior) saldoanterior,SUM(S.movDebito) debito,SUM(S.movCredito) credito,SUM(S.saldoActual) saldoactual,D.nivel,@totalsaldoant TsaldoAnt,@totaldebito Tdebito,@totalcredito Tcredito,@saldoactual Tsaldoactual
        FROM CNT.SaldoCuenta S cross apply [dbo].[ST_FnNivelesCuentasCostos]('C',s.id_cuenta) D where S.anomes=@anomes group by D.codigo,D.nivel,D.nombre,D.nivel order by orden,D.codigo 
 
    END
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
