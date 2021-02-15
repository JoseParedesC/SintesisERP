--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovEntradaCalcularFlete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MovEntradaCalcularFlete]
GO
CREATE  PROCEDURE [dbo].[ST_MovEntradaCalcularFlete]
	@id_entrada  INT,
	@flete		 NUMERIC(18,2), 
	@tipoprorrat CHAR(1)
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[ST_MovEntradaCalcularFlete]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		25/03/17
*Desarrollador: (JTOUS)
***************************************/
DECLARE @error VARCHAR(MAX);
BEGIN TRY
	DECLARE  @total numeric(18,2) = 
	(Select Sum(CASE WHEN @tipoprorrat = 'V' THEN costo * cantidad
				WHEN @tipoprorrat = 'C' THEN cantidad END ) 
	FROM Dbo.MOVEntradasItemsTemp Where id_entrada = @id_entrada AND inventarial != 0);
	IF(@total > 0)
	BEGIN
		IF(@tipoprorrat = 'V')
		BEGIN
			UPDATE Dbo.MOVEntradasItemsTemp 
				SET flete = ROUND(((((costo * cantidad) * 100 / @total) / 100) * @Flete),2)
			Where id_entrada = @id_entrada AND inventarial != 0
		END
		ELSE IF(@tipoprorrat = 'C')
		BEGIN
			UPDATE Dbo.MOVEntradasItemsTemp 
				SET flete = ROUND((((cantidad * 100 / @total) / 100) * @Flete),2)
			Where id_entrada = @id_entrada AND inventarial != 0
		END


		UPDATE MOVEntradasItemsTemp set fleteund = ROUND(flete / cantidad,2) WHERE id_entrada = @id_entrada;
	END
END TRY
BEGIN CATCH

	    --Getting the error description
	    Select @error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	    -- save the error in a Log file
	    RaisError(@error,16,1)
	    Return  
End Catch