--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_ReporteCampos]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_ReporteCampos]
GO
CREATE PROCEDURE [dbo].[ST_ReporteCampos]
@id BIGINT = 0,
@id_user INT

--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_ReporteCampos]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		19/06/2015
*Desarrollador:  Jose Luis Tous P�rez (jtous)
*Descripcion:	Se realizan EL PROCESO DE REVERTIR EL TRASLADO.
***************************************/
Declare @Mensaje varchar(max);
BEGIN TRY
	SELECT id, parametro, codigo, nombre, tipo, fuente, ancho, requerido, metadata, campos, seleccion, params
	FROM [dbo].[ST_CamposReporte]
	WHERE id_reporte = @id
	ORDER BY orden ASC;
END TRY
BEGIN CATCH	
	SET @Mensaje = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@Mensaje,16,0);	
END CATCH
