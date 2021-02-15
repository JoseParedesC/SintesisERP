--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovOrdenCompraTemp]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MovOrdenCompraTemp]
GO



CREATE PROCEDURE [dbo].[ST_MovOrdenCompraTemp]
@id BIGINT = 0,
@fechadocumen VARCHAR(10) = NULL,
@id_proveedor BIGINT = NULL, 
@id_bodega BIGINT = NULL,
@id_user INT
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[ST_MovEntradasTemp]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		27/03/17
*Desarrollador: (JTOUS)
***************************************/
Declare @ds_error Varchar(Max), @id_return int;

Begin Try
	If(Isnull(@id,0) = 0)
	Begin
		Insert Into [dbo].[MovOrdenComprasTemp] (id_usercreated,id_userupdated)
		Values(@id_user,@id_user);

		Set @id_return = SCOPE_IDENTITY();
	End
	ELSE
		Set @id_return = @id;

	if(isnull(@id_return,0) != 0)
	Begin
		UPDATE [dbo].[MovOrdenComprasTemp]
		SET 
			fechadocument	= CASE WHEN @fechadocumen != '' THEN @fechadocumen ELSE NULL END, 
			id_proveedor	= CASE WHEN @id_proveedor = 0 THEN NULL ELSE @id_proveedor END , 
			bodega			= @id_bodega,
			updated			= GETDATE(),
			id_userupdated			= @id_user
		Where id = @id_return;
	End

	SELECT @id_return id;

End Try
Begin Catch
	    Select @ds_error = ERROR_MESSAGE()
	    RaisError(@ds_error,16,1)
	    Return
End Catch

GO


