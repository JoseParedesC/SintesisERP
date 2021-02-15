--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_EmpresaSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_EmpresaSave]
GO

CREATE PROCEDURE [dbo].[ST_EmpresaSave]
@razon VARCHAR(200),
@nit VARCHAR(200),
@direccion VARCHAR(200),
@telefono VARCHAR(200),
@ciudad VARCHAR(200),
@admin VARCHAR(200),
@teladmin VARCHAR(200),
@mailadmin VARCHAR(200),
@urlimg VARCHAR(200),
@urlimgrpt VARCHAR(200),
@nombrecomercial VARCHAR(250) = '',
@id_user int
AS
/***************************************
*Nombre:		[Dbo].[ST_EmpresaSave]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		09/04/17
*Desarrollador: (JTOUS)
***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT )
BEGIN TRY
		
		
		UPDATE Parametros SET valor = @razon Where codigo = 'COMPANYNAME';
		UPDATE Parametros SET valor = @nit Where codigo = 'COMPANYNIT';
		UPDATE Parametros SET valor = @ciudad Where codigo = 'COMPANYCITY';
		UPDATE Parametros SET valor = @direccion Where codigo = 'COMPANYADDRESS';
		UPDATE Parametros SET valor = @telefono Where codigo = 'COMPANYTEL';
		UPDATE Parametros SET valor = @admin Where codigo = 'COMPANYADMIN';
		UPDATE Parametros SET valor = @teladmin Where codigo = 'COMPANYADMINTEL';
		UPDATE Parametros SET valor = @mailadmin Where codigo = 'COMPANYADMINMAIL';
		UPDATE Parametros SET valor = @urlimg Where codigo = 'COMPANYURLIMG';
		UPDATE Parametros SET valor = @urlimgrpt Where codigo = 'COMPANYIMGRPT';
		UPDATE Parametros SET valor = @nombrecomercial Where codigo = 'COMPANYNAMECOMER';
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
