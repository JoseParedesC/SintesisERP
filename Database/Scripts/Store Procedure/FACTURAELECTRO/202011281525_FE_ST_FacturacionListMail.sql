--liquibase formatted sql
--changeset ,jtous:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FE].[ST_FacturacionListMail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	DROP PROCEDURE [FE].[ST_FacturacionListMail]
GO
CREATE PROCEDURE [FE].[ST_FacturacionListMail]
@id_documento INT = 0,
@op CHAR(1) = 'G',
@xml XML = ''
AS
/***************************************
*Nombre:		[FE].[ST_FacturacionListMail]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		02/10/19
*Desarrollador: (JTOUS)
***************************************/
DECLARE @error VARCHAR(MAX), 
		@rutaE			VARCHAR(MAX), 
		@rutaSEND		VARCHAR(MAX), 
		@rutaSEARCH		VARCHAR(MAX),
		@userMAIL		VARCHAR(MAX),  
		@useriTtleMAIL	VARCHAR(MAX), 
		@serverMAIL		VARCHAR(MAX), 
		@passMAIL		VARCHAR(MAX), 
		@sslMAIL		BIT, 
		@portMAIL		INT,
		@xmlempresa		VARCHAR(max),
		@id_return		INT,
		@manejador		INT;	
Declare @table TABLE (id int identity(1,1), keyid VARCHAR(255), tipodoc INT);
BEGIN TRY
	DECLARE @id_empresa INT = (SELECT TOP 1 id FROM VW_Empresas);

	SET @rutaE		= dbo.ST_FnGetValueParam('FILEFACTURE');

	SELECT TOP 1 
				@serverMAIL = servermail, 
				@userMAIL	= usermail, 
				@useriTtleMAIL = usertitlemail,
				@passMAIL	= passmail, 
				@portMAIL	= portmail, 
				@sslMAIL	= sslmail
	FROM Dbo.aspnet_MailConfig

	Select  
				@rutaE									[ruta],
				'TempateEmailFE.xslt'					[nameXSLCE],
				@serverMAIL								[serverMAIL], 
				@userMAIL								[userMAIL], 
				@useriTtleMAIL							[userTitleMAIL],
				@passMAIL								[passMAIL], 
				@portMAIL								[portMAIL], 
				@sslMAIL								[sslMAIL],
				'Notificación de Factura'				[subjetMAIL],
				'Facturación Electronica'				[titleMAIL]

	IF (@op = 'I')
	BEGIN
		EXEC sp_xml_preparedocument @manejador OUTPUT, @xml; 	

		INSERT INTO @table ([keyid], tipodoc)
		SELECT [key], tipodoc	
		FROM OPENXML(@manejador, N'items/item') 
		WITH ( [key] [VARCHAR](255) 'key',
				tipodoc [INT] 'tipodoc'
		 ) AS P	

		EXEC sp_xml_removedocument @manejador;		
		
		SELECT DISTINCT
					E.id, 
					VFE.keyid [key],
					VFE.tipodocumento,
					M.folder, 
					M.urlimgrpt, 
					E.email correo, 
					CASE 
						 WHEN VFE.tipodocumento = 1 THEN 'FacturaElectronicaInt.frx' 
						 WHEN VFE.tipodocumento = 3 THEN 'CreditoElectronicaInt.frx' 
						 ELSE '' END frxrpt,
					VFE.cufe,	
					M.urlimgrpt urlimg,				
					M.urlfirma,
					VFE.tipodocumento tipodoc,
					M.nit+';'+M.razonsocial+';'+VFE.prefijo+CAST(VFE.consecutivofacturacion AS VARCHAR)+';'+CASE WHEN VFE.tipodocumento = 1 THEN '01'
															WHEN VFE.tipodocumento = 3 THEN '91'
															WHEN VFE.tipodocumento = 2 THEN '92' END+';'+M.razonsocial+';' AS [subject],
					CASE WHEN VFE.tipodocumento = 1 THEN 'fv'
						WHEN VFE.tipodocumento = 3 THEN 'nc'
						WHEN VFE.tipodocumento = 2 THEN 'nd' END +VFE.prefijo+CAST(VFE.consecutivofacturacion AS VARCHAR) + RIGHT('0' + Ltrim(Rtrim(M.nit)),10) + '000'+CONVERT(VARCHAR(2), VFE.fechafac, 2) AS namepdf,
				'ad'+VFE.prefijo+CAST(VFE.consecutivofacturacion AS VARCHAR) + RIGHT('0' + Ltrim(Rtrim(M.nit)),10) + '000'+CONVERT(VARCHAR(2), VFE.fechafac, 2) namexml
			FROM FE.DocumentosSeguimientoEmails E 
			INNER JOIN @table T ON T.tipodoc = E.tipodocumento AND T.keyid = E.keyid
			INNER JOIN [FE].[VW_FacturaFE] VFE ON VFE.TipoDocumento = T.tipodoc AND VFE.keyid = T.keyid
			INNER JOIN VW_Empresas M ON M.id = @id_empresa	
			WHERE E.email LIKE '%_@_%_.__%' AND E.estado = Dbo.ST_FnGetIdList('PREVIA') AND activo = 1
	END

END TRY
BEGIN CATCH

	    --Getting the error description
	    Select @error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	    -- save the error in a Log file
	    RaisError(@error,16,1)
	    Return  
End Catch
