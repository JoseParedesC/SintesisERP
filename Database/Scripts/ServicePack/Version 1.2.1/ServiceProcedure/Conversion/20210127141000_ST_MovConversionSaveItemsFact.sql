--liquibase formatted sql
--changeset ,CZULBARAN:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovConversionSaveItemsFact]') and OBJECTPROPERTY(id, N'IsProcedure') = 1) 
DROP PROCEDURE dbo.ST_MovConversionSaveItemsFact
GO
CREATE  PROCEDURE [dbo].[ST_MovConversionSaveItemsFact]
	@factura	    VARCHAR(255),
    @xml			xml,
    @id_user		[INT]

AS
/***************************************
*Nombre:		[dbo].[ST_MovConversionSaveItemsFact]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		27/01/2021
*Desarrollador: (CZULBARAN)
***************************************/
DECLARE @error VARCHAR(MAX), @id int,@manejador int, @id_articulo bigint
DECLARE @tableserie table (id int identity (1,1),serie varchar(255), id_articulo BIGINT)
DECLARE @newtable table (id int identity (1,1),serie varchar(255), factura VARCHAR(255))
BEGIN TRAN
BEGIN TRY
			
			EXEC sp_xml_preparedocument @manejador OUTPUT, @xml;
			
			INSERT INTO @tableserie (serie, id_articulo)
			SELECT C.item, id
			FROM OPENXML(@manejador, N'root/item') 
			WITH (
			value		VARCHAR(255)        '@value',
			id			BIGINT				'@id'
			) AS P			
		    CROSS APPLY [dbo].[ST_FnTextToTable] (P.value,',') C

			EXEC sp_xml_removedocument @manejador;	

			DELETE ST FROM MovFacturaSeriesTemp ST INNER JOIN @tableserie T ON ST.id_itemstemp = T.id_articulo
			
			INSERT INTO MovFacturaSeriesTemp (id_itemstemp,id_facturatemp,serie) 
			SELECT N.id_articulo,
			@factura,
			N.serie
			FROM @tableserie N

COMMIT TRAN;
END TRY
BEGIN CATCH
		ROLLBACK TRAN;
	    --Getting the error description
	    SELECT @error   = ERROR_MESSAGE()
	    -- save the error in a Log file
	    RAISERROR(@error,16,1);
	    RETURN  
END CATCH