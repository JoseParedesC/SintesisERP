--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[BodegasGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE Dbo.[BodegasGet]
GO
CREATE PROCEDURE [dbo].[BodegasGet]
	@id [int] = null,
	@id_user [int]
--WITH ENCRYPTION
AS
BEGIN
/***************************************
*Nombre:		[dbo].[BodegasGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		17/11/19
*Desarrollador: (JETEHERAN)
***************************************/
	Declare @ds_error varchar(max)
	
	Begin Try
		Select id, codigo, nombre, ctainven, ctacosto, ctadescuento, ctaingreso, ctaingresoexc,ctaivaflete, nomctainven,
		 nomctadescuento, nomctaingreso, nomctacosto, nomctaingexc, nomctaivaflete
		From  Dbo.VW_Bodegas A
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
