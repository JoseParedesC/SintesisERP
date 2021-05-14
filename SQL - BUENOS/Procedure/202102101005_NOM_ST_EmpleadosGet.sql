--liquibase formatted sql
--changeset ,JARCINIEGAS:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_EmpleadosGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_EmpleadosGet]
GO
CREATE PROCEDURE [NOM].[ST_EmpleadosGet]
	
	@id_persona INT ,
	@iden VARCHAR (20) = NULL,
	@id_user INT 
AS

/***************************************
*Nombre:		[NOM].[ST_EmpleadosGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		24/11/2020
*Desarrollador: JPAREDES
*Descripcion:	
***************************************/

DECLARE @error VARCHAR(MAX)

BEGIN TRY

IF (ISNULL(@iden,0) = 0)
BEGIN
	SELECT	id, --
			id_personeria,------lo dejo momentaneo, por si se necesita mas adelante, pero en el get como tal no lo necesito
			tipoiden,  --//
			iden,  --//
			digitoverificacion,  --//
			primernombre,  --//
			segundonombre,  --//
			primerapellido,  --//
			segundoapellido,  --
			razonsocial,  -----lo dejo momentaneo, por si se necesita mas adelante, pero en el get como tal no lo necesito
			CONVERT(VARCHAR (10),fechaexpedicion,120) fechaexpedicion,  --
			CONVERT(VARCHAR (10),fechanacimiento,120) fechanacimiento,  --
			direccion,  --
			email,  --
			telefono, --                        
			celular,  --
			id_ciudad,--  
			id_tipotercero,  ---------lo dejo momentaneo, por si se necesita mas adelante, pero en el get como tal no lo necesito
			id_estrato,  --
			id_genero,  --
			profesion,  --
			id_estadocivil,  --
			universidad,  --
			id_escolaridad,  --
			nacionalidad,  --
			cant_hijos,  --
			id_tiposangre,  --
			discapasidad,  --
			CONVERT(VARCHAR (10),fechavenci_extran,120) fechavenci_extran,   --                        
			congenero,  --
			CONVERT(VARCHAR (10),confecha_naci,120) confecha_naci, -- 
			conprofesion,  --
			connombres,  --
			conapellidos,  --
			coniden,  --
			tipodiscapasidad,  --
			porcentajedis,  --
			gradodis,  --
			carnetdis,  --
			CONVERT(VARCHAR (10),fechaexpdis,120) fechaexpdis,  
			CONVERT(VARCHAR (10),vencimientodis,120) vencimientodis

	FROM [NOM].[VW_Empleados] EM
	WHERE EM.id = @id_persona 
		

END
ELSE
BEGIN

SELECT		id, --
			id_personeria,------lo dejo momentaneo, por si se necesita mas adelante, pero en el get como tal no lo necesito
			tipoiden,  --//
			iden,  --//
			digitoverificacion,  --//
			primernombre,  --//
			segundonombre,  --//
			primerapellido,  --//
			segundoapellido,  --
			razonsocial,  -----lo dejo momentaneo, por si se necesita mas adelante, pero en el get como tal no lo necesito
			CONVERT(VARCHAR (10),fechaexpedicion,120) fechaexpedicion,  --
			CONVERT(VARCHAR (10),fechanacimiento,120) fechanacimiento,  --
			direccion,  --
			email,  --
			telefono, --                        
			celular,  --
			id_ciudad--  
			
	FROM [CNT].[Terceros] 
	WHERE iden = @iden


END
	
SELECT	id,
			identificacion,
			nombres,
			apellidos,
			genero,
			profesion,
			(SELECT nombre FROM [DBO].[ST_Listados] WHERE id = genero) textgen,
			(SELECT nombre FROM [DBO].[ST_Listados] WHERE id = profesion) textprofe
	FROM [CNT].[TercerosHijos] 
	WHERE id_tercero = @id_persona

END TRY
BEGIN CATCH
--Getting the error description
	Set @error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	-- save the error in a Log file
	RAISERROR(@error,16,1)
	RETURN
END CATCH