--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[TiposCotizanteTreeList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[TiposCotizanteTreeList]
GO
CREATE PROCEDURE [NOM].[TiposCotizanteTreeList]

@id_user INT = 0,
@filtro VARCHAR(25) = ''

AS


/***************************************
*Nombre:		[NOM].[TiposCotizanteTreeList]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		30/03/2021
*Desarrollador:  JPAREDES
*Descripcion:	Lista la informacion de los tipos de cotizante
***************************************/

BEGIN TRY
	DECLARE @error VARCHAR(MAX)
	DECLARE @table TABLE (idtable INT identity(1,1), id BIGINT, codigo VARCHAR(25),  nombre VARCHAR(75), nivel INT, 
						  id_padre VARCHAR(25), tipo char(1)) 

	INSERT INTO @table (id, codigo, nombre, id_padre, tipo, nivel)
	SELECT id_subtipo, codigo, CONCAT(id_padre, CASE WHEN codigo != '' THEN ' - ' ELSE ''END, codigo) AS nombre, id_padre, '' tipo, CAST(ROW_NUMBER() OVER(ORDER BY id_padre DESC) AS INT) AS indice
	FROM [NOM].[VW_TiposCotizante] 
	
	SELECT id, codigo, CONCAT(id, CASE WHEN codigo != '' THEN ' - ' ELSE '' END, codigo) AS nombre, CAST(ROW_NUMBER() OVER(ORDER BY id DESC) AS INT) AS indice, IIF(detalle = 1, 'G','D') tipo
	FROM [NOM].[TiposCotizante]
	WHERE CONCAT(id, CASE WHEN codigo != '' THEN ' - ' ELSE ''END, codigo) like '%' + @filtro + '%'
	ORDER BY id ASC
	
	SELECT id, codigo, nombre, id_padre, nivel AS indice, '' tipo
	FROM @table 	
	ORDER BY id ASC
	


END TRY
BEGIN CATCH

	    --Getting the error DESCription
	    SELECT @error   =  ERROR_PROCEDURE() +
					';  ' + CONVERT(VARCHAR,ERROR_LINE()) +
					'; ' + ERROR_MESSAGE()
	    -- save the error in a Log file
	    RAISERROR(@error,16,1)
	    RETURN  
END CATCH