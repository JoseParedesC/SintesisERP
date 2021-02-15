--liquibase formatted sql
--changeset ,kmartinez:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MOVFacturasRecurrentes]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [dbo].[ST_MOVFacturasRecurrentes] 
GO

CREATE PROCEDURE [dbo].[ST_MOVFacturasRecurrentes] 
@id                 BIGINT,
@id_tipodoc			BIGINT,
@id_centrocostos	BIGINT,
@fechadoc			VARCHAR(10),
@id_tercero			BIGINT,
@id_formapagos		BIGINT = null,
@id_vendedor		BIGINT,
@anticipo			NUMERIC(18,2) = null ,
@idToken			VARCHAR(255),
@id_user			INT
 
 
AS
/***************************************
*Nombre:		[dbo].[ST_MOVFacturasRecurrentes] 
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		15/10/2020
*Desarrollador:  Kevin Jose Martinez Teheran
*Descripcion:	PROCESO DE FACTURAR RECURRENTES 
***************************************/
Declare @id_return INT, @idestado INT, @manejador int, @valortotal NUMERIC(18,4), @totalforma NUMERIC(18,4), @id_turno BIGINT, @anomes VARCHAR(6) = '';
Declare @resolucion VARCHAR(50), @id_resolucion bigint, @consefac int, @prefijo varchar(20), @mensaje varchar(max), @id_saldo BIGINT;
DECLARE @tableforma TABLE (id int identity (1,1), id_forma BIGINT, valor numeric(18,2), voucher varchar(200))
DECLARE @isfe INT = 0;
BEGIN TRY
BEGIN TRANSACTION

IF(Isnull(@id,0) = 0)
	BEGIN			
	
			SET @isfe = (SELECT CASE WHEN valor = 'S' THEN 1 ELSE 0 END FROM Parametros WHERE codigo = 'FACTURAELECTRO');

			SELECT TOP 1 @resolucion = resolucion, @id_resolucion = id_resolucion, @consefac = consecutivo, @prefijo = prefijo 
			FROM Dbo.ST_FnConsecutivoFactura(ISNULL(@id_centrocostos, 0), @isfe);	
	
			SET @anomes = CONVERT(VARCHAR(6), REPLACE(@fechadoc, '-', ''), 112);
		
			EXECUTE [Dbo].ST_ValidarPeriodo
			@fecha			= @fechadoc,
			@anomes			= @anomes,
			@mod			= 'I'

			SET @fechadoc = REPLACE(@fechadoc, '-', '');

			 SET @idestado = Dbo.ST_FnGetIdList('TEMP');
	 
			 SET @id_turno = (SELECT TOP 1 id_turno FROM Dbo.Usuarios WHERE id = @id_user);
	
			INSERT INTO [dbo].[MOVFacturasRecurrentes] (id_tipodoc, id_centrocostos, id_formapagos, fechafac, estado, id_tercero, iva, inc, descuento, subtotal, total, 
		    isFe, estadoFE, id_user, id_vendedor)
			SELECT 
			@id_tipodoc				id_tipo,
			@id_centrocostos		id_ccosto,
			@id_formapagos          id_formapagos,
			@fechadoc				fecha, 
			@idestado				estado,
			@id_tercero				id_terceo, 
			T.iva,
			T.inc,						
			T.descuentoart, 
			T.precio, 
			T.total,
		    @isfe,
		    Dbo.ST_FnGetIdList('PREVIA') estadofe,
			@id_user				id_user,
			@id_vendedor			id_vendedor
			FROM Dbo.ST_FnCalTotalFactura(@idToken, 0) T

			SET @id_return = SCOPE_IDENTITY();													
	
			INSERT INTO [dbo].[MOVFacturaRecurrentesItems] (id_factura, id_producto, id_bodega, serie, lote, cantidad, costo, precio, preciodesc, descuentound, 
							pordescuento, descuento, id_ctaiva, poriva, iva, id_ctainc, porinc, inc, total, formulado, id_user, inventarial, id_itemtemp)
			SELECT  @id_return, 
					T.id_articulo,
					T.id_bodega,
					T.serie,
					T.lote,
					T.cantidad, 
					ISNULL(E.costo, 0) costo,
					T.precio,
					T.preciodes,
					T.descuentound,
					T.pordescuento,
					T.descuento,
					C1.id_ctaventa id_ctaiva,
					T.poriva,
					T.iva,
					C2.id_ctaventa id_ctainc,
					T.porinc,
					T.inc,
					T.total,
					T.formulado,
					@id_user, 
					T.inventarial,
					T.id
			FROM [dbo].[MOVFacturaItemsTemp] T
				LEFT JOIN dbo.Existencia E ON T.id_articulo = E.id_articulo AND E.id_bodega = T.id_bodega
				LEFT JOIN CNT.Impuestos C1 ON  C1.id = T.id_iva
				LEFT JOIN CNT.Impuestos C2 ON C2.id = T.id_inc
			WHERE 
				id_factura = @idToken AND T.id_user = @id_user;
	
			 DELETE [dbo].[MOVFacturaItemsTemp]  WHERE id_factura = @idToken AND id_user = @id_user;
 
			SELECT @id_return id, 'PROCESADO' estado;

	
		 
	END
	ELSE
	BEGIN
		 SET @idestado = Dbo.ST_FnGetIdList('PROCE');
	 
	    UPDATE F
		SET id_tipodoc = @id_tipodoc,
			id_centrocostos = @id_centrocostos,
			--id_formapagos= @id_formapagos,
			--fechafac = @fechadoc, 
			--estado = @idestado,
			id_tercero = @id_tercero, 
			iva = T.iva,
			inc = T.inc,						
			descuento = T.descuentoart, 
			subtotal = T.precio, 
			total = T.total,
			--consecutivo = @consefac,
			--isFe = @isfe,
			--isPos = 0,
			--id_turno = @id_turno,
			--valoranticipo = 0,
			--estadoFE = Dbo.ST_FnGetIdList('PREVIA'),
			updated		= GETDATE(),
			--id_user = @id_user,
			id_vendedor = @id_vendedor
		    FROM [dbo].[MOVFacturasRecurrentes]  F  CROSS APPLY Dbo.[ST_FnCalTotalFacturaRecurrente](@id) T
		
		WHERE F.id = @id;
			
			SET @id_return = @id;		


			
			SELECT @id_return id, 'PROCESADO' estado;
	
	END

 
COMMIT TRANSACTION;
END TRY
BEGIN CATCH	
	ROLLBACK TRANSACTION;
	SET @mensaje = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@Mensaje,16,0);	
END CATCH