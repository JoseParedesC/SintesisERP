--liquibase formatted sql
--changeset ,kmartinez:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FIN].[FacturaCuotasListFinan]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [FIN].[FacturaCuotasListFinan]
GO

CREATE PROCEDURE [FIN].[FacturaCuotasListFinan]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@id_factura VARCHAR(30),
	@id_tercero BIGINT = 2,
	@porceinteres NUMERIC(6,2),
	@fecha VARCHAR(10)

AS
/***************************************
*Nombre:		[FIN].[FacturaCuotasListFinan]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		21/11/20
*Desarrollador: (kMARTINEZ)
***************************************/
DECLARE @error VARCHAR(MAX), @anomes VARCHAR(6) = @fecha;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) , numfactura varchar(30), cuota INT, id_tercero BIGINT)
BEGIN TRY
		SET @numpage = ISNULL(@numpage,10);				

		INSERT INTO @temp(numfactura, cuota, id_tercero)
		SELECT  numfactura, cuota, id_cliente
		FROM [FIN].[VW_SaldoCliente_Cuotas]
		WHERE  numfactura = @id_factura AND id_cliente = @id_tercero AND anomes = @anomes and devolucion=0 AND cancelada = 0
		ORDER BY id ASC;

		SET @countpage = @@rowcount;
		
		
			SELECT DISTINCT Tm.id_record, 
					A.id, 
					A.cuota, 
					A.id_saldo id_factura, 
					A.factura, 
					A.cuotafianza vlrcuota,					
					A.acapital,
					A.InteresCausado,
					A.id_cliente,
					(A.abono + A.abonofianza ) abono,
					A.CuotaFianza - (A.abono + A.AbonoFianza ) saldo,
					
					CONVERT(varchar, CAST(vencimiento_cuota as date), 23) vencimiento_cuota,

					CASE WHEN DATEDIFF(DD,vencimiento_cuota,@fecha )< 0 THEN 0 ELSE CAST((DATEDIFF(DD,vencimiento_cuota,@fecha) - A.diasmora) AS INT) END diasdevenci,
				
					CONVERT(NUMERIC(18,2), CASE WHEN DATEDIFF(DD,vencimiento_cuota, @fecha) <= 0 THEN 0 ELSE ((DATEDIFF(DD,vencimiento_cuota,@fecha) - A.diasmora) * ((A.acapital- (A.abono - A.AbonoInteres))  *((@porceInteres/100)/30))) END) interes,
										
					CASE WHEN A.InteresCausado != 0 THEN 1 ELSE  0 END causada
			 
			FROM @temp Tm
			INNER JOIN [FIN].[VW_SaldoCliente_Cuotas] A ON A.numfactura = Tm.numfactura AND A.cuota = TM.cuota AND TM.id_tercero = A.id_cliente				  
		WHERE devolucion = 0 AND cancelada = 0 AND A.anomes = @anomes
		ORDER BY A.cuota ASC
 
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
