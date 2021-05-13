--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_BancosState]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_BancosState]
GO
CREATE PROCEDURE [CNT].[ST_BancosState]

@id BIGINT, 
@id_user BIGINT

	
AS
/***************************************
*Nombre:		[CNT].[ST_BancosState]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		07/05/2021
*Desarrollador: JPAREDES
*DESCRIPCIÓN:	Cambia el estado del banco
***************************************/
DECLARE @ds_error VARCHAR(MAX)
	
BEGIN TRY

	
	IF(ISNULL(@id,0) = 0)
		RAISERROR('No se ha encontrado el banco', 16, 0)

	UPDATE B 
		SET B.estado = CASE WHEN estado = 0 THEN 1 ELSE 0 END,
			B.id_userupdated = @id_user,
			B.updated = GETDATE()
	FROM [CNT].[Bancos] B WHERE B.id = @id
		
END TRY
BEGIN CATCH

	SET @ds_error   =  ERROR_PROCEDURE() + 
					';  ' + CONVERT(VARCHAR,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()

	RAISERROR(@ds_error,16,1)
END CATCH


