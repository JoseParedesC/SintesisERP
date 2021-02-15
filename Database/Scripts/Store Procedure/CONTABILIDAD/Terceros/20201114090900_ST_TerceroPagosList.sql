--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_TerceroPagosList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [CNT].[ST_TerceroPagosList]
GO


CREATE PROCEDURE [CNT].[ST_TerceroPagosList]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@totalproveedor NUMERIC(18,2)=0 OUTPUT,
	@filter VARCHAR(50) = NULL,	
	@id_factura VARCHAR(50),
	@tipoterce VARCHAR(2),
	@fecha SMALLDATETIME,
	@id_cuenta BIGINT,
	@id_user INT
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[CNT].[ST_TerceroPagosList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		07/09/20
*Desarrollador: (Jeteme)
***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1,@porceinteres numeric(18,2),@saldoactual numeric(18,2);
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,tipodocumento VARCHAR(10),nrodocumento BIGINT,FECHADCTO varchar(10) )
BEGIN TRY
			SET @numpage = ISNULL(@numpage,10);

			SET @starpage = (@page * @numpage) - @numpage +1;
			SET @endpage = @numpage * @page;
			IF(@tipoterce='CL')
			SELECT @saldoactual= saldoActual FROM CNT.SaldoCliente WHERE @id_cuenta=@id_cuenta AND nrofactura=@id_factura and id_nota is null and id_devolucion is null and anomes =convert(varchar(6),@fecha,112)
			ELSE
			SELECT @saldoactual= saldoActual FROM CNT.SaldoProveedor WHERE @id_cuenta=@id_cuenta AND nrofactura=@id_factura and id_nota is null  and anomes =convert(varchar(6),@fecha,112)

			INSERT INTO @temp(tipodocumento,nrodocumento,FECHADCTO)
			SELECT  DISTINCT tipodocumento,nrodocumento,CONVERT(VARCHAR(10), fechadcto,120) FECHADCTO	
			FROM CNT.Transacciones
			WHERE  ((isnull(@filter,'')='' or tipodocumento like '%' + @filter + '%')) AND id_cuenta=@id_cuenta AND nrofactura=@id_factura AND estado=DBO.ST_FnGetIdList('PROCE')   
			ORDER BY tipodocumento ASC;
	
			SET @countpage = @@rowcount;		
				
			SELECT *,@saldoactual saldoactual FROM @temp tm  WHERE id_record between @starpage AND @endpage;		

			
			 

	
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

