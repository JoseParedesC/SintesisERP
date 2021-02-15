--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CRE].[ST_AnalisisUpdate_MOVCredito]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CRE].[ST_AnalisisUpdate_MOVCredito]
GO
CREATE PROCEDURE [CRE].[ST_AnalisisUpdate_MOVCredito]

@cuotaini NUMERIC,
@numcuotas INT,
@fecha SMALLDATETIME,
@cuotamen NUMERIC,
@forma VARCHAR(10),
@id_solicitud BIGINT,
@lineacredir BIGINT

AS
/******************************************************
*Nombre:		[CRE].[AnalisisUpdate_MOVCredito]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		12/112020
*Desarrollador: JPAREDES
*Descripcion:	Actualiza la informacion de las cuotas 
				del credito de una cotizacion
******************************************************/

DECLARE @error VARCHAR(MAX);
	
BEGIN TRY
	
	UPDATE C SET  
		C.inc = @cuotaini,
		C.numcuotas = @numcuotas,
		C.fechaini = @fecha,
		C.cuotamen = @cuotamen,
		C.credito = @forma,
		C.lineacredit= @lineacredir
	FROM [dbo].[MOVCotizacion] C INNER JOIN 
		 [CRE].[Solicitudes] S ON S.id_cotizacion = C.id
	WHERE S.id = @id_solicitud

END TRY
BEGIN CATCH
	--Getting the error description
	    SELECT @error   =  ERROR_PROCEDURE() + 
					';  ' + CONVERT(VARCHAR,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	    -- save the error in a Log file
	    RAISERROR(@error,16,1)
	    RETURN 
END CATCH