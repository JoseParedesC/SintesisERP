--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_FnNivelesCuentasCostos]') and OBJECTPROPERTY(id, N'IsTableFunction') = 1)
DROP FUNCTION [dbo].[ST_FnNivelesCuentasCostos]
GO
CREATE Function  [dbo].[ST_FnNivelesCuentasCostos] (@op CHAR, @id BIGINT)
RETURNS @TblResultante TABLE (idtable int identity(1,1) NOT NULL, id bigint, codigo varchar(25),  nombre varchar(75), nivel int, id_padre varchar(25), tipo char(1))

--With Encryption 
As
BEGIN

	IF(@op = 'C')
	BEGIN
		;WITH
		categoriasCTE(id, id_padre, codigo, nombre, nivel, tipo)
		AS
		(   
			SELECT 
				CC.id,
				CC.id_padre,
				CC.codigo,
				CC.nombre,
				CC.indice,
				CC.tipo
			FROM  CNTCuentas CC
			where CC.id =  @id
			UNION ALL
			-- Aquí va la recursividad
			SELECT  
				A.id, 
				A.id_padre, 
				A.codigo, 
				A.nombre, 
				A.indice,
				A.tipo
			FROM   CNTCuentas AS A 
				   INNER JOIN categoriasCTE AS E
			ON (A.codigo = E.id_padre )
		)
		Insert Into @TblResultante (id, codigo,  nombre, nivel, id_padre, tipo)
		SELECT DISTINCT id, codigo, codigo + ' - '+ nombre nombre, nivel, id_padre, 
		CASE WHEN tipo != 0 THEN 'D' ELSE 'G' END tipo
		FROM categoriasCTE ORDER BY nivel asc, id, codigo asc	
	END
	ELSE IF(@op = 'O')
	BEGIN
		;WITH
		categoriasCTE( id, id_padre, codigo, nombre, nivel, tipo)
		AS
		(   
			SELECT 
			   id,
			   id_padre,
			   codigo,
			   nombre,
			   indice,
			   detalle
			FROM  [CNT].[VW_CentroCosto]
			where id = @id
			UNION ALL
			-- Aquí va la recursividad
			SELECT 
					A.id, 
					A.id_padre, 
					A.codigo, 
					A.nombre, 
					A.indice,
					A.detalle
			FROM   [CNT].[VW_CentroCosto] AS A 
				   INNER JOIN categoriasCTE AS E -- Llamada a si misma
			ON (A.codigo = E.id_padre ) -- Unión invertida
		)
		INSERT INTO @TblResultante (id, codigo, nombre, nivel, id_padre, tipo)
		SELECT DISTINCT id, codigo, codigo + ' - '+ nombre, nivel, id_padre, CASE WHEN tipo != 0 THEN 'D' ELSE 'G' END tipo
		FROM categoriasCTE ORDER BY nivel asc, id, codigo asc
	
	END
	
	RETURN
End


GO


