--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MOVFacturaCuotasList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [dbo].[ST_MOVFacturaCuotasList]
GO


CREATE PROCEDURE [dbo].[ST_MOVFacturaCuotasList]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@id_factura VARCHAR(50),
	@porceinteres NUMERIC(6,2),
	@fecha smalldatetime,
	@all bit=0
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[ST_MOVFacturaCuotasList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		04/11/19
*Desarrollador: (jeteme)
***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 10,@anomes VARCHAR(6);
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT )
BEGIN TRY
		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = 1000;

		SET @anomes = CONVERT(VARCHAR(6), @fecha, 112);

		IF(@all=0)
		INSERT INTO @temp(id_pk)
		SELECT  id	
		FROM CNT.VW_MOVSaldoCliente_Cuotas
		WHERE  factura=@id_factura  and id_devolucion is null and saldoActual>0 and  id_nota is null and anomes=@anomes
		ORDER BY id ASC;
		ELSE
		INSERT INTO @temp(id_pk)
		SELECT  id	
		FROM CNT.VW_MOVSaldoCliente_Cuotas
		WHERE  factura=@id_factura  and id_devolucion is null  and  id_nota is null and anomes=@anomes
		ORDER BY id ASC;

		SET @countpage = @@rowcount;		
		
		SELECT distinct Tm.id_record,
							 A.id,
							 A.cuota,
							 A.factura,
							 ( A.movdebito+A.saldoanterior) vlrcuota,
							 A.movcredito abono,
							 (A.saldoactual) saldo,
							 convert(varchar, CAST(vencimiento_cuota as date), 23) vencimiento_cuota,
							 isnull((case when datediff(day,vencimiento_cuota,getdate())<0 then 0 else datediff(day,vencimiento_cuota,getdate()) end)-(select ISNULL(sum(diasinterespagados),0) from cnt.MOVReciboCajasItems I INNER JOIN CNT.MOVReciboCajas R ON I.id_recibo=R.id where id_cuota=A.id and R.estado=Dbo.ST_FnGetIdList('PROCE')),0) diasdevenci,
							 ISNULL(ROUND(((saldoActual)*(@porceInteres/100)/30) *((case when datediff(day,vencimiento_cuota,getdate())<0 then 0 else datediff(day,vencimiento_cuota,getdate()) end)-(select ISNULL(sum(diasinterespagados),0) from cnt.MOVReciboCajasItems I INNER JOIN CNT.MOVReciboCajas R ON I.id_recibo=R.id where id_cuota=A.id and R.estado=Dbo.ST_FnGetIdList('PROCE')))-(((select ISNULL(SUM(pagoInteres),0) from cnt.MOVReciboCajasItems I Inner JOIN cnt.MOVReciboCajas R ON R.id=I.id_recibo  where id_cuota=A.id  and R.estado=Dbo.ST_FnGetIdList('PROCE') and I.pagototalinteres=0))),0),0) interes,
							 0 Ainteres 
		FROM @temp Tm
				Inner join CNT.VW_MOVSaldoCliente_Cuotas A on Tm.id_pk = A.id 
				LEFT JOIN CNT.MOVReciboCajasItems R ON R.id_cuota=A.id 
				LEFT JOIN CNT.MOVReciboCajas RC ON R.id_recibo=RC.id and RC.estado=Dbo.ST_FnGetIdList('PROCE') 
		WHERE id_record between @starpage AND @endpage  GROUP BY Tm.id_record,A.cuota,A.id,A.factura,A.movdebito,A.movcredito,A.vencimiento_cuota,A.saldoActual,A.saldoanterior,vencimiento_interes;
			
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
