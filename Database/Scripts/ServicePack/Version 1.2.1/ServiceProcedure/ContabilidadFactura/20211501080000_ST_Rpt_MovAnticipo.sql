--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_Rpt_MovAnticipo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_Rpt_MovAnticipo]
GO


/***************************************
*Nombre:		[CNT].[ST_MOVTransacciones]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		15/01/2021
*Desarrollador: (Jeteme)

Reporte de anticipos 
***************************************/

CREATE PROCEDURE [dbo].[ST_Rpt_MovAnticipo]
@id BIGINT,
@op CHAR(1)
 
AS
Declare @error varchar(max)
Declare @table Table (id int identity, concepto varchar(50), valor numeric(18,2))
BEGIN TRY		
SET LANGUAGE Spanish
	IF(@op = 'A')
	BEGIN		
		SELECT id,iden +' - '+tercero cliente, fecha, usuario, valor, descripcion, 'Anticipo' concepto, 
		UPPER(LEFT(tipo, 1)) + LOWER(SUBSTRING(tipo, 2, LEN(tipo))) tipo,estado
		FROM VW_MovAnticipos
		WHERE id = @id;		
	END
	IF(@op = 'D')
	BEGIN		
		SELECT id,iden +' - '+tercero tercero, fecha, usuario, valor, descripcion, 'Devolucion de Anticipo' concepto,estado, 
		UPPER(LEFT(tipo, 1)) + LOWER(SUBSTRING(tipo, 2, LEN(tipo))) tipo
		FROM VW_MovDevAnticipos
		WHERE id = @id;		
	END
	
END TRY
BEGIN Catch
	--Getting the error description
	Select @error   =  ERROR_PROCEDURE() + 
				';  ' + convert(varchar,ERROR_LINE()) + 
				'; ' + ERROR_MESSAGE()
	-- save the error in a Log file
	RaisError(@error,16,1)
End Catch
GO






