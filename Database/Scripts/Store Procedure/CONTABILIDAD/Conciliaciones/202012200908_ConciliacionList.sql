--liquibase formatted sql
--changeset ,apuello:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id =
OBJECT_ID(N'[dbo].[ConciliacionList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ConciliacionList]
GO
CREATE PROCEDURE [dbo].[ConciliacionList]
/***************************************
*Nombre: [dbo].[ConciliacionList]
----------------------------------------
*Tipo: Procedimiento almacenado
*creación: 23/12/20
*Desarrollador: APUELLO
*Descripcion: Usa una vista y devuelve consultas que varian en base a los parametros que entran al SP 
***************************************/
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL,
	@fecha VARCHAR(10),
	@consolidado INT,
	@id_conciliado BIGINT
AS
DECLARE @error VARCHAR(MAX)
DECLARE @credito INT, @debito INT
BEGIN TRY

		IF(@fecha = '')
			SET @fecha = CONVERT(VARCHAR(7), GETDATE(), 120)

		IF(@consolidado != 0)
			BEGIN
				SELECT 
					T.id,
					T.fuente,
					T.documento,
					T.fecha,
					T.descrip,
					T.debito,
					T.credito,
					CASE WHEN I.id_transaccion IS NULL THEN 0 ELSE 1 END estado,
					T.factura
				FROM CNT.VW_Transacciones T
				LEFT JOIN (SELECT I.id_transaccion 
							FROM [CNT].[MOVConciliadosItems] I 
							INNER JOIN [CNT].[MOVConciliados] C ON C.id = I.id_conciliado 
							WHERE C.estado = [dbo].[ST_FnGetIdList]('PROCE')) I
				ON T.id = I.id_transaccion
				WHERE T.fecha = @fecha
				ORDER BY estado DESC
			END
		ELSE IF(@id_conciliado = 0)
			BEGIN
				SELECT  
					T.id,
					T.fuente,
					T.documento,
					T.fecha,
					T.descrip,
					T.debito,
					T.credito,
					0 estado,
					T.factura
				FROM CNT.VW_Transacciones T
				LEFT JOIN (SELECT I.id_transaccion 
							FROM [CNT].[MOVConciliadosItems] I 
							INNER JOIN [CNT].[MOVConciliados] C ON C.id = I.id_conciliado 
							WHERE C.estado = [dbo].[ST_FnGetIdList]('PROCE')) C
				ON T.id = C.id_transaccion
				WHERE C.id_transaccion is null AND fecha = @fecha
				ORDER BY id ASC;
			END
		ELSE
			BEGIN
				SET @consolidado = 1
				SELECT  
					T.id,
					T.fuente,
					T.documento,
					T.fecha,
					T.descrip,
					T.debito,
					T.credito,
					@consolidado estado,
					T.factura
				FROM CNT.VW_Transacciones T
				INNER JOIN [CNT].[MOVConciliadosItems] I ON I.id_transaccion = T.id
				INNER JOIN  [CNT].[MOVConciliados] C ON C.id = I.id_conciliado
				WHERE (T.id = I.id_transaccion AND C.id = @id_conciliado)
				ORDER BY id ASC;				
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

