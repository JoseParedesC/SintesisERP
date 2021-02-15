--liquibase formatted sql
--changeset ,CZULBARAN:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[GSC].[ST_ClientesGestionSaveBitacora]') and OBJECTPROPERTY(id, N'IsProcedure') = 1) 
	DROP PROCEDURE GSC.ST_ClientesGestionSaveBitacora
GO
CREATE PROCEDURE  [GSC].[ST_ClientesGestionSaveBitacora]
/***************************************
--*Nombre:		[GSC].[ST_ClientesGestionSaveBitacora]
----------------------------------------
--*Tipo:			Procedimiento almacenado
--*creación:		22/11/2020
--*Desarrollador:   (CZULBARAN)
--*Descripcion:     Guarda las bitacoras insertanto en la tabla seguimiento y la tabla seguimientoHistorial
***************************************/
@id_cliente BIGINT,
@programacion VARCHAR(16)=null,
@descripcion VARCHAR(MAX),
@tipo VARCHAR(20)=null,
@programer BIT,
@id_user BIGINT
AS

/***************************************
*Nombre:		[GSC].[ST_ClientesGestionSaveBitacora]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		14/11/2020
*Desarrollador: JPAREDES
*Descripcion:	Guardar y almacenar el historial de la bitacora de un cliente
***************************************/
BEGIN TRANSACTION
BEGIN TRY

DECLARE @error VARCHAR(MAX);
DECLARE @id_return BIGINT;
	

		IF NOT EXISTS(SELECT 1 FROM [GSC].[GestionSeguimientos] WHERE id_cliente = @id_cliente)
		BEGIN

		--PROGRAMA UNA LLAMADA O COMPROMISO DE PAGO
			INSERT INTO [GSC].[GestionSeguimientos] (id_cliente,fechaProgramacion,id_user,created,tipo, programado) 
			VALUES (@id_cliente,@programacion,@id_user,getdate(),@tipo,@programer)
			SET @id_return = SCOPE_IDENTITY()

		END 
		ELSE
		BEGIN

		--RE-PROGRAMA UNA LLAMADA O COMPROMISO DE PAGO
			UPDATE [GSC].[GestionSeguimientos]
			SET fechaProgramacion = @programacion,
				tipo = @tipo,
				programado = @programer
			WHERE id_cliente = @id_cliente

			SET @id_return = (SELECT TOP 1 id FROM [GSC].[GestionSeguimientos] WHERE id_cliente = @id_cliente);

		END

		INSERT INTO [GSC].[GestionSeguimientosHistorial] (id_seguimiento,fechaProgramacion,seguimiento,tipo,programado,id_user,created) 
		VALUES (@id_return,@programacion,@descripcion,@tipo,@programer, @id_user,getdate())


		EXEC [GSC].[ST_BitacoraList] @idC = @id_cliente


COMMIT TRANSACTION
END TRY
BEGIN CATCH
	SET @error = 'Error: '+ERROR_MESSAGE();
		RAISERROR(@error,16,0);		
		ROLLBACK TRANSACTION;
END CATCH