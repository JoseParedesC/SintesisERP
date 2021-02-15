--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MOVAjusteGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MOVAjusteGet]
GO
CREATE PROCEDURE [dbo].[ST_MOVAjusteGet]
	@id [int]
--WITH ENCRYPTION
AS
BEGIN
/***************************************
*Nombre:		[dbo].[ST_MOVAjusteGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		27/03/17
*Desarrollador: (JTOUS)
***************************************/
	------------------------------------------------------------------------------
	-- Declaring variables Page_Nav
	------------------------------------------------------------------------------
	Declare @ds_error varchar(max), @id_ajuste INT;
	
	Begin Try

		SET @id_ajuste = (SELECT Top 1 CASE WHEN Dbo.ST_FnGetIdList('REVON') = estado THEN id_reversion ELSE id END FROM Dbo.MOVAjustes T Where T.id = @id);
		
		Select 
			T.id, 
			fecha,
			T.id_tipodoc,
			isnull(T.id_centrocosto,0) id_centrocosto,
			isnull(t.centrocosto,'') centrocosto,			
			T.concepto,
			T.id_concepto,
			T.estado,
			T.detalle,
			T.costototal	Ttotal,
			T.id_reversion
		From Dbo.VW_MOVAjustes T		
		Where 
			T.id = @id;



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
