--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_NovedadesGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_NovedadesGet]
GO
CREATE PROCEDURE [NOM].[ST_NovedadesGet]

@id BIGINT, 
@id_user BIGINT

AS

/***************************************
*Nombre:		[NOM].[ST_NovedadesGet]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		30/03/2021
*Desarrollador:  JPAREDES
*Descripcion:	Obtiene la informacion de la Novedad
***************************************/
DECLARE @error VARCHAR(MAX)

BEGIN TRY

	IF(ISNULL(@id,0) = 0)
		RAISERROR('No se ha encontrado la Novedad',16,0)

	--SELECT @id ,ISNULL(CONVERT(VARCHAR(16),D.fecha_inicio,120),0) inicio_devengo, ISNULL(CONVERT(VARCHAR(16),D.fecha_fin,120),0) fin_devengo, ISNULL(CONVERT(VARCHAR(16),A.fecha_ini,120),0) inicio_ausencia, ISNULL(CONVERT(VARCHAR(16),A.fecha_fin,120),0) fin_ausencia FROM [NOM].[Devengos] D INNER JOIN [NOM].[Ausencias] A ON D.id_per_cont = A.id_per_cont
	

	SELECT ISNULL(CONVERT(VARCHAR(16),D.fecha_inicio,120),'') inicio_devengo, ISNULL(CONVERT(VARCHAR(16),D.fecha_fin,120),'') fin_devengo, boni, comi 
		FROM	[NOM].[Devengos] D
		WHERE D.id_per_cont = @id 
	

	SELECT id_diagnostico, A.id_tipoausencia,nombre, iden, remunerado, domingo_suspencion, D.codigo ds_diagnostico, CONVERT(VARCHAR(16),ISNULL(fecha_ini,0),120) inicio_ausencia, CONVERT(VARCHAR(16),ISNULL(fecha_fin,0),120) fin_ausencia, D.codigo ds_disgnostico
		FROM	[NOM].[Ausencias] A													LEFT JOIN 
				[NOM].[Diagnostico] D ON A.id_diagnostico = D.id					INNER JOIN
				[dbo].[ST_Listados] S ON S.id = A.id_tipoausencia 
		WHERE A.id_per_cont = @id
	

	SELECT prestamos, libranzas, id_embargo, retencion_fuente retencion, E.nombre ds_embargo
		FROM	[NOM].[Deducciones] D LEFT JOIN
				[NOM].[Embargos] E ON D.id_embargo = E.id
		WHERE id_per_cont = @id
	

END TRY
BEGIN CATCH	
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);	
END CATCH