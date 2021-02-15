--liquibase formatted sql
--changeset ,apuello:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id =
OBJECT_ID(N'[CNT].[MOVCierreContableList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[MOVCierreContableList]
GO
CREATE PROCEDURE [CNT].[MOVCierreContableList]
/***************************************
*Nombre: [CNT].[MOVCierreContableList]
----------------------------------------
*Tipo: Procedimiento almacenado
*creación: 23/12/20
*Desarrollador: APUELLO
*Descripcion: Obtiene una lista con todos los movimientos que se han realizado en la tabla MOVCierreContable
***************************************/
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL
AS
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT )
BEGIN TRY
		
		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;

		INSERT INTO @temp(id_pk)
		SELECT id
		FROM [CNT].[MOVCierreContable] 
		WHERE (isnull(@filter,'')='' or fecha like '%' + @filter + '%') 
		ORDER BY id ASC;

		SET @countpage = @@rowcount;		
		
		SELECT	Tm.id_record, 
				CR.id,
				CASE CR.estado WHEN [dbo].[ST_FnGetIdList]('PROCE') THEN 'PROCESADO' WHEN [dbo].[ST_FnGetIdList]('REVER') THEN 'REVERSION' ELSE 'REVERTIDO' END estado,
				CASE WHEN CR.fecha is null THEN CONVERT(VARCHAR(11),CR.fecha_revertido,120) ELSE CONVERT(VARCHAR(11),CR.fecha,120) END fecha, 
				CT.nombre centro, 
				(SELECT nombre FROM [dbo].[CNTCuentas] WHERE id = CR.id_cuentacierre) id_cierre,
				(SELECT nombre FROM [dbo].[CNTCuentas] WHERE id = CR.id_cuentacancelacion) id_cancel,
				'CR' documento,
				CONVERT(VARCHAR(4),CR.anomes, 112) anomes
		FROM @temp Tm
				INNER JOIN [CNT].[MOVCierreContable] CR ON CR.id = Tm.id_pk
				INNER JOIN [CNT].[CentroCosto] CT ON CT.id = CR.id_centrocosto
		WHERE id_record between @starpage AND @endpage
		ORDER BY Tm.id_pk DESC;
				
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

