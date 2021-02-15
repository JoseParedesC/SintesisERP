--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[TercerosGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE CNT.TercerosGet
GO
CREATE  PROCEDURE [CNT].[TercerosGet]
	@id [int] = null,
	@id_user [int]
--WITH ENCRYPTION
AS
BEGIN
/***************************************
*Nombre:		[CNT].[TercerosGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		04/11/19
*Desarrollador: (Jeteme)
***************************************/
	Declare @ds_error varchar(max)
	
	Begin Try
		Select TOP 1 T.id,
			   tipoiden,
			   nombretipoiden,
			   iden, 
			   digitoverificacion,
			   primernombre,
			   segundonombre,
			   primerapellido,
			   segundoapellido,
			   tercero, 
			   sucursal,
			   tiporegimen,
			   regimen,
			   nombrecomercial,
			   paginaweb,
			   CONVERT(VARCHAR(10), fechaexpedicion, 120) fechaexpedicion,
			   CONVERT(VARCHAR(10), fechanacimiento, 120) fechanacimiento,
			   direccion,
			   email,
			   telefono,
			   celular,
			   id_ciudad,
			   ciudad,
			   nombrescontacto,
			   telefonocontacto,
			   emailcontacto,
			   SUBSTRING(cnt.FnTipoTerceros(@id),0 ,len(cnt.FnTipoTerceros(@id)))  tipoterceros,
			   id_personeria,
			   personeria,
			   id_catfiscal
		From  CNT.VW_Terceros T LEFT JOIN CNT.TipoTerceros TT ON T.id=TT.id_tercero
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


