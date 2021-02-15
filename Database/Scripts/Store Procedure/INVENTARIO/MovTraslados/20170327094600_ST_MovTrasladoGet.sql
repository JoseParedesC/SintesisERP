--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovTrasladoGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MovTrasladoGet]
GO

CREATE PROCEDURE [dbo].[ST_MovTrasladoGet]
	@id [int]
--WITH ENCRYPTION
AS
BEGIN
/***************************************
*Nombre:		[dbo].[ST_MovTrasladoGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		27/03/17
*Desarrollador: (JTOUS)
***************************************/
	------------------------------------------------------------------------------
	-- Declaring variables Page_Nav
	------------------------------------------------------------------------------
	Declare @ds_error varchar(max)
	
	Begin Try
		
		Select 
			T.id, 
			fecha,
			T.id_tipodoc,
			isnull(T.id_centrocosto,0) id_centrocosto,
			isnull(t.CentroCosto,'') centrocosto,			
			T.estado,
			T.descripcion,
			T.costototal	Ttotal,
			T.id_reversion
			
		From Dbo.[VW_MOVTraslados] T
		Where 
			T.id = @id;

		SELECT 
			A.id, A.codigo, A.presentacion, A.nombre, A.cantidad, A.costo, A.bodega, A.bodegades
		FROM 
			[dbo].VW_MOVTrasladosItems  A		
		WHERE 
			A.id_traslado = @id;

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


