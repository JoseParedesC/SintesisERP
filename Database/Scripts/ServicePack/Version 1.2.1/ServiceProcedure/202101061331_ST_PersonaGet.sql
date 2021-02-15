--liquibase formatted sql
--changeset ,jarciniegas:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id =
OBJECT_ID(N'[CRE].[ST_PersonaGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1) DROP PROCEDURE [CRE].[ST_PersonaGet]
GO
CREATE PROCEDURE [CRE].[ST_PersonaGet]
	@iden varchar(20) ,
	@id_user [int] 
 
AS
BEGIN
/***************************************
*Nombre:		[CRE].[ST_PersonaGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		27/03/17
*Desarrollador: (JTOUS)
***************************************/
	------------------------------------------------------------------------------
	-- Declaring variables Page_Nav
	------------------------------------------------------------------------------
	Declare @ds_error varchar(max)
	
	Begin Try
		IF EXISTS (SELECT * FROM [CRE].[Personas] WHERE identificacion = @iden)
		BEGIN
			SELECT TOP 1 1 opcion,
					P.primernombre,
					P.segundonombre,
					P.primerapellido,
					P.segundoapellido,
					P.tipo_persona,
					P.identificacion,
					P.id_tipoiden,
					P.id_ciudad,
					P.id_genero,
					P.id_estrato,
					P.id_estadocivil,
					P.profesion,
					P.telefono,
					P.celular,
					P.otrotel,
					P.direccion,
					P.correo,
					P.id_viveinmueble,
					P.valorarriendo,
					P.id_fincaraiz,
					P.cualfinca,
					P.vehiculo,
					P.percargo,
					P.digverificacion verificacion,
					P.id_escolaridad,
					PA.connombre,
					PA.contipoid,
					PA.coniden,
					PA.contelefono,
					PA.concorreo,
					PA.conempresa,
					P.urlimgper urlimg,
					PA.condireccionemp,
					PA.contelefonoemp,
					PA.consalario,
					ISNULL(PA.id_tipoact,0) id_tipoact,
					PA.id_tipoemp,
					Pa.empresalab,
					PA.direccionemp,
					PA.telefonoemp,
					PA.cargo,
					PA.id_tiempoemp,
					PA.salarioemp,
					PA.otroingreso,
					PA.concepto
			FROM [CRE].[Personas] P 
				 INNER JOIN [CRE].[Personas_Adicionales] PA ON PA.id_persona = P.id
				 INNER JOIN [CRE].[Solicitud_Personas] PS ON PS.id_persona = P.id
				 LEFT JOIN [CRE].[Solicitud_Evaluacion] SE ON SE.id_solicitudpersona = PS.id
			WHERE P.identificacion = @iden
			ORDER BY PS.id DESC;			
		END
		ELSE IF EXISTS (SELECT 1 FROM [CNT].[Terceros] WHERE iden = @iden)
		BEGIN
			SELECT 2 opcion, 
			iden identificacion,
			primernombre, 
			segundonombre, 
			primerapellido, 
			segundoapellido, 
			(tipoiden) id_tipoiden,
			(id_personeria) tipo_persona,
			(email) correo,
			telefono,
			celular,
			id_ciudad
			FROM [CNT].[Terceros]
			WHERE iden = @iden
			ORDER BY id DESC;
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
