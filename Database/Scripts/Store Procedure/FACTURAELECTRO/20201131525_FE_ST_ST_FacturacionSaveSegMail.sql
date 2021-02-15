--liquibase formatted sql
--changeset ,jtous:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FE].[ST_FacturacionSaveSegMail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	DROP PROCEDURE [FE].[ST_FacturacionSaveSegMail]
GO
CREATE PROCEDURE [FE].[ST_FacturacionSaveSegMail]
@xml XML

--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[FE].[ST_FacturacionSaveSegMail]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		30/11/2020
*Desarrollador:  Jose Luis Tous Pérez (jtous)
*Descripcion:	Se realizan EL PROCESO DE FACTURAR LAS ENTRADAS
***************************************/
Declare @id_return INT, @manejador int, @mensaje VARCHAR(MAX);
Declare @table TABLE (id int identity(1,1), [key] VARCHAR(255), tipodoc INT, error bit, code varchar(50), mensaje varchar(max));
BEGIN TRY
BEGIN TRANSACTION

	EXEC sp_xml_preparedocument @manejador OUTPUT, @xml; 	

	INSERT INTO @table ([key], tipodoc, error, code, mensaje)
	SELECT [key], tipodoc, error, code, mensaje
	FROM OPENXML(@manejador, N'items/item') 
	WITH (  
			[key] [VARCHAR](255) 'key',
			[tipodoc] [INT] 'tipodoc',
			error [bit] 'error',
			code [VARCHAR] (10) 'code',
			mensaje [VARCHAR](MAX) 'mensaje'
		) AS P
			
	EXEC sp_xml_removedocument @manejador;
	
	
	UPDATE DS SET DS.estado = [dbo].[ST_FnGetIdList](T.code), DS.mensaje = T.mensaje, DS.activo = 0
	FROM [FE].[DocumentosSeguimientoEmails] DS INNER JOIN @table T ON T.[key] = DS.keyid AND DS.tipodocumento = T.tipodoc	
	
COMMIT TRANSACTION;
END TRY
BEGIN CATCH	
	ROLLBACK TRANSACTION;
	SET @mensaje = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@Mensaje,16,0);	
END CATCH
