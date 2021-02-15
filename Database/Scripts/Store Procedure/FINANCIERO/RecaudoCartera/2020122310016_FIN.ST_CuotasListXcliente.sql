--liquibase formatted sql
--changeset ,kmartinez:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FIN].[ST_CuotasListXcliente]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [FIN].[ST_CuotasListXcliente]
GO

CREATE PROCEDURE [FIN].[ST_CuotasListXcliente]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL,
	@id_cliente BIGINT,
	@id_recibo BIGINT=0,
	@fecha varchar(10)
 
AS
/***************************************
*Nombre:		 [FIN].[ST_CuotasListXcliente]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci?n:		21/11/20
*Desarrollador: (Kmartinez)

SP que lista las cuotas que estan pendientes por pagar filtrando por cliente / cuotas que se pagaron filtradas por recibo de caja
***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1,@anomes VARCHAR(6), @pormora NUMERIC(18,2) = 0;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk VARCHAR(30) )
BEGIN TRY
		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;
		SET @anomes = CONVERT(VARCHAR(6), @fecha);

		SET @pormora = [dbo].[GETParametrosValor]('PORCEINTERESMORA');
		
		IF(@id_recibo=0)
		BEGIN
			INSERT INTO @temp(id_pk)
			SELECT  DISTINCT A.numfactura	
			FROM [FIN].[VW_SaldoCliente_Cuotas] A 
			WHERE  ((isnull(@filter,'')='' or CAST(A.id AS Varchar) like '%' + @filter + '%')	OR
				   (isnull(@filter,'')='' or factura like '%' + @filter + '%')) AND A.id_cliente = @id_cliente and cancelada = 0 and devolucion = 0 and A.anomes = @anomes
			group by A.numfactura,A.id_cliente
			ORDER BY A.numfactura ASC;

			SET @countpage = @@rowcount;		
		
			if (@numpage = -1)
				SET @endpage = @countpage;

			SELECT  tm.id_pk id, 
					c.prefijo+ '-' +CONVERT(VARCHAR,c.consecutivo) factura, 
					D.cuotapendiente cuota_pagar,
					c.totalcredito total, 
					D.fechavencimiento,
					D.valorcuota, 
					D.saldocuota, 
					S.porcentaje porcentaje,
					D.diasvencido, 
					D.interesabono,
					ISNULL(@pormora,0) pormora,
					D.Capital
			FROM @temp Tm
					INNER JOIN [FIN].[SaldoCliente] S ON tm.id_pk = S.nrofactura
					INNER JOIN Dbo.MOVFactura C ON S.id_documento = C.id
					CROSS APPLY [FIN].[DatosCuotasFacturaFinan](S.nrofactura, @fecha) D
			WHERE id_record between @starpage AND @endpage and S.anomes = @anomes
			group by tm.id_pk,c.prefijo,c.consecutivo,c.totalcredito,D.fechavencimiento,D.saldocuota,D.valorcuota,D.cuotapendiente,D.diasVencido,D.interesabono,S.porcentaje,
			S.fechaactual, D.creditointeres, D.DiasAnticipado,D.Capital,D.valorIva
			 
	    END
		ELSE
		BEGIN
			INSERT INTO @temp(id_pk)
			SELECT  A.id
			FROM [FIN].[VW_RecaudoReciboCarteraItems] A 
			WHERE  ((isnull(@filter,'')='' or CAST(A.id AS Varchar) like '%' + @filter + '%')	OR
					(isnull(@filter,'')='' or valorCuota like '%' + @filter + '%')) AND A.id_recibo=@id_recibo 
			ORDER BY A.id_factura ASC;

			SET @countpage = @@rowcount;		
		
			if (@numpage = -1)
				SET @endpage = @countpage;

			select  tm.id_pk id, c.id_recibo AS factura, C.valorIva, c.interesCorriente, c.porcenInCorriente, c.cuota, c.valorCuota, c.pagoCuota, c.InteresMora, c.porceInMora, 
			c.totalpagado,c.vencimiento_interes
			FROM @temp Tm
					INNER JOIN [FIN].[VW_RecaudoReciboCarteraItems] C ON tm.id_pk = C.id
			WHERE id_record between @starpage AND @endpage 
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