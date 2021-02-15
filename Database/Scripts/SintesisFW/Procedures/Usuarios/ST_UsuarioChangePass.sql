--liquibase formatted sql
--changeset ,jtous:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[Dbo].[ST_UsuarioChangePass]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Drop Procedure Dbo.ST_UsuarioChangePass
GO
CREATE PROCEDURE [Dbo].ST_UsuarioChangePass
	@id_user [int],
	@password [varchar] (255),
	@tokenId   [varchar] (255)

WITH ENCRYPTION
AS
	
BEGIN TRY
/***************************************
*Nombre:		[Dbo].[ST_UsuarioChangePass]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		10/04/17
*Desarrollador: (JTOUS)
***************************************/
	
DECLARE @error VARCHAR(MAX);
BEGIN TRAN

	UPDATE Dbo.aspnet_Membership 
		SET [Password] = @password 
	WHERE UserId = @tokenId

	UPDATE Dbo.Usuarios Set Updated = GETDATE() Where id = @id_user;
	
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
