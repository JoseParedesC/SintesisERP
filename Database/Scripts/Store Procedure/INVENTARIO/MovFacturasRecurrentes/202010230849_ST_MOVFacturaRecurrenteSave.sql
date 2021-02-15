--liquibase formatted sql
--changeset ,kmartinez:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MOVFacturaRecurrenteSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [dbo].[ST_MOVFacturaRecurrenteSave] 
GO
/***************************************
*Nombre: [dbo].[ST_MOVFacturaRecurrenteSave]
----------------------------------------
*Tipo: Procedimiento almacenado
*creación: 17/10/2020
*Desarrollador: (Kmartinez)Kevin Jose Martinez Teheran
*Descripcion:
***************************************/

CREATE PROCEDURE [dbo].[ST_MOVFacturaRecurrenteSave] 
 @Id bigint
 
AS
declare @id_return INT, @id_cencostos BIGINT, @isfe BIT = 0, @resolucion VARCHAR(50), @id_resolucion bigint, @consefac int, @prefijo varchar(20),
 @idestado INT, @fechadoc VARCHAR(10), @anomes varchar(6), @id_terce bigint;
 declare @idUser int, @id_factura BIGINT, @id_turno BIGINT;
BEGIN

	 SELECT TOP 1  @id_cencostos = FRF.id_centrocostos FROM [dbo].[MOVFacturasRecurrentes] FRF where FRF.id = @Id

	 SET @isfe = (SELECT CASE WHEN valor = 'S' THEN 1 ELSE 0 END FROM Parametros WHERE codigo = 'FACTURAELECTRO');

	SET @anomes =  (SELECT convert(varchar(6), getdate(), 112));
	SELECT TOP 1 @resolucion = resolucion, @id_resolucion = id_resolucion, @consefac = consecutivo, @prefijo = prefijo 
	FROM Dbo.ST_FnConsecutivoFactura(ISNULL(@id_cencostos, 0), @isfe);	

	  SELECT  @id_factura = id, @fechadoc=CONVERT(VARCHAR(10),FR.fechafac,120) , @id_terce = FR.id_tercero, @isfe = isFe, @idUser = FR.id_user FROM [dbo].[MOVFacturasRecurrentes] FR  where id = @Id
	
	
		EXECUTE [Dbo].ST_ValidarPeriodo
		@fecha			= @fechadoc,
		@anomes			= @anomes,
		@mod			= 'I'
		
		SET @fechadoc = REPLACE (@fechadoc, '-','');

		EXECUTE [dbo].[ST_MOVValidarFacturaRecurrentes]
		@fechadoc		= @fechadoc,
		@id_ccosto   	= @id_cencostos,
		@id_factura     = @id_factura,
		@id_tercero		= @id_terce,
		@id_user		= @idUser,
		@isfe			=@isfe OUTPUT;

  SET @id_turno = (SELECT TOP 1 id_turno FROM Dbo.Usuarios WHERE id = @idUser);

	 SET @idestado = Dbo.ST_FnGetIdList('PROCE');
	INSERT INTO Dbo.MOVFactura (id_tipodoc, id_centrocostos, fechafac, estado, id_tercero, iva, inc, descuento, subtotal, total, valorpagado, 
		totalcredito, id_resolucion, resolucion, consecutivo, prefijo, isFe,isPos, id_turno, cambio, id_ctaant, valoranticipo, cuotas, veninicial, dias, 
		id_tipovence, estadoFE, id_user, id_vendedor)
    SELECT 
	FR.id_tipodoc,
	FR.id_centrocostos,
	FR.fechafac, 
	@idestado,
	FR.id_tercero, 
	FR.iva,
	FR.inc,						
	FR.descuento, 
	FR.subtotal, 
	FR.total,
	0, 
	0,
	@id_resolucion			id_resolucion,
	@resolucion				resolucion,
	@consefac,
    @prefijo				prefijo,
	FR.isFe,
	0					    isPos,
	@id_turno,
	0,
	null,
	0,
	1				        cuotas,
	DATEADD(DAY,30,GETDATE()) veninicial,
	30					    dias,
	Dbo.ST_FnGetIdList('XDV')	id_tipovencto,
	Dbo.ST_FnGetIdList('PREVIA') estadofe,
	FR.id_user,
	FR.id_vendedor
	FROM [dbo].[MOVFacturasRecurrentes] FR  where id = @Id

	SET @id_return = SCOPE_IDENTITY();		
 
 
	 INSERT INTO [dbo].[MOVFacturaItems] (id_factura, id_producto, id_bodega, serie, lote, cantidad, costo, precio, preciodesc, descuentound, 
						pordescuento, descuento, id_ctaiva, poriva, iva, id_ctainc, porinc, inc, total, formulado, id_user, inventarial, id_itemtemp)

	SELECT  @id_return, FTR.id_producto, null, FTR.serie, FTR.lote, FTR.cantidad, FTR.costo, FTR.precio, FTR.preciodesc, FTR.descuentound,
				FTR.pordescuento, FTR.descuento, FTR.id_ctaiva, FTR.poriva, FTR.iva, FTR.id_ctainc, FTR.porinc, FTR.inc, FTR.total, FTR.formulado, FTR.id_user, FTR.inventarial,
				FTR.id_itemtemp
	FROM [dbo].[MOVFacturaRecurrentesItems] FTR where id_factura = @Id



		UPDATE Dbo.DocumentosTecnicaKey SET consecutivo = @consefac WHERE id = @id_resolucion AND id_ccosto = @id_cencostos AND isfe = @isfe;

		SELECT @id_return id, 'PROCESADO' estado ,@fechadoc fecha,@anomes anomes;

END
