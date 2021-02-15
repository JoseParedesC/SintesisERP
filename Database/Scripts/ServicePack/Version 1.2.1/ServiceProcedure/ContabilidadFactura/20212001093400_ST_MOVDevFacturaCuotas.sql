--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MOVDevFacturaCuotas]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MOVDevFacturaCuotas]
GO

CREATE PROCEDURE [dbo].[ST_MOVDevFacturaCuotas]
@id_devolucion BIGINT,
@isFinan BIT=NULL OUTPUT,
@id_user BIGINT


--WITH ENCRYPTION
/***************************************
*Nombre:		[CNT].[ST_MOVDevFacturaCuotas]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		20/01/2021
*Desarrollador: (Jeteme)

***************************************/
AS	

DECLARE @miCTE table(id BIGINT,cuota int,  valorcuotadev NUMERIC(18,2))
Declare @id_cliente BIGINT,@nrofactura varchar(50),@id_cuenta BIGINT,@total numeric(18,2),@valcuota Numeric(18,2),@totaldevolucion NUMERIC(18,2),@valor Numeric(18,2),@numcuotas Numeric(18,2),@cuota INT,@id_saldo BIGINT,@id_documento BIGINT,@valcuotadev numeric(18,2),@firstcuota numeric(18,2),@anomes varchar(6),@fechadoc smalldatetime,@id_factura bigint,@id_forma bigint;
BEGIN TRY	
			
			
			SELECT @id_cuenta=iif(FA.PagoFinan is null,F.id_cuenta,Fa.id_ctaFin),@totaldevolucion= D.total-D.valoranticipo,@fechadoc=D.fecha,@id_cliente=Fa.id_tercero,@nrofactura=CONCAT(Fa.prefijo,'-',Fa.consecutivo),@id_forma=F.id,@id_factura=FA.id,@isFinan=iif(FA.PagoFinan is not null,1,0)   from MOVFacturaFormaPago FP join MOVDevFactura D on FP.id_factura=D.id_factura JOIN FormaPagos F ON F.id=FP.id_formapago join MOVFactura Fa on Fa.id=D.id_factura  where (F.id_tipo=DBO.ST_FnGetIdList('CARTERA'))  AND D.id=@id_devolucion
			SET @totaldevolucion=dbo.FnVlrDescFP(@id_factura,@id_forma,@totaldevolucion)

			
			SET @anomes = CONVERT(VARCHAR(6), @fechadoc, 112);
			Select @cuota=MIN(cuota),@numcuotas= count(*) from CNT.SaldoCliente_Cuotas C where C.id_cliente=@id_cliente and id_cuenta=@id_cuenta and nrofactura=@nrofactura and C.saldoActual>0 and C.id_devolucion is null and c.anomes=@anomes and C.id_nota is NULL

	
			SET @valcuotadev=round((@totaldevolucion/@numcuotas),2);

			;WITH miCTE (id,cuota ,vlrcuotadev) AS(
			   SELECT 1,@cuota,CONVERT(DECIMAL(18,2),@valcuotadev)
			   UNION ALL
			   SELECT 
					id + 1,
					cuota+1,
					CONVERT(DECIMAL(18,2), CASE WHEN id+1 < @numcuotas THEN @valcuotadev ELSE CONVERT(DECIMAL(18,2), @totaldevolucion - (@valcuotadev * (id))) END) 			
					--,CONVERT(DECIMAL(18,2),@valcuotadev)
			   FROM miCTE
			   WHERE id +1 <= @numcuotas
			)
			INSERT INTO @miCTE
			Select * from miCTE

			IF(@isFinan=0)
				INSERT INTO [dbo].[MovDevFacturaCuotas](id_devolucion,cuota,valorcuotadev,vencimiento,id_cuenta,id_user)
				SELECT @id_devolucion,C.cuota,C.valorcuotadev,S.vencimiento_cuota,@id_cuenta,@id_user FROM @miCTE C JOIN CNT.SaldoCliente_Cuotas S ON C.cuota=S.cuota AND id_cliente=@id_cliente and id_cuenta=@id_cuenta and nrofactura=@nrofactura and id_nota is null and anomes=@anomes
			ELSE
				INSERT INTO [dbo].[MovDevFacturaCuotas](id_devolucion,cuota,valorcuotadev,vencimiento,id_cuenta,id_user)
				SELECT @id_devolucion ,cuota,acapital,vencimiento_cuota,@id_cuenta,@id_user FROM FIN.SaldoCliente_Cuotas C JOIN FIN.SaldoCliente S ON C.id_saldo=S.id and S.anomes=C.anomes  WHERE  S.id_cliente=@id_cliente and nrofactura=@nrofactura and S.anomes=@anomes				
		
END TRY
BEGIN CATCH
	DECLARE @Mensajee varchar(max) = (select ERROR_MESSAGE())
	RAISERROR(@Mensajee,16,0);
END CATCH