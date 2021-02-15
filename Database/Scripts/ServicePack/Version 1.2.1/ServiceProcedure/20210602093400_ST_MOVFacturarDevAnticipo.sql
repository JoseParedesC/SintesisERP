--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MOVFacturarDevAnticipo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MOVFacturarDevAnticipo]
GO

CREATE PROCEDURE [dbo].[ST_MOVFacturarDevAnticipo]
    @id_tipodoc BIGINT,
	@id_centrocostos BIGINT,
	@fecha SMALLDATETIME,
	@descripcion [VARCHAR] (500),
	@id_cliente [BIGINT],
	@id_tipoanticipo [BIGINT],
	@id_cta [BIGINT],
	@valor [NUMERIC] (18,2),
	@id_formapago [BIGINT],
	@id_user [INT]
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_MOVFacturarDevAnticipo]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		09/05/2017
*Desarrollador: (JTOUS)
***************************************/
DECLARE @error VARCHAR(MAX), @id_return INT, @idestado INT, @valoranticipo NUMERIC(18,2) = 0,@anomes VARCHAR(6),@fechadoc VARCHAR(10);

BEGIN TRY
BEGIN TRAN


	SET @idestado = Dbo.ST_FnGetIdList('PROCE');
	SET @anomes   = CONVERT(VARCHAR(6), @fecha, 112);
	SET @fechadoc = CONVERT(VARCHAR(10), @fecha, 120);

		EXECUTE [Dbo].ST_ValidarPeriodo
			@fecha			= @fechadoc,
			@anomes			= @anomes,
			@mod			= 'C'
	
	IF(ISNULL(@valor, 0) = 0)
		RAISERROR('El valor no puede ser menor ni igual a 0.', 16, 0);

	SELECT @valoranticipo = saldoactual
	FROM CNT.SaldoTercero 
	WHERE id_cuenta = @id_cta and id_tercero = @id_cliente and anomes=@anomes
			
	IF @valor IS NULL
		RAISERROR('Verifique el valor del anticipo a revertir.', 16, 0);

	SET @valoranticipo= iif(@id_tipoanticipo=Dbo.ST_FnGetIdList('CL'),@valoranticipo*-1,@valoranticipo)


	IF(@valoranticipo >= @valor)
	BEGIN
		INSERT INTO [dbo].[MOVDevAnticipos](id_tipodoc,id_centrocostos,estado, fecha, descripcion, valor, id_cliente, Id_cta ,id_formapago,id_tipoanticipo,id_user)
		VALUES(@id_tipodoc,@id_centrocostos,@idestado, @fecha, @descripcion,  @valor, @id_cliente, @id_cta ,@id_formapago,@id_tipoanticipo,@id_user);				
	
		SET @id_return =  SCOPE_IDENTITY();

	
		EXEC CNT.ST_MOVTransacciones @id = @id_return,@id_user = @id_user,@nombreView='CNT.VW_TRANSACIONES_DEVANTICIPOS';
		EXEC CNT.ST_MOVSaldos                       @opcion='I',@id=@id_return,@id_user=@id_user,@nombreView='CNT.VW_TRANSACIONES_DEVANTICIPOS'

		IF ISNULL(@id_return, 0) = 0
			RAISERROR('No se pudo guardar la devoluci�n de anticipo.', 16,0);
	
		SELECT @id_return id, 'PROCESADO' estado
	END
	ELSE
	BEGIN
		RAISERROR('No se le puede hacer una devoluci�n por este valor, porque no tiene saldo suficiente...',16,0);	
	END

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
