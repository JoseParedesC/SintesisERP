--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[GSC].[ST_TercerosClientesFacturasGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE GSC.ST_TercerosClientesFacturasGet
GO
 
CREATE PROCEDURE [GSC].[ST_TercerosClientesFacturasGet]

@id_user BIGINT,
@idC BIGINT

AS
/***************************************
*Nombre:		[GSC].[ST_TercerosClientesFacturasGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		12/11/2020
*Desarrollador: jparedes
*Descripcion:	Lista los datos del cliente, 
				codeudores, facturas, y el 
				historial de seguimiento
***************************************/
BEGIN TRY
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
		DECLARE @table TABLE (id int)

		SELECT TOP 1 T.id,
					   t.nombretipoiden tipoiden,
					   t.razonsocial cliente,
					   t.iden, 
					   t.sucursal,
					   t.direccion,
					   t.email,
					   t.telefono,
					   t.celular,
					   c.nombre ciudad,
					   t.nombrescontacto,
					   t.telefonocontacto,
					   t.emailcontacto
			FROM  	CNT.VW_Terceros t INNER JOIN 			
					[CNT].[VW_TercerosTipo] tt ON tt.id_tercero = t.id INNER JOIN
					[dbo].[DivPolitica] c ON c.id = t.id_ciudad
			WHERE tt.id = @idC
		
		SELECT id CONTACTO, id IDEN, id DIRECCION,id  TELEFONO,id CELULAR FROM @table 

		EXEC [GSC].[ST_FacturasList] @id_tercero = @idC

		EXEC [GSC].[ST_BitacoraList] @idC = @idC

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