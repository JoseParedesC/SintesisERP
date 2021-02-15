--liquibase formatted sql
--changeset ,CZULBARAN:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MOVCargarExistenciaFac]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [dbo].[ST_MOVCargarExistenciaFac]   
GO
CREATE PROCEDURE [dbo].[ST_MOVCargarExistenciaFac]
@Opcion		VARCHAR(5),
@id			BIGINT,
@id_factura VARCHAR(MAX),
@id_user	INT
--WITH ENCRYPTION
AS	
BEGIN TRY	
	Declare @tableent Table (id_pk int identity, id_art bigint, formulado bit);
	Declare @rows int = 0, @count int = 1, @id_ent int, @formulado bit,@factuformula int=0;
	IF @Opcion = 'I'
	BEGIN
		Insert Into @tableent(id_art, formulado)
		Select id, formulado From [dbo].[MOVFacturaItemsTemp] Where id_factura = @id_factura;

		Set @rows = @@ROWCOUNT;
		
		While(@rows >= @count)
		Begin 
			Select @id_ent = id_art, @formulado = formulado From @tableent Where id_pk = @count;

			UPDATE E SET	
						E.updated				= GETDATE(),
						E.existencia			-= AT.Cantidad										
			FROM Dbo.Existencia E 
			INNER JOIN [dbo].[MOVFacturaItemsTemp] AT ON AT.id_articulo = E.id_articulo AND E.id_bodega = AT.id_bodega
			WHERE AT.id = @id_ent;

			UPDATE EL SET 
						EL.existencia = 0 
			FROM   ExistenciaLoteSerie		EL INNER JOIN 
				   MovFacturaSeriesTemp		S ON S.serie = EL.serie INNER JOIN
				   [MOVFacturaItemsTemp]	I ON I.id = S.id_itemstemp
			WHERE I.id = @id_ent  AND I.inventarial != 0 AND I.serie != 0;

			UPDATE  S SET					
					S.existencia	-= L.Cantidad
			FROM [dbo].[ExistenciaLoteSerie] S
			INNER JOIN Dbo.Existencia E  ON S.id_existencia = E.id 
			INNER JOIN [dbo].[MOVFacturaItemsTemp] AT ON AT.id_articulo = E.id_articulo AND E.id_bodega = AT.id_bodega
			INNER JOIN [dbo].MOVFacturaLotesTemp L ON At.id = L.id_itemtemp AND S.id_lote = L.id_lote
			WHERE AT.id = @id_ent AND AT.serie = 0 AND AT.inventarial != 0;
			
			Set @count += 1;
		End
		
	END
	
	ELSE IF @Opcion = 'D'
	BEGIN	

		Insert Into @tableent(id_art, formulado)
		Select id, formulado From [dbo].[MOVFacturaItemsTemp] Where id_factura = @id_factura AND selected=1;
	
		Set @rows = @@ROWCOUNT;

		
		While(@rows >= @count)
		Begin 			
			Select @id_ent = id_art, @formulado = formulado From @tableent Where id_pk = @count;

		UPDATE E SET	
				E.updated		= GETDATE(),
				E.existencia	= (E.existencia + AT.Cantidaddev), 
				E.Costo			= CASE  WHEN E.existencia + Cantidad = 0 
											THEN E.costo
											ELSE CAST( (((AT.costo - AT.descuentound) * AT.cantidad) + (E.costo * E.existencia)) / (E.existencia + AT.cantidad) AS DECIMAL (18,2)) END
			FROM Dbo.Existencia E 
			INNER JOIN [dbo].[movFacturaItemsTemp] AT ON AT.id_articulo = E.id_articulo AND E.id_bodega = AT.id_bodega
			WHERE AT.id = @id_ent;

			UPDATE EL SET EL.existencia = 1
			FROM ExistenciaLoteSerie	EL INNER JOIN 
			MovFacturaSeries			ES ON ES.serie = EL.serie INNER JOIN
			MOVFacturaItemsTemp		I  ON I.id_itemFac = ES.id_items INNER JOIN
			MovFacturaSeriesTemp		S  ON S.id_itemstemp = I.id AND S.serie = EL.serie
			WHERE I.id = @id_ent  AND I.inventarial != 0 AND S.selected != 0

			UPDATE  S SET					
					S.existencia	+= LO.cantidaddev
			FROM [dbo].[ExistenciaLoteSerie] S
			INNER JOIN Dbo.Existencia E  ON S.id_existencia = E.id 
			INNER JOIN [dbo].MOVFacturaItemsTemp AT ON AT.id_articulo = E.id_articulo AND E.id_bodega = AT.id_bodega 
			INNER JOIN dbo.MOVFacturaLotesTemp LO ON S.id_lote=Lo.id_lote AND LO.id_itemtemp=At.id
			WHERE AT.id = @id_ent AND AT.serie = 0 AND AT.inventarial != 0;

			Set @count += 1;
		End
	END
	ELSE IF(@Opcion = 'Z')
	BEGIN
	
		INSERT INTO @tableent(id_art)
		SELECT id FROM [dbo].[MOVConversionesItemsForm] WHERE id_conversion = @id
	
		SET @rows = @@ROWCOUNT;
		
		WHILE(@rows >= @count)
		BEGIN 			
			SELECT @id_ent = id_art FROM @tableent WHERE id_pk = @count;
			
			UPDATE  E SET	
					E.updated		= GETDATE(),
					E.existencia	= (E.existencia + AT.cantidad), 
					E.Costo			= CASE  WHEN (E.existencia + Cantidad) = 0 
											THEN E.costo
											ELSE CAST( (((AT.costo) * AT.cantidad) + (E.costo * E.existencia)) / (E.existencia + AT.cantidad) AS DECIMAL (18,2)) END
			FROM Dbo.Existencia E 
			INNER JOIN [dbo].MOVConversionesItemsForm AT ON AT.id_articulo = E.id_articulo AND E.id_bodega = AT.id_bodega
			WHERE AT.id = @id_ent;

			UPDATE EL SET EL.existencia = 1
			FROM ExistenciaLoteSerie	EL INNER JOIN 
			Existencia					E ON E.id = EL.id_existencia INNER JOIN 
			MOVConversionesItemsForm	I  ON I.id_articulo = E.id_articulo AND E.id_bodega = I.id_bodega INNER JOIN
			MOVConversionesItemsSeriesForm SE ON I.id = SE.id_producto AND SE.serie = EL.serie AND I.id_conversion = SE.id_conversion
			WHERE I.id = @id_ent ANd I.serie != 0

			SET @count += 1;
		End
	END			   
END TRY
BEGIN CATCH
	DECLARE @Mensajee varchar(max) = (select ERROR_MESSAGE())
	RAISERROR(@Mensajee,16,0);
END CATCH
GO


