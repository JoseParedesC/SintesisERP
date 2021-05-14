--liquibase formatted sql
--changeset ,jarciniegas:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[NOM].[VW_Empleados]') and
OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [NOM].[VW_Empleados]
END
GO
CREATE VIEW [NOM].[VW_Empleados]
AS
SELECT        T.id, T.id_personeria, T.tipoiden, T.iden, T.digitoverificacion, T.primernombre, T.segundonombre, T.primerapellido, T.segundoapellido, T.razonsocial, T.fechaexpedicion, T.fechanacimiento, T.direccion, T.email, T.telefono, 
                         T.celular, T.id_ciudad, TA.id_estrato, TA.id_genero, TA.profesion, TA.id_estadocivil, TA.nacionalidad, TA.id_tiposangre, TA.id_escolaridad, TA.universidad, TA.discapasidad, TA.tipodiscapasidad, TA.porcentajedis, TA.gradodis, TA.cant_hijos,TA.fechavenci_extran,
                         TA.carnetdis, TA.fechaexpdis, TA.vencimientodis, TA.coniden, TA.connombres, TA.conapellidos, TA.confecha_naci, TA.congenero, TA.conprofesion, TT.id_tipotercero
FROM            CNT.Terceros AS T INNER JOIN
                         CNT.TipoTerceros AS TT ON T.id = TT.id_tercero INNER JOIN
                         CNT.TerceroAdicionales AS TA ON T.id = TA.id_tercero
WHERE        (TT.id_tipotercero =
                             (SELECT        id
                               FROM            dbo.ST_Listados
                               WHERE        (iden = 'TC')))


GO


