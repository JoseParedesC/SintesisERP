--liquibase formatted sql
--changeset ,jarciniegas:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
IF EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_FechaFesDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_FechaFesDelete]
GO
CREATE PROCEDURE [NOM].[ST_FechaFesDelete]

@id INT
AS
/****************************************
*Nombre:		[NOM].[ST_FechaFesDelete]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		16/10/2020
*Desarrollador: (JARCINIEGAS)
*DESCRIPCIÓN:	Recoge el id que envia la 
				función FechaFesDelete y
				elimina el registro que 
				coincide con el id
****************************************/
BEGIN

DECLARE @ds_error varchar(max)
	
	BEGIN TRY
		DELETE 
		FROM  NOM.[FechaFes]
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

