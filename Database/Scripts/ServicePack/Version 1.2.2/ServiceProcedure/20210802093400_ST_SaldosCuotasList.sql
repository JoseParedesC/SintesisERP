--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_SaldosCuotasList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_SaldosCuotasList]
GO
CREATE PROCEDURE [CNT].[ST_SaldosCuotasList]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL,
	@nrofactura VARCHAR(100),
	@id_tercero BIGINT=0,
	@fecha VARCHAR(10),
	@id_cuenta BIGINT
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		 [CNT].[ST_SaldosCuotasList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci?n:		08/02/21
*Desarrollador: (jeteme)

Procedimiento que lista las cuotas de una determinada factura de cliente filtrando por cuenta, tercero y numero de factura
***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1,@anomes VARCHAR(6);
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk BIGINT,cuota int,vencimiento varchar(10),saldoactual numeric(18,2) )
BEGIN TRY
		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;
		SET @anomes = CONVERT(VARCHAR(6), @fecha, 112);
		
		
		
			INSERT INTO @temp(id_pk,cuota,vencimiento,saldoactual)
			SELECT  A.id,A.cuota,CONVERT(VARCHAR(10),A.vencimiento_cuota,120),A.saldoActual
			FROM CNT.SaldoCliente_Cuotas A  
			WHERE  ((isnull(@filter,'')='' or CAST(A.cuota AS Varchar) like '%' + @filter + '%')	OR
				   (isnull(@filter,'')='' or vencimiento_cuota like '%' + @filter + '%')) AND A.id_cliente=@id_tercero and A.anomes=@anomes  and id_cuenta=@id_cuenta and nrofactura=@nrofactura
			ORDER BY A.id ASC;
			SET @countpage = @@rowcount;		
			if (@numpage = -1)
				SET @endpage = @countpage;
			SELECT id_pk id,vencimiento,cuota,saldoactual from @temp
			WHERE id_record between @starpage AND @endpage;  
				
		
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