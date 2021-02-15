--liquibase formatted sql
--changeset ,jteheran:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_LogSaveContabilizacion]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [dbo].[ST_LogSaveContabilizacion]   
GO
CREATE PROCEDURE dbo.ST_LogSaveContabilizacion
		@id BIGINT ,
		@mensaje varchar(max),
		@id_user INT,
		@nombreView varchar (50) = ''
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[ST_EntradaLogSaveContabilizacion]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		28/03/17
*Desarrollador: (JTOUS)
***************************************/
DECLARE @error VARCHAR(MAX),  @fecha varchar(10),@opcion VARCHAR(2)='',@id_caja BIGINT =NULL;
BEGIN TRAN	
BEGIN TRY
	SELECT @opcion = CASE @nombreView	WHEN 'CNT.VW_TRANSACIONES_ENTRADAS' THEN 'EN' 
										WHEN 'CNT.VW_TRANSACIONES_DEVENTRADAS'  THEN 'DC' 
										WHEN 'CNT.VW_TRANSACIONES_AJUSTES'  THEN 'AJ'  
										WHEN 'CNT.VW_TRANSACIONES_TRASLADOS'  THEN 'TR'  
										WHEN 'CNT.VW_TRANSACIONES_FACTURAS'  THEN 'FV'  
										WHEN 'CNT.VW_TRANSACIONES_DEVFACTURAS'  THEN 'DV'ELSE '' END

	IF (@opcion = 'EN')
	BEGIN
		SELECT TOP 1 @fecha = CONVERT(varchar(10), fechadocumen, 120) FROM [dbo].MOVEntradas WHERE id = @id;
	END
	ELSE IF (@opcion = 'DC')
	BEGIN
		SELECT TOP 1 @fecha = CONVERT(varchar(10), fechadocumen, 120) FROM [dbo].MOVDevEntradas WHERE id = @id;		
	END
	ELSE IF (@opcion = 'TR')
	BEGIN
		SELECT TOP 1 @fecha = CONVERT(varchar(10), fecha, 120) FROM [dbo].MOVTraslados WHERE id = @id;	
	END
	ELSE IF (@opcion = 'AJ')
	BEGIN
		SELECT TOP 1 @fecha = CONVERT(varchar(10), fecha, 120) FROM [dbo].MOVAjustes WHERE id = @id;
	END
	ELSE IF (@opcion = 'FV')
	BEGIN
		SELECT TOP 1 @fecha = CONVERT(varchar(10), fechafac, 120), @id_caja = id_caja FROM [dbo].MOVFactura WHERE id = @id;	
	END
	ELSE IF (@opcion = 'DV')
	BEGIN
		SELECT TOP 1 @fecha = CONVERT(varchar(10), fecha, 120),@id_caja=id_caja FROM [dbo].MOVDevFactura WHERE id = @id;	
	END

	INSERT INTO LogContabilizacion (tipodoc, fecha, id_caja, id_doc, mensaje, id_user)
	SELECT @opcion, @fecha, @id_caja, @id, @mensaje, @id_user
COMMIT TRAN
END TRY
BEGIN CATCH
	Select @error   =  ERROR_MESSAGE();
	RAISERROR(@error,16,1)	
	ROLLBACK TRAN
END CATCH
