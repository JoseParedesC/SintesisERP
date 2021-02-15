--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_MOVNotasCarteraGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [CNT].[ST_MOVNotasCarteraGet]   
GO
CREATE PROCEDURE [CNT].[ST_MOVNotasCarteraGet] 
		@id [BIGINT]
--WITH ENCRYPTION
AS
BEGIN
/***************************************
*Nombre:		[CNT].[ST_MOVNotasCarteraGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		16/10/20
*Desarrollador: (Jeteheran)

SP para obtener notas de cartera filtrado por Id
***************************************/
	------------------------------------------------------------------------------
	-- Declaring variables Page_Nav
	------------------------------------------------------------------------------
	Declare @ds_error varchar(max), @id_recibo Bigint
	
	Begin Try
		SET @id_recibo = (SELECT Top 1 CASE WHEN Dbo.ST_FnGetIdList('REVON') = estado THEN id_reversion ELSE id END FROM CNT.MOVNotasCartera T Where T.id = @id);
		
		SELECT
			 T.id, 
			 fecha,
			 estado,
			 id_tipodoc,
			 id_centrocosto,
			 Centrocostos,
			 tercero,
			 id_tercero,
			 id_tipotercero,
			 id_estado,
			 estado,
			 id_saldo,
			 nrofactura,
			 id_reversion,
			 id_ctaact,
			 cuentaactual,
			 id_ctaant,
			 cuentanterior,
			 vencimientoact,
			 detalle,
			 dia,
			 nrocuotas,
			 saldoactual,
			 id_tipoven
			 FROM 
			CNT.[VW_MOVNotascartera] T
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

