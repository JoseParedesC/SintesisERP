--liquibase formatted sql
--changeset ,CZULBARAN:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_ParametrosGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1) 
DROP PROCEDURE dbo.ST_ParametrosGet
GO
CREATE PROCEDURE [dbo].[ST_ParametrosGet]
--@id BIGINT = 0,
@id_user INT

--WITH ENCRYPTION
AS
/***************************************
*Nombre:		[dbo].[ST_ParametrosGet]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		30/11/2020
*Desarrollador: CZULBARAN
*Descripcion:	Este procedimiento trae todos los parametros que tienen la posibilidad de editarse,
				es decir, todos los que tengan [default]=0
***************************************/
Declare @Mensaje varchar(max);
BEGIN TRY
		SELECT tipo,nombre,fuente,metadata,seleccion,campos,codigo,params,valor,icon,ancho as ancho, extratexto as extratexto
		FROM [dbo].[Parametros]
		where [default] = 0 
END TRY
BEGIN CATCH	
	SET @Mensaje = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@Mensaje,16,0);	
END CATCH