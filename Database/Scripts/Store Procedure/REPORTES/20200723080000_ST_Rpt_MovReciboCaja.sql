--liquibase formatted sql
--changeset ,kmartinez:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_Rpt_MovReciboCaja]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [CNT].[ST_Rpt_MovReciboCaja] 
GO

CREATE PROCEDURE [CNT].[ST_Rpt_MovReciboCaja] 
@id BIGINT,
@op CHAR (2)
 
AS
/***************************************
*Nombre:		[CNT].[ST_Rpt_ReciboCaja]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci?n:		23/07/2020
*Desarrollador:  Jesid Teheran Meza(jeteme)
*Descripcion:	Se realizan la consulta de la informacion del de recibo de cajas
***************************************/
BEGIN
Declare @error varchar(max),@totalpositivo NUMERIC(18,2),@totalnegativo NUMERIC(18,2)
BEGIN TRY		
SET LANGUAGE Spanish
	Declare @id_recibo int,  @id_Recaudo int;

	SET @id_recibo = (SELECT TOP 1 CASE WHEN Dbo.ST_FnGetIdList('REVON') = estado THEN id_reversion ELSE id END FROM CNT.MOVReciboCajas T Where T.id = @id);
	SET @id_Recaudo = (SELECT TOP 1 CASE WHEN Dbo.ST_FnGetIdList('REVON') = estado THEN id_reversion ELSE id END FROM [FIN].[Recaudocartera] T Where T.id = @id);
	IF(@op = 'C')
	BEGIN
		SELECT id, estado, CONVERT(VARCHAR(10), fecha, 120)  fechadoc,  cliente,
			   valorcliente,valorDescuento*-1 valorDescuento,(valorcliente-valorDescuento) totalRecaudo,valorconcepto,((valorcliente-valorDescuento)+valorconcepto) Total_recibo,cambio
		FROM CNT.VW_MOVReciboCajas
		WHERE id = @id_recibo;
	END

	ELSE IF(@op = 'B')
	BEGIN
		SELECT
			CONCAT('Pago o Abono a Factura: ',I.id_factura) concepto,I.totalpagado valor
		FROM 
			[CNT].[VW_MOVReciboCajasItems] I 
		WHERE 
			I.id_recibo = @id_recibo
		UNION ALL
		SELECT 
			I.concepto, I.valor		FROM 
			[CNT].[VW_MOVReciboCajasConceptos] I 
		WHERE 
			I.id_recibo = @id_recibo;
	END ELSE IF (@op='F')
	BEGIN
	SELECT FP.nombre, SUM(F.valor) valor, F.voucher
		FROM CNT.MOVReciboCajasFormaPago F
		LEFT JOIN Dbo.FormaPagos FP ON F.id_formapago = FP.id
		WHERE F.id_recibo = @id_recibo
		GROUP BY FP.nombre, F.voucher

	END 
	ELSE IF(@op = 'R')--Recaudo Cartera
	BEGIN
		SELECT
			CONCAT('Pago o Abono a Factura: ',I.id_factura, ', cuota No.', I.cuota) concepto, I.totalpagado valor
		FROM 
			[FIN].[VW_RecaudoReciboCarteraItems] I 
		WHERE 
			I.id_recibo = @id_Recaudo
		UNION ALL
		SELECT DISTINCT I.concepto, I.valorDescuento AS valor FROM 
			[FIN].[VW_RecaudoReciboCarteraItems] I 
		WHERE 
			I.id_recibo = @id_Recaudo AND concepto IS NOT NULL
	END
	ELSE IF(@op = 'RC')--Recaudo Cartera
	BEGIN
		SELECT id, estado, CONVERT(VARCHAR(10), fecha, 120)  fechadoc,  cliente,
			   valorcliente,valorDescuento*-1 valorDescuento,(valorcliente-valorDescuento) totalRecaudo,valorconcepto,((valorcliente-valorDescuento)+valorconcepto) Total_recibo,cambio
		FROM [FIN].[VW_Recaudocartera]
		WHERE id = @id_Recaudo;
	END

	ELSE IF(@op = 'FP')--Recaudo Cartera forma de pago 
	BEGIN		
		SELECT FPP.nombre, SUM(F.valor) valor, F.voucher FROM  [FIN].[RecaudoCarteraFormaPago] F 
			LEFT JOIN Dbo.FormaPagos FPP ON F.id_formapago = FPP.id inner join 
					  [FIN].[Recaudocartera] AS R ON F.id_recibo = R.id
		WHERE F.id_recibo = @id
		GROUP BY FPP.nombre, F.voucher
	 
	 

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