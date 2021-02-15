--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_FnConsecutivoFactura]') and OBJECTPROPERTY(id, N'IsTableFunction') = 1)
DROP FUNCTION [dbo].[ST_FnConsecutivoFactura]
GO

CREATE FUNCTION [dbo].[ST_FnConsecutivoFactura](
	@id_centrocosto int,
	@isfe			bit
)
RETURNS @Tbl TABLE (Id Int Identity (1,1), id_resolucion BIGINT, prefijo varchar(20), consecutivo int, resolucion VARCHAR(50)) 
AS 
BEGIN
	DECLARE @Consecutivo INT, @prefijo varchar(20), @resolucion VARCHAR(50), @id_resolucion BIGINT;

	SELECT TOP 1 @id_resolucion = R.id, @Consecutivo = (R.consecutivo + 1), @prefijo = R.prefijo, @resolucion = R.resolucion
	FROM Dbo.DocumentosTecnicaKey R 
	WHERE R.id_ccosto = @id_centrocosto AND R.isfe = @isfe AND estado != 0;
	
    Insert Into @Tbl (id_resolucion, prefijo, consecutivo, resolucion)
	Values(@id_resolucion, @prefijo, @Consecutivo, @resolucion);	
	
	RETURN
END;

GO


