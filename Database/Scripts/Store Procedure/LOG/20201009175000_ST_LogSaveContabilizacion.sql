--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_LogSaveContabilizacion]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [dbo].[ST_LogSaveContabilizacion]   
GO
CREATE PROCEDURE [dbo].[ST_LogSaveContabilizacion]
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
BEGIN TRY
	
	SELECT @opcion=CASE @nombreView When 'CNT.VW_TRANSACIONES_ENTRADAS' Then 'EN' When 'CNT.VW_TRANSACIONES_DEVENTRADAS'  Then 'DC' When 'CNT.VW_TRANSACIONES_AJUSTES'  Then 'AJ'  When 'CNT.VW_TRANSACIONES_TRASLADOS'  Then 'TR'  When 'CNT.VW_TRANSACIONES_FACTURAS'  Then 'FV'  When 'CNT.VW_TRANSACIONES_DEVFACTURAS'  Then 'DV'ELSE '' END

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
		SELECT TOP 1 @fecha = CONVERT(varchar(10), fechafac, 120),@id_caja=id_caja FROM [dbo].MOVFactura WHERE id = @id;

	
	END
	ELSE IF (@opcion = 'DV')
	BEGIN
		SELECT TOP 1 @fecha = CONVERT(varchar(10), fecha, 120),@id_caja=id_caja FROM [dbo].MOVDevFacturas WHERE id = @id;

	
	END

	INSERT INTO LogContabilizacion (tipodoc, fecha, id_caja, id_doc, mensaje, id_user)
	VALUES(@opcion, @fecha, @id_caja, @id, @mensaje, @id_user);

END TRY
BEGIN CATCH
	Select @error   =  ERROR_MESSAGE();
	RaisError(@error,16,1)	
END CATCH
