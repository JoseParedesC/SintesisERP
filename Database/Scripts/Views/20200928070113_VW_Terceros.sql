--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[CNT].[VW_Terceros]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
	Drop View CNT.VW_Terceros
END
GO


CREATE VIEW [CNT].[VW_Terceros]
AS 
SELECT  
		  c.id
		, c.razonsocial AS tercero
		, c.iden
		, l.iden AS nombretipoiden
		, l.codigogen AS codiden
		, c.primernombre
		, c.segundonombre
		, c.primerapellido
		, c.segundoapellido
		, C.primernombre + ' ' + C.segundonombre nombres
		, C.primerapellido + ' ' + C.segundoapellido apellidos
		, c.razonsocial
		, D.codigo			codigociudad
		, D.codeDepartament	codigodepartamento
		, D.nombredep		nombredepartamento
		, D.nombre			ciudad
		, c.id_ciudad
		, c.direccion
		, ISNULL(c.sucursal, '') AS sucursal
		, c.tiporegimen
		, s.nombre AS regimen
		, ISNULL(c.nombrecomercial, '') AS nombrecomercial
		, ISNULL(c.paginaweb, '') AS paginaweb
		, ISNULL(CONVERT(VARCHAR(16)
		, c.fechaexpedicion, 120), '') AS fechaexpedicion
		, ISNULL(CONVERT(VARCHAR(16)
		, c.fechanacimiento, 120), '') AS fechanacimiento
		, c.telefono
		, c.email
		, c.celular
		, c.digitoverificacion
		, c.nombrescontacto
		, c.telefonocontacto
		, c.emailcontacto
		, c.estado
		, c.tipoiden
		, c.id_personeria
		, CASE WHEN A.iden = 'NATURAL' THEN 2 ELSE 1 END tipopersoneria
		, A.nombre AS personeria
		,c.id_catfiscal
		
FROM	CNT.Terceros AS C INNER JOIN
		dbo.DivPolitica AS D ON D.id = c.id_ciudad LEFT OUTER JOIN
		dbo.ST_Listados AS s ON c.tiporegimen = s.id LEFT OUTER JOIN
		dbo.ST_Listados AS l ON c.tipoiden = l.id LEFT OUTER JOIN
		dbo.ST_Listados AS A ON c.id_personeria = A.id 
GO