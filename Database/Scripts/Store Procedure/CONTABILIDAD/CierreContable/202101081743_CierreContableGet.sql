--liquibase formatted sql
--changeset ,apuello:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id =
OBJECT_ID(N'[CNT].[CierreContableGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[CierreContableGet]
GO
CREATE PROCEDURE [CNT].[CierreContableGet]
/***************************************
*Nombre: [CNT].[CierreContableGet]
----------------------------------------
*Tipo: Procedimiento almacenado
*creación: 23/12/20
*Desarrollador: APUELLO
*Descripcion: Obtiene el centro de costo, fecha, cuenta de cancelación y cuenta de cierre 
	en base a un id que entra como parametro al SP
***************************************/
	@id BIGINT,
	@id_user BIGINT
AS
BEGIN
	BEGIN TRY
		Declare @error varchar(max)
		SELECT 
			CONVERT(VARCHAR(10),CR.fecha, 120) fecha,
			C.nombre centro,
			(SELECT codigo + ' - ' + nombre FROM [dbo].[CNTCuentas] C INNER JOIN [CNT].[MOVCierreContable] CR ON CR.id_cuentacancelacion = C.id WHERE CR.id = @id) cancel,
			(SELECT codigo + ' - ' + nombre FROM [dbo].[CNTCuentas] C INNER JOIN [CNT].[MOVCierreContable] CR ON CR.id_cuentacierre = C.id WHERE CR.id = @id) cierre,
			CR.descripcion descrip,
			CONVERT(VARCHAR(4), CR.anomes, 112) anomes
		FROM [CNT].[MOVCierreContable] CR
		INNER JOIN [CNT].[CentroCosto] C ON C.id = CR.id_centrocosto
	END TRY
    BEGIN CATCH
	--Getting the error description
	SET @error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	-- save the error in a Log file
	RAISERROR(@error,16,1)
	RETURN
	END CATCH

END
