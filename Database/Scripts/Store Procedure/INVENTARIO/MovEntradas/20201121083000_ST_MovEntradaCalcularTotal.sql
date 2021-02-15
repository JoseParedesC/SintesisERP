--liquibase formatted sql
--changeset ,jteheran:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovEntradaCalcularTotal]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MovEntradaCalcularTotal]
GO

CREATE PROCEDURE [dbo].[ST_MovEntradaCalcularTotal]
	@id_proveedor		INT, 
	@id_entra			INT, 
	@flete				NUMERIC(18,2),
	@opcion				VARCHAR(3), 
	@id_entrada			BIGINT = null,
	@id_proveedorfle	BIGINT,
	@anticipo			[NUMERIC] (18,2) = 0,
	@id_ctaant			[BIGINT],
	@op					[CHAR] (1),
	@fecha		  [VARCHAR] (10)
AS
BEGIN
/***************************************
*Nombre:		[dbo].[ST_MovEntradaCalcularTotal]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		15/09/20
*Desarrollador: (Jeteme)
***************************************/
	Declare @ds_error varchar(max),@id_catFiscal int,@id_cat int,@retiene bit,@valoranticipo NUMERIC(18, 2) = 0, @anomes VARCHAR(6)
	
	Begin Try
	SET @anomes = REPLACE(@fecha, '-', '');
	
		
	SELECT TOP 1 @valoranticipo = saldoactual FROM CNt.SaldoTercero 
	WHERE id_tercero = @id_proveedor AND anomes = @anomes AND id_cuenta = @id_ctaant
	
	IF(@anticipo>0)
		SET @valoranticipo = iif(@anticipo>@valoranticipo,@valoranticipo,@anticipo);
	
	SET @id_catFiscal = (SELECT id_catfiscal FROM CNT.Terceros T WHERE T.id = @id_proveedor);
	SELECT @id_cat = F.id, @retiene =  F.retiene FROM  CNTCategoriaFiscal F WHERE F.id = @id_catFiscal AND F.retiene != 0
	SELECT 
		@valoranticipo anticipo,
		R.porfuente, 
		R.retfuente, 
		R.poriva, 
		R.retiva, 
		R.porica, 
		R.retica, 
		R.costo Tcosto, 
		R.iva+R.ivaFlete Tiva, 
		R.descuento Tdesc,
		R.tinc Tinc, 
		(R.total) Ttotal , 
		@anticipo valoranticipo
	FROM Dbo.ST_FnCalRetenciones(@id_proveedor, @id_entra, @flete, @opcion, @id_entrada, @id_proveedorfle,@id_catFiscal,@id_cat,@retiene) R
	
End Try
Begin Catch
--Getting the error description
Set @ds_error   =  ERROR_PROCEDURE() + 
				';  ' + convert(varchar,ERROR_LINE()) + 
				'; ' + ERROR_MESSAGE()
-- save the error in a Log file
RaisError(@ds_error,16,1)
return
End Catch
END
GO


