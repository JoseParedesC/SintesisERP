--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_SaldosList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [CNT].[ST_SaldosList]   
GO
CREATE PROCEDURE [CNT].[ST_SaldosList]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL,
	@tipoterce VARCHAR(2),
	@id_tercero BIGINT=0,
	@fecha VARCHAR(10)
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		 [CNT].[ST_SaldosList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci?n:		13/10/20
*Desarrollador: (jeteme)

SP que lista las cuotas que estan pendientes por pagar filtrando por cliente / cuotas que se pagaron filtradas por recibo de caja
***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1,@anomes VARCHAR(6);
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk BIGINT )
BEGIN TRY
		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;
		SET @anomes = CONVERT(VARCHAR(6), @fecha, 112);
		
		IF(@tipoterce='CL')
		BEGIN
			INSERT INTO @temp(id_pk)
			SELECT  A.id
			FROM CNT.SaldoCliente A  
			WHERE  ((isnull(@filter,'')='' or CAST(A.id AS Varchar) like '%' + @filter + '%')	OR
				   (isnull(@filter,'')='' or nrofactura like '%' + @filter + '%')) AND A.id_cliente=@id_tercero and A.anomes=@anomes and A.saldoactual!=0 
			group by A.id,A.id_cliente
			ORDER BY A.id ASC;
			SET @countpage = @@rowcount;		
			if (@numpage = -1)
				SET @endpage = @countpage;
			select distinct tm.id_pk id,S.nrofactura factura,id_documento documento,S.saldoActual,S.id_cuenta,CN.nombre Cuenta
			FROM @temp Tm
					INNER JOIN CNT.saldocliente S ON tm.id_pk = S.id
					LEFT JOIN Dbo.MOVFactura C ON S.id_documento = C.id
					LEFT JOIN Dbo.CNTCuentas CN ON CN.id=S.id_cuenta
			WHERE id_record between @starpage AND @endpage and S.anomes=@anomes 
				
		END
			ELSE IF(@tipoterce='PR')
			BEGIN
			INSERT INTO @temp(id_pk)
				SELECT  A.id	
				FROM CNT.SaldoProveedor A 
				WHERE  ((isnull(@filter,'')='' or CAST(A.id AS Varchar) like '%' + @filter + '%')	OR
					   (isnull(@filter,'')='' or nrofactura like '%' + @filter + '%')) AND A.id_proveedor=@id_tercero and A.anomes=@anomes and A.saldoactual!=0
				group by A.id,A.id_proveedor
				ORDER BY A.id ASC;
				SET @countpage = @@rowcount;		
				if (@numpage = -1)
					SET @endpage = @countpage;

				select  tm.id_pk id,s.nrofactura factura,id_documento documento,S.saldoActual,S.id_cuenta,CN.nombre Cuenta
				FROM @temp Tm
						INNER JOIN CNT.SaldoProveedor S ON tm.id_pk = S.id
						LEFT JOIN Dbo.MOVFactura C ON S.id_documento = C.id
						LEFT JOIN Dbo.CNTCuentas CN ON CN.id=S.id_cuenta
				WHERE id_record between @starpage AND @endpage and S.anomes=@anomes
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

