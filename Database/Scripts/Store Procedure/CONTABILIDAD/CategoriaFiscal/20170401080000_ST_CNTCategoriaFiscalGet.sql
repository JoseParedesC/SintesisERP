--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_CNTCategoriaFiscalGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_CNTCategoriaFiscalGet]
GO
CREATE PROCEDURE [dbo].[ST_CNTCategoriaFiscalGet]
	@id [int] = null,
	@id_user [int]
--WITH ENCRYPTION
AS
BEGIN
/***************************************
*Nombre:		[dbo].[ST_CNTCategoriaFiscalGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		01/04/17
*Desarrollador: (JTOUS)
***************************************/
	Declare @ds_error varchar(max)
	
	Begin Try
		Select id, codigo, descripcion, retiene,
		id_retefuente, id_reteica, id_reteiva, fuentebase, icabase, ivabase
		From  Dbo.VW_CNTCategoriaFiscal
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
