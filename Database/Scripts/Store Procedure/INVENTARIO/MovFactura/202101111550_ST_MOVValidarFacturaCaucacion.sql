--liquibase formatted sql
--changeset ,JTOUS:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FIN].[ST_MOVValidarFacturaCaucacion]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [FIN].[ST_MOVValidarFacturaCaucacion]
GO
CREATE PROCEDURE [FIN].[ST_MOVValidarFacturaCaucacion]
@id_ccosto		BIGINT,
@isfe			BIT,
@id_tercero		BIGINT

--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_MOVValidarFacturaCaucacion]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creacin:		11/01/2021
*Desarrollador:  Jose Luis Tous Perez (jtous)
*Descripcion:	Se realizan EL PROCESO DE Validar Factura Causacion
***************************************/
Declare @idestado INT, @Cantidad INT, @valor NUMERIC(18,2) = 0;
Declare @id_resolucion int, @resolucion VARCHAR(50), @consefac int, @prefijo varchar(20), @mensaje varchar(max) 
BEGIN TRY

	--Valida el cliente si existe.
	IF NOT EXISTS (SELECT  1 FROM CNT.Terceros C  WHERE C.id = @id_tercero) 
		RAISERROR('Cliente no existe.',16,0);	

	--Valida el consecutivo de facturacion junto a la resolucion y prefijo.
	SELECT TOP 1 @id_resolucion = id_resolucion, @resolucion = resolucion, @consefac = consecutivo, @prefijo = prefijo
	FROM Dbo.ST_FnConsecutivoFactura(@id_ccosto, @isfe);
	IF(ISNULL(@id_resolucion, 0) = 0)
		RAISERROR('No tiene resolucion para el centro de costo seleccionado.',16,0);

	IF EXISTS (SELECT 1 FROM DBO.MovFactura WHERE consecutivo = @consefac AND id_resolucion = @id_resolucion 
												AND prefijo = @prefijo AND resolucion = @resolucion)
	BEGIN
		RAISERROR('El consecutivo de facturación ya existe en otro documento. Verifique Consecutivos...',16,0);
	END

END TRY
BEGIN CATCH	
	SET @mensaje = ERROR_MESSAGE();
	RAISERROR(@Mensaje,16,0);	
END CATCH

