--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_Rpt_MovimientosCaja]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_Rpt_MovimientosCaja]
GO 
	CREATE PROCEDURE [dbo].[ST_Rpt_MovimientosCaja]

	@cuenta1 BIGINT,
	@cuenta2 BIGINT,
	@fechainicial VARCHAR(10),
	@fechafinal VARCHAR(10)

AS

DECLARE @error VARCHAR(MAX);

DECLARE @cuentainicial BIGINT = (SELECT codigo from CNTCuentas where id = @cuenta1);
DECLARE @cuentafinal BIGINT = (SELECT codigo FROM CNTCuentas WHERE id = @cuenta2);

DECLARE @fecha1 VARCHAR(6) = REPLACE(@fechainicial,'-','');
DECLARE @fecha2 VARCHAR(6) = REPLACE(@fechafinal,'-','');

BEGIN TRY

	SELECT	TD.nombre documento
			,C.codigo cuenta
			,CONCAT(T.tipodocumento,' - ',T.id) factura
			,TER.iden [cliente/tercero]
			,TER.primerapellido+' '+Ter.segundoapellido nombre
			,T.formapago
			,T.valor
			,C.nombre nombrecaja
			,@cuentainicial cuentainicial
			,@cuentafinal cuentafinal
	  FROM	[CNT].[Transacciones] T INNER JOIN 
			[CNT].[TipoDocumentos] TD ON TD.id = T.nrodocumento INNER JOIN
			[DBO].[CNTCuentas] C ON C.id = T.id_cuenta INNER JOIN
			[CNT].[Terceros] Ter ON Ter.id = T.id_tercero
	  WHERE SUBSTRING(C.codigo,1,4) = 1105 AND 
			(T.anomes BETWEEN @fecha1 AND @fecha2) AND 
			(C.codigo BETWEEN @cuentainicial AND @cuentafinal) AND 
			T.estado = [dbo].[ST_FnGetIdList]('PROCE')

END TRY
BEGIN CATCH
	--Getting the error description
	SELECT @error   =  ERROR_PROCEDURE() + 
				';  ' + CONVERT(VARCHAR,ERROR_LINE()) + 
				'; ' + ERROR_MESSAGE()
	-- save the error in a Log file
	RAISERROR(@error,16,1)
	RETURN 
END CATCH
