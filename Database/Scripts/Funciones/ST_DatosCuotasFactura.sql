
--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_DatosCuotasFactura]') and OBJECTPROPERTY(id, N'IsTableFunction') = 1)
DROP FUNCTION [CNT].[ST_DatosCuotasFactura]
GO

CREATE Function  [CNT].[ST_DatosCuotasFactura] (@id_cliente BIGINT,@nrofactura VARCHAR(50),@id_cuenta VARCHAR(50),@anomes VARCHAR(6))
RETURNS @TblResultante  TABLE ( Id Int Identity (1,1) Not Null, fechavencimiento VARCHAR(10), 
								valorcuota NUMERIC(18,2),saldocuota Numeric(18,2),cuotapendiente int,diasvencido int,interesabono NUMERIC(18,2))

 
As
BEGIN
	Declare  @vencimiento				 VARCHAR(10),
			 @Vlrcuota   				 NUMERIC(18,2) = 0,
			 @abono				  		 NUMERIC(18,2) = 0,
			 @salCuota  				 NUMERIC(18,2) = 0,
			 @cuotaPend				     INT,
			 @dias						 INT,
			 @diasInterespaagos          INT,
			 @cuota						 INT,
			 @interesabono				 NUMERIC(18,2)
			
			 
	SELECT TOP 1 @cuota	= cuota,@vencimiento=IIF(fechapagointeres=vencimiento_cuota,IIF((CAST(GETDATE() as date) > CAST(vencimiento_cuota as date)),convert(varchar, CAST(vencimiento_cuota as date), 23) ,''),convert(varchar, CAST(fechapagointeres as date), 23)),@Vlrcuota=(saldoAnterior)+movdebito,@abono=movCredito,@cuotaPend=cuota FROM CNT.SaldoCliente_Cuotas WHERE id_cliente=@id_cliente and id_cuenta=@id_cuenta and nrofactura=@nrofactura and cancelada=0 and id_devolucion is null and anomes=@anomes and saldoActual>0 order by id
	SET @salCuota			=   @Vlrcuota-@abono;
	SET @dias				=  case when @vencimiento='' then 0 else datediff(day,@vencimiento,getdate()) end
	SELECT @diasInterespaagos   = ISNULL(sum(diasinterespagados),0) from cnt.MOVReciboCajasItems I INNER JOIN CNT.MOVReciboCajas R ON I.id_recibo=R.id where I.id_factura=@nrofactura AND cuota=@cuota and vencimiento_interes=@vencimiento and R.estado=Dbo.ST_FnGetIdList('PROCE')
	SELECT @interesabono		=  	sum(pagointeres) from cnt.MOVReciboCajasItems I INNER JOIN CNT.MOVReciboCajas R ON I.id_recibo=R.id where I.id_factura=@nrofactura AND cuota=@cuota and vencimiento_interes=@vencimiento and R.estado=Dbo.ST_FnGetIdList('PROCE') and pagototalinteres=0
	Insert Into @TblResultante (fechavencimiento, valorcuota,saldocuota,cuotapendiente,diasvencido,interesabono)

	Values	(@vencimiento,@Vlrcuota,  @salCuota,@cuotaPend,@dias-@diasInterespaagos,@interesabono);	
	RETURN
End
  


