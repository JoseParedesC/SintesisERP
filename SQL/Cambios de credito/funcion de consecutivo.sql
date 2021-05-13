--liquibase formatted sql--changeset ,jarciniegas:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CRE].[ST_FnConsecutivoSolicitud]') 
and OBJECTPROPERTY(id, N'IsScalarFunction') = 1)
DROP FUNCTION [CRE].[ST_FnConsecutivoSolicitud]
GO
CREATE FUNCTION [CRE].[ST_FnConsecutivoSolicitud](@id_estacion int, @tipo varchar(20))
/***************************************
*Nombre: [CRE].[ST_FnConsecutivoSolicitud]
----------------------------------------
*Tipo: Función
*creación: 24/11/20
*Desarrollador: (Jarciniegas)
*Descripción: Lleva el conteo de la canti-
			  dad de solicitudes que se 
			  han hecho y se refleja en 
			  el campo de consecutivo
***************************************/
RETURNS VARCHAR(10)
AS 
	
BEGIN
DECLARE @Consecutivo INT = 0, @numcosecutivo VARCHAR(10);
	SELECT TOP 1 @Consecutivo = consecutivo 
	FROM [CRE].[Consecutivo] WHERE tipo = @tipo

	SET @numcosecutivo = RIGHT('0000000000' + Ltrim(Rtrim(ISNULL(@Consecutivo,0) + 1)),10)
	RETURN @numcosecutivo;
END;
