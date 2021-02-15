--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[FnVlrDescFP]') and OBJECTPROPERTY(id, N'IsScalarFunction') = 1)
DROP FUNCTION [dbo].[FnVlrDescFP]
GO
CREATE FUNCTION [dbo].[FnVlrDescFP] 
(
	-- Add the parameters for the function here
	@id_factura bigint,
	@id_forma bigint,
	@valordevolver Numeric(18,2)
)
/*
Funcion que me devuelve valor a descontar en la cuenta de forma de pago a la hora de hacer una devolucion

*/
RETURNS Numeric(18,2)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Total Numeric(18,2);
	DECLARE @id int,@result numeric(18,2)
	DECLARE @tableforma TABLE (id int identity (1,1),id_factura BIGINT, id_forma BIGINT, valor numeric(18,2));
	DECLARE @miCTE TABLE (id int ,id_factura BIGINT, id_forma BIGINT, valor numeric(18,2),devolver Numeric(18,2));


	-- Add the T-SQL statements to compute the return value here
	INSERT INTO @tableforma (id_factura,id_forma,valor)
		SELECT id_factura,id_formapago,SUM(valor)-(select  ISNULL(SUM(DF.valor),0) from movdevfacturaformapago DF  where DF.id_Factura=@id_factura and DF.id_formapago=FF.id_formapago) from MOVFacturaFormaPago FF inner join FormaPagos F ON FF.id_formapago=F.id where id_factura=@id_factura and F.nombre='Efectivo'   group by id_factura,id_formapago 
		HAVING sum(valor)-(select  ISNULL(SUM(DF.valor),0) from movdevfacturaformapago DF  where DF.id_Factura=@id_factura and DF.id_formapago=FF.id_formapago)>0 
	UNION ALL
		SELECT id_factura,id_formapago,SUM(valor)-(select  ISNULL(SUM(DF.valor),0) from movdevfacturaformapago DF  where DF.id_Factura=@id_factura and DF.id_formapago=FF.id_formapago) FROM MOVFacturaFormaPago FF inner join FormaPagos F ON FF.id_formapago=F.id INNER JOIN ST_Listados S ON F.id_tipo=S.id WHERE id_factura=@id_factura and F.nombre!='Efectivo' AND S.nombre!='Cartera cliente'   group by id_factura,id_formapago 
		HAVING sum(valor)-(select  ISNULL(SUM(DF.valor),0) from movdevfacturaformapago DF  where DF.id_Factura=@id_factura and DF.id_formapago=FF.id_formapago)>0 
	UNION ALL
		SELECT id_factura,id_formapago,SUM(valor)-(select  ISNULL(SUM(DF.valor),0) from movdevfacturaformapago DF  where DF.id_Factura=@id_factura and DF.id_formapago=FF.id_formapago) FROM MOVFacturaFormaPago FF inner join FormaPagos F ON FF.id_formapago=F.id INNER JOIN ST_Listados S ON F.id_tipo=S.id WHERE id_factura=@id_factura AND S.nombre='Cartera cliente'   group by id_factura,id_formapago 
		HAVING sum(valor)-(select  ISNULL(SUM(DF.valor),0) from movdevfacturaformapago DF  where DF.id_Factura=@id_factura and DF.id_formapago=FF.id_formapago)>0 


	;WITH miCTE (id, id_factura, id_formapago,valor,devolver) AS (
				   SELECT TOP 1 id, 
								id_factura, 
								id_forma,
								valor,
								@valordevolver-valor
								FROM @tableforma 
						UNION ALL
				    SELECT 
						T.id,
						T.id_factura, 
						T.id_forma,
						T.valor,
						CAST(devolver as NUMERIC(18,2))-T.valor
				   FROM miCTE M INNER JOIN @tableforma T ON T.id = M.id +1
				   WHERE M.devolver>0)
				   INSERT INTO @miCTE 
				   SELECT * FROM miCTE

		SELECT @id=id,@result= devolver FROM @miCTE WHERE id_forma=@id_forma
		IF(@id=1 )
		BEGIN
			IF(@result<=0)
			  SELECT @Total= @valordevolver from @miCTE where id=@id
			ELSE
			  SELECT @Total = valor from @miCTE where id=@id
		END
		ELSE IF(@id>1 )
			BEGIN
				 IF(@result<=0)
					SELECT @Total= devolver from @miCTE where id=@id-1 
				ELSE
					SELECT @Total= valor from @miCTE where id=@id 
			END
	
			




	-- Return the result of the function
	RETURN @Total

END
