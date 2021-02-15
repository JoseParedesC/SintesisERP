--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_MOVReciboCajaGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_MOVReciboCajaGet]
GO

CREATE PROCEDURE [CNT].[ST_MOVReciboCajaGet] 
	@id [BIGINT]
--WITH ENCRYPTION
AS
BEGIN
/***************************************
*Nombre:		[CNT].[ST_MOVReciboCajaGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		27/06/20
*Desarrollador: (Jeteheran)

SP para obtener recibo de cajas filtrado por Id
***************************************/
	------------------------------------------------------------------------------
	-- Declaring variables Page_Nav
	------------------------------------------------------------------------------
	Declare @ds_error varchar(max), @id_recibo Bigint
	
	Begin Try
		SET @id_recibo = (SELECT Top 1 CASE WHEN Dbo.ST_FnGetIdList('REVON') = estado THEN id_reversion ELSE id END FROM CNT.MOVReciboCajas T Where T.id = @id);
		
		SELECT
			 T.id, 
			 CONVERT(VARCHAR(10), T.fecha, 120) AS fecha,
			 estado,
			 id_tipodoc,
			 id_centrocostos,
			 Centrocostos,
			 cliente,
			 id_cliente,
			 valorcliente,
			 valorconcepto,
			 conceptoDescuento,
			 valorDescuento,
			 id_reversion
			 FROM 
			CNT.VW_MOVReciboCajas T
		WHERE
			T.id = @id;

				SELECT
				C.id,
				C.id_concepto,
				C.concepto,
				C.valor

				FROM CNT.VW_MOVReciboCajasConceptos C
				WHERE C.id_recibo=@id

		
	End Try
    Begin Catch
	--Getting the error description
	Set @ds_error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	-- save the error in a Log file
	RaisError(@ds_error,16,1)
	return
	End Catch
END


GO


