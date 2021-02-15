--liquibase formatted sql
--changeset ,kmartinez:4 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovFacturaRecCuotas]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MovFacturaRecCuotas]
GO

CREATE PROCEDURE [dbo].[ST_MovFacturaRecCuotas]
	@id	           varchar(2) = null,
	@SelectCredito BIGINT = null,
	@idToken	  [VARCHAR] (255),	
	@valor		  [NUMERIC] (18, 2),
	@numcuotas	  [INT],
	@dias		  [INT],
	@venini		  [VARCHAR](10),
	@vencimiento  [INT],
	@opcion       int = null						 
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_MovFacturaRecCuotas]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		09/05/2017
*Desarrollador: (JTOUS)
***************************************/
DECLARE @error VARCHAR(MAX),  @total decimal(18,4), @valcuota decimal(18,4), @optven int;
DECLARE @tablecuo TABLE (id int identity(1,1), valor decimal(18,0), vencimiento varchar(10), saldo decimal(18,0));
BEGIN TRY
BEGIN TRAN
	
	
	IF(@opcion = [dbo].[ST_FnGetIdList]('FINAN') OR @id = 'F')
	BEGIN
		SELECT cuota id, valorcuota cuota, FechaInicio, vencimiento, saldo, interes,  Acapital, SaldoAnterior, porcentaje, @valor total_Acreditar 
		FROM [FIN].[ST_FnRecCuotasLineasCreditos](@SelectCredito, @idToken, @valor, @numcuotas, @vencimiento, @venini, @dias)
	END
	ELSE IF(@opcion = [dbo].[ST_FnGetIdList]('CREDI'))
	BEGIN
		SELECT id, valorcuota cuota, vencimiento, saldo, @valor total_Acreditar 
		FROM ST_FnMovFacturaRecCuotas (@idToken, @valor, @numcuotas, @vencimiento, @venini, @dias)
	END

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