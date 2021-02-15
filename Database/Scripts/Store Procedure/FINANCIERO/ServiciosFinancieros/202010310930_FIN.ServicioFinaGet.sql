--liquibase formatted sql
--changeset ,kmartinez:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FIN].[ServicioFinaGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [FIN].[ServicioFinaGet]
GO

CREATE PROCEDURE [FIN].[ServicioFinaGet]
	@id BIGINT = null,
	@id_user [int]
--WITH ENCRYPTION
AS
BEGIN
/***************************************
*Nombre:		[FIN].[ServicioFinaGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		27/10/2020
*Desarrollador: (Kmartinez)
*Descripcion: Este SP tiene como funcionalidad listar por codigo un registro para poder modificarlo o eliminarlo  

***************************************/
	Declare @ds_error varchar(max)
	
	Begin Try
		Select  id, [codigo], [nombre], [id_cuenta], [cuenta] From [FIN].[VW_ServiciosFinanciero]
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