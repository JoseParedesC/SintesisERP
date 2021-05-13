--liquibase formatted sql
--changeset ,jarciniegas:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_PeriodoPorContratoSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_PeriodoPorContratoSave]
GO
CREATE PROCEDURE [NOM].[ST_PeriodoPorContratoSave]

@id_contrato BIGINT  ,
@id_periodo BIGINT  

AS
/****************************************
*Nombre:		[NOM].[ST_PeriodoPorContratoSave]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		16/10/2020
*Desarrollador: (JARCINIEGAS)
*DESCRIPCIÓN:	Recoge el id que envia la 
				función FechaFesDelete y
				elimina el registro que 
				coincide con el id
****************************************/
BEGIN

Declare @ds_error varchar(max)

Begin Try

IF EXISTS(SELECT 1 FROM [NOM].[VW_Contratos] WHERE id_contrato = @id_contrato AND estado = 'Vigente')
BEGIN
	IF NOT EXISTS(SELECT 1 FROM [NOM].[Periodos_Por_Contrato] WHERE id_contrato = @id_contrato)
	BEGIN
		INSERT INTO [NOM].[Periodos_Por_Contrato](id_contrato, id_periodo, fecha_pago, id_usercreated, id_userupdated)
			SELECT @id_contrato, @id_periodo, CONCAT(CONVERT(VARCHAR, DATEPART(YY, GETDATE())), PP.prox_dia_pago), 1, 1
			FROM [NOM].[VW_Contratos] C
			INNER JOIN [NOM].[Periodos_Pago] PP ON C.id_periodo = PP.id
			WHERE C.id_contrato = @id_contrato AND PP.id = @id_periodo
	END
END


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




