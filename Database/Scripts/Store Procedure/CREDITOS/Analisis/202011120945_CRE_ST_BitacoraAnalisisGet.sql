--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CRE].[ST_BitacoraAnalisisGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CRE].[ST_BitacoraAnalisisGet]
GO
CREATE PROCEDURE [CRE].[ST_BitacoraAnalisisGet]

@id_sol BIGINT,
@id_user BIGINT

/***************************************
*Nombre:		[CRE].[ST_BitacoraAnalisisGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		12/112020
*Desarrollador: JPAREDES
*Descripcion:	Lista la informacion de 
				seguimiento aplicada en 
				las solicitudes
***************************************/
AS
DECLARE @error VARCHAR(MAX);

BEGIN TRY
	
	DECLARE @nombre VARCHAR(50) = (SELECT nombre FROM [DBO].[Usuarios] WHERE id = @id_user)

	SELECT '<b style="color:#0074bcf0;">'+ISNULL(@nombre,'Anonimo')+'</b></br>'+S.seguimiento content,
		   CONVERT(VARCHAR(20),S.created,120) [time]
	FROM [CRE].[Solicitud_Seguimientos] S WHERE S.id_solicitud = @id_sol

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