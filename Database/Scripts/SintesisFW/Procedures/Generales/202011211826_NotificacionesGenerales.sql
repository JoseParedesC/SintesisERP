--liquibase formatted sql
--changeset ,apuello:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_NotificacionesGenerales]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[ST_NotificacionesGenerales]
GO
CREATE PROCEDURE [dbo].[ST_NotificacionesGenerales]
@id_user BIGINT
/***************************************
*Nombre: [dbo].[CategoriasProductosList]
----------------------------------------
*Tipo: Procedimiento almacenado
*creación: 21/11/20
*Desarrollador: (APUELLO)
*Descripcion: Devuelve el número de pagos por vencer y los pagos vencidos
***************************************/
AS

BEGIN TRY
	DECLARE @anomes VARCHAR(6), @pagosVencer INT, @pagosVencidos INT
	SET @anomes = (SELECT CONVERT(VARCHAR(6), GETDATE(), 112));
	
	DECLARE @error VARCHAR(MAX), @conven BIGINT
    SET @conven = [dbo].[ST_FnGetIdList] ('CONVENCIO')

    SET @pagosVencer =  (SELECT COUNT(nrofactura) pagosVencer
                        FROM [CNT].[SaldoProveedor] S
                        INNER JOIN MOVEntradas E ON E.id = S.id_documento
						INNER JOIN FormaPagos P ON E.id_formapagos = P.id
						WHERE  P.id_tipo != @conven AND
                                S.saldoactual != 0 AND DATEDIFF(DAY, S.fechavencimiento, GETDATE()) <= 0
                                AND S.anomes = @anomes)

    SET @pagosVencidos = (SELECT COUNT(nrofactura) pagosVencer
                          FROM [CNT].[SaldoProveedor] S
                          INNER JOIN MOVEntradas E ON E.id = S.id_documento
                          INNER JOIN FormaPagos P ON E.id_formapagos = P.id
						  WHERE  P.id_tipo != @conven AND
                                S.saldoactual != 0 AND DATEDIFF(DAY, S.fechavencimiento, GETDATE()) > 0
                                AND S.anomes = @anomes)


	SELECT 'Pagos a Vencer' title, @pagosVencer cantidad, 'NOTPV' [type]
	UNION
	SELECT 'Pagos Vencidos' title,  @pagosVencidos pagosVencidos, 'NOTVN' [type]
				
END TRY
BEGIN CATCH

	    --Getting the error description
	    Select @error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	    -- save the error in a Log file
	    RaisError(@error,16,1)
	    Return  
End Catch
