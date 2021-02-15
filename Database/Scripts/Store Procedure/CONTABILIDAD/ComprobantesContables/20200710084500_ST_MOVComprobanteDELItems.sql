--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_MOVComprobanteDELItems]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_MOVComprobanteDELItems]
GO


CREATE PROCEDURE [CNT].[ST_MOVComprobanteDELItems]
    @id_item        [BIGINT],
	@id_comprobante	[BIGINT] 
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[CNT].[ST_MOVComprobanteDELItems]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		10/07/20
*Desarrollador: (Jeteme)
***************************************/
DECLARE @error VARCHAR(MAX), @id int;
BEGIN TRY
BEGIN TRAN

	DELETE [CNT].[MOVComprobantesItemsTemp] Where id = @id_item;

	SELECT 		
		R.Tdebito,R.Tcredito,R.diferencia
	FROM 
		CNT.ST_FnCalTotalComprobante(@id_comprobante,'T') R

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


