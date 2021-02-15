--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[CajasGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE Dbo.CajasGet
GO
CREATE PROCEDURE dbo.CajasGet
	@id [int] = null,
	@id_user [int]
AS
BEGIN
/***************************************
*Nombre:		[dbo].[CajasGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		19/12/19
*Desarrollador: (JETEHERAN)
***************************************/
	Declare @ds_error varchar(max)
	
	Begin Try
			Select A.id, A.codigo, A.nombre, A.id_bodega, A.id_cliente, A.cuentacodant, A.id_ctaant,A.id_centrocosto, 
		A.id_cuenta, A.cuentacod, A.cabecera, A.piecera, A.cliente, A.id_vendedor, A.vendedor,A.centrocosto
		From  dbo.VW_Cajas A
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