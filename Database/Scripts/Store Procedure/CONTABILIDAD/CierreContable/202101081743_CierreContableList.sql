--liquibase formatted sql
--changeset ,apuello:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id =
OBJECT_ID(N'[CNT].[CierreContableList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[CierreContableList]
GO
CREATE PROCEDURE [CNT].[CierreContableList]
/***************************************
*Nombre: [CNT].[CierreContableList]
----------------------------------------
*Tipo: Procedimiento almacenado
*creación: 23/12/20
*Desarrollador: APUELLO
*Descripcion: Devuelve una lista con todas las cuentas que se encuentran en la 4, 5, 6
***************************************/
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL,
	@id BIGINT = NULL
AS
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @anomes VARCHAR(6)
BEGIN TRY
		IF(@id != 0)
			BEGIN
				SELECT
					CT.codigo,
					CT.nombre,
					CASE WHEN I.debito IS NULL THEN 0 ELSE I.credito END debito,
					CASE WHEN I.credito IS NULL THEN 0 ELSE I.credito END credito
				FROM [CNT].[MOVCierreContableItems] I
				JOIN [dbo].[CNTCuentas] CT ON CT.id = I.id_cuenta
				WHERE I.id_cierrecontable = @id
			END
		ELSE
			BEGIN
				SELECT
					C.codigo,
					C.nombre,
					CASE WHEN S.movDebito IS NULL THEN 0 ELSE S.movDebito END debito,
					CASE WHEN S.movCredito IS NULL THEN 0 ELSE S.movCredito END credito
				FROM [CNT].[SaldoCuenta] S
				INNER JOIN [dbo].[CNTCuentas] C ON S.id_cuenta = C.id
				WHERE (SUBSTRING(codigo, 1, 1) IN (4, 5, 6)) AND cierre = 1
				ORDER BY S.id ASC;
			END
				
END TRY
BEGIN CATCH

	    --Getting the error description
	    Select @error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	    -- save the error in a Log file
	    RaisError(@error,16,1)
	    Return  
End Catch
