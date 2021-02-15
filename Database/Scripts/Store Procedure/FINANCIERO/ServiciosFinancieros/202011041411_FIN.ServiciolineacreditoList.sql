--liquibase formatted sql
--changeset ,kmartinez:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[FIN].[ServiciolineacreditoList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [FIN].[ServiciolineacreditoList]
GO

CREATE PROCEDURE [FIN].[ServiciolineacreditoList]
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL,
	@id_line BIGINT

 
AS
/***************************************
*Nombre:		[FIN].[ServiciolineacreditoList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		22/10/19
*Desarrollador: (Kmartinez)
*Descripcion: Este Store proc sirve para listar todo los registro de la tabla relacion entre financiero y lineas creditos
***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT )
BEGIN TRY
		
		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;

		INSERT INTO @temp(id_pk)
		SELECT  id
		FROM [FIN].[VW_Serviciolineacredito]
		WHERE	[id_lineascredito] = @id_line AND
		(isnull(@filter,'')='' or porcentaje like '%' + @filter + '%')
		ORDER BY id ASC;

		SET @countpage = @@rowcount;		
		
		SELECT Tm.id_record, t.id, t.Servicios, t.id_lineascredito, t.porcentaje
		FROM @temp Tm
				Inner join [FIN].[VW_Serviciolineacredito] t on Tm.id_pk = t.id
		WHERE id_record between @starpage AND @endpage
		ORDER BY id ASC;				
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