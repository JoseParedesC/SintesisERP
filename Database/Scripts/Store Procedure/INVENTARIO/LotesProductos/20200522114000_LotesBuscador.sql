--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[LotesBuscador]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE Dbo.LotesBuscador
GO
CREATE PROCEDURE [dbo].[LotesBuscador]
	@filtro [VARCHAR] (50),
	@opcion VARCHAR(2),
	@id BIGINT 
--WITH ENCRYPTION
AS
BEGIN
/***************************************
*Nombre:		[Dbo].[LotesBuscador]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		22/05/20
*Desarrollador: (JTOUS)
***************************************/
	
Declare @ds_error varchar(max)
DECLARE @id_articulo VARCHAR(50),@serie VARCHAR(50)
	
Begin Try
	IF(@opcion = 'ET')
	BEGIN
		SELECT Distinct A.id_lote id, CONVERT(VARCHAR(10), vencimientolote, 120) name
		FROM Dbo.MOVEntradasItemsTemp A
		WHERE (id_lote like '%'+@filtro+'%') AND id_entrada = @id;
	END
End Try
Begin Catch
	--Getting the error description
	Set @ds_error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	-- save the error in a Log file
	RaisError(@ds_error,16,1)

End Catch
END
