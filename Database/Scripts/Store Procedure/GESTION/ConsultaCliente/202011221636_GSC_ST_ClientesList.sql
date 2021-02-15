--liquibase formatted sql
--changeset ,JTOUS:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[GSC].[ST_ClientesList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1) 
DROP PROCEDURE GSC.ST_ClientesList
GO
CREATE  PROCEDURE [GSC].[ST_ClientesList] 
/***************************************
*Nombre:		[GSC].[ST_ClientesList] 
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		14/11/2020
*Desarrollador: JPAREDES
*Descripcion:	Lista los clientes que estan en mora y los filtra
***************************************/
@page INT = 1,
@numpage INT = 10,
@countpage INT = 0 OUTPUT,
@filter VARCHAR(50) = NULL,
@id_cliente bigint,
@id_time VARCHAR(10)=NULL,
@programed bit,
@cuenta bigint
--WITH ENCRYPTION
AS
BEGIN TRY
	DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
	DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT )
	DECLARE @anomes VARCHAR(6)= (SELECT valor FROM Parametros WHERE codigo = 'FECHAGESTION')

		SET @numpage = ISNULL(@numpage,10);

		SET @starpage = (@page * @numpage) - @numpage +1;
		SET @endpage = @numpage * @page;		 

		INSERT INTO @temp(id_pk)
		SELECT DISTINCT  id	
		FROM [GSC].[VW_Clientes] CL 
		WHERE  CL.anomes = @anomes AND  ISNULL(CL.programado, 0) = @programed AND
		(isnull(@id_time,'')='' or CL.vencimiento = @id_time) AND
		(isnull(@cuenta,'')='' or CL.cuenta = @cuenta)	AND
		(isnull(@filter,'')='' or CL.cliente like '%' + @filter + '%')
	
				
		ORDER BY id ASC;

		SET @countpage = @@rowcount;		
		
		if (@numpage = -1)
			SET @endpage = @countpage;
		begin
		SELECT DISTINCT VC.id,
			VC.cliente, 
			VC.vencimiento,
			CASE WHEN VC.cuenta != 0 THEN VC.cuenta ELSE '' END cuenta,
			CASE WHEN VC.programado != 0 THEN vc.tipo ELSE '' END tipo
			FROM @temp Tm 
			INNER JOIN [GSC].[VW_Clientes] VC ON VC.id = Tm.id_pk
			LEFT  JOIN  [GSC].[GestionSeguimientos] GES ON GES.id_cliente = VC.id
			WHERE id_record between @starpage AND @endpage			
		end
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