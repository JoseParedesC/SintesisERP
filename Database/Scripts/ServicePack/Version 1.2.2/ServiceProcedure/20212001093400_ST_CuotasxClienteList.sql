--liquibase formatted sql
--changeset ,jteheran:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_CuotasxClienteList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_CuotasxClienteList]
GO
CREATE PROCEDURE [CNT].[ST_CuotasxClienteList]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL,
	@id_cliente BIGINT,
	@id_recibo BIGINT=0,
	@fecha smalldatetime
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		 [CNT].[ST_CuotasxClienteList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci?n:		18/06/20
*Desarrollador: (jeteme)

SP que lista las cuotas que estan pendientes por pagar filtrando por cliente / cuotas que se pagaron filtradas por recibo de caja
***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1,@anomes VARCHAR(6);
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,factura VARCHAR(50),id_cliente BIGINT,id_cuenta BIGINT )
DECLARE @temp1 TABLE(id_record INT IDENTITY(1,1) ,id_pk BIGINT )
BEGIN TRY
		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;
		SET @anomes = CONVERT(VARCHAR(6), @fecha, 112);
		IF(@id_recibo=0)
		BEGIN
		INSERT INTO @temp(factura,id_cliente,id_cuenta)
		SELECT  A.factura,A.id_cliente,A.id_cuenta	
		FROM CNT.VW_MOVSaldoCliente_Cuotas A left JOIN MOVFACTURA F ON F.id_tercero=A.id_cliente and CONCAT(F.prefijo,'-',F.consecutivo)=A.factura 
		WHERE  ((isnull(@filter,'')='' or CAST(A.id AS Varchar) like '%' + @filter + '%')	OR
			   (isnull(@filter,'')='' or factura like '%' + @filter + '%')) AND A.id_cliente=@id_cliente and saldoactual>0 and id_devolucion is null and A.anomes=@anomes and F.pagofinan is null
		group by A.factura,A.id_cliente,id_cuenta
		ORDER BY A.factura ASC;

		SET @countpage = @@rowcount;		
		
		if (@numpage = -1)
			SET @endpage = @countpage;

		select  S.id id,tm.factura,S.saldoanterior+S.movDebito total,D.fechavencimiento,D.valorcuota,D.saldocuota,D.cuotapendiente cuota_pagar, 
		D.diasvencido,D.interesabono,U.codigo cuenta, convert(numeric(18,2), dbo.GETParametrosValor('PORCEINTERESMORA')) porinteres,isnull(U.id,0) id_cuenta
		FROM @temp Tm
				INNER JOIN CNT.saldocliente S ON tm.factura = S.nrofactura AND S.id_cliente=tm.id_cliente AND S.id_cuenta=tm.id_cuenta AND S.id_nota is null
				INNER JOIN dbo.CNTCuentas U ON S.id_cuenta=U.id
				cross apply cnt.ST_DatosCuotasFactura(tm.id_cliente,tm.factura,tm.id_cuenta,@anomes) D
		WHERE id_record between @starpage AND @endpage and S.anomes=@anomes
				group by S.id,tm.factura,D.fechavencimiento,D.saldocuota,D.valorcuota,D.cuotapendiente,D.diasVencido,D.interesabono,U.codigo,S.saldoanterior,S.movDebito,U.id
		
	    END
		ELSE
		BEGIN
		INSERT INTO @temp1(id_pk)
				SELECT  A.id
				FROM CNT.VW_MOVReciboCajasItems A 
				WHERE  ((isnull(@filter,'')='' or CAST(A.id AS Varchar) like '%' + @filter + '%')	OR
					   (isnull(@filter,'')='' or valorCuota like '%' + @filter + '%')) AND A.id_recibo=@id_recibo 
				ORDER BY A.id_factura ASC;

				SET @countpage = @@rowcount;		
		
				if (@numpage = -1)
					SET @endpage = @countpage;

				select  tm.id_pk id,c.id_factura,c.cuota,c.valorCuota,c.pagoCuota,c.pagoInteres,c.porceInteres, 
				c.totalpagado,c.vencimiento_interes
				FROM @temp1 Tm
						INNER JOIN VW_MOVReciboCajasItems C ON tm.id_pk = C.id
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
