--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_Rpt_MovComprobantecontable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [CNT].[ST_Rpt_MovComprobantecontable]
GO
CREATE PROCEDURE [CNT].[ST_Rpt_MovComprobantecontable] 
@id BIGINT,
@op CHAR (1)
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[CNT].[ST_Rpt_MovComprobantecontable]
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
	Declare @id_comprobante int;

	SET @id_comprobante = (SELECT TOP 1 CASE WHEN Dbo.ST_FnGetIdList('REVON') = estado THEN id_reversion ELSE id END FROM CNT.MOVComprobantesContables T Where T.id = @id);

	IF(@op = 'C')
	BEGIN
		SELECT C.id, S.nombre estado, CONVERT(VARCHAR(10), fecha, 120)  fechadoc,C.detalle,id_documento,T.nombre tipodocumento,C.id_centrocosto,O.nombre centrocosto
		FROM CNT.MOVComprobantesContables C inner join cnt.TipoDocumentos T on C.id_documento=T.id
		LEFT JOIN CNT.CentroCosto O ON C.id_centrocosto=O.id INNER JOIN DBO.ST_Listados S ON C.estado=S.id
		WHERE C.id = @id_comprobante;
	END
	ELSE IF(@op = 'B')
	BEGIN
		SELECT
			I.id_concepto,id_cuenta,ISNULL(P.nombre,C.nombre) nombre,R.razonsocial AS TERCERO,detalle,IIF(I.valor>0,I.valor,0) debito,IIF(I.valor<0,I.valor*-1,0) credito
		FROM 
			[CNT].[MOVComprobantesContablesItems] I 
			LEFT JOIN  Productos P ON I.id_concepto=P.id
			INNER JOIN dbo.CNTCuentas C ON I.id_cuenta=C.id 
			INNER JOIN CNT.Terceros R ON I.ID_TERCERO=R.id
		WHERE 
			I.id_comprobante = @id_comprobante
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


