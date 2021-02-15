--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_Rpt_SaldoCuenta]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [CNT].[ST_Rpt_SaldoCuenta] 
GO

CREATE PROCEDURE [CNT].[ST_Rpt_SaldoCuenta]
 
AS
/***************************************
*Nombre:		[CNT].[ST_Rpt_SaldoCuenta]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci?n:		01/09/2020
*Desarrollador:  Jesid Teheran Meza (jeteme)
*Descripcion:	Se realizan la consulta de saldo por cuenta anidadas
***************************************/
BEGIN
Declare @error varchar(max)
BEGIN TRY		
SET LANGUAGE Spanish
	
	;WITH
		categoriasCTE(id, id_padre, codigo, nombre, nivel, tipo,id_saldocuenta,saldo)
		AS
		(   
			SELECT 
				CC.id,
				CC.id_padre,
				CC.codigo,
				CC.nombre,
				CC.indice,
				CC.tipo,
				S.id,
				s.saldoActual
			FROM  CNTCuentas  CC inner join cnt.saldocuenta S on CC.id=S.id_cuenta
			
			UNION ALL
			-- Aqu? va la recursividad
			SELECT  
				A.id, 
				A.id_padre, 
				A.codigo, 
				A.nombre, 
				A.indice,
				A.tipo,
				E.id_saldocuenta,
				E.saldo
			FROM   CNTCuentas AS A 
				   INNER JOIN categoriasCTE AS E
			ON (A.codigo = E.id_padre )
		)
	SELECT codigo,nombre,SUM(saldo) saldo FROM categoriasCTE group by codigo,nombre,nivel ORDER BY codigo asc,nivel asc  	

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