--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[TiposDocumentosGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE CNT.TiposDocumentosGet
GO
CREATE PROCEDURE [CNT].[TiposDocumentosGet]
	@id [int] = null,
	@id_user [int]
--WITH ENCRYPTION
AS
BEGIN
/***************************************
*Nombre:		[CNT].[TiposDocumentosGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		22/10/19
*Desarrollador: (Jeteme)
***************************************/
	Declare @ds_error varchar(max)
	
	Begin Try
		Select  id, [codigo], [nombre],[isccosto],[id_centrocosto] ,[id_tipo],[centrocosto], [estado], [created], 
				[updated], [id_usercreated], [id_userupdated]
						From  CNT.VW_TipoDocumentos
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
GO