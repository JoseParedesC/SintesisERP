--liquibase formatted sql
--changeset ,jteheran:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_Rpt_AuxiliaresContable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [CNT].[ST_Rpt_AuxiliaresContable]
GO
CREATE PROCEDURE [CNT].[ST_Rpt_AuxiliaresContable]
	@fechaini smalldatetime=NULL,
	@fechafinal smalldatetime=NULL,
	@codigoini BIGINT=NULL,
	@codigoFin BIGINT=NULL,
	@id_tercero BIGINT=NULL,
	@cuenta BIGINT=NULL,
	@opcion CHAR(1)
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[CNT].[ST_Rpt_AuxiliaresContable]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		28/11/2020
*Desarrollador:  Jesid Teheran Meza (jeteme)
*Descripcion:	Informe de movimiento de cuentas contables por terceros
***************************************/
BEGIN
Declare @error varchar(max),@saldoanterior numeric(18,2),@saldoanteriorGlobal numeric(18,2);
Declare @miCTE TABLE(id int,tipodoc varchar(2) ,centrocosto varchar(50),nrodocumento varchar(50), id_cuenta Varchar(20),fechadcto varchar(10),descripcion varchar(500),iden_tercero varchar(50),debito numeric(18,2),credito numeric(18,2),saldo numeric(18,2),tercero VARCHAR(100)) 
BEGIN TRY		
SET LANGUAGE Spanish
	IF(@opcion='P')
	BEGIN	
			select @saldoanteriorGlobal= ISNULL(SUM(valor),0) from cnt.Transacciones T join CNTCuentas C on T.id_cuenta=c.id where (ISNULL(@codigoini,0)=0 or c.codigo between @codigoini and @codigoFin) and (ISNULL(@id_tercero,0)=0 or T.id_tercero=@id_tercero) AND T.fechadcto < @fechaini and T.estado=dbo.ST_FnGetIdList('PROCE')
			SELECT  distinct c.id id_cuenta,codigo,@saldoanteriorGlobal saldoAntGlobal FROM CNT.Transacciones S inner  join CNTCuentas C on S.id_cuenta=C.id where S.fechadcto between @fechaini and @fechafinal AND (ISNULL(@codigoini,0)=0 or c.codigo between @codigoini and @codigoFin) and (ISNULL(@id_tercero,0)=0 or S.id_tercero=@id_tercero) and S.estado=dbo.ST_FnGetIdList('PROCE') order by codigo
	END ELSE
	IF(@opcion='D')
	BEGIN
	DECLARE @tabla TABLE(id int identity, tipodoc varchar(2), centrocosto varchar(50) ,nrodoc BIGINT,id_cuenta BIGINT ,fechadcto VARCHAR(10),descripcion VARCHAR(500),debito numeric(18,2),credito numeric(18,2),iden_tercero VARCHAR(50),tercero VARCHAR(100));
					
					select @saldoanterior= ISNULL(SUM(valor),0) from cnt.Transacciones T where (ISNULL(@cuenta,0)=0  OR id_cuenta = @cuenta) and (ISNULL(@id_tercero,0)=0 or T.id_tercero=@id_tercero) AND T.fechadcto < @fechaini and T.estado=dbo.ST_FnGetIdList('PROCE')
				
					INSERT INTO @tabla (tipodoc,centrocosto ,nrodoc,id_cuenta ,fechadcto,descripcion,debito,credito,iden_tercero,tercero)
					SELECT  tipodocumento,
								Ce.nombre,
								  nrodocumento,
								  t.id_cuenta,
								  CONVERT(VARCHAR(10),fechadcto,120),
								  T.descripcion,
								  CONVERT(NUMERIC(18,4), IIF(valor>0,valor,0)),
								  CONVERT(NUMERIC(18,4), (IIF(valor>0,0,valor)*-1)),
								  TT.iden,
								  TT.tercero
								  FROM cnt.transacciones t left JOIN CNTCuentas C on t.id_cuenta=c.id  and T.estado=dbo.ST_FnGetIdList('PROCE') left join
								  CNT.VW_Terceros TT ON T.id_tercero=TT.id left join cnt.CentroCosto Ce on Ce.id=T.id_centrocosto
								  WHERE   T.fechadcto between @fechaini and @fechafinal AND (ISNULL(@cuenta,0)=0  OR t.id_cuenta = @cuenta) and (ISNULL(@id_tercero,0)=0 or T.id_tercero=@id_tercero) order by fechadcto

					;WITH miCTE (id,tipodoc ,centrocosto,nrodocumento, id_cuenta,fechadcto,descripcion,iden_tercero,debito,credito,saldo,tercero) AS(
								  SELECT TOP 1 id,
								  tipodoc,
								  centrocosto,
								  nrodoc,
								  id_cuenta,
								  fechadcto,
								  descripcion,
								  iden_tercero,
								  CONVERT(NUMERIC(18,4),debito),
								  CONVERT(NUMERIC(18,4),credito),
								  CONVERT(NUMERIC(18,4),@saldoanterior+debito-credito),
								  tercero
								  FROM @tabla 
								  UNION ALL
								   SELECT 
										T.id,
										T.tipodoc,
										T.centrocosto,
										T.nrodoc,
										T.id_cuenta, 			
										T.fechadcto ,
										T.descripcion,
										T.iden_tercero,
										CONVERT(NUMERIC(18,4),T.debito),
										CONVERT(NUMERIC(18,4),T.credito),
										CONVERT(NUMERIC(18,4),saldo+T.debito-T.credito),
										T.tercero
								   FROM miCTE M INNER JOIN @tabla t ON T.id = M.id +1
					)
					
					INSERT INTO @miCTE
					select * from miCTE order by id_cuenta
					OPTION(MAXRECURSION 32767);

					select *,@saldoanterior saldoanterior from @miCTE

	END ELSE IF(@opcion='E')
	BEGIN
		SELECT D.nombre
	   FROM  Dbo.ST_FnNivelesCuentasCostos('C', @cuenta) D WHERE  D.tipo='G'
	   UNION 
	   SELECT concat(codigo,'-',nombre) FROM CNTCuentas WHERE id=@cuenta
	END

END TRY
BEGIN Catch
	    --Getting the error description
	    Select @error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	    -- save the error in a Log file
	    RaisError(@error,16,1)
	    Return  
	End Catch
END



GO


