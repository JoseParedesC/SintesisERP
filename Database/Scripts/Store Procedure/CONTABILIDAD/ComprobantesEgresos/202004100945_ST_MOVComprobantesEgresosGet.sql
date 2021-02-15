--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_MOVComprobantesEgresosGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_MOVComprobantesEgresosGet]
GO


CREATE PROCEDURE [CNT].[ST_MOVComprobantesEgresosGet] 
	@id [BIGINT]
--WITH ENCRYPTION
AS
BEGIN
/***************************************
*Nombre:		[dbo].[ST_MOVComprobantesEgresosGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci?n:		10/04/20
*Desarrollador: (Jeteme)

SP para obtener o consultar un comprobante de egresos por su numero de ID
***************************************/
	------------------------------------------------------------------------------
	-- Declaring variables Page_Nav
	------------------------------------------------------------------------------
	Declare @ds_error varchar(max), @id_recibo Bigint
	
	Begin Try
		SET @id_recibo = (SELECT Top 1 CASE WHEN Dbo.ST_FnGetIdList('REVON') = estado THEN id_reversion ELSE id END FROM CNT.MOVComprobantesEgresos T Where T.id = @id);
		
		SELECT
			 T.id_tipodoc,
			 t.id_centrocosto,
			 T.centrocosto,
			 T.id, 
			 CONVERT(VARCHAR(10), T.fechadoc, 120) AS fecha,
			 estado,
			 nomestado,
			 proveedor,
			 id_proveedor,
			 valorproveedor,
			 valorconcepto,
			 id_reversion,
			 T.id_ctaant,
			 T.ctaanticipo,
			 ISNULL(valoranticipo,0) valoranticipo,
			 T.detalle
			 FROM 
			CNT.VW_MOVComprobantesEgresos T
		WHERE
			T.id = @id;
		
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


