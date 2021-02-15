--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_MOVComprobanteLoadFile]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_MOVComprobanteLoadFile]
GO

CREATE PROCEDURE [CNT].[ST_MOVComprobanteLoadFile]
	@id_comprobante		[int],   
	@xmlart				[XML],
    @id_user			[INT]
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[CNT].[ST_MOVComprobanteLoadFile]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		15/01/2021
*Desarrollador: (JTeheran)
***************************************/

SET LANGUAGE spanish

DECLARE @error VARCHAR(MAX), @id int, @manejador int;
DECLARE @table Table(id_centro bigint,centro varchar(50),id_cuenta bigint,cuenta varchar(50),id_tercero bigint ,tercero varchar(50), descripcion varchar(1000), debito numeric(18,2),credito numeric(18,2));
BEGIN TRY
BEGIN TRAN

	DELETE [CNT].[MOVComprobantesItemsTemp] WHERE id_comprobante = @id_comprobante;
	
	EXEC sp_xml_preparedocument @manejador OUTPUT, @xmlart; 	

	INSERT INTO @table (centro,Cuenta, tercero, descripcion, debito, credito)
	SELECT CENTRO,REPLACE(cuenta,' ',''), Tercero, Descripcion, debito, credito
	FROM OPENXML(@manejador, N'items/item') 
	WITH (  centro [VARCHAR](50) '@CENTRO',
		    cuenta [VARCHAR](50) '@CUENTA',
			Tercero [varchar](50) '@TERCERO',
			Descripcion [varchar](100) '@DESCRIPCION',
			debito [NUMERIC](18,2) '@DEBITO',
			credito [NUMERIC](18,2) '@CREDITO'
			) AS P;
	
	EXEC sp_xml_removedocument @manejador;



	UPDATE T SET
	 t.id_cuenta  =			A.id,
	 t.id_tercero =         TER.id,
	 t.id_centro  =         C.id
	 FROM @table T 
	LEFT JOIN Dbo.CNTCuentas A ON T.cuenta = A.codigo LEFT JOIN CNT.Terceros TER ON T.tercero=TER.iden
	LEFT JOIN CNT.CentroCosto C ON t.centro=T.centro

	IF EXISTS (SELECT 1 FROM @table WHERE id_cuenta is null)
	BEGIN
		SET @error = 'Esta cuenta  (' + (SELECT TOP 1 cuenta  FROM @table WHERE id_cuenta is null) + ')que intenta subir no existe en la base de datos'
		RAISERROR(@error, 16, 0);
	END

	IF EXISTS (SELECT 1 FROM @table WHERE id_tercero is null)
	BEGIN
		SET @error = 'Tercero (' + (SELECT TOP 1 tercero  FROM @table WHERE id_tercero is null) + ')que intenta subir no existe en la base de datos'
		RAISERROR(@error, 16, 0);
	END

	IF EXISTS (SELECT 1 FROM @table WHERE id_centro is null)
	BEGIN
		SET @error = 'Centro de costo (' + (SELECT TOP 1 Centro  FROM @table WHERE id_tercero is null) + ')que intenta subir no existe en la base de datos'
		RAISERROR(@error, 16, 0);
	END

	
	INSERT INTO [CNT].[MOVComprobantesItemsTemp] (id_comprobante,id_centrocosto ,id_cuenta, id_tercero,detalle,valor,id_usercreated)
	SELECT 
		@id_comprobante,id_centro ,id_cuenta, id_tercero,descripcion,(debito-credito) , @id_user
	FROM @table 



	SELECT 
		I.id,Ce.nombre centrocosto ,C.codigo+' '+C.nombre cuenta, P.nombre concepto, ISNULL(T.primernombre, '') + ' ' + ISNULL(T.segundonombre, '') + ' ' + ISNULL(T.primerapellido, '') + ' ' + ISNULL(T.segundoapellido, '') AS tercero,case when (I.valor>0) then I.valor else 0 end debito,case when (I.valor<0) then I.valor*-1 else 0 end credito,R.Tdebito,R.Tcredito,R.diferencia,I.factura,I.id_saldocuota
		
	FROM 
		[CNT].[MOVComprobantesItemsTemp]  I
		INNER JOIN CNTCuentas C ON I.id_cuenta=C.id
		LEFT JOIN dbo.Productos P ON I.id_concepto=P.id
		INNER JOIN [CNT].[VW_Terceros]        AS T ON I.id_tercero   = T.id 
		left join cnt.CentroCosto ce on I.id_centrocosto=ce.id
		Cross Apply CNT.ST_FnCalTotalComprobante(@id_comprobante,'T') R
	WHERE 
		I.id_comprobante = @id_comprobante;

COMMIT TRAN;
END TRY
BEGIN CATCH
		ROLLBACK TRAN;
	    --Getting the error description
	    SELECT @error   =   ERROR_MESSAGE()
	    -- save the error in a Log file
	    RAISERROR(@error,16,1);
END CATCH