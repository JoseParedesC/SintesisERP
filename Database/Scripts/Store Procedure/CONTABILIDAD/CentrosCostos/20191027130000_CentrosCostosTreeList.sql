--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[CentroCostoTreeList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[CentroCostoTreeList]
GO
CREATE procedure [CNT].[CentroCostoTreeList] 
@id_user int = 0,
@filtro VARCHAR(25) = ''
--WITH ENCRYPTION
AS
BEGIN TRY
	DECLARE @error VARCHAR(MAX)
	DECLARE @table TABLE (idtable int identity(1,1), id bigint, codigo varchar(25),  nombre varchar(75), nivel int, 
						  id_padre varchar(25), tipo char(1)) 

	;WITH
	categoriasCTE(num, id, id_padre, codigo, nombre, nivel, tipo)
	AS
	(   
		SELECT CAST(ROW_NUMBER() OVER(ORDER BY indice desc, CAST(codigo as int) desc) *0 +1 AS int ) RowNum, 
		   id,
		   id_padre,
		   codigo,
		   nombre,
		   indice,
		   detalle
		FROM  [CNT].VW_CentroCosto
		WHERE codigo like '%'+@filtro+'%' OR nombre like '%'+@filtro+'%'
		UNION ALL
		-- Aquí va la recursividad
		SELECT CAST(1 as int) RowNum, 
				A.id, 
				A.id_padre, 
				A.codigo, 
				A.nombre, 
				A.indice,
				A.detalle
		FROM   [CNT].VW_CentroCosto AS A 
			   INNER JOIN categoriasCTE AS E -- Llamada a si misma
		ON (A.codigo = E.id_padre ) -- Unión invertida
	)
	INSERT INTO @table (id, codigo, nombre, nivel, id_padre, tipo)
	SELECT DISTINCT id, codigo, codigo + CASE WHEN codigo != '' THEN ' - ' ELSE ''END + nombre, nivel, id_padre, CASE WHEN tipo != 0 THEN 'D' ELSE 'G' END tipo
	FROM categoriasCTE ORDER BY nivel asc, id, codigo asc
	
	SELECT id, codigo, nombre, nivel as indice, tipo
	FROM @table 
	WHERE nivel = 1 ORDER BY ID ASC
	
	SELECT id, codigo, nombre, id_padre, nivel as indice, tipo
	FROM @table 
	WHERE nivel > 1
	ORDER BY nivel ASC, CAST(codigo AS INT) ASC	
				
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


