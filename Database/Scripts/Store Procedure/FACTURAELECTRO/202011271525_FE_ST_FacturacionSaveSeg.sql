--liquibase formatted sql
--changeset ,JTOUS:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FE].[ST_FacturacionSaveSeg]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	DROP PROCEDURE [FE].[ST_FacturacionSaveSeg]
GO
CREATE PROCEDURE [FE].[ST_FacturacionSaveSeg]
@xml XML,
@id_user INT,
@systemerror VARCHAR(MAX)

--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_FacturacionSaveSeg]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		11/09/2019
*Desarrollador:  Jose Luis Tous Pérez (jtous)
*Descripcion:	Se realizan EL PROCESO DE FACTURAR LAS ENTRADAS
***************************************/
Declare @id_return INT, @manejador int, @mensaje VARCHAR(MAX);
Declare @table TABLE (id int identity(1,1), [key] VARCHAR(255), tipodoc INT, error bit, code varchar(50), codename varchar(20), messagestatus varchar(max), xmlresponse varchar(max), cufe varchar(250), fechaautorizacion varchar(17), response bit);
BEGIN TRY
BEGIN TRANSACTION

	EXEC sp_xml_preparedocument @manejador OUTPUT, @xml; 	

	INSERT INTO @table ([key], tipodoc, error, code, codename, messagestatus, xmlresponse, cufe, fechaautorizacion, response)
	SELECT [key], tipodoc, error, code, codename, messagestatus, xmlresponse, cufe, fechaaut, response
	FROM OPENXML(@manejador, N'items/item') 
	WITH (  
			[key] [VARCHAR] (255) 'key',
			tipodoc [INT] 'tipodoc',
			error [bit] 'consulta/error',
			code [VARCHAR] (10) 'consulta/code',
			codename [VARCHAR] (10) 'consulta/codename',
			messagestatus [VARCHAR](MAX) 'consulta/messagestatus',
			xmlresponse [VARCHAR](MAX) 'consulta/xmlresponse',
			cufe [VARCHAR](250) 'cufe',
			fechaaut [VARCHAR](17) 'fechaaut',
			response [BIT] 'consulta/response'
		) AS P
	
	EXEC sp_xml_removedocument @manejador;

	INSERT INTO [FE].[DocumentosSeguimiento] ([key], tipodocumento, fechaseguimiento, respuesta, estado, error, coderespuesta)
	SELECT [key], tipodoc, GETDATE(), ISNULL(messagestatus, 'Proceso ejecutado exitoso') respuesta, [dbo].[ST_FnGetIdList](code) estado, error, codename
	FROM @table

	UPDATE DS 
		SET DS.estadoFE			 = [dbo].[ST_FnGetIdList](T.code), 
			DS.fechaautorizacion = CASE WHEN T.response != 0 
										THEN T.fechaautorizacion 
										ELSE NULL END
	FROM [dbo].Movfactura DS INNER JOIN @table T ON T.[key] = DS.[keyid] AND T.tipodoc = 1

	UPDATE DS 
		SET DS.estadoFE			 = [dbo].[ST_FnGetIdList](T.code),
			DS.fechaautorizacion = CASE WHEN T.response != 0 
										THEN T.fechaautorizacion 
										ELSE NULL END
	FROM [dbo].MovDevfactura DS INNER JOIN @table T ON T.[key] = DS.[keyid] AND T.tipodoc = 3
	
COMMIT TRANSACTION;
END TRY
BEGIN CATCH	
	ROLLBACK TRANSACTION;
	SET @mensaje = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@Mensaje,16,0);	
END CATCH
