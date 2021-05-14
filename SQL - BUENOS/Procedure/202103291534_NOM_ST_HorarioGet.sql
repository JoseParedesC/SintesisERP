--liquibase formatted sql
--changeset ,JARCINIEGAS:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_HorarioGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_HorarioGet]
GO
CREATE PROCEDURE [NOM].[ST_HorarioGet]
	
	@id INT ,
	@id_user INT
AS

/***************************************
*Nombre:		[CRE].[ST_HorarioGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		24/11/2020
*Desarrollador: JPAREDES
*Descripcion:	
***************************************/

DECLARE @error VARCHAR(MAX)

BEGIN TRY

	IF EXISTS(SELECT 1 FROM [NOM].[Horario] WHERE id_padre = @id)
	BEGIN
	
	SELECT	id, --
			nombre,  --//
			tipo_horario,
			cantdias,
			canttrabdias,
			cantdesdias,
			convert(varchar(5),Hinicio) Hinicio,
			convert(varchar(5),Hiniciodesc) Hiniciodesc,
			convert(varchar(5),Hfindesc) Hfindesc,
			convert(varchar(5),Hfin) Hfin,
			sab
	FROM [NOM].[Horario]
	WHERE id = @id
	UNION  
	SELECT	id, --
			nombre,  --//
			tipo_horario,
			cantdias,
			canttrabdias,
			cantdesdias,
			convert(varchar(5),Hinicio) Hinicio,
			convert(varchar(5),Hiniciodesc) Hiniciodesc,
			convert(varchar(5),Hfindesc) Hfindesc,
			convert(varchar(5),Hfin) Hfin,
			sab
	FROM [NOM].[Horario]
	WHERE id_padre = @id

	END
	ELSE 
	BEGIN

	SELECT	id, --
			nombre,  --//
			tipo_horario,
			cantdias,
			canttrabdias,
			cantdesdias,
			convert(varchar(5),Hinicio) Hinicio,
			convert(varchar(5),Hiniciodesc) Hiniciodesc,
			convert(varchar(5),Hfindesc) Hfindesc,
			convert(varchar(5),Hfin) Hfin


	FROM [NOM].[Horario]
	WHERE id = @id
	
	END

END TRY
BEGIN CATCH
--Getting the error description
	Set @error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	-- save the error in a Log file
	RAISERROR(@error,16,1)
	RETURN
END CATCH