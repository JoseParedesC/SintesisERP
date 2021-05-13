--liquibase formatted sql
--changeset ,jarciniegas:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
IF EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_EmbargosGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_EmbargosGet]
GO
CREATE PROCEDURE [NOM].[ST_EmbargosGet]

@id INT 
	
AS
/***************************************
*Nombre:		[NOM].[ST_EmbargosGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		16/10/2020
*Desarrollador: (JARCINIEGAS)
*DESCRIPCI�N:	Recoge el id que envia 
				la funci�n EmbargosGet
				y envia la informaci�n
				del elemento que coinci-
				de con el id recogido
***************************************/
BEGIN

	DECLARE @ds_error VARCHAR(MAX)
	
	BEGIN TRY
		SELECT E.id, E.nombre
		FROM  [NOM].[Embargos] E
		WHERE id = @id;		
		
	END TRY
    BEGIN CATCH
	--Getting the error description
	SET @ds_error   =  ERROR_PROCEDURE() + 
					';  ' + CONVERT(VARCHAR,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	-- save the error in a Log file
	RAISERROR(@ds_error,16,1)
	RETURN
	END CATCH
END

