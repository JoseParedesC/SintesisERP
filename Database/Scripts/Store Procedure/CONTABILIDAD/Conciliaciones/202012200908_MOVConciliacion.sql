--liquibase formatted sql
--changeset ,apuello:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id =
OBJECT_ID(N'[CNT].[MOVConciliacion]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[MOVConciliacion]
GO
CREATE PROCEDURE [CNT].[MOVConciliacion]
/***************************************
*Nombre: [dbo].[CategoriasProductosList]
----------------------------------------
*Tipo: Procedimiento almacenado
*creación: 23/12/20
*Desarrollador: APUELLO
*Descripcion: Obtiene un XML para insertas varios registros, 
	si el id_conciliado es diferente de 0 se inserta un nuevo registro y 
	se actualiza el estado del registro que coincida con el id que entra como parametro en el SP
***************************************/
	@xml XML,
	@id_conciliado BIGINT,
	@id_user BIGINT	
AS

DECLARE  @id_return INT, @error VARCHAR(MAX), @idper INT, @estado INT
DECLARE @credito_t INT, @debito_t INT
DECLARE @temp_xml TABLE (id_transaccion BIGINT)
BEGIN TRY
BEGIN TRAN
		
	EXEC sp_xml_preparedocument @idper OUTPUT, @xml

	INSERT INTO @temp_xml (id_transaccion)	
	SELECT 
		id
	FROM OPENXML(@idper, N'items/item') 
	WITH (  id		INT '@id'
	) AS P

		SET @debito_t = (SELECT SUM(debito) FROM [CNT].[VW_Transacciones] t INNER JOIN @temp_xml tm ON tm.id_transaccion = t.id)
	SET @credito_t = (SELECT SUM(credito) FROM [CNT].[VW_Transacciones] t INNER JOIN @temp_xml tm ON tm.id_transaccion = t.id)

	IF(@id_conciliado = 0)
		BEGIN
			SET @estado = (select [dbo].[ST_FnGetIdList]('PROCE'))
			INSERT INTO [CNT].[MOVConciliados] 
				(fecha,
				 estado,
				 debito_t,
				 credito_t,
				 user_created) 
				 VALUES 
				 (GETDATE(), 
				 @estado,
				 @debito_t,
				 @credito_t, 
				 @id_user)

			 SET @id_return = SCOPE_IDENTITY();

			 INSERT INTO [CNT].[MOVConciliadosItems] 
					(id_conciliado, 
					id_transaccion, 
					centrocosto, 
					documento, 
					factura,
					descripcion,
					fecha,
					debito, 
					credito, 
					user_created)
				SELECT 
					@id_return,
					T.id,
					fuente,
					documento,
					factura,
					descrip,
					fecha,
					debito,
					credito,
					@id_user
				FROM [CNT].[VW_Transacciones] T 
				INNER JOIN @temp_xml Tm ON Tm.id_transaccion = T.id
				WHERE Tm.id_transaccion = T.id

			SELECT @id_return AS id
		END
	ELSE
		BEGIN
			SET @debito_t = (SELECT SUM(I.debito) FROM [CNT].[MOVConciliadosItems] I INNER JOIN [CNT].[MOVConciliados] C ON C.id = I.id_conciliado WHERE C.id = @id_conciliado)
			SET @credito_t = (SELECT SUM(I.credito) FROM [CNT].[MOVConciliadosItems] I INNER JOIN [CNT].[MOVConciliados] C ON C.id = I.id_conciliado WHERE C.id = @id_conciliado)
			SET @estado = (select [dbo].[ST_FnGetIdList]('REVER'))
			INSERT INTO [CNT].[MOVConciliados]
				(fecha_revertido, 
				estado,
				debito_t,
				credito_t, 
				id_revertido, 
				updated)
			VALUES 
				(GETDATE(), 
				@estado,
				@debito_t,
				@credito_t, 
				@id_conciliado, 
				@id_user)

			SET @id_return = SCOPE_IDENTITY();
			SET @estado = (select [dbo].[ST_FnGetIdList]('REVON'))
			UPDATE [CNT].[MOVConciliados]
				SET id_revertido	=	@id_return,
					estado			=	@estado
			WHERE id = @id_conciliado

			SELECT @id_return AS id

		END

COMMIT TRAN	
END TRY
BEGIN CATCH
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);		
	ROLLBACK TRANSACTION;
END CATCH

