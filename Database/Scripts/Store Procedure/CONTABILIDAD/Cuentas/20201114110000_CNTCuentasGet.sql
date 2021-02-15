--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[CNTCuentasGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [Dbo].[CNTCuentasGet]
GO

CREATE PROCEDURE [dbo].[CNTCuentasGet]
	@id [int] = null,
	@id_user [int]
--WITH ENCRYPTION
AS
BEGIN
/***************************************
*Nombre:		[dbo].[ST_CNTCuentasGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		15/11/17
*Desarrollador: (JETEHERAN)
***************************************/
Declare @ds_error varchar(max);
Declare @id_cuenta BIGINT = 0;
Begin Try
	
	SELECT @id_cuenta = CC.id 
	FROM  CNTCuentas C
	INNER JOIN CNTCuentas CC ON C.id_padre = CC.codigo
	where C.id =  @id
	
	Select id, subcodigo codigo, nombre, tipo, idparent id_padre, id_tipocta,categoria,dbo.ST_FnGetNombreList(categoria) nomcategoria
	From  dbo.VW_CNTCuentas T
	Where T.id = @id;

	SELECT id, codigo,  nombre, nivel, id_padre 
	FROM Dbo.ST_FnNivelesCuentasCostos('C', @id_cuenta);

End Try
Begin Catch
	--Getting the error description
	Set @ds_error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	-- save the error in a Log file
	RaisError(@ds_error,16,1)
	return
End Catch
END