--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_Empresas]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [dbo].[VW_Empresas]
END
GO

CREATE VIEW [dbo].[VW_Empresas]
AS
/***************************************
*Nombre:		[dbo].[VW_Empresas]
----------------------------------------
*Tipo:			Vista
*creación:		02/04/17
*Desarrollador: (JTOUS)
***************************************/
		SELECT C.id
			, C.razonsocial
			, C.nit
			, L.iden tipoid
			, L.codigogen codiden
			, C.id_tipoid
			, C.digverificacion
			, D.codigo AS codciudad
			, D.nombre AS ciudad
			, D.codeDepartament AS coddepartamento
			, D.nombredep AS departamento
			, C.telefono
			, C.direccion
			, C.email
			, C.urlimg
			, C.urlimgrpt
			, C.estado
			, C.carpetaname AS folder
			, C.certificatename
			, C.passcertificate
			, C.tipoambiente
			, C.softid
			, C.softpin
			, C.softtecnikey AS clavetec
			, C.testid
			, C.nombrecomercial
			, urlfirma
		FROM     dbo.Empresas AS C INNER JOIN
                 dbo.DivPolitica AS D ON C.id_ciudad = D.id INNER JOIN
				 ST_Listados  L ON L.id = C.id_tipoid


GO


