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
*Desarrollador: (JETEHERAN)
***************************************/
	
Declare @ds_error varchar(max), @id_articuloT BIGINT = 0, @count DECIMAL(18,2)
	
Begin Try
	IF (@opcion = 'U')
	BEGIN
	
		SELECT DISTINCT TOP 15 (CU.id) id,
			CASE WHEN CU.codigo like '%' +@filtro+ '%' THEN CU.codigo + ' - ' + CU.nombre
				 WHEN CU.nombre like '%' +@filtro+ '%' THEN  CU.codigo+' - '+ CU.nombre END name
		FROM dbo.VW_CNTCuentas CU
		WHERE tipo != 0 and estado !=0 AND (CU.codigo like '%'+@filtro+'%' OR CU.nombre like'%'+@filtro+'%') and categoria = (SELECT id FROM [dbo].[ST_Listados] WHERE iden = 'CTERCE')
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
		SELECT id, nombre [name] FROM [NOM].[Area]
	END
	ELSE IF (@opcion = 'J')
	BEGIN	
		SELECT  EM.id,CAR.nombre +' - '+  (EM.razonsocial) [name]			  
			FROM [NOM].[VW_Empleados] EM 
			INNER JOIN [NOM].Contrato C ON C.id_empleado = EM.id
			INNER JOIN [NOM].Cargo CAR ON  CAR.id = C.cargo
			WHERE C.jefe = 1 AND C.estado = dbo.ST_FnGetIdList('VIG')
	END
	ELSE IF (@opcion = 'E')
	BEGIN	
		SELECT id, nombre [name] FROM [NOM].[Entidades_de_Salud]
	END
	ELSE IF (@opcion = 'P')
	BEGIN	
		SELECT id, nombre [name] FROM [NOM].[Pension]
	END
	ELSE IF (@opcion = 'O')
	BEGIN	
		SELECT id, nombre [name] FROM [NOM].[Cajas_de_Compensacion]
	END
	ELSE IF (@opcion = 'B')
	BEGIN	
		SELECT id, nombre [name] FROM [NOM].[Bancos]
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
