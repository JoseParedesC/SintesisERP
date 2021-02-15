--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_MOVComprobanteContableItemList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [CNT].[ST_MOVComprobanteContableItemList]
GO
CREATE PROCEDURE [CNT].[ST_MOVComprobanteContableItemList]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL,
	@id_comprobante BIGINT,
	@op CHAR(1)
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[CNT].[ST_MOVComprobanteContableItemList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		10/07/20
*Desarrollador: (Jeteme)

SP que lista los items agregado en la tabla de MOVComprobantesItemsTemp o en la MOVComprobantesContablesItems dependiendo de la opcion ingresada
***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT,id_comprobante BIGINT ,id_concepto BIGINT,id_cuenta BIGINT,id_tercero BIGINT,valor NUMERIC(18,2) )
BEGIN TRY
		
		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;
		IF(@op = 'T')
		BEGIN		
			INSERT INTO @temp(id_pk,id_comprobante,id_concepto,id_cuenta,id_tercero,valor)
			SELECT  i.id,i.id_comprobante,i.id_concepto,i.id_cuenta,i.id_tercero,i.valor
			FROM CNT.MOVComprobantesItemsTemp i 
			WHERE	((isnull(@filter,'')='' or i.valor like '%' + @filter + '%')) and i.id_comprobante=@id_comprobante
				
			ORDER BY i.id ASC;

			SET @countpage = @@rowcount;		
		
			SELECT Tm.id_record,tm.id_pk as id ,tm.id_comprobante, tm.id_concepto,tm.id_cuenta nombre,tm.id_tercero,case when (tm.valor>0) then tm.valor else 0 end debito,case when (tm.valor<0) then tm.valor*-1 else 0 end credito, C.codigo+' '+C.nombre cuenta, P.nombre concepto, tercero,R.Tdebito,R.Tcredito,R.diferencia
			FROM @temp Tm INNER JOIN CNTCuentas C ON tm.id_cuenta=C.id
			LEFT JOIN dbo.Productos P ON tm.id_concepto=P.id INNER JOIN
			 [CNT].[VW_Terceros]    AS TT ON Tm.id_tercero = TT.id          
			Cross Apply CNT.ST_FnCalTotalComprobante(@id_comprobante,'T') R
			WHERE id_record between @starpage AND @endpage
			ORDER BY tm.id_pk ASC;

			END
		ELSE
		BEGIN
		INSERT INTO @temp(id_pk,id_comprobante,id_concepto,id_cuenta,id_tercero,valor)
			SELECT  i.id,i.id_comprobante,i.id_concepto,i.id_cuenta,i.id_tercero,i.valor
			FROM CNT.MOVComprobantesContablesItems i 
			WHERE	((isnull(@filter,'')='' or i.valor like '%' + @filter + '%')) and i.id_comprobante=@id_comprobante
		
				
			ORDER BY i.id ASC;

			SET @countpage = @@rowcount;		
		
			SELECT Tm.id_record,tm.id_pk as id ,tm.id_comprobante,tm.id_concepto,tm.id_cuenta nombre,tm.id_tercero,case when (tm.valor>0) then tm.valor else 0 end debito,case when (tm.valor<0) then tm.valor*-1 else 0 end credito, C.codigo+' '+C.nombre cuenta, P.nombre concepto, TT.tercero,R.Tdebito,R.Tcredito,R.diferencia
			FROM @temp Tm INNER JOIN CNTCuentas C ON tm.id_cuenta=C.id
			LEFT JOIN dbo.Productos P ON tm.id_concepto=P.id INNER JOIN
			 [CNT].[VW_Terceros]    AS TT ON Tm.id_tercero = TT.id            
		  			Cross Apply CNT.ST_FnCalTotalComprobante(@id_comprobante,'C') R
			WHERE id_record between @starpage AND @endpage
			ORDER BY tm.id_pk ASC;

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