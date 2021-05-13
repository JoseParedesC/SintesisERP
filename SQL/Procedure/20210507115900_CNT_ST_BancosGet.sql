--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_BancosGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_BancosGet]
GO
CREATE PROCEDURE [CNT].[ST_BancosGet]

@id INT 

	
AS
/***************************************
*Nombre:		[CNT].[ST_BancosGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		16/10/2020
*Desarrollador: (JARCINIEGAS)
*DESCRIPCIÓN:	Recoge el id que envia 
				la función BancosGet
				y envia la información
				del elemento que coinci-
				de con el id recogido
***************************************/

DECLARE @ds_error VARCHAR(MAX)
	
	IF(ISNULL(@id,0) = 0)
		RAISERROR('No se encontró el banco', 16,0)

	BEGIN TRY
		SELECT B.id, B.nombre, B.codigo_compensacion
		FROM  [CNT].[Bancos] B
		WHERE id = @id;		
		
END TRY
	BEGIN CATCH
	SET @ds_error   =  ERROR_PROCEDURE() + 
					';  ' + CONVERT(VARCHAR,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	
	RAISERROR(@ds_error,16,1)

END CATCH


