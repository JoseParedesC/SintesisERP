--liquibase formatted sql
--changeset ,jarciniegas:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[BuscadorMaestrosNomina]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[BuscadorMaestrosNomina]
GO
CREATE PROCEDURE [NOM].[BuscadorMaestrosNomina]
	@filtro		[VARCHAR] (50),
	@opcion		[CHAR] (1),
	@op			VARCHAR(2) = NULL,
	@tipo VARCHAR (10) =''


AS
BEGIN
/***************************************
*Nombre:		[Dbo].[BuscadorMaestrosNomina]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		17/11/19
*Desarrollador: (JARCINIEGAS)
***************************************/
	
Declare @ds_error varchar(max), @id_articuloT BIGINT = 0, @count DECIMAL(18,2)
	
Begin Try
	IF (@opcion = 'U')
	BEGIN
	
		SELECT DISTINCT TOP 15 (CU.id) id,
			CASE WHEN CU.codigo like '%' +@filtro+ '%' THEN CU.codigo + ' - ' + CU.nombre
				 WHEN CU.nombre like '%' +@filtro+ '%' THEN  CU.codigo+' - '+ CU.nombre END name
		FROM dbo.VW_CNTCuentas CU
		WHERE tipo != 0 and estado !=0 AND ((LEFT(CU.codigo, 1)) = 2) AND (CU.codigo like '%'+@filtro+'%' OR CU.nombre like'%'+@filtro+'%') AND categoria = (SELECT id FROM [dbo].[ST_Listados] WHERE iden = 'CTERCE')
		ORDER BY id ASC;
	END	
	ELSE IF (@opcion = 'H')
	BEGIN
	
		SELECT DISTINCT TOP 15 (CU.id) id,
			CASE WHEN CU.codigo like '%' +@filtro+ '%' THEN CU.codigo + ' - ' + CU.nombre
				 WHEN CU.nombre like '%' +@filtro+ '%' THEN  CU.codigo+' - '+ CU.nombre END name
		FROM dbo.VW_CNTCuentas CU
		WHERE tipo != 0 and estado !=0 AND ((LEFT(CU.codigo, 1)) IN(5,6,7)) AND (CU.codigo like '%'+@filtro+'%' OR CU.nombre like'%'+@filtro+'%') AND categoria = (SELECT id FROM [dbo].[ST_Listados] WHERE iden = 'CTERCE')
		ORDER BY id ASC;
	END
	ELSE IF (@opcion = 'A')
	BEGIN	
		SELECT id, 
		CASE WHEN nombre like '%' +@filtro+ '%' THEN nombre END [name] 
		FROM [NOM].[Area] 
		WHERE nombre like '%' +@filtro+ '%'
		ORDER BY id ASC;
	END
	ELSE IF (@opcion = 'J')
	BEGIN	
		SELECT  EM.id,
			CASE WHEN CAR.nombre like '%' +@filtro+ '%' THEN CAR.nombre +' - '+  (EM.razonsocial)
				 WHEN EM.razonsocial like '%' +@filtro+ '%' THEN  CAR.nombre +' - '+  (EM.razonsocial) END name  
			FROM [NOM].[VW_Empleados] EM 
			INNER JOIN [NOM].Contrato C ON C.id_empleado = EM.id
			INNER JOIN [NOM].Cargo CAR ON  CAR.id = C.cargo
			WHERE C.jefe = 1 AND C.estado = dbo.ST_FnGetIdList('VIG') AND (CAR.nombre like '%'+@filtro+'%' OR EM.razonsocial like'%'+@filtro+'%')
			ORDER BY id ASC;
	END
	ELSE IF (@opcion = 'E')
	BEGIN	
		SELECT id, CASE WHEN nombre like '%' +@filtro+ '%' THEN nombre END [name] 
		FROM [NOM].[Entidades_de_Salud]
		WHERE nombre like '%' +@filtro+ '%'AND id_tiposeg = (SELECT id FROM ST_Listados WHERE iden = 'SEPS')--eps
		ORDER BY id ASC;
	END
	ELSE IF (@opcion = 'P')
	BEGIN	
		SELECT id, CASE WHEN nombre like '%' +@filtro+ '%' THEN nombre END [name] 
		FROM [NOM].[Entidades_de_Salud]
		WHERE nombre like '%' +@filtro+ '%' AND id_tiposeg = (SELECT id FROM ST_Listados WHERE iden = 'SPEN')--pension
		ORDER BY id ASC;
	END
	ELSE IF (@opcion = 'O')
	BEGIN	
		SELECT id, CASE WHEN nombre like '%' +@filtro+ '%' THEN nombre END [name] 
		FROM [NOM].[Entidades_de_Salud]
		WHERE nombre like '%' +@filtro+ '%' AND id_tiposeg = (SELECT id FROM ST_Listados WHERE iden = 'SCAJA')--caja
		ORDER BY id ASC;
	END
	ELSE IF (@opcion = 'B')
	BEGIN	
		SELECT id, CASE WHEN nombre like '%' +@filtro+ '%' THEN nombre END [name] 
		FROM [CNT].[Bancos]
		WHERE nombre like '%' +@filtro+ '%'
		ORDER BY id ASC;
	END
	ELSE IF (@opcion = 'T')
	BEGIN	
		SELECT T.id_tipo_subtipo id,
			CASE WHEN CONVERT(VARCHAR,T.codigo_externo)		like '%' +@filtro+ '%' THEN 'Cod '+ TC.codigo +''+ T.codigo + '  Pila '+CONVERT(VARCHAR,T.codigo_externo)+'-'+CONVERT(VARCHAR,TC.codigo_externo) 
				 WHEN CONVERT(VARCHAR,TC.codigo_externo)	like '%' +@filtro+ '%' THEN 'Cod '+ TC.codigo +''+ T.codigo + '  Pila '+CONVERT(VARCHAR,T.codigo_externo)+'-'+CONVERT(VARCHAR,TC.codigo_externo)   
				 WHEN TC.codigo								like '%' +@filtro+ '%' THEN 'Cod '+ TC.codigo +''+ T.codigo + '  Pila '+CONVERT(VARCHAR,T.codigo_externo)+'-'+CONVERT(VARCHAR,TC.codigo_externo) 
				 WHEN T.codigo								like '%' +@filtro+ '%' THEN 'Cod '+ TC.codigo +''+ T.codigo + '  Pila '+CONVERT(VARCHAR,T.codigo_externo)+'-'+CONVERT(VARCHAR,TC.codigo_externo) END [name] 
		FROM [NOM].[VW_TiposCotizante] T
		INNER JOIN [NOM].[TiposCotizante] TC ON TC.id = T.id_padre
		WHERE (T.codigo_externo like '%'+@filtro+'%' OR TC.codigo_externo like'%'+@filtro+'%' OR TC.codigo like'%'+@filtro+'%' OR T.codigo like'%'+@filtro+'%')
		ORDER BY T.id_padre ASC;
	END 
	ELSE IF(@opcion = 'D') -- JPAREDES
	BEGIN
		SELECT D.id, D.codigo name FROM [NOM].[Diagnostico] D
		WHERE D.codigo like '%' + @filtro + '%'
	END
	ELSE IF(@opcion = 'L') -- JPAREDES
	BEGIN
		SELECT E.id, E.nombre name FROM [NOM].[Embargos] E
		WHERE E.nombre like '%' + @filtro + '%'
	END
	ELSE IF(@opcion = 'G') -- JPAREDES
	BEGIN 
		SELECT id, CONCAT(codigo,' - ',nombre) name FROM CNTCUENTAS where SUBSTRING(codigo,1,1) = 2
	END
		

End Try
Begin Catch
	--Getting the error description
	Set @ds_error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	-- save the error in a Log file
	RaisError(@ds_error,16,1)
	return
End Catch
END
