--liquibase formatted sql
--changeset ,jtous:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[ST_EmpresasSaveRange]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure dbo.ST_EmpresasSaveRange
GO
CREATE PROCEDURE dbo.ST_EmpresasSaveRange
@xml			XML,
@id_user		BIGINT

--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_EmpresasSaveRange]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		14/01/19
*Desarrollador: (JTOUS)
***************************************/

Declare @manejador int, @id_return INT, @error VARCHAR(MAX);
Declare @table TABLE (id int identity(1,1), prefijo varchar(20), resolucion varchar(50), tecnikey varchar(100), rangoini int, rangofin int, feci varchar(10), fecf varchar(10));
BEGIN TRANSACTION
BEGIN TRY

	EXEC sp_xml_preparedocument @manejador OUTPUT, @xml; 	

	INSERT INTO @table (prefijo, resolucion, tecnikey, rangoini, rangofin, feci, fecf)
	SELECT pre, res, [key], ini, fin, feci, fecf
	FROM OPENXML(@manejador, N'items/item') 
	WITH (  
			pre [varchar](20) 'pre',
			res [varchar](50) 'res',
			[key] [VARCHAR] (100) 'key',
			ini [INT] 'ini',
			fin [INT] 'fin',
			feci [VARCHAR](10) 'feci',
			fecf [VARCHAR](10) 'fecf'
		) AS P
			
	EXEC sp_xml_removedocument @manejador;

	UPDATE D SET D.fechaini = T.feci, D.fechafin = T.fecf, D.tecnicakey = T.tecnikey
	FROM [DocumentosTecnicaKey] D INNER JOIN 
	@table T ON D.prefijo = T.prefijo AND D.resolucion = T.resolucion	
	

	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);		
	ROLLBACK TRANSACTION;
END CATCH