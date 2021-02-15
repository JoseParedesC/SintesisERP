--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[FormasPagosGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE Dbo.FormasPagosGet
GO

CREATE PROCEDURE dbo.FormasPagosGet
	@id [int] = null,
	@id_user [int]
--WITH ENCRYPTION
AS
BEGIN
/***************************************
*Nombre:		[dbo].[FormasPagosGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		27/11/19
*Desarrollador: (JETEHERAN)
***************************************/
	------------------------------------------------------------------------------
	-- Declaring variables Page_Nav
	------------------------------------------------------------------------------
	Declare @ds_error varchar(max)
	
	Begin Try
		Select A.id, A.nombre, A.codigo,A.id_tipo, A.nombretipo,A.id_cuenta, nombrecuenta,id_typeFE,nombetipoFE, voucher
		From  dbo.VW_FormaPago A
		Where A.id = @id;
		
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
