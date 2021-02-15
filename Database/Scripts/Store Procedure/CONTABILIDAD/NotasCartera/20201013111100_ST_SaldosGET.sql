--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_SaldosGET]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_SaldosGET]
GO
CREATE PROCEDURE [CNT].[ST_SaldosGET]
	@id_saldo BIGINT,
	@tipoterce VARCHAR(2),
	@id_cliente BIGINT=NULL,
	@nrofactura VARCHAR(50),
	@fecha VARCHAR(10)
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		 [CNT].[ST_SaldosGET]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci?n:		13/10/20
*Desarrollador: (jeteme)

SP que lista las cuotas que estan pendientes por pagar filtrando por cliente / cuotas que se pagaron filtradas por recibo de caja
***************************************/
DECLARE @error VARCHAR(MAX),@cantcuotas int,@anomes varchar(6),@totalinteres numeric(18,2)
DECLARE @temp TABLE(id_record INT  ,id INT,cuota INT,factura VARCHAR(50),vlrcuota NUMERIC(18,2),abono NUMERIC(18,2),saldo NUMERIC(18,2),vencimiento_cuota varchar(10),diasdevenci int,interes NUMERIC(18,2),Ainteres NUMERIC(18,2) )

BEGIN TRY
		SET @anomes = CONVERT(VARCHAR(6), @fecha, 112);

		IF(@tipoterce='CL')
		BEGIN
			SELECT @cantcuotas= COUNT(*) FROM CNT.SaldoCliente_Cuotas WHERE id_cliente=@id_cliente AND nrofactura=@nrofactura AND id_nota IS NULL AND anomes=@anomes AND id_devolucion IS NULL AND cancelada=0 and saldoActual>0
		    INSERT INTO @temp
			EXEC [dbo].[ST_MOVFacturaCuotasList] @id_factura = @nrofactura,@porceinteres = 10,	@fecha = @fecha,@all = 0

			SELECT @totalinteres = SUM(interes) from @temp
		
			SELECT TOP 1 S.id,S.id_cuenta,U.cuota,C.nombre cuenta,convert(varchar, CAST(vencimiento_cuota as date), 23) vencimientocuota,@cantcuotas cantcuotas,S.saldoactual,@totalinteres totalinteres FROM CNT.SaldoCliente S 
			INNER JOIN CNTCuentas C ON C.id=S.id_cuenta INNER JOIN CNT.saldocliente_cuotas U ON S.id_cliente=U.id_cliente AND S.nrofactura=U.nrofactura AND S.id_cuenta=U.id_cuenta AND U.id_devolucion IS NULL AND U.id_nota IS NULL AND U.anomes=S.anomes
			WHERE S.id=@id_saldo and U.cancelada=0  and s.anomes=@anomes order by U.id asc
				
		END
			ELSE IF(@tipoterce='PR')
			BEGIN
				SELECT S.id,S.id_cuenta,C.nombre cuenta,0 cuota,0 cantcuotas,S.saldoactual*-1 saldoactual,convert(VARCHAR(10),S.fechavencimiento,120) vencimientocuota ,0 totalinteres FROM CNT.SaldoProveedor S 
				INNER JOIN CNTCuentas C ON C.id=S.id_cuenta 
				WHERE S.id=@id_saldo 
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