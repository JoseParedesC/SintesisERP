--liquibase formatted sql
--changeset ,apuello:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id =
OBJECT_ID(N'[CNT].[MOVConciliacionGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[MOVConciliacionGet]
GO
CREATE PROCEDURE [CNT].[MOVConciliacionGet]
/***************************************
*Nombre: [dbo].[CategoriasProductosList]
----------------------------------------
*Tipo: Procedimiento almacenado
*creación: 23/12/20
*Desarrollador: APUELLO
*Descripcion: Obtiene el consecutivo de un movimiento en base a su id
***************************************/	
	@id_user BIGINT,
	@id_conciliado BIGINT

AS
BEGIN
	Declare @ds_error varchar(max)
	BEGIN TRY
	SELECT
		id
	FROM [CNT].[MOVConciliados]
	WHERE id = @id_conciliado
	END TRY
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
