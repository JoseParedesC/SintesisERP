--liquibase formatted sql
--changeset ,jtous:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FE].[ST_FacturacionSendMail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	DROP PROCEDURE [FE].[ST_FacturacionSendMail]
GO
CREATE PROCEDURE [FE].[ST_FacturacionSendMail]
@key		VARCHAR(255),
@email		VARCHAR(200),
@tipodoc	INT,
@id_user	BIGINT
AS
/***************************************
*Nombre:		[Dbo].[ST_FacturacionListMail]
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
Declare @id_seguimiento int;
BEGIN TRY
	DECLARE @id_empresa INT = (SELECT TOP 1 id FROM VW_Empresas);

	INSERT INTO [FE].[DocumentosSeguimientoEmails](keyid, tipodocumento, email, estado, id_user, mensaje, activo)
	VALUES (@key, @tipodoc, @email, Dbo.ST_FnGetIdList('PREVIA'), @id_user, '', 1)

	SET @id_seguimiento = SCOPE_IDENTITY();

	SET @rutaE	= dbo.ST_FnGetValueParam('FILEFACTURE');

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
			INNER JOIN [FE].[VW_FacturaFE] VFE ON VFE.TipoDocumento = E.tipodocumento AND VFE.keyid = E.keyid
			INNER JOIN VW_Empresas M ON M.id = @id_empresa	
			WHERE E.id = @id_seguimiento AND E.email LIKE '%_@_%_.__%' AND E.estado = Dbo.ST_FnGetIdList('PREVIA') AND activo = 1

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
