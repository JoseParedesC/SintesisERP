--liquibase formatted sql
--changeset ,jteheran:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_Rpt_ComprobanteEgresos]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [CNT].[ST_Rpt_ComprobanteEgresos]
GO


CREATE PROCEDURE [CNT].[ST_Rpt_ComprobanteEgresos] 
@id BIGINT,
@op CHAR (1)
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[ST_Rpt_ComprobanteEgresos] 
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		24/10/2020
*Desarrollador:  jeteme
*Descripcion:	Se realizan la consulta de la informacion del reporte Comprobante de egresos
***************************************/
BEGIN
Declare @error varchar(max)
BEGIN TRY		
SET LANGUAGE Spanish
	Declare @id_entra int;
	SET @id_entra = (SELECT Top 1 CASE WHEN Dbo.ST_FnGetIdList('REVON') = estado THEN id_reversion ELSE id END FROM Dbo.MOVEntradas T Where T.id = @id);
	IF(@op = 'C')
	BEGIN
		SELECT id, nomestado, proveedor,valorconcepto,valorproveedor,tipodoc,centrocosto,(valorconcepto+valorproveedor) totalcomprobante,fechadoc, valoranticipo
			   
		FROM cnt.VW_MOVComprobantesEgresos
		WHERE id = @id;
	END
	ELSE IF(@op = 'B')
	BEGIN
			SELECT
			CONCAT('Pago o Abono a Factura de compra: ',I.nrofactura) concepto,I.valor
		FROM 
			[CNT].[VW_MOVComprobantesEgresosItems] I 
		WHERE 
			I.id_comprobante = @id
		UNION ALL
		SELECT 
			I.concepto, I.valor		FROM 
			[CNT].[VW_MOVComprobantesEgresosConceptos] I 
		WHERE 
			I.id_comprobante = @id;
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


