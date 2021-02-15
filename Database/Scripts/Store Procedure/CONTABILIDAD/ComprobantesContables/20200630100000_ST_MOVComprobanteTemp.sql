--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_MOVComprobanteTemp]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_MOVComprobanteTemp]
GO


CREATE PROCEDURE [CNT].[ST_MOVComprobanteTemp]
@id BIGINT = 0,
@fecha VARCHAR(10) = NULL,
@detalle VARCHAR(50) = NULL, 
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
		Insert Into [CNT].[MOVComprobantesContablesTemp] (id_usercreated)
		Values(@id_user);

		Set @id_return = SCOPE_IDENTITY();
	End
	ELSE
		Set @id_return = @id;


	SELECT @id_return id;

End Try
Begin Catch
	    Select @ds_error = ERROR_MESSAGE()
	    RaisError(@ds_error,16,1)
	    Return
End Catch


GO


