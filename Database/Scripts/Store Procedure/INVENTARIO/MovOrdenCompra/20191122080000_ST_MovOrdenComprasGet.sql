﻿--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovOrdenComprasGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MovOrdenComprasGet]
GO

CREATE PROCEDURE [dbo].[ST_MovOrdenComprasGet] 
	@id [int]
--WITH ENCRYPTION
AS
BEGIN
/***************************************
*Nombre:		[dbo].[ST_MovOrdenComprasGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		22/11/19
*Desarrollador: (Jeteme)
***************************************/
	------------------------------------------------------------------------------
	-- Declaring variables Page_Nav
	------------------------------------------------------------------------------
	Declare @ds_error varchar(max), @id_entra int
	
	Begin Try
		SET @id_entra = (SELECT Top 1 CASE WHEN Dbo.ST_FnGetIdList('REVON') = estado THEN id_reversion ELSE id END FROM Dbo.MovOrdenCompras T Where T.id = @id);
		
		Select 
			id, 
			id_tipodoc,
			centrocosto,
			id_cencostos,
			fechadocumen,
			estado,
			id_proveedor,
			proveedor,
			bodega,
			nombrebodega,
			costo Tcosto
		From 
			Dbo.VW_MOVOrdenCompras M
		Where 
			id = @id;
		
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


