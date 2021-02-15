--liquibase formatted sql
--changeset ,JTOUS:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_ReporteGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_ReporteGet]
GO

CREATE PROCEDURE [Dbo].[ST_ReporteGet]
@id BIGINT = 0,
@id_user INT,
@type VARCHAR(20),
@codigo VARCHAR(20)

 
AS
/***************************************
*Nombre:		[Dbo].[ST_ReporteGet]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		19/06/2015
*Desarrollador:  Jose Luis Tous Pérez (jtous)
*Descripcion:	Se realizan EL PROCESO DE REVERTIR EL TRASLADO.
***************************************/
Declare @Mensaje varchar(max), @urlimg VARCHAR (MAX) = '', @urlfirma varchar(MAX) = '', @folder VARCHAR(50) = '';
BEGIN TRY

	SELECT TOP 1 @urlimg = urlimgrpt , @urlfirma = urlfirma, @folder = carpetaname + '\' FROM Empresas;

	IF Upper(@type) = 'ID'
		SELECT Top 1 frx, nombre, nombreproce, paramadicionales, @urlimg urlimg, @urlfirma urlfirma, @folder folder, tipo FROM [dbo].[ST_Reportes] WHERE id = @id;
	ELSE
		SELECT Top 1 frx, nombre, nombreproce, paramadicionales, @urlimg urlimg, @urlfirma urlfirma, @folder folder, tipo FROM [dbo].[ST_Reportes] WHERE codigo = @codigo;
END TRY
BEGIN CATCH	
	SET @Mensaje = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@Mensaje,16,0);	
END CATCH
GO
