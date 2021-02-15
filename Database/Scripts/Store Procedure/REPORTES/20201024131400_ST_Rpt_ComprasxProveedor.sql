--liquibase formatted sql
--changeset ,jteheran:2 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_Rpt_ComprasxProveedor]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [dbo].[ST_Rpt_ComprasxProveedor]
GO
CREATE PROCEDURE [dbo].[ST_Rpt_ComprasxProveedor] 
@fechaini SMALLDATETIME,
@fechafinal SMALLDATETIME,
@id_proveedor BIGINT=null,
@id_user BIGINT
--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[Dbo].[ST_Rpt_ComprasxProveedor]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		15/05/2020
*Desarrollador:  Jeteheran
***************************************/
BEGIN
Declare @error varchar(max)
DECLARE @table TABLE(identrada BIGINT ,id_proveedor BIGINT,vlrbruto NUMERIC(18,2),totalIva NUMERIC(18,2),totalInc NUMERIC(18,2),descuento NUMERIC(18,2),subtotal NUMERIC(18,2),retefuente NUMERIC(18,2),reteica NUMERIC(18,2),reteiva NUMERIC(18,2),valortotal NUMERIC(18,2) )
BEGIN TRY		
SET LANGUAGE Spanish

		
				INSERT INTO @table(identrada,id_proveedor,vlrbruto,totalIva,totalInc,descuento,subtotal,retefuente,reteica,reteiva,valortotal)
				SELECT	P.id,P.id_proveedor,SUM(P.valorbruto*cantidad) vlrbruto,SUM(P.total_iva*cantidad) totalIva,SUM(P.total_inc*cantidad) totalInc,E.descuento,SUM(P.valorbruto*cantidad-p.descuento) subtotal,E.retefuente,E.reteica,E.reteiva,SuM(P.total)-E.retefuente-E.reteica-E.reteiva valortotal from [VW_Productos_comprados] P INNER JOIN MOVEntradas E ON P.id=E.id WHERE E.fechadocumen BETWEEN @fechaini and @fechafinal AND( Isnull(@id_proveedor,0) = 0 OR P.id_proveedor=@id_proveedor) GROUP BY P.Id_proveedor,P.ID,E.valor,E.descuento,E.retefuente,E.reteica,E.reteiva


		SELECT CONCAT(t.iden,IIF(t.digitoverificacion is null,'',CONCAT('-',t.digitoverificacion))) Identificacion,
		razonsocial,
		COUNT(*)  NumComprobante,
		sum(E.vlrbruto) ValorBruto,
		SUM(E.subtotal) subtotal,
		SUM(E.descuento) descuento,
		ISNULL(SUM(totalIva),0) totalIva,
		ISNULL(SUM(totalInc),0) totalInc,
		ISNULL(SUM(reteica),0) Treteica,
		ISNULL(SUM(reteiva),0) Treteiva,
		ISNULL(SUM(retefuente),0) Tretefuente,
		SUM(valortotal) total,
		U.nombre usuario
		FROM @table E INNER JOIN
		  [CNT].[VW_Terceros]        AS T ON E.id_proveedor     = T.id  INNER JOIN
		  dbo.Usuarios U ON U.id=@id_user
		 GROUP BY t.iden,t.digitoverificacion,t.razonsocial,U.nombre
END TRY
BEGIN Catch
	    --Getting the error description
	    Select @error   =  ERROR_PROCEDURE() + 
					';  ' + convert(varchar,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE()
	    -- save the error in a Log file
	    RaisError(@error,16,1)
	    Return  
	End Catch
END
GO


