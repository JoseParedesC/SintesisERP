USE [SintesisPlaneacion]
GO
/****** Object:  StoredProcedure [dbo].[ST_CargarListado] Script Date:
25/02/2021 16:52:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ST_CargarListado]
@c_op        VARCHAR(20),
@v_param    VARCHAR(50) = null,
@id_user    INT = 1

AS

/***************************************
*Nombre: [dbo].[CategoriasProductosList]
----------------------------------------
*Tipo: Procedimiento almacenado
*creación: 15/11/19
*Desarrollador: (Jeteme)
*Descripcion: Carga lis select
***************************************/

BEGIN TRY
     DECLARE @error VARCHAR(MAX);


     IF(@c_op = 'PROFILES')
     BEGIN
         SELECT id, RoleName [name]
         FROM Dbo.aspnet_Roles
         WHERE UPPER(RoleName) != 'SUPER ADMINISTRADOR';
     END
     ELSE IF(@c_op = 'MODULOS')
     BEGIN
         SELECT id, Nombre name
         FROM Modulos
         WHERE estado = 1

         SELECT id, NumVersion name
         FROM dbo.Versiones
         WHERE estado = 1

     END
     --JPAREDES Cargar el nombre e id del sistema
     ELSE IF(@c_op = 'SISTEMAS')
     BEGIN
         SELECT id, Nombre name
         FROM Sistemas
     END
     --APUELLO consulta el id, fecha inicial y fecha final de Releases
     ELSE IF(@c_op = 'REQUERIMIENTOS')
     BEGIN
         SELECT id, nombre n_sistema
         FROM dbo.Sistemas

         SELECT id, NumVersion n_version
         FROM dbo.Versiones

         SELECT id, CONVERT(VARCHAR(10), FechaInicial, 120) + ' & '+
CONVERT(VARCHAR(10), FechaFinal, 120) name
         FROM dbo.Releases
         WHERE estado = 1

         SELECT id, codigo cod
         FROM dbo.Bugs
         WHERE estado = 1

         SELECT id, nombre n_requerimiento
         FROM dbo.Requerimientos
         WHERE estado = 1

         SELECT id, Nombre modulo
         FROM dbo.Modulos
         WHERE estado = 1
     END
     /*JARCINIEGAS -> CONSULTA LOS DÍAS FESTIVOS*/
     ELSE IF (@c_op = 'FECHAFES')
     BEGIN
         SELECT 'S' id, 'SABADO' [name]
         UNION
         SELECT 'D' id, 'DOMINGO' [name]
         UNION
         SELECT 'F' id, 'FESTIVO' [name]
     END
     /*JARCINIEGAS -> CONSULTA LOS RELEASES*/
     ELSE IF (@c_op = 'FILTRAR')
     BEGIN
     DECLARE @fecha date
     set @fecha= GETDATE();
         SELECT  id, CONVERT(VARCHAR(10), FechaInicial, 120) + ' & '+ CONVERT(VARCHAR(10), FechaFinal, 120) name
         FROM dbo.Releases where convert(varchar(10), @fecha, 120) between  CONVERT(VARCHAR(10), FechaInicial, 120)  and CONVERT(VARCHAR(10), FechaFinal, 120) and estado = 1
         union all

         (SELECT id, CONVERT(VARCHAR(10), FechaInicial, 120) + ' & '+ CONVERT(VARCHAR(10), FechaFinal, 120) name
         FROM dbo.Releases
         WHERE estado = 1
         Except
         SELECT  id, CONVERT(VARCHAR(10), FechaInicial, 120) + ' & '+
CONVERT(VARCHAR(10), FechaFinal, 120) name
         FROM dbo.Releases where convert(varchar(10), @fecha, 120)
between CONVERT(VARCHAR(10), FechaInicial, 120) and CONVERT(VARCHAR(10),
FechaFinal, 120)
         )
     END

     --JPAREDES Cargar el nombre e id de la version
     ELSE IF(@c_op = 'SISTEMASVERSIONES')
     BEGIN
         SELECT DISTINCT V.id, V.NumVersion name
         FROM Sistemas_Versiones_Modulos S INNER JOIN
         Versiones V ON S.idversion = V.id
         WHERE IdSistema = CAST(@v_param AS BIGINT)
     END

     ELSE IF(@c_op = 'VERSIONESMODULOS')
     BEGIN
         SELECT DISTINCT M.id, M.Nombre name
         FROM Sistemas_Versiones_Modulos S INNER JOIN
         Modulos M ON S.idModulo = M.id
         WHERE IdVersion = CAST(@v_param AS BIGINT)
     END

     /*JARCINIEGAS -> CONSULTA LOS DÍAS DESARROLLADORES*/
     ELSE IF(@c_op = 'DESARROLLADOR')
     BEGIN
     SELECT A.Id, A.Usuario name from [dbo].[Desarrolladores] A

     END

     ELSE IF (@c_op = 'STATERQ')
     BEGIN
         SELECT id, (CONVERT(VARCHAR,FechaInicial,111))+' &
'+(CONVERT(VARCHAR,FechaFinal,111)) name
         FROM Releases

         SELECT id,Usuario name
         FROM Desarrolladores

         SELECT id, estado name, color
         FROM [dbo].[Estadorequerimiento]

     END

     ELSE IF (@c_op = 'TIPOAPL')
     BEGIN

         SELECT id, nombre name
         FROM ST_Listados WHERE
         Codigo = 'TIPOAPL'
     END
     ELSE IF(@c_op = 'TICKET')
     BEGIN
         SELECT id, NumVersion name
         FROM dbo.Versiones

         SELECT id, nombre name
         FROM dbo.Sistemas

         SELECT id, razonsocial name
         FROM dbo.Clientes

         SELECT id, nombre name
         FROM dbo.ST_Listados
         WHERE codigo = 'TICKET'

         SELECT
                 id,
                 nombre name,
                 CASE nombre
                 WHEN 'Baja' THEN '#2ECC71'
                 WHEN 'Media' THEN '#2980B9'
                 WHEN 'Alta' THEN '#F1C40F'
                 WHEN 'Urgente' THEN '#E74C3C' END color
         FROM dbo.ST_Listados
         WHERE codigo = 'PRIORIDAD'

         SELECT U.id, nombre name
         FROM dbo.Usuarios U
         INNER JOIN dbo.aspnet_Roles R ON R.id = U.id_perfil
         WHERE R.RoleName = 'Desarrolladores'

         SELECT
             U.id,
             nombre name
         FROM dbo.Usuarios U
         INNER JOIN dbo.aspnet_Roles R ON R.id = U.id_perfil
         LEFT JOIN dbo.Tickets T ON T.id_user = U.id
         WHERE R.LoweredRoleName = 'Desarrolladores'
     END

END TRY
BEGIN CATCH
     SET @error = 'Error: '+ERROR_MESSAGE();
     RAISERROR(@error,16,0);
     ROLLBACK TRANSACTION;
END
CATCH
