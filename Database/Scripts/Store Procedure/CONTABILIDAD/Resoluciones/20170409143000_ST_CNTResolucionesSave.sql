--liquibase formatted sql
--changeset ,JTOUS:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_CNTResolucionesSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_CNTResolucionesSave]
GO

CREATE PROCEDURE [dbo].[ST_CNTResolucionesSave]
@id BIGINT = null,
@id_centrocosto bigint, 
@codigo VARCHAR(50),
@fechainicio SMALLDATETIME, 
@fechafin SMALLDATETIME, 
@prefijo varchar(20), 
@conini int, 
@confin int,
@confac int,
@leyenda VARCHAR(MAX), 
@isfe	BIT,
@id_user int

AS

/***************************************
*Nombre:		[Dbo].[ST_CNTResolucionesSave]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		09/04/17
*Desarrollador: (JTOUS)
***************************************/

BEGIN TRANSACTION
BEGIN TRY
	Declare @manejador int;
	DECLARE @id_return INT, @error VARCHAR(MAX);
	--IF EXISTS (SELECT 1 FROM Dbo.CNTResoluciones A WHERE A.codigo = @codigo AND id <> @id)
	--BEGIN
	--	RAISERROR('Ya existe resoluci�n con este c�digo...', 16,0);
	--END

	IF (@fechainicio > @fechafin)
	BEGIN
		RAISERROR('La fecha inicio no puede ser mayor a la final.', 16,0);
	END
	
	IF(Isnull(@id,0) = 0)
	BEGIN
		INSERT INTO [dbo].[DocumentosTecnicaKey] (prefijo, resolucion, tecnicakey, rangoini, rangofin, fechaini, fechafin, estado, consecutivo, leyenda, id_ccosto, id_user, isfe)
		VALUES(@prefijo, @codigo, '', @conini, @confin, @fechainicio, @fechafin, 0, @confac, @leyenda, @id_centrocosto, @id_user, @isfe)
				
		SET @id_return = SCOPE_IDENTITY();
	END
	ELSE
	BEGIN
		UPDATE Dbo.[DocumentosTecnicaKey]
		SET 
			prefijo		= @prefijo, 
			resolucion	= @codigo, 
			rangoini	= @conini, 
			rangofin	= @confin, 
			fechaini	= @fechainicio, 
			fechafin	= @fechafin, 			
			consecutivo	= @confac, 
			leyenda		= @leyenda, 			
			id_ccosto	= @id_centrocosto, 
			isfe		= @isfe,
			updated		= GETDATE()
		WHERE id = @id;
			
		SET @id_return = @id		
	END	

	COMMIT TRANSACTION;
END TRY
BEGIN CATCH	
	ROLLBACK TRANSACTION;
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);	
END CATCH

SELECT @id_return;

GO


