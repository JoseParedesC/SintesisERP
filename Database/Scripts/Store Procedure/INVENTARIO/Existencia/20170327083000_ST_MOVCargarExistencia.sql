--liquibase formatted sql
--changeset ,CZULBARAN:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MOVCargarExistencia]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MOVCargarExistencia]
GO
CREATE PROCEDURE [dbo].[ST_MOVCargarExistencia]
@Opcion VARCHAR(5),
@id BIGINT,
@id_user INT,
@id_bodega INT=NULL
--WITH ENCRYPTION
AS	
BEGIN TRY	
	Declare @tableent Table (id_pk int identity, id_art bigint);
	Declare @tableartbod Table (id_pk int identity, id_art bigint, id_bod bigint);
	Declare @rows int = 0, @count int = 1, @id_ent int,@mensaje varchar(max),@id_serie BIGINT,@numserie int;
	IF @Opcion = 'I'
	BEGIN
		Insert Into @tableent(id_art)
		Select id From [dbo].[MOVEntradasItemsTemp] Where id_entrada = @id AND inventarial != 0;

		Set @rows = @@ROWCOUNT;

		INSERT INTO @tableartbod (id_art, id_bod) 
		(SELECT DISTINCT 
				AT.id_articulo,
				@id_bodega
		FROM [dbo].[MOVEntradasItemsTemp] AT INNER JOIN dbo.Productos P on AT.id_articulo=P.id
		WHERE  NOT EXISTS
		(
			SELECT 1 FROM Dbo.Existencia WHERE id_articulo = AT.id_articulo AND id_bodega = @id_bodega
		) 
		AND AT.id_entrada = @id AND AT.inventarial != 0) ;
		
		INSERT INTO Dbo.Existencia (id_articulo, id_bodega, existencia, disponibilidad, costo, id_user)
		SELECT	
				id_art,
				id_bod,
				0.00,
				0.00,
				0.00, 
				@id_user
		FROM @tableartbod
		
		INSERT INTO [dbo].[ExistenciaLoteSerie] (id_lote, serie, existencia, id_existencia, id_user)
		
		SELECT id_lote, serie, existencia, id, @id_user 
		FROM 
		(
			SELECT Dbo.ST_FNGetIdLote(ISNULL(I.id_lote, ''), vencimientolote) id_lote, T.serie, 1 existencia, E.id
			FROM		[dbo].[MovEntradasSeriesTemp] T
			INNER JOIN  [MOVEntradasItemsTemp] I ON I.id = T.id_itemstemp		
			INNER JOIN  Existencia E ON E.id_articulo = I.id_articulo AND E.id_bodega = @id_bodega
			WHERE I.id_entrada = @id AND I.inventarial != 0 AND I.serie != 0

			UNION ALL

			SELECT DISTINCT Dbo.ST_FNGetIdLote(ISNULL(I.id_lote, ''), vencimientolote), '' serie, 0 existencia, E.id
			FROM		[MOVEntradasItemsTemp] I
			INNER JOIN  Existencia E ON E.id_articulo = I.id_articulo AND E.id_bodega = @id_bodega
			LEFT JOIN	[ExistenciaLoteSerie] S ON S.id_existencia = E.id AND S.id_lote = Dbo.ST_FNGetIdLote(ISNULL(I.id_lote, ''), vencimientolote)
			WHERE I.id_entrada = @id AND I.serie = 0 AND S.id IS NULL AND I.inventarial != 0 and I.lote=1
			GROUP BY I.id_lote, I.vencimientolote, E.id
		) AS T
 

		WHILE(@rows >= @count)
		BEGIN 
			SET @id_ent = (SELECT id_art FROM @tableent WHERE id_pk = @count);
					
			UPDATE E SET
					E.updated		= GETDATE(),
					E.existencia	= (E.existencia + AT.Cantidad), 				
					E.Costo			= CASE  WHEN E.existencia + Cantidad = 0 
											THEN E.costo
											ELSE CAST( (((AT.costo - AT.descuentound + AT.fleteund) * AT.cantidad) + (E.costo * E.existencia)) / (E.existencia + AT.cantidad) AS DECIMAL (18,2)) END
			FROM Dbo.Existencia E 
			INNER JOIN [dbo].[MOVEntradasItemsTemp] AT ON AT.id_articulo = E.id_articulo AND E.id_bodega = @id_bodega
			WHERE AT.id = @id_ent;

			UPDATE  S SET					
					S.existencia	+= AT.Cantidad
			FROM [dbo].[ExistenciaLoteSerie] S
			INNER JOIN Dbo.Existencia E  ON S.id_existencia = E.id 
			INNER JOIN [dbo].[MOVEntradasItemsTemp] AT ON AT.id_articulo = E.id_articulo 
														AND E.id_bodega = @id_bodega 
														AND S.id_lote = Dbo.ST_FNGetIdLote(ISNULL(AT.id_lote, ''), AT.vencimientolote)
			WHERE AT.id = @id_ent AND AT.serie = 0;

			SET @count += 1;
		End
	END
	ELSE IF @Opcion = 'R'
	BEGIN	

		INSERT INTO @tableent(id_art)
		SELECT id FROM [dbo].[MOVEntradasItems] WHERE id_entrada = @id  AND inventarial != 0;
		SET @rows = @@ROWCOUNT;

		WHILE(@rows >= @count)
		BEGIN 
			SET @id_ent = (SELECT id_art FROM @tableent WHERE id_pk = @count);
			
			UPDATE E SET	
						E.updated				= GETDATE(),
						E.existencia			-= AT.Cantidad, 					
						E.Costo					= CASE  WHEN E.existencia - AT.Cantidad = 0 
													THEN E.costo
													ELSE CAST( ((E.costo * E.existencia) - ((AT.costo - AT.descuentound + AT.fleteund) * AT.cantidad))/(E.existencia - AT.cantidad) AS DECIMAL (18,2)) END
			FROM Dbo.Existencia E 
			INNER JOIN [dbo].[MOVEntradasItems] AT ON AT.id_articulo = E.id_articulo AND E.id_bodega = AT.id_bodega
			WHERE AT.id = @id_ent;

			DELETE EL 
			FROM ExistenciaLoteSerie EL INNER JOIN 
			MovEntradasSeries ES ON ES.serie = EL.serie INNER JOIN
			MOVEntradasItems I ON I.id = ES.id_items
			WHERE I.id = @id_ent  AND I.inventarial != 0

			UPDATE  S SET					
					S.existencia	-= AT.Cantidad
			FROM [dbo].[ExistenciaLoteSerie] S
			INNER JOIN Dbo.Existencia E  ON S.id_existencia = E.id 
			INNER JOIN [dbo].[MOVEntradasItems] AT ON AT.id_articulo = E.id_articulo AND E.id_bodega = AT.id_bodega AND S.id_lote = AT.id_lote
			WHERE AT.id = @id_ent AND AT.serie = 0 AND AT.inventarial != 0;
			
			Set @count += 1;
		End
	END
	ELSE IF @Opcion = 'A'
	BEGIN
		Insert Into @tableent(id_art)
		Select id From [dbo].[MOVEntradasItemsTemp] Where id_entrada = @id AND inventarial != 0;

		Set @rows = @@ROWCOUNT;

	 
		INSERT INTO @tableartbod (id_art, id_bod) 
		(SELECT DISTINCT 
				AT.id_articulo,
				AT.id_bodega
		FROM [dbo].[MOVEntradasItemsTemp] AT INNER JOIN dbo.Productos P on AT.id_articulo=P.id
		WHERE NOT EXISTS
		(
			SELECT 1 FROM Dbo.Existencia WHERE id_articulo = AT.id_articulo AND id_bodega = At.id_bodega
		) 
		AND AT.id_entrada = @id AND AT.inventarial != 0) ;


		INSERT INTO Dbo.Existencia (id_articulo, id_bodega, existencia, disponibilidad, costo, id_user)
		SELECT	
				id_art,
				id_bod,
				0.00,
				0.00,
				0.00, 
				@id_user
		FROM @tableartbod
		
		INSERT INTO [dbo].[ExistenciaLoteSerie] (id_lote, serie, existencia, id_existencia, id_user)
		
		SELECT id_lote, serie, existencia, id, @id_user 
		FROM 
		(
			SELECT Dbo.ST_FNGetIdLote(ISNULL(I.id_lote, ''), vencimientolote) id_lote, T.serie, 1 existencia, E.id
			FROM		[dbo].[MovEntradasSeriesTemp] T
			INNER JOIN  [MOVEntradasItemsTemp] I ON I.id = T.id_itemstemp		
			INNER JOIN  Existencia E ON E.id_articulo = I.id_articulo AND E.id_bodega = i.id_bodega
			WHERE I.id_entrada = @id AND I.serie != 0 and I.cantidad > 0 AND I.inventarial != 0

		) AS T

			WHILE(@rows >= @count)
		BEGIN 
			SET @id_ent = (SELECT id_art FROM @tableent WHERE id_pk = @count);
			
			----Actualiza la tabla existencia
			UPDATE E SET
					E.updated		= GETDATE(),
					E.existencia	= (E.existencia + AT.Cantidad), 				
					E.Costo			= CASE  WHEN E.existencia + Cantidad = 0 
											THEN E.costo
											ELSE At.costo END
			FROM Dbo.Existencia E 
			INNER JOIN [dbo].[MOVEntradasItemsTemp] AT ON AT.id_articulo = E.id_articulo AND E.id_bodega = At.id_bodega
			WHERE AT.id = @id_ent;

			
			UPDATE EL SET 
						EL.existencia = 0 
			FROM   ExistenciaLoteSerie		EL INNER JOIN 
				   MovEntradasSeriesTemp		S ON S.serie = EL.serie INNER JOIN
				   [MOVEntradasItemsTemp]	I ON I.id = S.id_itemstemp
			WHERE I.id = @id_ent  AND I.serie != 0 AND I.inventarial != 0 AND I.cantidad<0;

			UPDATE  S SET					
					S.existencia	+= L.Cantidad
			FROM [dbo].[ExistenciaLoteSerie] S
			INNER JOIN Dbo.Existencia E  ON S.id_existencia = E.id 
			INNER JOIN [dbo].[MOVEntradasItemsTemp] AT ON AT.id_articulo = E.id_articulo AND E.id_bodega = AT.id_bodega
			INNER JOIN [dbo].MOVEntradaLotesTemp L ON At.id = L.id_itemtemp AND S.id_lote = L.id_lote
			WHERE AT.id = @id_ent AND AT.serie = 0 AND AT.inventarial != 0 and L.cantidad!=0;



			SET @count += 1;
		END			
	END

	--Revertir ajustes
	 ELSE IF @Opcion = 'AR'
	BEGIN	

		INSERT INTO @tableent(id_art)
		SELECT id FROM [dbo].[MOVAjustesItems] WHERE id_ajuste = @id  
		SET @rows = @@ROWCOUNT;

		WHILE(@rows >= @count)
		BEGIN 
			SET @id_ent = (SELECT id_art FROM @tableent WHERE id_pk = @count);
			
			UPDATE E SET	
						E.updated				= GETDATE(),
						E.existencia			-= AT.Cantidad, 					
						E.Costo					= CASE  WHEN E.existencia - AT.Cantidad = 0 
													THEN E.costo
													ELSE CAST( ((E.costo * E.existencia) - ((AT.costo) * AT.cantidad))/(E.existencia - AT.cantidad) AS DECIMAL (18,2)) END
			FROM Dbo.Existencia E 
			INNER JOIN [dbo].[MOVAjustesItems] AT ON AT.id_articulo = E.id_articulo AND E.id_bodega = AT.id_bodega
			WHERE AT.id = @id_ent;

			--VALIDACION SI TIENE MOVIMIENTO  EL PRODUCTO CON SERIE 
			SELECT TOP 1 @mensaje = 'Documento no se puede Revertir; el producto ' + P.nombre +' ha tenido movimiento con esta (' + ES.serie + ') serie' 
			FROM ExistenciaLoteSerie EL INNER JOIN 
			MovAjustesSeries ES ON ES.serie = EL.serie INNER JOIN
			MOVAjustesItems I ON I.id = ES.id_items INNER JOIN PRODUCTOS P  ON I.id_articulo=P.id
			WHERE I.id = @id_ent and El.existencia=0 AND I.cantidad > 0

			IF(ISNULL(@mensaje, '' ) != '')
			RAISERROR(@mensaje, 16, 0);


			--VALIDACION SI EL PRODUCTO TIENE PARA ASI ELIMINARLO AL REVERTIRLO
			SELECT TOP 1 @id_serie = EL.id, @numserie=(select count(*)  from MovAjustesSeries where serie =Es.serie) 
			FROM ExistenciaLoteSerie EL INNER JOIN 
			MovAjustesSeries ES ON ES.serie = EL.serie INNER JOIN
			MOVAjustesItems I ON I.id = ES.id_items INNER JOIN PRODUCTOS P  ON I.id_articulo=P.id
			WHERE I.id = @id_ent and El.existencia=1 AND I.cantidad > 0
			
			IF(@id_serie is not null and @numserie=1)
			DELETE FROM ExistenciaLoteSerie WHERE ID=@id_serie
			

			UPDATE EL SET EL.existencia = IIF(I.cantidad>0,0,1) 
			FROM ExistenciaLoteSerie EL INNER JOIN 
			MovAjustesSeries ES ON ES.serie = EL.serie INNER JOIN
			MOVAjustesItems I ON I.id = ES.id_items
			WHERE I.id = @id_ent

			UPDATE  S SET					
					S.existencia	-= L.Cantidad
			FROM [dbo].[ExistenciaLoteSerie] S
			INNER JOIN Dbo.Existencia E  ON S.id_existencia = E.id 
			INNER JOIN [dbo].[MOVAjustesItems] AT ON AT.id_articulo = E.id_articulo AND E.id_bodega = AT.id_bodega 
			INNER JOIN DBO.MovAjustesLotes AS L ON S.id_lote=L.id_lote and AT.id=L.id_item
			WHERE AT.id = @id_ent AND AT.serie = 0;
			
			Set @count += 1;
		End
	END
	
	-- Cuando se realiza un devolucion de compras
	ELSE IF @Opcion = 'DI'
	BEGIN	

		INSERT INTO @tableent(id_art)
		SELECT id FROM [dbo].[MOVEntradasItemsTemp] WHERE id_entrada = @id AND inventarial != 0 AND selected != 0;
		SET @rows = @@ROWCOUNT;

		WHILE(@rows >= @count)
		BEGIN 
			SET @id_ent = (SELECT id_art FROM @tableent WHERE id_pk = @count);
			
			UPDATE E SET	
				E.updated		= GETDATE(),
				E.existencia	= (E.existencia - AT.Cantidaddev), 
				E.Costo			= CASE  WHEN E.existencia - AT.Cantidaddev = 0 
									THEN E.costo
									ELSE CAST( ((E.costo * E.existencia) - ((AT.costo - AT.descuentound) * AT.cantidaddev))/(E.existencia - AT.cantidaddev) AS DECIMAL (18,2)) END
			FROM Dbo.Existencia E 
			INNER JOIN [dbo].[MOVEntradasItemsTemp] AT ON AT.id_articulo = E.id_articulo AND E.id_bodega = AT.id_bodega
			WHERE AT.id = @id_ent;

			UPDATE EL SET EL.existencia = 0 
			FROM ExistenciaLoteSerie	EL INNER JOIN 
			MovEntradasSeries			ES ON ES.serie = EL.serie INNER JOIN
			MOVEntradasItemsTemp		I  ON I.id_itementra = ES.id_items INNER JOIN
			MovEntradasSeriesTemp		S  ON S.id_itemstemp = I.id AND S.serie = EL.serie
			WHERE I.id = @id_ent  AND I.inventarial != 0 AND S.selected != 0

			UPDATE  S SET					
					S.existencia	-= AT.Cantidaddev
			FROM [dbo].[ExistenciaLoteSerie] S
			INNER JOIN Dbo.Existencia E  ON S.id_existencia = E.id 
			INNER JOIN [dbo].[MOVEntradasItemsTemp] AT ON AT.id_articulo = E.id_articulo AND E.id_bodega = AT.id_bodega 
														  AND S.id_lote = DBO.ST_FNGetIdLote(ISNULL(AT.id_lote, ''), AT.vencimientolote)
			WHERE AT.id = @id_ent AND AT.serie = 0 AND AT.inventarial != 0;

			Set @count += 1;
		End
	END
	ELSE IF(@Opcion = 'TL')
	BEGIN
	Insert Into @tableent(id_art)
		Select id From [dbo].[MOVEntradasItemsTemp] Where id_entrada = @id AND inventarial != 0;

		Set @rows = @@ROWCOUNT;

		INSERT INTO @tableartbod (id_art, id_bod) 
		(SELECT DISTINCT 
				AT.id_articulo,
				AT.id_bodegadest
		FROM [dbo].[MOVEntradasItemsTemp] AT INNER JOIN dbo.Productos P on AT.id_articulo=P.id
		WHERE  NOT EXISTS
		(
			SELECT 1 FROM Dbo.Existencia WHERE id_articulo = AT.id_articulo AND id_bodega = AT.id_bodegadest
		) 
		AND AT.id_entrada = @id AND AT.inventarial != 0) ;
		
		INSERT INTO Dbo.Existencia (id_articulo, id_bodega, existencia, disponibilidad, costo, id_user)
		SELECT	
				id_art,
				id_bod,
				0.00,
				0.00,
				0.00, 
				@id_user
		FROM @tableartbod
		
		INSERT INTO [dbo].[ExistenciaLoteSerie] (id_lote, serie, existencia, id_existencia, id_user)
		
		SELECT id_lote, serie, existencia, id, @id_user 
		FROM 
		(
			SELECT Dbo.ST_FNGetIdLote(ISNULL(I.id_lote, ''), vencimientolote) id_lote, T.serie, 1 existencia, E.id
			FROM		[dbo].[MovEntradasSeriesTemp] T
			INNER JOIN  [MOVEntradasItemsTemp] I ON I.id = T.id_itemstemp		
			INNER JOIN  Existencia E ON E.id_articulo = I.id_articulo AND E.id_bodega = I.id_bodegadest
			WHERE I.id_entrada = @id AND I.inventarial != 0 AND I.serie != 0

			UNION ALL

			SELECT L.id_lote,'' serie,0 existencia,E.id  from MOVEntradasItemsTemp I
			INNER JOIN  [MOVEntradaLotesTemp] L ON I.id = L.id_itemtemp
			INNER JOIN  [LotesProducto] LP ON L.id_lote=LP.id 
			INNER JOIN  Existencia E ON E.id_articulo = I.id_articulo AND E.id_bodega = I.id_bodegadest
			LEFT JOIn ExistenciaLoteSerie ES ON ES.id_existencia=E.id AND L.id_lote=Es.id_lote
			WHERE i.id_entrada = @id AND I.serie = 0 AND I.inventarial != 0 AND ES.id is null
		) AS T

		/*Se recorre los items y se descuentas  de existencias y en existenciaserielotes de la bodega origen*/
		While(@rows >= @count)
		Begin 
			Select @id_ent = id_art From @tableent Where id_pk = @count;
			--Se resta de la bodega origen la cantidad enviada
			UPDATE E SET	
						E.updated				= GETDATE(),
						E.existencia			-= AT.Cantidad, 					
						E.Costo					= CASE  WHEN E.existencia - AT.Cantidad = 0 
												  THEN E.costo
												  ELSE CAST( ((E.costo * E.existencia) - (AT.costo * AT.cantidad)) / (E.existencia - AT.cantidad) AS DECIMAL (18,2)) END
			FROM Dbo.Existencia E 
			INNER JOIN [dbo].[MOVEntradasItemsTemp] AT ON AT.id_articulo = E.id_articulo AND E.id_bodega = AT.id_bodega
			WHERE AT.id = @id_ent;

			--SE elimina de existencialoteserie la serie que se traslada desde la bodega origen
			DELETE FROM ExistenciaLoteSerie WHERE ID in(
			SELECT EL.id FROM   ExistenciaLoteSerie		EL INNER JOIN 
				   MovEntradasSeriesTemp		S ON S.serie = EL.serie INNER JOIN
				   [MOVEntradasItemsTemp]	I ON I.id = S.id_itemstemp INNER JOIN
				   Existencia E ON E.id=EL.id_existencia and E.id_bodega =I.id_bodega
			WHERE I.id = @id_ent  AND I.inventarial != 0 AND I.serie != 0)
			
			--Se resta la cantidad para los que manejan Lotes
			UPDATE  S SET					
					S.existencia	-= L.cantidad
			FROM [dbo].[ExistenciaLoteSerie] S
			INNER JOIN Dbo.Existencia E  ON S.id_existencia = E.id 
			INNER JOIN [dbo].[MOVEntradasItemsTemp] AT ON AT.id_articulo = E.id_articulo AND E.id_bodega = AT.id_bodega
			INNER JOIN [dbo].MOVEntradaLotesTemp L ON At.id = L.id_itemtemp AND S.id_lote = L.id_lote
			WHERE AT.id = @id_ent AND AT.serie = 0 AND AT.inventarial != 0;

			/*sumar existencia a la bodega destino*/
			UPDATE E SET
					E.updated		= GETDATE(),
					E.existencia	= (E.existencia + AT.Cantidad), 				
					E.Costo			= CASE  WHEN E.existencia + Cantidad = 0 
											THEN E.costo
											ELSE CAST( (((AT.costo - AT.descuentound + AT.fleteund) * AT.cantidad) + (E.costo * E.existencia)) / (E.existencia + AT.cantidad) AS DECIMAL (18,2)) END
			FROM Dbo.Existencia E 
			INNER JOIN [dbo].[MOVEntradasItemsTemp] AT ON AT.id_articulo = E.id_articulo AND E.id_bodega = AT.id_bodegadest
			WHERE AT.id = @id_ent;

			--Se suma a la bodega destino la cantidad 
			UPDATE  S SET					
				S.existencia	+= EL.cantidad
			FROM [dbo].[ExistenciaLoteSerie] S
			INNER JOIN Dbo.Existencia E  ON S.id_existencia = E.id 
			INNER JOIN [dbo].[MOVEntradasItemsTemp] AT ON AT.id_articulo = E.id_articulo 
														AND E.id_bodega = AT.id_bodegadest 
														INNER JOIN Dbo.MOVEntradaLotesTemp EL ON AT.id=EL.id_itemtemp and S.id_lote=El.id_lote
														WHERE AT.id = @id_ent AND AT.serie = 0;
			
			Set @count += 1;
		End
 
	END IF @Opcion = 'RTL'
	BEGIN	
	
		INSERT INTO @tableent(id_art)
		SELECT id FROM [dbo].[MOVTrasladosItems] WHERE id_traslado = @id ;
		SET @rows = @@ROWCOUNT;

		WHILE(@rows >= @count)
		BEGIN 
			SET @id_ent = (SELECT id_art FROM @tableent WHERE id_pk = @count);

			/*Devuelvo la existencia de la bodega origen*/
			UPDATE E SET	
						E.updated				= GETDATE(),
						E.existencia			+= AT.Cantidad, 					
						E.Costo					= CASE  WHEN E.existencia - AT.Cantidad = 0 
													THEN E.costo
													ELSE CAST( ((E.costo * E.existencia) - ((AT.costo - 0 + 0) * AT.cantidad))/(E.existencia - AT.cantidad) AS DECIMAL (18,2)) END
			FROM Dbo.Existencia E 
			INNER JOIN [dbo].[MOVTrasladosItems] AT ON AT.id_articulo = E.id_articulo AND E.id_bodega = AT.id_bodega
			WHERE AT.id = @id_ent;

			--Se resta la existencia en la bodega destino
			UPDATE E SET	
						E.updated				= GETDATE(),
						E.existencia			-= AT.Cantidad, 					
						E.Costo					= CASE  WHEN E.existencia - AT.Cantidad = 0 
													THEN E.costo
													ELSE CAST( ((E.costo * E.existencia) - ((AT.costo - 0 + 0) * AT.cantidad))/(E.existencia - AT.cantidad) AS DECIMAL (18,2)) END
			FROM Dbo.Existencia E 
			INNER JOIN [dbo].[MOVTrasladosItems] AT ON AT.id_articulo = E.id_articulo AND E.id_bodega = AT.id_bodegades
			WHERE AT.id = @id_ent;

			--Se devuelve existencia a series de bodega origen
			INSERT INTO [dbo].[ExistenciaLoteSerie] (id_lote, serie, existencia, id_existencia, id_user)
			SELECT El.id_lote,EL.serie,1,E2.id,@id_user FROM ExistenciaLoteSerie EL INNER JOIN 
			MOVTrasladosSeries ES ON ES.serie = EL.serie INNER JOIN
			MOVTrasladosItems I ON I.id = ES.id_items INNER JOIN
			Existencia E ON EL.id_existencia=E.id AND E.id_bodega=I.id_bodegades
			Inner JOIN Existencia E2 ON E2.id_articulo=I.id_articulo and E2.id_bodega=I.id_bodega
			WHERE I.id = @id_ent  and I.serie=1

			--Se Elimina las series de Bodega destino
			DELETE from ExistenciaLoteSerie WHERE
			id IN (SELECT EL.id FROM ExistenciaLoteSerie EL INNER JOIN 
			MOVTrasladosSeries ES ON ES.serie = EL.serie INNER JOIN
			MOVTrasladosItems I ON I.id = ES.id_items INNER JOIN 
			Existencia E ON EL.id_existencia=E.id AND E.id_bodega=I.id_bodegades
			WHERE I.id = @id_ent and I.serie=1)  

			--Se le adiciona la cantidad a la bodega de origen
			UPDATE  S SET					
					S.existencia	+= L.Cantidad
			FROM [dbo].[ExistenciaLoteSerie] S
			INNER JOIN Dbo.Existencia E  ON S.id_existencia = E.id 
			INNER JOIN [dbo].[MOVTrasladosItems] AT ON AT.id_articulo = E.id_articulo AND E.id_bodega = AT.id_bodega
			INNER JOIN dbo.MOVTrasladosLotes L ON S.id_lote=L.id_lote  and AT.id=L.id_item
			WHERE AT.id = @id_ent AND AT.serie = 0;
			
			--Se resta la cantidad a la bodega destino
			UPDATE  S SET					
					S.existencia	-= L.Cantidad
			FROM [dbo].[ExistenciaLoteSerie] S
			INNER JOIN Dbo.Existencia E  ON S.id_existencia = E.id 
			INNER JOIN [dbo].[MOVTrasladosItems] AT ON AT.id_articulo = E.id_articulo AND E.id_bodega = AT.id_bodegades
			INNER JOIN dbo.MOVTrasladosLotes L ON S.id_lote=L.id_lote  and AT.id=L.id_item
			WHERE AT.id = @id_ent AND AT.serie = 0;
			
			
			Set @count += 1;


		END

	END
	
	ELSE IF @Opcion = 'RDI'--Cuando se revierte una devolucion de compras
	BEGIN	

		Insert Into @tableent(id_art)
		Select id From [dbo].[MOVDevEntradasItems] Where id_devolucion = @id;
		Set @rows = @@ROWCOUNT;

		While(@rows >= @count)
		Begin 
			Set @id_ent = (Select id_art From @tableent Where id_pk = @count);
			
			UPDATE E SET	
						E.updated				= GETDATE(),
						E.existencia			= (E.existencia + AT.Cantidad), 
						E.Costo					= CASE  WHEN E.existencia + Cantidad = 0 
													THEN 0.00
													ELSE CAST( ((AT.costo *AT.cantidad) + (E.costo * E.existencia))/(E.existencia + AT.cantidad) AS DECIMAL (18,2)) END
			FROM Dbo.Existencia E 
			INNER JOIN [dbo].[MOVDevEntradasItems] AT  ON AT.id_articulo = E.id_articulo AND E.id_bodega = AT.id_bodega
			WHERE AT.id = @id_ent;

			UPDATE EL SET EL.existencia = 1 
			FROM ExistenciaLoteSerie	EL INNER JOIN 
			MovDevEntradasSeries			ES ON ES.serie = EL.serie and ES.serie=El.serie INNER JOIN
			MOVDevEntradasItems		I  ON I.id = ES.id_items 
			WHERE I.id=@id_ent

			UPDATE  S SET					
					S.existencia	+= AT.cantidad
			FROM [dbo].[ExistenciaLoteSerie] S
			INNER JOIN Dbo.Existencia E  ON S.id_existencia = E.id 
			INNER JOIN [dbo].[MOVDevEntradasItems] AT ON AT.id_articulo = E.id_articulo AND E.id_bodega = AT.id_bodega 
														  AND S.id_lote = AT.id_lote
			WHERE AT.id=@id_ent AND AT.serie = 0  and At.lote=1

			

			Set @count += 1;
		End
	END
	ELSE IF(@Opcion = 'ZU')
	BEGIN
		INSERT INTO @tableent(id_art)
		SELECT id FROM [dbo].[MOVConversionesItems] WHERE id_conversion = @id  --AND inventarial != 0;
		SET @rows = @@ROWCOUNT;

		WHILE(@rows >= @count)
		BEGIN 
			SET @id_ent = (SELECT id_art FROM @tableent WHERE id_pk = @count);
			
			UPDATE E SET	
						E.updated				= GETDATE(),
						E.existencia			-= AT.Cantidad, 					
						E.Costo					= CASE  WHEN E.existencia - AT.Cantidad = 0 
													THEN E.costo
													ELSE CAST( ((E.costo * E.existencia) - ((AT.costo) * AT.cantidad))/(E.existencia - AT.cantidad) AS DECIMAL (18,2)) END
			FROM Dbo.Existencia E 
			INNER JOIN [dbo].[MOVConversionesItems] AT ON AT.id_articulo = E.id_articulo AND E.id_bodega = AT.id_bodega
			WHERE AT.id = @id_ent;

			DELETE EL 
			FROM ExistenciaLoteSerie EL INNER JOIN 
			MOVConversionesItemsSeries ES ON ES.serie = EL.serie INNER JOIN
			MOVConversionesItems I ON I.id = ES.id_producto
			WHERE I.id = @id_ent  

			UPDATE  S SET					
					S.existencia	-= AT.Cantidad
			FROM [dbo].[ExistenciaLoteSerie] S
			INNER JOIN Dbo.Existencia E  ON S.id_existencia = E.id 
			INNER JOIN [dbo].MOVConversionesItems AT ON AT.id_articulo = E.id_articulo AND E.id_bodega = AT.id_bodega 
			WHERE AT.id = @id_ent 
			
			Set @count += 1;
		END
	END
END TRY
BEGIN CATCH
	DECLARE @Mensajee varchar(max) = (select ERROR_MESSAGE())
	RAISERROR(@Mensajee,16,0);
END CATCH

GO


