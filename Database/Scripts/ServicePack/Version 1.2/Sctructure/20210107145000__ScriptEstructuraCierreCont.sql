--liquibase formatted sql
--changeset ,APUELLO:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false

IF COL_LENGTH('[CNT].[SaldoCuenta]', 'cierre') IS NULL
BEGIN
    Alter Table
        [CNT].[SaldoCuenta]
    Add
        [cierre] bit NOT NULL default 0;
END
GO

IF COL_LENGTH('[CNT].[SaldoTercero]', 'cierre') IS NULL
BEGIN
    Alter Table
        [CNT].[SaldoTercero]
    Add
        [cierre] bit NOT NULL default 0;
END
GO

DECLARE @TABLATERCERO TABLE(ANOMES VARCHAR(6),ID_TERCERO BIGINT,ID_CUENTA  BIGINT,FECHAACTUAL SMALLDATETIME,SALDOANTERIOR NUMERIC(18,2),MOVDEBITO NUMERIC(18,2),MOVCREDITO NUMERIC(18,2),SALDOACTUAL NUMERIC(18,2))

INSERT INTO @TABLATERCERO (ANOMES,ID_TERCERO,ID_CUENTA,FECHAACTUAL,SALDOANTERIOR,MOVDEBITO,MOVCREDITO,SALDOACTUAL)
SELECT anomes,id_tercero,id_cuenta,MAX(FECHAACTUAL),SUM(saldoanterior),SUM(movdebito),SUM(movcredito),SUM(saldoactual) from cnt.saldotercero  group by anomes,id_tercero,id_cuenta

TRUNCATE TABLE CNT.SALDOTERCERO;

INSERT INTO CNT.SALDOTERCERO (ANOMES,ID_TERCERO,ID_CUENTA,FECHAACTUAL,SALDOANTERIOR,MOVDEBITO,MOVCREDITO,SALDOACTUAL,CHANGED,BEFORE,ID_USER,CIERRE)
SELECT ANOMES,ID_TERCERO,ID_CUENTA,FECHAACTUAL,SALDOANTERIOR,MOVDEBITO,MOVCREDITO,SALDOACTUAL,1,1,2,0 FROM @TABLATERCERO
GO

IF NOT EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id =
OBJECT_ID(N'CNT.MOVCierreContable') and OBJECTPROPERTY(id, N'IsTable') = 1)
CREATE TABLE CNT.MOVCierreContable(
	id BIGINT PRIMARY KEY IDENTITY(1, 1),
	fecha SMALLDATETIME,
	id_centrocosto BIGINT,
	id_cuentacierre BIGINT,
	id_cuentacancelacion BIGINT,
	id_tercero BIGINT,
	tipodocumento BIGINT,
	fecha_revertido SMALLDATETIME,
	id_revertido BIGINT,
	anomes VARCHAR(6),
	descripcion VARCHAR(MAX),
	created SMALLDATETIME DEFAULT GETDATE(),
	updated SMALLDATETIME,
	user_created BIGINT,
	user_updated BIGINT,
	estado BIGINT
)
IF NOT EXISTS(SELECT 1 FROM dbo.SYSOBJECTS WHERE id =
OBJECT_ID(N'CNT.MOVCierreContableItems') and OBJECTPROPERTY(id, N'IsTable') = 1)
CREATE TABLE CNT.MOVCierreContableItems(
	id_cierrecontable BIGINT,
	id_cuenta BIGINT,
	id_tercero BIGINT,
	valor BIGINT,
	credito BIGINT,
	debito BIGINT,
	created SMALLDATETIME DEFAULT GETDATE(),
	updated SMALLDATETIME,
	user_created BIGINT,
	user_updated BIGINT
)
ALTER TABLE CNT.MOVCierreContableItems ADD
CONSTRAINT FK_CierreContable_id FOREIGN KEY (id_cierrecontable) REFERENCES CNT.MOVCierreContable(id)


IF NOT EXISTS(SELECT 1 FROM [dbo].[Menus] WHERE nombrepagina = 'Cierre Contable')
	INSERT INTO [dbo].[Menus] (nombrepagina, estado, pathpagina, id_padre, descripcion, orden, padre, icon, id_usuario) 
	VALUES ('Cierre Contable', 1, 'cierrecontable.aspx', 50, 'Cierre Contable', 8, 0, 'fa-th-large', 1)

DECLARE @id_return BIGINT
SET @id_return = SCOPE_IDENTITY();

IF NOT EXISTS (SELECT 1 FROM [dbo].[MenusPerfiles] WHERE id_menu = @id_return)
	INSERT INTO [dbo].[MenusPerfiles] (id_perfil, id_menu, id_user) 
	VALUES	(1, @id_return, 1), (2, @id_return, 1)
GO

IF COL_LENGTH('[CNT].[MOVNotasCartera]', 'tipoter') IS NULL
BEGIN
    Alter Table
        [CNT].[MOVNotasCartera]
    Add
        tipoter VARCHAR(2) NOT NULL DEFAULT ('CL');
END
GO