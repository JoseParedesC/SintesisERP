--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[GSC].[ST_BitacoraList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE GSC.ST_BitacoraList
GO
 
CREATE PROCEDURE [GSC].[ST_BitacoraList]

@idC BIGINT

AS
/***************************************
*Nombre:		[GSC].[ST_BitacoraList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		17/11/2020
*Desarrollador: jparedes
*Descripcion:	Lista el historial de seguimiento 
				que va a mostrar en la bitacora
***************************************/
DECLARE @error VARCHAR(MAX);
DECLARE @temp TABLE(fecha SMALLDATETIME,seg_pt1 VARCHAR(MAX), seg_pt2 VARCHAR(MAX), programer VARCHAR(20) , id BIGINT,id_record BIGINT IDENTITY(1,1));

BEGIN TRY
	
	SELECT CONVERT(VARCHAR(20),GSH.created,(120)) [time],
	'<b style="color:#58c8a9;">'+U.username +'</b></br>'+ UPPER(LEFT(GSH.seguimiento, 1)) + LOWER(SUBSTRING(GSH.seguimiento, 2, LEN(GSH.seguimiento)))+'</br>'+
	CASE WHEN GSH.programado != 0 THEN 'y se programo '+
		CASE	WHEN UPPER(GSH.tipo) = 'CALL'  THEN 'una <b>Llamada </b><i class="fa fa-phone" style:"margin-left:6px;"></i>, '
				WHEN UPPER(GSH.tipo) = 'PAGO'  THEN 'un <b>Compromiso de Pago </b><i class="fa fa-money" style:"margin-left:6px;"></i>, '
				WHEN UPPER(GSH.tipo) = 'INMOV' THEN 'una <b>Penalización </b><i class="fa fa-motorcycle" style:"margin-left:6px;"></i>, '
				WHEN UPPER(GSH.tipo) = 'VISIT' THEN 'una <b>Visita </b><i class="fa fa-user-secret" style:"margin-left:6px;"></i>, ' 
				END +'Para el dia '+ ISNULL(CONVERT(VARCHAR(10), GSH.fechaprogramacion, 120), '')
	ELSE '' END content
	FROM [GSC].[GestionSeguimientosHistorial] GSH 
	INNER JOIN [GSC].[GestionSeguimientos] GES ON GES.id = GSH.id_seguimiento
	INNER JOIN VW_Usuarios U ON U.id = GSH.id_user
	WHERE GES.id_cliente = @idC

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