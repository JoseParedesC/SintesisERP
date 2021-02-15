--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_MOVComprobanteSetItemTemp]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [CNT].[ST_MOVComprobanteSetItemTemp]
GO
CREATE PROCEDURE [CNT].[ST_MOVComprobanteSetItemTemp] 
	@id				BIGINT,
	@column			VARCHAR(20),
	@valor			DECIMAL(18,2)
--WITH ENCRYPTION
AS
BEGIN
/***************************************
*Nombre:		[CNT].[ST_MOVComprobanteSetItemTemp]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		23/10/2020
*Desarrollador: (JETEHERAN)
***************************************/
------------------------------------------------------------------------------
-- Declaring variables Page_Nav
------------------------------------------------------------------------------
DECLARE @ds_error VARCHAR(MAX), @count decimal(18,2)= 0, @id_comprobante BIGINT;
Begin Try

	IF(@column = 'debito')
	BEGIN		
			UPDATE T SET T.valor = @valor
			FROM [cnt].[MOVComprobantesItemsTemp]  T 
			WHERE T.id = @id;
	END
	ELSE IF (@column = 'credito')
	BEGIN
		UPDATE T SET T.valor = @valor *-1
		FROM [cnt].[MOVComprobantesItemsTemp]  T 
		WHERE T.id = @id;
	END
	
	SET @id_comprobante=(Select id_comprobante From CNT.MOVComprobantesItemsTemp where id=@id)

	SELECT 
		I.id, C.codigo+' '+C.nombre cuenta, P.nombre concepto, ISNULL(T.primernombre, '') + ' ' + ISNULL(T.segundonombre, '') + ' ' + ISNULL(T.primerapellido, '') + ' ' + ISNULL(T.segundoapellido, '') AS tercero,case when (I.valor>0) then I.valor else 0 end debito,case when (I.valor<0) then I.valor*-1 else 0 end credito,R.Tdebito,R.Tcredito,R.diferencia
		
	FROM 
		[CNT].[MOVComprobantesItemsTemp]  I
		INNER JOIN CNTCuentas C ON I.id_cuenta=C.id
		LEFT JOIN dbo.Productos P ON I.id_concepto=P.id
	    INNER JOIN 	    [CNT].[VW_Terceros]        AS T ON I.id_tercero   = T.id 
		Cross Apply CNT.ST_FnCalTotalComprobante(@id_comprobante,'T') R
	WHERE 
		I.id = @id;
		
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



