--liquibase formatted sql
--changeset ,jteheran:4 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MOVFacturarAnticipo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MOVFacturarAnticipo]
GO
CREATE  PROCEDURE [dbo].[ST_MOVFacturarAnticipo]
    @id_tipodoc			[BIGINT],
    @id_centrocostos	[BIGINT],
	@fecha				[SMALLDATETIME],
	@descripcion		[VARCHAR] (MAX),
	@id_tipoanticipo	[INT],
	@id_tercero			[BIGINT],
	@id_forma			[INT],
	@id_ctaant			[BIGINT],
	@valor				[NUMERIC] (18,2),
	@voucher			[VARCHAR](200),
	@id_user			[INT]
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_MOVFacturarAnticipo]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		09/05/2017
*Desarrollador: (JTOUS)
***************************************/
DECLARE @error VARCHAR(MAX), @id_return INT, @idestado INT, @anomes VARCHAR(6), @id_saldo BIGINT,@fechadoc VARCHAR(10);

BEGIN TRY
BEGIN TRAN
	
	SET @anomes = CONVERT(VARCHAR(6), @fecha, 112);
	SET @fechadoc = CONVERT(VARCHAR(10), @fecha, 120);

		EXECUTE [Dbo].ST_ValidarPeriodo
			@fecha			= @fechadoc,
			@anomes			= @anomes,
			@mod			= 'C'
	
	IF(ISNULL(@valor, 0) = 0)
		RAISERROR('El valor no puede ser menor ni igual a 0.', 16, 0);	
	
	SET @idestado = Dbo.ST_FnGetIdList('PROCE');

	INSERT INTO [dbo].[MOVAnticipos](id_tipodoc, id_centrocostos, fecha, id_tercero, id_cuenta, descripcion, valor, id_formapago,id_tipoanticipo ,id_reversion, estado, id_user, voucher)
	VALUES(@id_tipodoc, @id_centrocostos, @fecha, @id_tercero, @id_ctaant, @descripcion, @valor, @id_forma,@id_tipoanticipo, NULL, @idestado, @id_user, @voucher);				
	
	SET @id_return =  SCOPE_IDENTITY();


	EXEC CNT.ST_MOVTransacciones				 @id = @id_return,@id_user = @id_user,@nombreView='CNT.VW_TRANSACIONES_ANTICIPOS';
	EXEC CNT.ST_MOVSaldos                       @opcion='I',@id=@id_return,@id_user=@id_user,@nombreView='CNT.VW_TRANSACIONES_ANTICIPOS'


	IF ISNULL(@id_return, 0) = 0
		RAISERROR('No se pudo guardar el anticipo.', 16,0);
	
	SELECT @id_return id, 'PROCESADO' estado

COMMIT TRAN;
END TRY
BEGIN CATCH
		ROLLBACK TRAN;
	    --Getting the error description
	    SELECT @error   =  ERROR_MESSAGE()
	    -- save the error in a Log file
	    RAISERROR(@error,16,1);
	    RETURN  
END CATCH
