--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CRE].[ST_SolicitudesState]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CRE].[ST_SolicitudesState]
GO
CREATE PROCEDURE [CRE].[ST_SolicitudesState]

@id_solicitud BIGINT,
@estado VARCHAR(10),
@id_user BIGINT

AS

/***************************************
*Nombre:		[CRE].[ST_SolicitudesState]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		03/12/2020
*Desarrollador: (JPAREDES)
*Descripcion:	Cambia el estado de la solicitud
***************************************/

DECLARE @error VARCHAR(MAX)


BEGIN TRY
	
	UPDATE S
			SET S.estado			= (SELECT id FROM [dbo].[ST_Listados] WHERE iden = @estado),
				S.id_userupdated	= @id_user,
				S.updated			= GETDATE()
		FROM [CRE].[Solicitudes] S WHERE S.id = @id_solicitud


	UPDATE C
			SET 
				C.estado			= (SELECT id FROM [dbo].[ST_Listados] WHERE iden = 'UTIL')
		FROM [CRE].[Solicitudes] S INNER JOIN 
				[dbo].[MOVCotizacion] C ON C.id = S.id_cotizacion 
		WHERE S.id = @id_solicitud

END TRY
BEGIN CATCH
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);		
END CATCH