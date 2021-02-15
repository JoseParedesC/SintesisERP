--liquibase formatted sql
--changeset ,jteheran:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[CNTCuentasSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [Dbo].[CNTCuentasSave]
GO


CREATE PROCEDURE [dbo].[CNTCuentasSave]
@id				BIGINT = null,
@codigo			VARCHAR(2), 
@nombre			VARCHAR(50), 
@tipo			bit,
@id_padre		bigint, 
@id_user		int,
@id_tipocta		BIGINT

--WITH ENCRYPTION
AS

/***************************************
*Nombre:		[dbo].CNTCuentasSave
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		15/11/19
*Desarrollador: (JETEHERAN)
***************************************/

BEGIN TRANSACTION
BEGIN TRY

	DECLARE @id_return INT, @error VARCHAR(MAX);
	DECLARE @indice INT, @codigopadre VARCHAR(25), @idparent BIGINT, @id_naturaleza INT = NULL;

	SELECT @indice = indice + 1, @codigopadre = codigo, @idparent = id FROM CNTCuentas WHERE id = @id_padre;
	IF EXISTS (SELECT 1 FROM dbo.CNTCuentas WHERE id = @id AND bloqueada != 0)
		RAISERROR('No se puede modificar esta cuenta, por ser precargada.', 16, 0);

	IF (EXISTS (SELECT 1 FROM dbo.CNTCuentas WHERE codigo = @codigopadre+@codigo AND id != @id))
		RAISERROR('Ya existe cuenta contable', 16, 0);
	IF(@tipo != 0)
	BEGIN
		SELECT @id_naturaleza = CASE SUBSTRING(@codigopadre,1,1) WHEN '1' THEN dbo.ST_FnGetIdList('DEBITO') --ACTIVO 
												WHEN '2' THEN dbo.ST_FnGetIdList('CREDITO')--PASIVOS 
												WHEN '3' THEN dbo.ST_FnGetIdList('CREDITO')--PATRIMONIO
												WHEN '4' THEN dbo.ST_FnGetIdList('CREDITO')--INGRESOS
												WHEN '5' THEN dbo.ST_FnGetIdList('DEBITO') --GASTOS
												WHEN '6' THEN dbo.ST_FnGetIdList('CREDITO')--COSTOS
												END
	END
	IF(Isnull(@id,0) = 0)
	BEGIN		
		INSERT INTO dbo.CNTCuentas(subcodigo, codigo, nombre, tipo, id_padre, id_user, bloqueada, indice, idparent, id_tipocta,id_naturaleza,categoria)
		SELECT @codigo, @codigopadre+@codigo, @nombre, @tipo, @codigopadre, @id_user, 0, @indice, @idparent, CASE WHEN @id_tipocta = 0 THEN NULL ELSE @id_tipocta END,@id_naturaleza,
		CASE WHEN @id_tipocta=dbo.ST_FnGetIdList('CRED')  THEN dbo.ST_FnGetIdList('CCLIENTE')  
			 WHEN @id_tipocta=dbo.ST_FnGetIdList('PROVE') THEN dbo.ST_FnGetIdList('CPROVE') 
			 ELSE dbo.ST_FnGetIdList('CTERCE') END
				
		SET @id_return = SCOPE_IDENTITY();
	END
	ELSE
	BEGIN
		IF(EXISTS (SELECT 1 FROM dbo.CNTCuentas WHERE idparent = @id AND @tipo != 0))
			RAISERROR('Esta cuenta no puede ser transaccional, porque ya tiene dependientes.', 16, 0);

		IF EXISTS(SELECT 1 FROM dbo.CNTCuentas WHERE idparent = @id) AND EXISTS (SELECT 1 FROM dbo.CNTCuentas WHERE subcodigo != @codigo AND id = @id)
			RAISERROR('No se puede modificar el código, porque ya tiene cuentas dependientes.',16,1)

		UPDATE dbo.CNTCuentas 
		SET
			subcodigo	= @codigo,
			codigo		= @codigopadre+@codigo, 
			nombre		= @nombre, 
			tipo		= @tipo, 
			id_user		= @id_user,
			id_tipocta	= @id_tipocta,
			categoria	= CASE WHEN @id_tipocta=dbo.ST_FnGetIdList('CRED')  THEN dbo.ST_FnGetIdList('CCLIENTE')  
			 WHEN @id_tipocta=dbo.ST_FnGetIdList('PROVE') THEN dbo.ST_FnGetIdList('CPROVE') 
			 ELSE dbo.ST_FnGetIdList('CTERCE') END,
			updated		= GETDATE()
		WHERE id = @id;
			
		SET @id_return = @id;	
	END
	

COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);		
	ROLLBACK TRANSACTION;
END CATCH

SELECT @id_return;


GO


