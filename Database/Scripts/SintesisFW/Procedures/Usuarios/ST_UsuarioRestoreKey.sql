--liquibase formatted sql
--changeset ,jtous:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[Dbo].[ST_UsuarioRestoreKey]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Drop Procedure Dbo.ST_UsuarioRestoreKey
GO
CREATE PROCEDURE [Dbo].ST_UsuarioRestoreKey
	@id [bigint],
	@password [varchar] (255),
	@id_user [bigint]

WITH ENCRYPTION
AS
	
BEGIN TRY
/***************************************
*Nombre:		[Dbo].[ST_UsuarioRestoreKey]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		10/04/17
*Desarrollador: (JTOUS)
***************************************/
	
DECLARE @error VARCHAR(MAX), @userid   [varchar] (255)
BEGIN TRAN
	
	SET @userid = (SELECT userid FROM Usuarios WHERE id = @id);

	UPDATE Dbo.aspnet_Membership 
		SET [Password] = @password ,
		IsLockedOut = 0,
		FailedPasswordAttemptCount = 0
	WHERE UserId = @userid

	UPDATE Dbo.Usuarios Set Updated = GETDATE(), id_user = @id_user Where id = @id;
	
COMMIT TRAN
END TRY
BEGIN CATCH
	ROLLBACK TRAN;
	--Getting the error description
	Select @error   =  ERROR_PROCEDURE() + 
				';  ' + convert(varchar,ERROR_LINE()) + 
				'; ' + ERROR_MESSAGE()
	-- save the error in a Log file
	RaisError(@error,16,1)  
End Catch
