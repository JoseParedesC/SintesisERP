--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_MOVNotasCarteraItemsList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [CNT].[ST_MOVNotasCarteraItemsList]
GO


CREATE PROCEDURE [CNT].[ST_MOVNotasCarteraItemsList]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@id_factura VARCHAR(50),
	@tipotercero VARCHAR(2)='CL',
	@fecha smalldatetime
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[CNT].[ST_MOVNotasCarteraItemsList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		28/10/20
*Desarrollador: (jeteme)


***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 10,@anomes VARCHAR(6);
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT )
BEGIN TRY
		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = 1000;
		SET @anomes   = CONVERT(VARCHAR(6), @fecha, 112);
		IF(@tipotercero='CL')
		BEGIN
			INSERT INTO @temp(id_pk)
			SELECT  id	
			FROM CNT.VW_MOVSaldoCliente_Cuotas
			WHERE  factura=@id_factura  and id_devolucion is null and id_nota is null and cancelada=0 and anomes=@anomes and saldoActual>0
			ORDER BY id ASC;

			SET @countpage = @@rowcount;		
		
			SELECT Tm.id_record, A.id,A.cuota,  A.factura, (A.saldoanterior+A.movdebito) vlrcuota,convert(varchar, CAST(vencimiento_cuota as date), 23) vencimiento_cuota 
			FROM @temp Tm
					Inner join CNT.VW_MOVSaldoCliente_Cuotas A on Tm.id_pk = A.id AND anomes=@anomes 
			WHERE id_record between @starpage AND @endpage 
		END ELSE BEGIN
			INSERT INTO @temp(id_pk)
			SELECT  id	
			FROM CNT.SaldoProveedor
			WHERE  nrofactura=@id_factura  and id_nota IS NULL and (saldoactual*-1) >0 and anomes=@anomes
			ORDER BY id ASC;
		SET @countpage = @@rowcount;		
		SELECT Tm.id_record id,1 cuota,A.nrofactura,A.saldoactual*-1 vlrcuota,convert(VARCHAR(10),A.fechavencimiento,120) vencimiento_cuota FROM @temp Tm 
				Inner join CNT.SaldoProveedor A ON TM.id_pk=A.id WHERE id_record between @starpage AND @endpage  ORDER BY id ASC;
									
		
		END
END TRY
BEGIN CATCH

	    --Getting the error description
	    Select @error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	    -- save the error in a Log file
	    RaisError(@error,16,1)
	    Return  
End Catch
GO


