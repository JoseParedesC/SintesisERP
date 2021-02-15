--liquibase formatted sql
--changeset ,kmartinez:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FIN].[ServiciosFinancieros]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [FIN].[ServiciosFinancieros]
GO

CREATE PROCEDURE [FIN].[ServiciosFinancieros]
    @id                 [BIGINT] = null,
	@codigo 			[VARCHAR](50),
	@nombre 		    [VARCHAR](50),
	@id_ctaant			[BIGINT],
    @id_user			[INT]
		 

AS
/***************************************
*Nombre:		[FIN].[ServiciosFinancieros]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		27/10/2020
*Desarrollador: (Kmartinez)
*Descripcion: Este SP tiene como funcionalidad guardar registros y tambien modificarlos  

***************************************/
DECLARE @error VARCHAR(MAX), @id_return INT;

BEGIN TRY
BEGIN TRAN

 IF(Isnull(@id, 0) = 0)
	BEGIN			
	
    INSERT INTO [FIN].[ServiciosFinanciero](codigo, nombre, id_cuenta, id_user)
				VALUES(@codigo, @nombre,  @id_ctaant, @id_user);				
	
	SET @id_return =  SCOPE_IDENTITY();
    SELECT @id_return id, 'PROCESADO' estado

	END
	ELSE
	BEGIN
		 
	  UPDATE F
		SET F.codigo = @codigo,
			F.nombre = @nombre,
			F.id_cuenta = @id_ctaant,
			F.updated		= GETDATE() FROM [FIN].[ServiciosFinanciero] F WHERE F.id = @id;
			
			SET @id_return = @id;		
			SELECT @id_return id, 'PROCESADO' estado;
	
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
