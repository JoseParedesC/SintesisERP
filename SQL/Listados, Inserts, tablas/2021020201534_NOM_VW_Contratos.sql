--liquibase formatted sql
--changeset ,jarciniegas:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[NOM].[VW_Contratos]') and
OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [NOM].[VW_Contratos]
END
GO
CREATE VIEW [NOM].[VW_Contratos]
AS
SELECT        C.id AS id_contrato, A.id AS id_area, H.id AS id_horario, CAR.id AS id_cargo, TSTC.id AS id_tipo_subtipo, C.consecutivo, C.id_empleado, C.id_contratacion, C.id_tipo_contrato, C.coti_extranjero, C.tipo_salario,
                             (SELECT        nombre
                               FROM            dbo.ST_Listados AS LIST
                               WHERE        (id = C.tipo_nomina)) AS tipo_nomina, C.diasapagar, C.salario, A.nombre AS nombre_area, H.nombre AS nombre_horario, CAR.nombre AS nombre_cargo, C.funciones_esp, C.jefe, C.cual_jefe,
                             (SELECT        nombre
                               FROM            dbo.ST_Listados AS list
                               WHERE        (id = C.id_formapago)) AS formapago, C.ncuenta, C.tipo_cuenta, C.banco,
                             (SELECT        nombre
                               FROM            dbo.ST_Listados AS list
                               WHERE        (id = C.tipo_jornada)) AS tipo_jornada, C.ley50, C.procedimiento,
                             (SELECT        nombre
                               FROM            dbo.ST_Listados AS list
                               WHERE        (id = C.estado)) AS estado, C.id_periodo, H.HporDia, H.Hfin, H.Hinicio, H.Hnoche, EPS.codigo AS epscod, EPS.nombre AS epsnom, EPS.cod_ext AS epscodext, EPS.contrapartida AS epscontrapartida, 
                         PENSION.codigo AS pencod, PENSION.nombre AS pennom, PENSION.cod_ext AS pencodext, PENSION.contrapartida AS pencontrapartida, CAJA.codigo AS cajacod, CAJA.nombre AS cajanom, CAJA.cod_ext AS cajacodext, 
                         CAJA.contrapartida AS cajacontrapartida, C.centrocosto, C.created AS fecha_Creacion_con
FROM            NOM.Contrato AS C INNER JOIN
                         NOM.Area AS A ON C.area = A.id INNER JOIN
                         NOM.Cargo AS CAR ON CAR.id = C.cargo INNER JOIN
                         NOM.Horario AS H ON H.id = C.id_horario INNER JOIN
                         NOM.Tipos_SubtiposCotizanets AS TSTC ON TSTC.id = C.id_tipo_cotizante INNER JOIN
                         NOM.Entidades_de_Salud AS EPS ON C.id_eps = EPS.id AND EPS.id_tiposeg =
                             (SELECT        id
                               FROM            dbo.ST_Listados
                               WHERE        (iden = 'SEPS')) INNER JOIN
                         NOM.Entidades_de_Salud AS CAJA ON C.id_cajacomp = CAJA.id AND CAJA.id_tiposeg =
                             (SELECT        id
                               FROM            dbo.ST_Listados
                               WHERE        (iden = 'SCAJA')) INNER JOIN
                         NOM.Entidades_de_Salud AS PENSION ON C.id_pension = PENSION.id AND PENSION.id_tiposeg =
                             (SELECT        id
                               FROM            dbo.ST_Listados
                               WHERE        (iden = 'SPEN'))
WHERE        (ISNULL(H.id_padre, 0) = 0)

GO

