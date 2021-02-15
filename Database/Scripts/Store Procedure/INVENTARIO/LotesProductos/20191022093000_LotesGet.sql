--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[LotesGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE Dbo.LotesGet
GO


CREATE PROCEDURE [dbo].[LotesGet]
	@id [int] = null,
	@id_user [int]
--WITH ENCRYPTION
AS
BEGIN
/***************************************
*Nombre:		[dbo].[LotesGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		08/04/17
*Desarrollador: (JTOUS)
***************************************/
	Declare @ds_error varchar(max)
	
	Begin Try
		Select id, lote, CONVERT(VARCHAR(10),T.vencimiento_lote, 120) vencimiento_lote
		From  dbo.LotesProducto T
		Where T.id = @id;
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


