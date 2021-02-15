--liquibase formatted sql
--changeset ,JTOUS:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FIN].[ST_MOVFacturarIntereses]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [FIN].[ST_MOVFacturarIntereses] 
GO

CREATE PROCEDURE [FIN].[ST_MOVFacturarIntereses] 
	@numfacturas VARCHAR(30) = '',
	@id_terceros BIGINT = 0,
	@fechas VARCHAR (10) = '20210228',
	@cuotas	INT = 0,
	@id_user  BIGINT = 1,
	@op CHAR(1) = 'G'
AS
/***************************************
*Nombre:		[Dbo].[ST_MOVFacturarIntereses]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creacion:		11/01/2021
*Desarrollador:  Jose Luis Tous Perez (jtous)
*Descripcion:	Se realizan EL PROCESO DE FACTURAR Los intereses Causados de las Facturas Financiadas.
***************************************/
DECLARE @periodo	BIGINT = 0,  @mensaje varchar(max), @anomes VARCHAR(6);
DECLARE @fechaperiodo SMALLDATETIME = GETDATE(), @fechaper VARCHAR(10), @fecha VARCHAR(10), @diascaus INT = 0, @count INT = 0, @rows INT = 1;
DECLARE @TableTemp TABLE (id BIGINT IDENTITY (1,1), numfactura VARCHAR(30), id_tercero BIGINT, cuota INT)
DECLARE @id_tercero BIGINT, @numfactura VARCHAR(30), @cuota INT

BEGIN TRY	
	
	IF(@op = 'G')
	BEGIN
		SET @diascaus = CAST(ISNULL((SELECT valor FROM Parametros WHERE codigo = 'DAYSCAUCATION'),0) AS INT);

		SELECT  @fechaper = CONVERT(VARCHAR(10), @fechaperiodo, 120), @anomes = CONVERT(VARCHAR(6), @fechaperiodo, 112), @fecha = CONVERT(VARCHAR(10), @fechaperiodo, 112)

		EXECUTE [Dbo].ST_ValidarPeriodo @fecha = @fechaper, @anomes = @anomes, @mod = 'C'

		INSERT @TableTemp (numfactura, id_tercero, cuota)
		SELECT numfactura, id_tercero, cuota
		FROM FIN.SaldoCliente_Cuotas
		WHERE InteresCausado = 0 AND DATEDIFF(DD, GETDATE(), vencimiento_cuota) <= @diascaus AND anomes = @anomes;
	
		SET @count = @@ROWCOUNT;

		WHILE(@rows <= @count)
		BEGIN
			SELECT @id_tercero = id_tercero, @numfactura = numfactura, @cuota = cuota FROM @TableTemp WHERE id = @rows;
		
			BEGIN TRY
				BEGIN TRAN
					EXECUTE [FIN].[ST_MOVFacturasCausacionInteres] 
						@numfactura = @numfactura,
						@id_tercero = @id_tercero,
						@fecha		= @fecha,
						@cuota		= @cuota,
						@id_user	= @id_user;
		
				COMMIT TRAN
			END TRY
			BEGIN CATCH	
				SET @mensaje = ERROR_MESSAGE() + ' Factura:('+@numfactura+') Cuota: '+CAST(@cuota AS VARCHAR) +' Tercero: '+CAST(@id_tercero AS VARCHAR);
				ROLLBACK TRAN;
				INSERT INTO [dbo].[LogContabilizacion] (TipoDoc, fecha, id_caja, id_doc, mensaje, id_user)
				VALUES('CAUINT', GETDATE(), NULL, NULL, @mensaje, 1);			
			END CATCH
			SET @rows += 1;
		END
	END
	ELSE IF(@op = 'C')
	BEGIN
		
		SELECT  @fechaper = CONVERT(VARCHAR(10), CAST(@fechas AS DATE), 120), @anomes = CONVERT(VARCHAR(6), @fechaperiodo, 112)

		EXECUTE [Dbo].ST_ValidarPeriodo @fecha = @fechaper, @anomes = @anomes, @mod = 'C'

		EXECUTE [FIN].[ST_MOVFacturasCausacionInteres] 
						@numfactura = @numfacturas,
						@id_tercero = @id_terceros,
						@fecha		= @fechas,
						@cuota		= @cuotas,
						@id_user	= @id_user;
	END
	
END TRY
BEGIN CATCH	
	SET @mensaje = 'Error: '+ERROR_MESSAGE();	
	RAISERROR(@Mensaje,16,0);
END CATCH
GO


