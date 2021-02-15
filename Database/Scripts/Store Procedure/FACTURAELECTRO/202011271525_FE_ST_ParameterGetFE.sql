--liquibase formatted sql
--changeset ,JTOUS:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FE].[ST_ParameterGetFE]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	DROP PROCEDURE [FE].[ST_ParameterGetFE]
GO
CREATE PROCEDURE [FE].[ST_ParameterGetFE] 
	@id_user [INT],
	@key varchar(250),
	@op CHAR(1) = 'I',
	@fecha	BIT = 0,
	@fechaini [VARCHAR] (10) = '',
	@fechafin [VARCHAR] (10) = ''
WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[ST_ParameterGetFE]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		17/06/19
*Desarrollador: (JTOUS)
***************************************/
------------------------------------------------------------------------------
-- Declaring variables Page_Nav
------------------------------------------------------------------------------
Declare @ds_error		VARCHAR(MAX), 
		@rutaE			VARCHAR(MAX), 
		@rutaSEND		VARCHAR(MAX), 
		@rutaSEARCH		VARCHAR(MAX),
		@userMAIL		VARCHAR(MAX), 
		@serverMAIL		VARCHAR(MAX), 
		@passMAIL		VARCHAR(MAX), 
		@sslMAIL		BIT, 
		@portMAIL		INT,
		@xmlempresa		VARCHAR(max),
		@id_return		INT,
		@tipiamb		INT = 0;
	
BEGIN TRY
BEGIN TRANSACTION

	SELECT TOP 1 
				@serverMAIL = servermail, 
				@userMAIL	= usermail, 
				@passMAIL	= passmail, 
				@portMAIL	= portmail, 
				@sslMAIL	= sslmail
	FROM Dbo.aspnet_MailConfig

	SET @rutaE		= dbo.ST_FnGetValueParam('FILEFACTURE');	
	SELECT TOP 1 @tipiamb = tipoambiente FROM Empresas

	SET @xmlempresa = (
	SELECT TOP 1 codiden tipoid, nit nit, digverificacion digveri, RazonSocial razon, codciudad, ciudad, coddepartamento, departamento, 
	direccion, RazonSocial +' - '+ nit regname, tipoambiente tipoamb, softid, email, telefono, nombrecomercial
	FROM [dbo].VW_Empresas Empresa
	FOR XML AUTO, ELEMENTS)

	Select TOP 1  
		E.id									id,
		nit										nit	,
		tipoambiente							,
		folder									[folderEM],
		@rutaE +folder+'\XmlDian\'				[rutaSF],
		@rutaE +folder+'\Firmados\'				[rutaF],
		@rutaE +folder+'\'+certificatename		[rutaCERT],
		passcertificate							[passCERT],
		'FacturacionElectronica.xslt'			[nameXSLFE],
		'FacturacionnNoteCredito.xslt'			[nameXSLNC],
		'TempateEmailFE.xslt'					[nameXSLCE],				
		@serverMAIL								[serverMAIL], 
		@userMAIL								[userMAIL], 
		@passMAIL								[passMAIL], 
		@portMAIL								[portMAIL], 
		@sslMAIL								[sslMAIL],
		'Notificación de Factura'				[subjetMAIL],
		'Facturación Electronica'				[titleMAIL],
		@xmlempresa								[XMLEMPRESA],
		softid + softpin						[softcodesecu],
		testid									,
		softid									,
		clavetec								,
		softpin									softpin,
		@id_return								id_historial
	From  dbo.VW_Empresas E
	
	IF (ISNULL(@fecha, 0) = 0)
	BEGIN
		IF(@op = 'F')
		BEGIN
			SELECT
				D.id, 
				D.consecutivo, 
				D.prefijo, 
				D.prefijo + CAST(D.consecutivo AS VARCHAR) precon,
				CONVERT(VARCHAR(19), D.fechafac, 126) fechafac, 
				CONVERT(VARCHAR(10), D.fechavence, 120) fechavencimiento,
				1 tipodocumento
				,K.tecnicakey clavetec
				,D.keyid [key]
				,'FACTURA' origen
			FROM  MOVFactura D
			INNER JOIN [DocumentosTecnicaKey] K ON K.id =  D.id_resolucion
			WHERE keyid = @key

			UPDATE MOVFactura 
			SET estadoFE = [dbo].[ST_FnGetIdList] ('PREPARE') 
			WHERE keyid = @key
		END

		ELSE IF(@op = 'D')
		BEGIN
			SELECT
				D.id, 
				D.id consecutivo, 
				'DV' prefijo, 
				'DV' + CAST(D.preconfac AS VARCHAR) precon,
				CONVERT(VARCHAR(19), D.fecha, 126) fechafac, 
				CONVERT(VARCHAR(10), DATEADD(month, 1, REPLACE(D.fecha,'-','')), 120) fechavencimiento,
				3 tipodocumento
				,'' clavetec
				,D.keyid [key]
				,'DEVOLUCION' origen
			FROM  VW_MOVDevFacturas D
			WHERE keyid = @key

			UPDATE MOVDevFactura 
			SET estadoFE = [dbo].[ST_FnGetIdList] ('PREPARE') 
			WHERE keyid = @key
		END
	END
	ELSE
	BEGIN
		SELECT   consecutivo id
				,consecutivo	
				,prefijo	
				,factura			precon
				,fecha				fechafac
				,fechavencimiento
				,tipoDocumento	
				,clavetec	
				,keyid				[key]
				,origen
		FROM [FE].[VW_DocumentosFacturados]
		WHERE estadoFE = [dbo].[ST_FnGetIdList] ('PREVIA') AND fecha BETWEEN @fechaini AND @fechafin
	END
COMMIT TRANSACTION;
END TRY
BEGIN CATCH	
	ROLLBACK TRANSACTION;
	--Getting the error description
	Set @ds_error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	-- save the error in a Log file
	RaisError(@ds_error,16,1)
	return
END CATCH
