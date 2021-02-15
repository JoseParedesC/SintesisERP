--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_Rpt_NotaCartera]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [CNT].[ST_Rpt_NotaCartera]
GO

CREATE PROCEDURE [CNT].[ST_Rpt_NotaCartera] 
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
	SET @id = (SELECT Top 1 CASE WHEN Dbo.ST_FnGetIdList('REVON') = id_estado THEN id_reversion ELSE id END FROM cnt.VW_MOVNotascartera T Where T.id = @id);

	IF(@op = 'C')
	BEGIN
		SELECT id, estado, tercero,tipotercero,detalle,tipodocumento,Centrocostos,nrofactura ,fecha,saldoactual
			   
		FROM cnt.VW_MOVNotascartera
		WHERE id = @id;
	END
	ELSE IF(@op = 'B')
	BEGIN
			SELECT cuenta,nrofactura,cuota,vencimiento,IIF(vlrcuota>0,vlrcuota,0) debito,IIF(vlrcuota>0,0,vlrcuota*-1) credito FROM cnt.VW_MOVNotasCarteraSaldos WHERE id=@id
			ORDER BY cuota asc,vencimiento
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