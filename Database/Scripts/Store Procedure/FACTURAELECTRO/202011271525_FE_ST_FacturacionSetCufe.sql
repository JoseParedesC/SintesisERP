--liquibase formatted sql
--changeset ,JTOUS:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FE].[ST_FacturacionSetCufe]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	DROP PROCEDURE [FE].[ST_FacturacionSetCufe]
GO
CREATE PROCEDURE [FE].[ST_FacturacionSetCufe]
@xml xml,
@tipoambiente INT = 0
AS

/***************************************
*Nombre:		[Dbo].[ST_FacturacionSetCufe]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		28/11/20
*Desarrollador: (JTOUS)
***************************************/

declare @manejador int, @id_return INT = 0, @error VARCHAR(MAX);
declare @table TABLE (id int identity (1,1), [key] varchar(250), tipodocumento int, cufe varchar(200), correo varchar(max));

BEGIN TRANSACTION
BEGIN TRY
	
	EXEC sp_xml_preparedocument @manejador OUTPUT, @xml;

	INSERT INTO @table ([key], tipodocumento, cufe, correo)
	SELECT [key], tipodocumento, cufe, correo
	FROM OPENXML(@manejador, N'items/item') 
	WITH (  
			[key] [varchar](250) 'key',
			tipodocumento [int] 'tipodocumento',
			[cufe] [VARCHAR](200) 'cufe', 
			[correo] [VARCHAR](max) 'correo'
		) AS P

	EXEC sp_xml_removedocument @manejador;
	
	SET @id_return = SCOPE_IDENTITY();
	
	IF (@tipoambiente = 1)
	BEGIN
		UPDATE D SET activo = 0 FROM [DocumentosSeguimientoEmails] D 
		INNER JOIN @table T ON T.[key] = D.keyid AND D.tipodocumento = T.tipodocumento
		 
		INSERT INTO [FE].[DocumentosSeguimientoEmails] (keyid, tipodocumento, email, estado, activo)
		SELECT [key], tipodocumento, correo, CASE WHEN correo = '' or correo NOT LIKE '%_@_%_.__%' THEN dbo.ST_FnGetIdList('NOSEND') ELSE dbo.ST_FnGetIdList('PREVIA') END, 1 activo
		FROM @table;
		
	END

	UPDATE F SET F.cufe = T.cufe FROM MovFactura F INNER JOIN @table T ON T.[key] = F.keyid AND T.tipodocumento = 1

	UPDATE F SET F.cufe = T.cufe FROM MovDevFactura F INNER JOIN @table T ON T.[key] = F.keyid AND T.tipodocumento = 3

COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);		
	ROLLBACK TRANSACTION;
END CATCH

SELECT @id_return;