--liquibase formatted sql
--changeset ,kmartinez:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MOVValidarFacturaRecurrentes]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [dbo].[ST_MOVValidarFacturaRecurrentes] 
GO
/***************************************
*Nombre: [dbo].[ST_MOVValidarFacturaRecurrentes]
----------------------------------------
*Tipo: Procedimiento almacenado
*creación: 17/10/2020
*Desarrollador: (Kmartinez)Kevin Jose Martinez Teheran
*Descripcion:
***************************************/
CREATE PROCEDURE [dbo].[ST_MOVValidarFacturaRecurrentes]
@fechadoc		VARCHAR(10),
@id_ccosto		BIGINT,
@id_factura     BIGINT,
@id_tercero		BIGINT,
@id_user		INT,
@isfe			BIT OUTPUT
AS

Declare @idestado INT, @Cantidad INT, @valor NUMERIC(18,2) = 0;
Declare @id_resolucion int, @resolucion VARCHAR(50), @consefac int, @prefijo varchar(20), @mensaje varchar(max), 
@mensaje2 VARCHAR(200), @id_articulo bigint, @id_bodega BIGINT;
DECLARE @table TABLE (id int identity(1,1), id_item bigint, id_articulo BIGINT, precio NUMERIC(18,2));

DECLARE @tableSL TABLE (id int identity(1,1), id_item bigint, id_articulo BIGINT, id_bodega BIGINT, cantidad NUMERIC(18,2), serie VARCHAR(200), id_lote BIGINT, lote bit);
BEGIN TRY

	--Valida la fecha de factura.
	IF NOT EXISTS (SELECT 1 FROM Dbo.DiasFac F WHERE CONVERT(VARCHAR(10), F.Fecha, 112) = CONVERT(VARCHAR(10),@fechadoc,112) AND F.Estado = 1 )
		RAISERROR('La fecha de factura no esta abierta.',16,0);

	--Valida el cliente si existe.
	IF NOT EXISTS (SELECT  1 FROM CNT.Terceros C  WHERE C.id = @id_tercero) 
		RAISERROR('Cliente no existe.',16,0);	

	--Valida el consecutivo de facturaci�n junto a la resoluci�n y prefijo.
	SELECT TOP 1 @id_resolucion = id_resolucion, @resolucion = resolucion, @consefac = consecutivo, @prefijo = prefijo
	FROM Dbo.ST_FnConsecutivoFactura(@id_ccosto, @isfe);
	IF(ISNULL(@id_resolucion, 0) = 0)
		RAISERROR('No tiene resoluci�n para el centro de costo seleccionado.',16,0);

	IF EXISTS (SELECT 1 FROM DBO.MovFactura WHERE consecutivo = @consefac AND id_resolucion = @id_resolucion 
												AND prefijo = @prefijo AND resolucion = @resolucion)
	BEGIN
		RAISERROR('El consecutivo de facturaci�n ya existe en otro documento. Verifique Consecutivos...',16,0);
	END

	--Valida si hay productos para facturar.
	IF NOT EXISTS(SELECT 1 FROM  MOVFacturaRecurrentesItems WHERE id_factura = @id_factura)
	BEGIN	
		RAISERROR('No se cargaron productos a la Factura, verifique..',16,0);
	END		
		
END TRY
BEGIN CATCH	
	SET @mensaje = ERROR_MESSAGE();
	RAISERROR(@Mensaje,16,0);	
END CATCH
GO


