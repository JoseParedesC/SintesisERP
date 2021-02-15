--liquibase formatted sql
--changeset ,JPAREDES:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CRE].[ST_AnalisisUpdate_MOVCotizacion]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CRE].[ST_AnalisisUpdate_MOVCotizacion]
GO
CREATE PROCEDURE [CRE].[ST_AnalisisUpdate_MOVCotizacion]

--@producto BIGINT,
--@valor NUMERIC,
@descuento NUMERIC(18,2),
@valfinan NUMERIC(18,2),
@iva NUMERIC(18,2),
@numcuotas INT,
@fecha VARCHAR(10),
@cuotamen NUMERIC(18,2),
@forma VARCHAR(10),
@id_solicitud BIGINT,
@id_cotizacion BIGINT,
@lineacredir BIGINT,
@cuotaini NUMERIC(18,2),
@observaciones VARCHAR(MAX),
@subtotal NUMERIC(18,2),
@idToken VARCHAR(255),
@id_user BIGINT

AS
/******************************************************
*Nombre:		[CRE].[AnalisisUpdate_MOVCredito]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		12/112020
*Desarrollador: JPAREDES
*Descripcion:	Actualiza la informacion de las cuotas 
				del credito de una cotizacion
******************************************************/

DECLARE @error VARCHAR(MAX);
	
BEGIN TRY

	IF NOT EXISTS(SELECT 1 FROM [dbo].[MOVFacturaItemsTemp] WHERE id_factura = @idToken)
	BEGIN
		RAISERROR('Debe existir minimo 1 articulo en la lista',16,0)
	END
	
		UPDATE C SET  
		C.numcuotas = @numcuotas,
		C.fechaini = @fecha,
		C.cuotamen = @cuotamen,
		C.credito = @forma,
		C.lineacredit= @lineacredir,
		C.descuento = @descuento,
		C.total = @valfinan,
		C.iva = @iva,
		C.observaciones = @observaciones,
		C.subtotal = @subtotal
	FROM [dbo].[MOVCotizacion] C INNER JOIN 
		 [dbo].[MOVCotizacionItems] CI ON C.id = CI.id_Cotizacion INNER JOIN
		 [CRE].[Solicitudes] S ON S.id_cotizacion = C.id
	WHERE S.id = @id_solicitud

	UPDATE S SET
		S.inicial = @cuotaini
	FROM [dbo].[MOVCotizacion] C INNER JOIN 
		 [dbo].[MOVCotizacionItems] CI ON C.id = CI.id_Cotizacion INNER JOIN
		 [CRE].[Solicitudes] S ON S.id_cotizacion = C.id
	WHERE S.id = @id_solicitud


	DELETE FROM [dbo].[MOVCotizacionItems] WHERE id_Cotizacion = @id_cotizacion

	INSERT INTO [dbo].[MOVCotizacionItems]
	SELECT
	@id_cotizacion,
	T.id_articulo,
	T.id_bodega,
	T.cantidad,
	T.precio,
	T.total,
	T.descuento,
	T.iva,
	GETDATE(),
	@id_user,
	T.inc
	FROM [dbo].[MOVFacturaItemsTemp] T WHERE id_factura = @idToken


END TRY
BEGIN CATCH
	--Getting the error description
	    SELECT @error = ERROR_MESSAGE()

	    -- save the error in a Log file
	    RAISERROR(@error,16,1)
	    RETURN 
END CATCH