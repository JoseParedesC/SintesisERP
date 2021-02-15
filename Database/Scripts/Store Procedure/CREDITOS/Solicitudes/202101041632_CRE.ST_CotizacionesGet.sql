--liquibase formatted sql
--changeset ,jarciniegas:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id =
OBJECT_ID(N'[CRE].[ST_CotizacionesGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1) DROP PROCEDURE [CRE].[ST_CotizacionesGet]
GO
CREATE PROCEDURE [CRE].[ST_CotizacionesGet]
	@id [int] = 4,
	@id_user [int] = 12
 
AS
BEGIN
/***************************************
*Nombre:		[CRE].[ST_CotizacionesGet]
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

		SELECT C.id, (CONVERT(VARCHAR(10),C.id)+' - '+C.cliente) cotizacion, C.estado, T.iden
		FROM dbo.VW_MOVCotizaciones C 
		INNER JOIN CNT.Terceros T ON T.id = C.id_cliente
		WHERE C.id = @id;
		
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
