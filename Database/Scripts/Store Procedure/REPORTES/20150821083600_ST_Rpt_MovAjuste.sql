--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_Rpt_MovAjuste]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_Rpt_MovAjuste]
GO

CREATE PROCEDURE [dbo].[ST_Rpt_MovAjuste] 
@id BIGINT,
@op CHAR (1)
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_Rpt_MovAjuste]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		21/08/2015
*Desarrollador:  Jose Luis Tous P�rez (jtous)
*Descripcion:	Se realizan la consulta de la informacion del reporte de factura de pago caja tirilla
***************************************/
BEGIN
Declare @error varchar(max),@totalpositivo NUMERIC(18,2),@totalnegativo NUMERIC(18,2)
BEGIN TRY		
SET LANGUAGE Spanish
	Declare @id_entra int;

	SET @id_entra = (SELECT TOP 1 CASE WHEN Dbo.ST_FnGetIdList('REVON') = estado THEN id_reversion ELSE id END FROM Dbo.MOVAjustes T Where T.id = @id);

	IF(@op = 'C')
	BEGIN
		SELECT id, estado, fecha fechadoc,  centrocosto, tipodocumento,
			   costototal,detalle
		FROM Dbo.VW_MOVAjustes
		WHERE id = @id;
	END

	ELSE IF(@op = 'B')
	BEGIN
		SELECT 
			I.id, I.cantidad, I.costo, I.costototal, I.serie,I.codigo, 
			I.presentacion, I.nombre articulo, I.lote lote,	I.lote,I.bodega,L.id_lote,isnull(LP.lote,'') nomlote
		FROM 
			[dbo].[VW_MOVAjustesItems] I LEFT join MovAjustesLotes L ON I.id=L.id_item
			LEFT JOIN LotesProducto LP ON L.id_lote=LP.id 
		WHERE 
			I.id_ajuste = @id_entra;
	END
	
	IF(@op = 'S')
	BEGIN
		SELECT serie
		FROM Dbo.MovAjustesSeries
		WHERE id_items = @id;
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
