--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CRE].[ST_MovFacturaRecCuotas]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CRE].[ST_MovFacturaRecCuotas]
GO
CREATE PROCEDURE [CRE].[ST_MovFacturaRecCuotas]
	@idToken	  [VARCHAR] (255),	
	@valor		  [NUMERIC] (18, 2),
	@numcuotas	  [INT],
	@dias		  [INT] = 0,
	@venini		  [VARCHAR](10),
	@vencimiento  [INT] = NULL,
	@SelectCredito [BIGINT]

--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[CRE].[ST_MovFacturaRecCuotas]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		05/01/2021
*Desarrollador: (JPAREDES)
***************************************/
DECLARE @error VARCHAR(MAX), @id int, @total decimal(18,4), @valcuota decimal(18,4), @optven int;
DECLARE @tablecuo TABLE (id int identity(1,1), valor decimal(18,0), vencimiento varchar(10), saldo decimal(18,0));
BEGIN TRY
BEGIN TRAN
	
	SELECT cuota id, valorcuota cuota, FechaInicio, vencimiento, saldo, interes,  Acapital, SaldoAnterior, porcentaje, @valor total_Acreditar 
	FROM [FIN].[ST_FnRecCuotasLineasCreditos](@SelectCredito, @idToken, @valor, @numcuotas, @vencimiento, @venini, @dias)

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