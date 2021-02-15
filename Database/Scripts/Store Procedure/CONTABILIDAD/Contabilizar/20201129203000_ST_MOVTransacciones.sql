--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_MOVTransacciones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_MOVTransacciones]
GO

/***************************************
*Nombre:		[CNT].[ST_MOVTransacciones]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		24/10/2020
*Desarrollador: (Jeteme)

SP Inserta en tablas transacciones 
***************************************/

CREATE PROCEDURE [CNT].[ST_MOVTransacciones] 
	-- Add the parameters for the stored procedure here
	@id BIGINT ,
	@id_user INT,
	@nombreView varchar(50)
AS
DECLARE  @mensaje varchar(max);
BEGIN TRY
BEGIN TRANSACTION
DECLARE @sql nvarchar(max)
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	 
    -- Insert statements for procedure here
	SET @sql='SELECT T.ANOMES,
           T.CENTROCOSTO,
		   T.NRODOCUMENTO,
		   T.nrofactura,
		   T.FECHADCTO,
		   T.CUENTA,
		   T.IDEN_TERCERO,
		   T.CODPRODUCTO,
		   T.PRESENPRODUCTO,
		   T.NOMPRODUCTO,
		   T.VALOR,
		   T.FORMAPAGO,
		   T.BASEIMP,
		   T.PORCEIMP,
		   T.CANTIDAD,
		   T.TIPODOC,
		   T.DESCRIPCION,
		   T.ESTADO,
		   T.FECHAVENCIMIENTO,
		   @id_user,
		   @id_user FROM ' + @nombreview+N' T WHERE 
		   ID=@id_transa'

	
	INSERT INTO [CNT].[Transacciones]([anomes],
									  [id_centrocosto],
									  [nrodocumento],
									  [nrofactura],
									  [fechadcto],
									  [id_cuenta],
									  [id_tercero],
									  [codigoproducto],
									  [presentacionproducto],
									  [nombreproducto],
									  [valor],
									  [formapago],
									  [baseimp],
									  [porceimp],
									  [cantidad],
									  [tipodocumento],
									  [descripcion],
									  [estado],
									  [fechavencimiento],
									  [id_usercreated],
									  [id_userupdated])
	                                  EXEC sp_executesql @sql,N'@id_user BIGINT,@id_transa BIGINT',@id_user=@id_user,@id_transa=@id
	
	
COMMIT TRANSACTION;
END TRY
BEGIN CATCH	
	SET @mensaje = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@Mensaje,16,0);	
	ROLLBACK TRANSACTION;
END CATCH

GO


