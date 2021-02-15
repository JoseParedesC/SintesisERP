--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ImpuestosGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE CNT.ImpuestosGet
GO

CREATE PROCEDURE [CNT].[ImpuestosGet]
	@id [int] = null,
	@id_user [int]
--WITH ENCRYPTION
AS
BEGIN
/***************************************
*Nombre:		[CNT].[ImpuestosGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		22/10/19
*Desarrollador: (jeteme)
***************************************/
	Declare @ds_error varchar(max)
	
	Begin Try
		Select  id, [codigo], [nombre], [id_ctaventa],[id_ctadevVenta],[id_ctacompra],[id_ctadevCompra],[nomctaventa],[nomctadevVenta],[nomctacompra],[nomctadevcompra],[id_tipoimp],[nomtipoimpuesto],
				[id_usercreated], [id_userupdated], valor
		From  CNT.VW_Impuestos 
		Where id = @id;
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
