--liquibase formatted sql
--changeset ,CZULBARAN:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovEntradasTemp]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MovEntradasTemp]
GO

CREATE PROCEDURE [dbo].[ST_MovEntradasTemp]
@id BIGINT = 0,
@fechadocumen VARCHAR(10) = NULL,
@fechafactura VARCHAR(10) = NULL, 
@fechavence VARCHAR(10) = NULL,
@numfactura VARCHAR(50) = NULL, 
@diasvence INT = NULL, 
@id_bodega BIGINT =NULL,
@id_proveedor BIGINT = NULL, 
@flete NUMERIC(18,0) = NULL, 
@id_pedido BIGINT = NULL,
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
		Insert Into [dbo].[MOVEntradasTemp] (id_user)
		Values(@id_user);

		Set @id_return = SCOPE_IDENTITY();
	End
	ELSE
		Set @id_return = @id;

	if(isnull(@id_return,0) != 0)
	Begin
		UPDATE [dbo].[MOVEntradasTemp]
		SET 
			fechadocumen	= CASE WHEN @fechadocumen != '' THEN @fechadocumen ELSE NULL END, 
			fechafactura	= CASE WHEN @fechafactura != '' THEN @fechafactura ELSE NULL END, 
			fechavence		= CASE WHEN @fechavence != '' THEN @fechavence ELSE NULL END, 
			numfactura		= @numfactura, 
			diasvence		= @diasvence, 
			id_bodega		= CASE WHEN @id_bodega = 0 THEN NULL ELSE @id_bodega END , 
			id_proveedor	= CASE WHEN @id_proveedor = 0 THEN NULL ELSE @id_proveedor END , 
			flete			= @flete, 
			id_pedido		= CASE WHEN @id_pedido = 0 THEN NULL ELSE @id_pedido END, 
			updated			= GETDATE(),
			id_user			= @id_user
		Where id = @id_return;
	End

	SELECT @id_return id,  UPPER(NEWID())factura;

End Try
Begin Catch
	    Select @ds_error = ERROR_MESSAGE()
	    RaisError(@ds_error,16,1)
	    Return
End Catch

GO


