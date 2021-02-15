--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_TerceroFacturasList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_TerceroFacturasList]
GO

CREATE PROCEDURE [CNT].[ST_TerceroFacturasList]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL,	
	@id_tercero BIGINT,
	@tipoterce VARCHAR(2),
	@all INT,
	@fecha smalldatetime
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[CNT].[ST_TerceroFacturasList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		07/09/20
*Desarrollador: (Jeteme)
***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1,@anomes VARCHAR(6);
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id INT,fechafac varchar(10),idcuenta bigint,consecutivo varchar(10),total numeric(18,2),totalcredito numeric(18,2),estado varchar(50),cliente varchar(50) )
BEGIN TRY

	SET @numpage = ISNULL(@numpage,10);

	SET @starpage = (@page * @numpage) - @numpage +1;
	SET @endpage = @numpage * @page;
	SET @anomes=CONVERT(VARCHAR(6),@fecha,112);
	IF(@tipoterce='CL' or @tipoterce='')
	BEGIN
			
		
		
			if (@numpage = -1)
				SET @endpage = @countpage;
             
			 IF(@all=0)
			 BEGIN
					INSERT INTO @temp(id,fechafac,idcuenta,consecutivo,total,totalcredito,estado,cliente)
					SELECT  A.id, A.fechadoc fechafac,S.id_cuenta idcuenta, A.rptconsecutivo consecutivo, A.total,A.totalcredito ,A.estado, cliente
					FROM dbo.VW_MOVFacturas A Inner Join CNT.SaldoCliente S on S.id_documento=A.id and S.id_nota is null and S.id_devolucion is null
					WHERE 
					((isnull(@filter,'')='' or CAST(A.id AS Varchar) like '%' + @filter + '%') OR	
					(isnull(@filter,'')='' or CAST(consecutivo AS Varchar) like '%' + @filter + '%') OR	
					(isnull(@filter,'')='' or cliente like '%' + @filter + '%') OR	
					(isnull(@filter,'')='' or prefijo like '%' + @filter + '%')) AND A.id_cliente=@id_tercero and totalcredito>0 AND S.saldoActual>0 and S.anomes=@anomes
					ORDER BY A.rptconsecutivo ;
					
					SET @countpage = @@rowcount;		
							
					
			
			END ELSE 
			BEGIN 
				INSERT INTO @temp(id,fechafac,idcuenta,consecutivo,total,totalcredito,estado,cliente)
					SELECT  A.id, A.fechadoc fechafac,S.id_cuenta idcuenta, A.rptconsecutivo consecutivo, A.total,A.totalcredito ,A.estado, cliente
					FROM dbo.VW_MOVFacturas A Inner Join CNT.SaldoCliente S on S.id_documento=A.id  and S.id_nota is null and S.id_devolucion is null
					WHERE 
					((isnull(@filter,'')='' or CAST(A.id AS Varchar) like '%' + @filter + '%') OR	
					(isnull(@filter,'')='' or CAST(consecutivo AS Varchar) like '%' + @filter + '%') OR	
					(isnull(@filter,'')='' or cliente like '%' + @filter + '%') OR	
					(isnull(@filter,'')='' or prefijo like '%' + @filter + '%')) AND A.id_cliente=@id_tercero and totalcredito>0 AND S.anomes=@anomes
					ORDER BY A.rptconsecutivo ;
					SET @countpage = @@rowcount;	
					
			END

			SELECT  * FROM @temp Tm 						
			WHERE id_record between @starpage AND @endpage 
	END
	ELSE 
	BEGIN
			
		
			if (@numpage = -1)
				SET @endpage = @countpage;

			IF(@all=0)
			BEGIN
				INSERT INTO @temp(id,fechafac,idcuenta,consecutivo,total,totalcredito,estado)
				SELECT   A.id, A.fechadocumen fechafac, S.id_cuenta idcuenta,A.numfactura consecutivo, A.valor total,A.valor totalcredito ,A.estado
				FROM dbo.VW_MOVEntradas A Inner join CNT.SaldoProveedor S on S.id_documento=A.id and S.id_nota is null --and S.id_devolucion is null
				WHERE 
				((isnull(@filter,'')='' or CAST(A.id AS Varchar) like '%' + @filter + '%') OR	
				(isnull(@filter,'')='' or CAST(numfactura AS Varchar) like '%' + @filter + '%') OR	
				(isnull(@filter,'')='' or proveedor like '%' + @filter + '%') OR	
				(isnull(@filter,'')='' or A.id like '%' + @filter + '%')) AND A.id_proveedor=@id_tercero AND S.saldoactual!=0 and S.anomes=@anomes
				ORDER BY A.numfactura;
				
				SET @countpage = @@rowcount;		
			END
			ELSE 
			BEGIN
				INSERT INTO @temp(id,fechafac,idcuenta,consecutivo,total,totalcredito,estado)
				SELECT   A.id, A.fechadocumen fechafac, S.id_cuenta idcuenta,A.numfactura consecutivo, A.valor total,A.valor totalcredito ,A.estado
				FROM dbo.VW_MOVEntradas A Inner join CNT.SaldoProveedor S on S.id_documento=A.id and S.id_nota is null --and S.id_devolucion is null
				WHERE 
				((isnull(@filter,'')='' or CAST(A.id AS Varchar) like '%' + @filter + '%') OR	
				(isnull(@filter,'')='' or CAST(numfactura AS Varchar) like '%' + @filter + '%') OR	
				(isnull(@filter,'')='' or proveedor like '%' + @filter + '%') OR	
				(isnull(@filter,'')='' or A.id like '%' + @filter + '%')) AND A.id_proveedor=@id_tercero AND  S.anomes=@anomes
				ORDER BY A.numfactura;

				SET @countpage = @@rowcount;		

			END

			SELECT  * FROM @temp Tm 						
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