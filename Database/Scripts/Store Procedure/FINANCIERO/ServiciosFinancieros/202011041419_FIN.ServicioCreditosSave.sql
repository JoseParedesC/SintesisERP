--liquibase formatted sql
--changeset ,kmartinez:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FIN].[ServicioCreditosSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [FIN].[ServicioCreditosSave]
GO

CREATE PROCEDURE [FIN].[ServicioCreditosSave]
	@id_servicios 		[BIGINT],
	@idservi            [BIGINT],
	@servicio 		    [VARCHAR](50),
	@porcentaje			NUMERIC(18,2),
    @id_user			[INT]
		 
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[FIN].[ServicioCreditosSave]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		27/10/2020
*Desarrollador: (Kmartinez)
*Descripcion: Este Store proc sirve para agregar nuevos servicios
***************************************/
DECLARE @error VARCHAR(MAX), @id_return INT;

BEGIN TRY
BEGIN TRAN

 IF(Isnull(@idservi, 0) != 0)
	BEGIN
			 
	  UPDATE F
		SET F.id_financiero = @servicio,
			F.porcentaje = @porcentaje 
		    FROM [FIN].[Financiero_lineacreditos] F WHERE F.id = @idservi;
			
			SET @id_return = @idservi;		
			SELECT @id_return id, 'PROCESADO' estado;			
	
	END
	ELSE
	BEGIN
	 INSERT INTO [FIN].[Financiero_lineacreditos](id_financiero, id_lineascredito, porcentaje)
				VALUES(@servicio, @id_servicios, @porcentaje);				
	
	SET @id_return =  SCOPE_IDENTITY();

    SELECT @id_return id, 'PROCESADO' estado
	
	END

COMMIT TRAN;
END TRY
BEGIN CATCH
		ROLLBACK TRAN;
	    --Getting the error description
	    SELECT @error   =  ERROR_MESSAGE()
	    -- save the error in a Log file
	    RAISERROR(@error,16,1);
	    RETURN  
END CATCH
