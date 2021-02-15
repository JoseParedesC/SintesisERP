--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_Rpt_CabeceraCompania]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_Rpt_CabeceraCompania]
GO

CREATE PROCEDURE [Dbo].[ST_Rpt_CabeceraCompania] 
@id_caja int = 0,
@id_user int = 1,
@cufe VARCHAR(500) = '' 
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_Rpt_CabeceraCompania]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		21/08/2015
*Desarrollador:  Jose Luis Tous P�rez (jtous)
*Descripcion:	Se realizan la consulta de la informacion del reporte de factura de pago caja tirilla
***************************************/
BEGIN
Declare @error varchar(max)
BEGIN TRY		
SET LANGUAGE Spanish
DECLARE @usuario varchar(200);
		
		SET @usuario =  (SELECT TOP 1 nombre FROM Dbo.VW_Usuarios WHERE id = 1);
		
		SELECT TOP 1 @usuario usuario, razonsocial nombre, Nit+'-'+ digverificacion nit, ciudad +' - '+departamento ciudad, 
		telefono, direccion, urlimgrpt urlimg, email, urlfirma, Nit nitfe
		FROM VW_Empresas;

END TRY
BEGIN Catch
	--Getting the error description
	Select @error   =  ERROR_PROCEDURE() + 
				';  ' + convert(varchar,ERROR_LINE()) + 
				'; ' + ERROR_MESSAGE()
	-- save the error in a Log file
	RaisError(@error,16,1)
	Return  
End Catch
END
GO
