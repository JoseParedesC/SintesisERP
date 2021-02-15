--liquibase formatted sql
--changeset ,jtous:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[ST_CajasSelect]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE Dbo.ST_CajasSelect
GO
CREATE PROCEDURE [dbo].[ST_CajasSelect]
	@id_caja BIGINT = 1,
	@monto NUMERIC(18,2),
	@id_user INT
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[ST_CajasSelect]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		19/12/19
*Desarrollador: (JETEHERAN)
***************************************/
DECLARE @error VARCHAR(MAX), @id_return INT;
BEGIN TRY
		
	IF EXISTS (SELECT 1 FROM Dbo.Cajas WHERE id = @id_caja AND estado = 1)
	BEGIN
		IF EXISTS (SELECT 1 FROM Dbo.aspnet_UsersInCajas WHERE id_caja = @id_caja AND [user_id] = @id_user)
		BEGIN
			IF NOT EXISTS (SELECT 1 FROM Dbo.CajasProceso WHERE id_caja = @id_caja AND estado = 1 AND @id_user != id_userapertura)
			BEGIN
				IF NOT EXISTS (SELECT 1 FROM Dbo.Cajas WHERE id = @id_caja AND userproceso = @id_user AND cajaproceso = 1)
				BEGIN					
					IF EXISTS (SELECT TOP 1 1 FROM Dbo.CajasProceso 
							   WHERE id_caja = @id_caja AND 
							   CONVERT(VARCHAR(10), GETDATE(), 120) = CONVERT(VARCHAR(10), fechaapertura, 120) 
							   AND fechacierre Is NOT NULL
							   AND id_usercierre is not null ORDER BY id DESC)
					BEGIN
						RAISERROR('Han cerrado la caja y no puede volver a entrar, el día de hoy.',16,0);
					END
					ELSE
					BEGIN
						BEGIN TRY
						BEGIN TRAN
								
							UPDATE Dbo.Cajas SET cajaproceso = 1, userproceso = @id_user WHERE id = @id_caja;

							IF NOT EXISTS (SELECT 1 FROM Dbo.CajasProceso WHERE id_caja = @id_caja AND estado = 1 AND @id_user = id_userapertura)
							BEGIN
						
								INSERT INTO  [dbo].[CajasProceso](id_caja, id_userapertura, fechaapertura, estado, valor)
								VALUES(@id_caja, @id_user, GETDATE(), 1, @monto);

								SET @id_return = SCOPE_IDENTITY();
							END

							SELECT id id_caja, id_bodega, id_centrocosto id_ccosto, centrocosto  FROM VW_Cajas WHERE id = @id_caja;
						COMMIT TRAN;
						END TRY
						BEGIN CATCH
							ROLLBACK TRAN;
							Select @error   =  ERROR_MESSAGE()
							-- save the error in a Log file
							RaisError(@error,16,0)
						END CATCH
					END
				END
				ELSE				
					RAISERROR('La caja no se ha cerrdo en días anteriores..', 16, 0);
			END
			ELSE
				RAISERROR('La caja ya esta siendo usada por otro usuario.', 16, 0);
		END
		ELSE
			RAISERROR('Usted no tiene permiso para acceder a esta caja.', 16, 0);
	END
	ELSE
		RAISERROR('No existe caja o esta inactiva', 16, 0);	
END TRY
BEGIN CATCH		
	    --Getting the error description
	    Select @error   =  ERROR_MESSAGE()
	    -- save the error in a Log file
	    RaisError(@error,16,1)
	    Return  
End Catch
