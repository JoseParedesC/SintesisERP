--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[ST_Rpt_VentasUsuario]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [Dbo].[ST_Rpt_VentasUsuario]
GO

CREATE PROCEDURE [Dbo].[ST_Rpt_VentasUsuario] 
@fechaini varchar(10),
@fechafin varchar(10),
@idusuario int
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_Rpt_VentasUsuario]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		21/08/2015
*Desarrollador:  Jose Luis Tous Pérez (jtous)
*Descripcion:	Se realizan la consulta de la informacion del reporte de factura de pago caja tirilla
***************************************/
BEGIN
Declare @error varchar(max)
BEGIN TRY		
SET LANGUAGE Spanish
	
	SELECT username, nomusuario, SUM(total) total, F.centrocosto caja
	FROM Dbo.VW_MOVFacturas F
	WHERE fechadoc
		BETWEEN @fechaini  AND @fechafin 
	AND estado='PROCESADO'  
	AND( Isnull(@idusuario,0) = 0 OR id_user = @idusuario)
	GROUP BY username, nomusuario, F.centrocosto
	
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