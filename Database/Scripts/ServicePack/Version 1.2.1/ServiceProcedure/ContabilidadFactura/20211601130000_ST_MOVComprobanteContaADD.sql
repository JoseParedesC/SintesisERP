--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_MOVComprobanteContaADD]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_MOVComprobanteContaADD]
GO

CREATE PROCEDURE [CNT].[ST_MOVComprobanteContaADD]
	@id					[BIGINT],
	@id_comprobante		[BIGINT],
	@id_centrocosto		[BIGINT],
 	@concepto			[BIGINT]=NULL,
	@cuenta				[BIGINT]=0,
	@tercero			[BIGINT],
	@factura			[VARCHAR](50)=NULL,
	@fechavencimiento	SMALLDATETIME=NULL,
	@id_saldocuota  	BIGINT=NULL,
	@detalle	 		[VARCHAR](MAX),
    @valor				[NUMERIC] (18,2),
    @id_user			[BIGINT]
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[CNT].[ST_MOVComprobanteContaADD]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		10/07/2020
*Desarrollador: (Jeteme)

SP que ingresa a la tabla temporal de comprobantes contables
***************************************/
DECLARE @error VARCHAR(MAX), @id_return int, @preciotemp NUMERIC(18,4);
BEGIN TRY
BEGIN TRAN
	
	
	/*IF EXISTS (SELECT 1 FROM [CNT].[MOVComprobantesItemsTemp] WHERE id_comprobante = @id_comprobante AND id_articulo = @id_articulo AND precio != @preciotemp)
		RAISERROR ('Ya existe un art�culo dentro de esta factura y esta con precio diferente. Verifique.!', 16, 0);*/
	IF(@cuenta=0)
		sET @cuenta=(SELECT id_ctacontable FROM dbo.Productos where id=@concepto)
	IF(@id_centrocosto=0)
		sET @id_centrocosto=NULL

	IF(Isnull(@id,0) = 0)
	BEGIN
		INSERT INTO [CNT].[MOVComprobantesItemsTemp] (id_comprobante,id_concepto,id_centrocosto,id_cuenta ,id_tercero, detalle,valor,factura,id_saldocuota,fechavencimiento, id_usercreated)
		SELECT @id_comprobante,@concepto,@id_centrocosto,@cuenta, @tercero,@detalle, @valor,@factura,@id_saldocuota,@fechavencimiento, @id_user;

		SET @id_return = SCOPE_IDENTITY();

		IF(ISNULL(@id_return,0) = 0)
			RAISERROR('No se inserto art�culo en el Comprobante.', 16, 0);
	  
	  SET @id=@id_return;

	END
	ELSE
	BEGIN
		UPDATE [CNT].[MOVComprobantesItemsTemp] SET id_concepto=@concepto,
													id_centrocosto=@id_centrocosto,
													id_cuenta=@cuenta,
													detalle=@detalle,
													valor=@valor,
													factura=@factura,
													id_saldocuota=@id_saldocuota,
													fechavencimiento=@fechavencimiento
		where id=@id


	END


	SELECT 
		I.id,Ce.nombre centrocosto ,C.codigo+' '+C.nombre cuenta, P.nombre concepto, ISNULL(T.primernombre, '') + ' ' + ISNULL(T.segundonombre, '') + ' ' + ISNULL(T.primerapellido, '') + ' ' + ISNULL(T.segundoapellido, '') AS tercero,case when (I.valor>0) then I.valor else 0 end debito,case when (I.valor<0) then I.valor*-1 else 0 end credito,R.Tdebito,R.Tcredito,R.diferencia,I.factura,I.id_saldocuota
		
	FROM 
		[CNT].[MOVComprobantesItemsTemp]  I
		INNER JOIN CNTCuentas C ON I.id_cuenta=C.id
		LEFT JOIN dbo.Productos P ON I.id_concepto=P.id
		INNER JOIN [CNT].[VW_Terceros]        AS T ON I.id_tercero   = T.id 
		LEFT JOIN [CNT].CentroCosto	CE	ON I.id_centrocosto=CE.id
		Cross Apply CNT.ST_FnCalTotalComprobante(@id_comprobante,'T') R
	WHERE 
		I.id = @id;

COMMIT TRAN;
END TRY
BEGIN CATCH
		ROLLBACK TRAN;
	    --Getting the error description
	    SELECT @error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	    -- save the error in a Log file
	    RAISERROR(@error,16,1);
	    RETURN  
END CATCH
