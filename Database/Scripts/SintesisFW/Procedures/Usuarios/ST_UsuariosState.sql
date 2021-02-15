--liquibase formatted sql
--changeset ,jtous:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[Dbo].[ST_UsuarioState]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Drop Procedure Dbo.ST_UsuarioState
GO
CREATE PROCEDURE Dbo.ST_UsuarioState
@id BIGINT,
@id_user INT
WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_UsuarioState]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		09/04/17
*Desarrollador: (JTOUS)
***************************************/
Declare @ds_error Varchar(Max)

Begin Try

		UPDATE Dbo.Usuarios
		SET estado = CASE estado WHEN 0 THEN 1 ELSE 0 END,
		id_user = @id_user, 
		updated = GETDATE() 
		WHERE id = @id;

End Try
Begin Catch
	    Select @ds_error = ERROR_MESSAGE()
	    RaisError(@ds_error,16,1)
	    Return
End Catch
GO
