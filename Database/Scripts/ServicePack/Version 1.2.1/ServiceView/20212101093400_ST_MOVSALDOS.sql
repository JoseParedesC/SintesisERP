--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_MOVSALDOS]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_MOVSALDOS]
GO

/***************************************
*Nombre:		[CNT].[ST_MOVSALDOS]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		20/01/2021
*Desarrollador: (jteheran)

Actualiza todas las tablas de saldos
***************************************/

create PROCEDURE [CNT].[ST_MOVSALDOS] 
	-- Add the parameters for the stored procedure here
	@opcion CHAR(1),
	@id BIGINT,
	@id_user BIGINT,
	@nombreView VARCHAR(50),
	@tipodocumento VARCHAR(10)=NULL,
	@anomes VARCHAR(6)=NULL
AS
DECLARE  @mensaje varchar(max);
BEGIN TRY
BEGIN TRANSACTION
			

			EXEC CNT.ST_MOVSaldoCuenta      @opcion=@opcion,   @id=@id,   @id_user=@id_user,   @nombreView=@nombreView,     @tipodocumento = @tipodocumento,   @anomes=@anomes
			EXEC CNT.ST_MOVSaldoTerceronew  @opcion=@opcion,   @id=@id,   @id_user=@id_user,   @nombreView=@nombreView,     @tipodocumento = @tipodocumento,   @anomes=@anomes
			EXEC CNT.ST_MOVSaldoClientes    @opcion=@opcion,   @id=@id,   @id_user=@id_user,   @nombreView=@nombreView,     @tipodocumento = @tipodocumento,   @anomes=@anomes
			EXEC CNT.ST_MOVSaldoCentroCosto @opcion=@opcion,   @id=@id,   @id_user=@id_user,   @nombreView=@nombreView,     @tipodocumento = @tipodocumento,   @anomes=@anomes
	
	
COMMIT TRANSACTION;
END TRY
BEGIN CATCH	
	ROLLBACK TRANSACTION;
	SET @mensaje = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@Mensaje,16,0);	
END CATCH

GO


