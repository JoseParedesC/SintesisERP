--liquibase formatted sql
--changeset ,kmartinez:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FIN].[LineasCreditoGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [FIN].[LineasCreditoGet]
GO

CREATE PROCEDURE [FIN].[LineasCreditoGet]
	@id [int] = null,
	@id_user [int]
--WITH ENCRYPTION
AS
BEGIN
/***************************************
*Nombre:		[CIN].[LineasCreditoGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		20/10/2020
*Desarrollador: (Kmartinez)
***************************************/
	Declare @ds_error varchar(max)
	
	Begin Try
		Select  id, codigo, nombre, id_ctacredito, CuentaCredito, id_ctaintcorriente, CuentaCorriente ,id_ctaiva, iva, ivaIncluido AS Incluido, porcenIva, id_ctamora,  CuentaFianza, Porcentaje, CuentaMora, Estado, created, 
				updated, id_user
						From  [FIN].[VW_LineasCredito]
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