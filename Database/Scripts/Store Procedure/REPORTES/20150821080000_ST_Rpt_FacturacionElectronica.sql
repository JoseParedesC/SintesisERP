--liquibase formatted sql
--changeset ,JTOUS:4 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_Rpt_FacturacionElectronica]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_Rpt_FacturacionElectronica]
GO

CREATE PROCEDURE [dbo].[ST_Rpt_FacturacionElectronica] 
@id INT,
@op char(1)

AS
/***************************************
*Nombre:		[Dbo].[ST_Rpt_FacturacionElectronica]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		21/08/2015
*Desarrollador:  Jose Luis Tous Pérez (jtous)
*Descripcion:	Se realizan la consulta de la informacion del reporte de factura de pago caja tirilla
***************************************/
BEGIN
Declare @error varchar(max);
DECLARE @cufeimp	VARCHAR (1000), @keyid varchar(250), @nit varchar(20) = ''
DECLARE @valores VARCHAR(max)
BEGIN TRY		
SET LANGUAGE Spanish
		
		IF (@op = 'C')
		BEGIN		
				
			SET @keyid = (SELECT TOP 1 Keyid FROM MovFactura WHERE id = @id);
			SET @nit = (SELECT TOP 1 nit FROM Empresas);
			
			DECLARE @cuotas INT 
			SET @cuotas = (SELECT COUNT(1) FROM  MovFacturaCuotas WHERE id_factura =  @id);

			SET @cufeimp = (
			SELECT  'NumeFac: '+prefijo+ CAST(ConsecutivoFacturacion AS VARCHAR)	+ CHAR(13) + CHAR(10)
					+'Fecfac: '+ CONVERT(VARCHAR(10), FechaFacturacion, 120)		+ CHAR(13) + CHAR(10)
					+'HorFac: '+ HoraFactura + '-05:00'								+ CHAR(13) + CHAR(10)
					+'NicFac: '+ @Nit												+ CHAR(13) + CHAR(10)
					+'DocAdq: ' +identficacionc											+ CHAR(13) + CHAR(10)
					+'ValFac: ' + CAST (CAST(SUM(ValorUnitarioADscto * cantidada) AS DECIMAL(18,2)) AS VARCHAR)	+ CHAR(13) + CHAR(10)
					+'ValIva: ' + CAST(CAST(SUM(IVAA * CantidadA) AS DECIMAL(18,2)) AS VARCHAR)				+ CHAR(13) + CHAR(10)
					+'ValOtroIm: '+CAST(CAST(SUM(INCA * CantidadA) AS DECIMAL(18,2)) AS VARCHAR)			+ CHAR(13) + CHAR(10)
					+'ValTolFac: ' + CAST(CAST(SUM(TotalA * CantidadA) AS DECIMAL(18,2)) AS VARCHAR)		+ CHAR(13) + CHAR(10)
					+'CUFE: '+ cufe
			FROM [FE].[VW_FacturaFE] AS factura 
			WHERE tipodocumento = 1 AND keyid = @keyid
			GROUP BY prefijo, ConsecutivoFacturacion, FechaFacturacion, HoraFactura, identficacionc, cufe)	

			SELECT 
				id
				,estado	
				,prefijo	
				,consecutivo	
				,resolucion	
				,leyenda	
				,fechadoc
				,iden						
				,cliente	
				,direccion	
				,telefono
				,correo				
				,ciudad	
				,ssubtotal	
				,subtotal	
				,descuento
				,iva	
				,inc	
				,total	
				,moneda	
				,relacionado	
				,'EFECTIVO' modalidad	
				,username usuario
				,vendedor nomusuario
				,'' detalle				
				,[dbo].ST_FNCantidadConLetra(total) totalletra
				,@cufeimp  cufeimp
				,cufe 
				,ISNULL(@cuotas,0) cuotas
				,cambio
				,fechavence
				,anticipo
				,dsctoFinanciero descuentogen
			FROM [VW_MOVFacturas] 
			WHERE id = @id;
		
		END
		ELSE IF (@op = 'I')
		BEGIN
				SELECT 
					 I.id
					,I.codigo
					,I.descripcion detalleconcepto
					,cantidad
					,(I.preciodesc +I.descuentound) valor
					,I.porinc porinc
					,I.poriva poriva
					,I.pordescuento pordcto
					,I.descuentound descuento
					,I.descuento * I.cantidad tdescuento
					,I.preciobruto
					,I.total totalA
					,I.total
				FROM [dbo].VW_movfacturaitems I
				WHERE I.id_factura = @id				
				
		END
		ELSE IF (@op = 'F')
		BEGIN	
		
			;WITH CTE (forma, valor, voucher)
			AS (	
				SELECT F.nombre forma, M.valor, M.voucher 
				FROM MOVFacturaFormaPago M
				INNER JOIN FormaPagos F ON F.id = M.id_formapago
				WHERE id_factura = @id
				UNION ALL
				SELECT 'Anticipo', F.valoranticipo, ''
				FROM Dbo.MOVFactura F 
				WHERE F.id = @id
			) 
			SELECT UPPER(forma) forma, valor, voucher FROM CTE 
			WHERE valor > 0 ORDER BY forma ASC
		END
		IF(@op = 'S')
		BEGIN
			SELECT @valores= COALESCE(@valores + ', ', '') + serie FROM Dbo.MovFacturaSeries
			WHERE id_items = @id;
			SELECT @valores as serie
		END
	/*	IF (@op = 'D')
		BEGIN
			SELECT 
				F.id
				,F.estado	
				,F.prefijo	
				,F.consecutivo	
				,F.resolucion	
				,F.leyenda	
				,F.fechadoc	
				,F.cnombre	
				,F.cliente	
				,F.direccion	
				,F.telefono	
				,F.ciudad	
				,F.ssubtotal	
				,F.subtotal	
				,F.descuento
				,F.iva	
				,F.inc	
				,F.total	
				,F.moneda	
				,F.modalidad	
				,F.usuario
				,F.detalle				
				,[dbo].ST_FNCantidadConLetra(F.total) totalletra
				,D.cufe cufefac
				,D.prefijo + '-' + D.consecutivo relacionado
				,porretefuente
				,porreteica
				,porreteiva
				,retefuente *-1 retefuente
				,reteica *-1 reteica
				,reteiva *-1 reteiva
			FROM VW_FacturacionDevoluciones F
			INNER JOIN DocumentosFacturacion D ON D.id_factura = F.id_factura AND D.tipodocumento = 1
			WHERE F.id = @id;
		END
		ELSE IF (@op = 'A')
		BEGIN
			SELECT 
				C.codigo
				,I.detalleconcepto
				,cantidad
				,I.valor
				,I.porinc
				,I.poriva
				,0.00 descuento
				,I.total
			FROM [dbo].[FacturacionDevConceptos] I
			INNER JOIN VW_Conceptos C ON C.id = I.id_concepto 
			WHERE id_devolucion = @id
		END
		*/
END TRY
BEGIN Catch
	    --Getting the error description
	    Select @error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	    -- save the error in a Log file
	    RaisError(@error,16,1)
	    Return  
	End Catch
END

GO


