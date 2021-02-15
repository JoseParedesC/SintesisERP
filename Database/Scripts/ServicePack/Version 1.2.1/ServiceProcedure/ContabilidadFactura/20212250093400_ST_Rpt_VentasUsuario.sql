--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_Rpt_VentasUsuario]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_Rpt_VentasUsuario]
GO

CREATE PROCEDURE [dbo].[ST_Rpt_VentasUsuario] 
@fechaini varchar(10),
@fechafin varchar(10),
@idusuario int
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_Rpt_VentasUsuario]
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
	
	SELECT F.username, F.nomusuario, SUM(F.total) total, F.centrocosto caja
	FROM Dbo.VW_MOVFacturas F left join dbo.VW_movdevfacturas D on D.id_factura =F.id
	WHERE F.fechadoc
		BETWEEN @fechaini  AND @fechafin 
	AND F.estado='PROCESADO'  AND D.id is null
	AND( Isnull(@idusuario,0) = 0 OR F.id_user = @idusuario)
	GROUP BY F.username, F.nomusuario, F.centrocosto
	
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


