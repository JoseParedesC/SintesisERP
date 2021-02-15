--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[Dbo].[ST_CajasProcesoList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE Dbo.ST_CajasProcesoList
GO
CREATE PROCEDURE dbo.ST_CajasProcesoList
	@page INT = 1,
	@numpage INT = 10,
	@countpage INT = 0 OUTPUT,
	@filter VARCHAR(50) = NULL,
	@id_user int = 1
AS
/***************************************
*Nombre:		[Dbo].[ST_CajasProcesoList]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		28/03/17
*Desarrollador: (JTOUS)
***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1, @idusuario int;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT )
BEGIN TRY

		SELECT TOP 1 @idusuario = CASE WHEN UPPER(ISNULL(RoleName, '')) = 'VENDEDOR' THEN U.id ELSE NULL END  
		FROM Dbo.Usuarios U
		Inner JOin Dbo.aspnet_Roles R ON R.id = U.id_perfil
		WHERE U.id = @id_user;

		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;
		IF (isnull(@idusuario, 0) != 0)
		BEGIN
			INSERT INTO @temp(id_pk)
			SELECT  id	
			FROM dbo.VW_CajasProceso
			WHERE estado = 1 AND id_user = @idusuario AND
				   ((isnull(@filter,'')='' or caja like '%' + @filter + '%') OR	
				   (isnull(@filter,'')='' or userapertura like '%' + @filter + '%')) 
			ORDER BY id ASC;
		END
		ELSE
		BEGIN
			INSERT INTO @temp(id_pk)
			SELECT  id	
			FROM dbo.VW_CajasProceso
			WHERE (estado = 1) AND
				   ((isnull(@filter,'')='' or caja like '%' + @filter + '%') OR	
				   (isnull(@filter,'')='' or userapertura like '%' + @filter + '%')) 
			ORDER BY id ASC;
		END

		SET @countpage = @@rowcount;		
		
		SELECT Tm.id_record, id, caja, userapertura, usercierre, fechaapert, fechacierre, estado, 
		CASE WHEN isnull(@idusuario, 0) = 0 THEN 1 ELSE 0 END [log],
		CASE WHEN isnull(@idusuario, 0) = 0 THEN 1 ELSE 0 END contab
		FROM @temp Tm
				Inner join dbo.VW_CajasProceso A on Tm.id_pk = A.id
		WHERE id_record between @starpage AND @endpage;

				
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
GO
