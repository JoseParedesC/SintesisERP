--liquibase formatted sql
--changeset ,kmartinez:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FIN].[ServicioLineaCreditoGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [FIN].[ServicioLineaCreditoGet]
GO

CREATE PROCEDURE [FIN].[ServicioLineaCreditoGet]
	@id [int] = null,
	@id_user [int]
 
AS
BEGIN
/***************************************
*Nombre:		[FIN].[ServicioLineaCreditoGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		20/10/2020
*Desarrollador: (Kmartinez)
*Descripcion: Este Store proc sirve para listra un registro para poder realizar una modificacion 
***************************************/
	Declare @ds_error varchar(max)
	
	Begin Try
		Select  id, id_financiero, Servicios, id_lineascredito, porcentaje From [FIN].[VW_Serviciolineacredito]
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