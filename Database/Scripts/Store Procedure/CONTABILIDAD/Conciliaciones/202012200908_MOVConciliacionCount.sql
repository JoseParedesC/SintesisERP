--liquibase formatted sql
--changeset ,apuello:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id =
OBJECT_ID(N'[CNT].[MOVConciliacionesCount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[MOVConciliacionesCount]
GO
CREATE PROCEDURE [CNT].[MOVConciliacionesCount]
/***************************************
*Nombre: [dbo].[CategoriasProductosList]
----------------------------------------
*Tipo: Procedimiento almacenado
*creación: 23/12/20
*Desarrollador: APUELLO
*Descripcion: Obtiene el total de transacciones conciliadas y no conciliadas
***************************************/
	@id_user BIGINT

AS
BEGIN
	Declare @ds_error varchar(max), @row_t BIGINT, @row_c BIGINT
	BEGIN TRY
		SET @row_c = (SELECT COUNT(I.id) FROM [CNT].[MOVConciliadosItems] I INNER JOIN [CNT].[MOVConciliados] C ON C.id = I.id_conciliado WHERE C.estado = [dbo].[ST_FnGetIdList]('PROCE'))
		SET @row_t = ((SELECT COUNT(id) FROM [CNT].[VW_Transacciones]) - @row_c)

		SELECT @row_t as porconciliar, @row_c as conciliados
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
