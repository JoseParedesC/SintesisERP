--liquibase formatted sql
--changeset ,CZULBARAN:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_ParametrosSave]') and OBJECTPROPERTY(id, N'IsProcedure') = 1) 
DROP PROCEDURE dbo.ST_ParametrosSave
GO
CREATE PROCEDURE [dbo].[ST_ParametrosSave]

@IdUser INT,
@xml XML


AS
/***************************************
*Nombre:		[dbo].[ST_ParametrosSave]
-----------------------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		30/11/2020
*Desarrollador: CZULBARAN
*Descripcion:	Se guardan la cantidad de parametros en cada codigo enviado desde el xml del Javascript
***************************************/
Declare @Mensaje varchar(max),@idper int
declare @tabla table (id int identity, valor varchar(max), codigo varchar(max), extratexto varchar(max))
BEGIN TRY

EXEC sp_xml_preparedocument @idper output, @xml 
insert into @tabla (valor, codigo, extratexto)
select valor, codigo, extratexto from openxml (@idper,'root/item') with (valor varchar(max), codigo varchar(max), extratexto varchar(max))
	
	UPDATE  P SET
	P.valor = T.valor,
	P.extratexto = T.extratexto
	FROM [dbo].[Parametros] P INNER JOIN @tabla T ON T.codigo = P.codigo
	
	

END TRY
BEGIN CATCH	
	SET @Mensaje = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@Mensaje,16,0);	
END CATCH