--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[CentrosCostosGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE CNT.CentrosCostosGet
GO
CREATE PROCEDURE CNT.CentrosCostosGet
	@id [int] = null,
	@id_user [int]
--WITH ENCRYPTION
AS
BEGIN
/***************************************
*Nombre:		[CNT].[CentrosCostosGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		22/10/19
*Desarrollador: (Jeteme)
***************************************/
		Declare @ds_error varchar(max)
	Declare @id_ccosto BIGINT = 0;
	
	Begin Try
		SELECT @id_ccosto = C.idparent
		FROM  CNT.CentroCosto C
		where C.id =  @id

		Select id, subcodigo codigo, nombre, detalle tipo, ISNULL(idparent,0) id_padre
		From  CNT.[VW_CentroCosto] T
		Where T.id = @id;


		SELECT id, codigo,  nombre, nivel, id_padre 
		FROM Dbo.ST_FnNivelesCuentasCostos('O', @id_ccosto);
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
