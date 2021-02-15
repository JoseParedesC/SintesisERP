--liquibase formatted sql
--changeset ,jteheran:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovFacturaRecalcular]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MovFacturaRecalcular]
GO
CREATE PROCEDURE [dbo].[ST_MovFacturaRecalcular]
	@idToken	  [VARCHAR] (255),	
	@id_cliente   [NUMERIC] (18,2) = 0,
	@anticipo	  [NUMERIC] (18,2) = 0,
	@id_ctaant	  [BIGINT],
	@op			  [CHAR] (1),
	@fecha		  [VARCHAR] (10),
	@descuentofin	  [NUMERIC](18,2)								
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_MovFacturaRecDescuento]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		09/05/2017
*Desarrollador: (JTOUS)
***************************************/
DECLARE @error VARCHAR(MAX), @valoranticipo NUMERIC(18, 2) = 0, @anomes VARCHAR(6);
BEGIN TRY
BEGIN TRAN

	SET @anomes = REPLACE(@fecha, '-', '');
	
	IF(@op = 'C')
	BEGIN
		SELECT TOP 1 @valoranticipo = ABS(saldoactual) FROM CNt.SaldoTercero 
		WHERE id_tercero = @id_cliente AND anomes = @anomes AND id_cuenta = @id_ctaant AND saldoactual < 0
	END
	ELSE
	BEGIN
		SET @valoranticipo = @anticipo;
	END

	
	SELECT 
		@valoranticipo anticipo, R.precio Tprecio, R.iva Tiva,isnull(R.inc,0) Tinc ,R.descuentoart Tdctoart, R.total-@descuentofin Ttotal, R.descuentoart Tdesc
	FROM Dbo.ST_FnCalTotalFactura(@idToken, @valoranticipo) R
	

COMMIT TRAN;
END TRY
BEGIN CATCH
		ROLLBACK TRAN;
	    --Getting the error description
	    SELECT @error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	    -- save the error in a Log file
	    RAISERROR(@error,16,1);
	    RETURN  
END CATCH

GO


