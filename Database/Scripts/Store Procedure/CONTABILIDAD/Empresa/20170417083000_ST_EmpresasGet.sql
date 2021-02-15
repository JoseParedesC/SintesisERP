--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_EmpresasGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_EmpresasGet]
GO

CREATE PROCEDURE [dbo].[ST_EmpresasGet]
	@id [int] = null
--WITH ENCRYPTION
AS
BEGIN
/***************************************
*Nombre:		[dbo].[ST_EmpresasGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		14/01/19
*Desarrollador: (JTOUS)
***************************************/
	------------------------------------------------------------------------------
	-- Declaring variables Page_Nav
	------------------------------------------------------------------------------
	Declare @ds_error varchar(max)
	Declare @urlfolder VARCHAR(MAX)

	SET @urlfolder = (SELECT TOP 1 valor FROM [dbo].[Parametros] WHERE codigo = 'FILEFACTURE')
	
	Begin Try
		Select TOP 1 id, razonsocial, nit, digverificacion, id_ciudad,  direccion, telefono, email, softid, softpin, softtecnikey, carpetaname, certificatename, passcertificate, testid, 
			   id_tipoid, tipoambiente, ISNULL(@urlfolder, '')  + carpetaname +'\' folder, nombrecomercial
		From  dbo.Empresas A		
		
	End Try
    Begin Catch
	--Getting the error description
	Set @ds_error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	-- save the error in a Log file
	RaisError(@ds_error,16,1)
	return
	End Catch
END
