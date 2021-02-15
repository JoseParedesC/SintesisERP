--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_MOVComprobanteContaGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_MOVComprobanteContaGet]
GO

CREATE PROCEDURE [CNT].[ST_MOVComprobanteContaGet] 
	@id [BIGINT]
--WITH ENCRYPTION
AS
BEGIN
/***************************************
*Nombre:		[CNT].[ST_MOVComprobanteContaGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		10/07/20
*Desarrollador: (Jeteme)

SP que retorna los datos de comprobantes guardados 
***************************************/
	------------------------------------------------------------------------------
	-- Declaring variables Page_Nav
	------------------------------------------------------------------------------
	Declare @ds_error varchar(max), @id_compro Bigint
	
	Begin Try
		SET @id_compro = (SELECT Top 1 CASE WHEN Dbo.ST_FnGetIdList('REVON') = estado THEN id_reversion ELSE id END FROM CNT.MOVComprobantesContables T Where T.id = @id);
		
		Select 
			 T.id, 
			 CONVERT(VARCHAR(10), T.fecha, 120) AS fecha,
		     T.detalle, 
			 dbo.ST_FnGetNombreList(T.estado) estado,
			 T.id_documento,
			 R.Tdebito,
			 R.Tcredito,
			 R.diferencia,
			 T.id_centrocosto,
			 C.codigo +' - ' + C.nombre centrocosto
		From 
			CNT.MOVComprobantesContables T
			Cross Apply CNT.ST_FnCalTotalComprobante(@id,'C') R
			LEFT JOIN CNT.CentroCosto C ON C.id = T.id_centrocosto
		Where 
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


