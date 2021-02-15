--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_EntradasxPagarList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [CNT].[ST_EntradasxPagarList]
GO

Create PROCEDURE [CNT].[ST_EntradasxPagarList]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL,
	@id_proveedor BIGINT,
	@id_comprobante BIGINT=0,
	@fecha smalldatetime=null
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		 CNT.ST_EntradasxPagarList
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		24/12/19
*Desarrollador: (jeteme)
SP que lista las facturas por pagar 
***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT,id_pro INT )
BEGIN TRY
		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;

		
		IF(@id_comprobante=0)
		BEGIN
		INSERT INTO @temp(id_pk,id_pro)
		SELECT  A.id,A.id_proveedor	
		FROM dbo.VW_MOVEntradas A Inner join CNT.SaldoProveedor S on A.id=S.id_documento AND A.id_proveedor=S.id_proveedor
		WHERE  ((isnull(@filter,'')='' or CAST(A.id AS Varchar) like '%' + @filter + '%')	OR
			   (isnull(@filter,'')='' or proveedor like '%' + @filter + '%')	 OR
			    (isnull(@filter,'')='' or numfactura like '%' + @filter + '%')) AND A.id_proveedor=@id_proveedor and saldoActual!=0 and S.anomes=CONVERT(VARCHAR(6), @fecha, 112) 
		UNION ALL
		SELECT  A.id,A.id_proveflete	
		FROM dbo.VW_MOVEntradas A Inner join CNT.SaldoProveedor S on A.id=S.id_documento AND A.id_proveflete=S.id_proveedor
		WHERE  ((isnull(@filter,'')='' or CAST(A.id AS Varchar) like '%' + @filter + '%')	OR
			   (isnull(@filter,'')='' or proveedor like '%' + @filter + '%')	 OR
			    (isnull(@filter,'')='' or numfactura like '%' + @filter + '%')) AND A.id_proveflete=@id_proveedor  and saldoActual!=0 and S.anomes=CONVERT(VARCHAR(6), @fecha, 112) 

		

		SET @countpage = @@rowcount;		
		
		if (@numpage = -1)
			SET @endpage = @countpage;

			SELECT  S.id, A.fechadocumen,U.codigo cuenta ,A.fechafactura, A.fechavence, A.numfactura, A.estado, A.proveedor, A.valor,A.FormaPago, 
			S.saldoActual*-1 SaldoActual,S.id_documento
		FROM @temp Tm
				Inner join dbo.VW_MOVEntradas A on Tm.id_pk = A.id Inner join CNT.SaldoProveedor S on A.id=S.id_documento and S.id_proveedor=Tm.id_pro and anomes=CONVERT(VARCHAR(6), @fecha, 112) and S.saldoactual!=0
				INNER JOIN dbo.CNTCuentas U ON S.id_cuenta=U.id
		WHERE id_record between @starpage AND @endpage 
		ORDER  BY A.id DESC;

		END
		ELSE 
		BEGIN
		INSERT INTO @temp(id_pk)
				SELECT  A.id
				FROM CNT.VW_MOVComprobantesEgresosItems A 
				WHERE  ((isnull(@filter,'')='' or CAST(A.id AS Varchar) like '%' + @filter + '%')	OR
					   (isnull(@filter,'')='' or valor like '%' + @filter + '%')) AND A.id_comprobante=@id_comprobante
				ORDER BY A.id_documento ASC;

				SET @countpage = @@rowcount;		
		
				if (@numpage = -1)
					SET @endpage = @countpage;

				select  tm.id_pk id,E.id id_entrada,c.nrofactura,c.valor,E.valor totalEntrada,0 SaldoActual
				FROM @temp Tm
						INNER JOIN VW_MOVComprobantesEgresosItems C ON tm.id_pk = C.id INNER JOIN
						CNT.SaldoProveedor M ON C.id_documento=M.id INNER JOIN 
						dbo.MOVEntradas E ON M.id_documento=E.id
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