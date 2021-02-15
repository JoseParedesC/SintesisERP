--liquibase formatted sql
--changeset ,jtous:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
DECLARE @id_report INT;
INSERT [dbo].[ST_Reportes] ([codigo], [nombre], [frx], [listado], [estado], [created], [updated], [id_user], [nombreproce], [paramadicionales]) VALUES (N'MAECUENTAS', N'Listado de Cuentas', N'CntCuentas.frx', 1, 1, CAST(N'20171125 13:28:00' AS SmallDateTime), CAST(N'20171125 13:28:00' AS SmallDateTime), 1, 'ST_Rpt_MAECuentas', N';op|C')

SET @id_report = SCOPE_IDENTITY();

INSERT INTO [dbo].[aspnet_RolesInReports](id_perfil, id_reporte, id_user)
VALUES(1, @id_report, 1), (2, @id_report, 1)
GO

IF EXISTS (SELECT 1 FROM Dbo.CNTCuentas WHERE id = 146)
BEGIN
	UPDATE CNTCuentas SET subcodigo = '25' WHERE id = 146
END
GO