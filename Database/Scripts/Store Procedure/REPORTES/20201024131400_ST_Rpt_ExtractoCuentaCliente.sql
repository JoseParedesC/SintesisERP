--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_Rpt_ExtractoCuentaCliente]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [CNT].[ST_Rpt_ExtractoCuentaCliente]
GO
CREATE PROCEDURE [CNT].[ST_Rpt_ExtractoCuentaCliente]
	@id_cliente BIGINT,
	@fechaini smalldatetime,
	@fechafinal smalldatetime,
	@factura varchar(50)=NULL
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[CNT].[ST_Rpt_ExtractoCuentaCliente]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		24/10/2020
*Desarrollador:  Jesid Teheran Meza (jeteme)
*Descripcion:	Se realizan la consulta de saldo de cuotas por cliente
***************************************/
BEGIN
Declare @error varchar(max)
BEGIN TRY		
SET LANGUAGE Spanish
	
	--select @factura
	--raiserror('16',16,0)
	if(@factura='0') set @factura=NULL
	
	DECLARE @tabla TABLE(id int identity, tipodoc varchar(2),  nrodoc BIGINT, fechadcto VARCHAR(10),nrofactura VARCHAR(50),fechaven varchar(10),debito numeric(18,2),credito numeric(18,2),tercero VARCHAR(100));

					INSERT INTO @tabla (tipodoc, nrodoc, fechadcto,nrofactura,fechaven,debito,credito,tercero)
					SELECT  tipodocumento,
								  nrodocumento,
								  CONVERT(VARCHAR(10),fechadcto,120),
								  nrofactura,
								  CONVERT(VARCHAR(10),fechavencimiento,120),
								  CONVERT(NUMERIC(18,4), IIF(valor>0,valor,0)),
								  CONVERT(NUMERIC(18,4), (IIF(valor>0,0,valor)*-1)),
								  TT.tercero
								  FROM cnt.transacciones t JOIN CNTCuentas C on t.id_cuenta=c.id AND c.categoria=dbo.ST_FnGetIdList('CCLIENTE') and T.estado=dbo.ST_FnGetIdList('PROCE') JOIN
								  CNT.VW_Terceros TT ON T.id_tercero=TT.id
								  WHERE T.id_tercero=@id_cliente and T.fechadcto between @fechaini and @fechafinal AND (ISNULL(@factura,'')=''  OR nrofactura =@factura)

					;WITH miCTE (id,tipodoc ,nrodocumento, fechadcto,nrofactura,fechaven,debito,credito,saldo,tercero) AS(
								  SELECT TOP 1 id,
								  tipodoc,
								  nrodoc,
								  fechadcto,
								  nrofactura,
								  fechaven,
								  CONVERT(NUMERIC(18,4),debito),
								  CONVERT(NUMERIC(18,4),credito),
								  CONVERT(NUMERIC(18,4),debito-credito),
								  tercero
								  FROM @tabla 
								  UNION ALL
								   SELECT 
										T.id,
										T.tipodoc,
										T.nrodoc, 			
										T.fechadcto ,
										T.nrofactura,
										T.fechaven,
										CONVERT(NUMERIC(18,4),T.debito),
										CONVERT(NUMERIC(18,4),T.credito),
										CONVERT(NUMERIC(18,4),saldo+T.debito-T.credito),
										T.tercero
								   FROM miCTE M INNER JOIN @tabla t ON T.id = M.id +1
					)
					select * from miCTE

	

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
