--liquibase formatted sql
--changeset ,JARCINIEGAS:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_FnProxdia]') and OBJECTPROPERTY(id, N'IsTableFunction') = 1)
DROP FUNCTION [NOM].[ST_FnProxdia]
GO
CREATE FUNCTION [NOM].[ST_FnProxdia]( @id_contrato BIGINT)
/***************************************
*Nombre: [NOM].[ST_FnProxdia]
----------------------------------------
*Tipo: Función
*creación: 24/11/20
*Desarrollador: (Jarciniegas)
*Descripción: Lleva el conteo de la canti-
			  dad de solicitudes que se 
			  han hecho y se refleja en 
			  el campo de consecutivo
***************************************/
RETURNS @TblResultante  TABLE ( Id Int Identity (1,1) Not Null, proxdia VARCHAR(4), 
								diasdepago VARCHAR(MAX))
AS 
	
BEGIN
DECLARE @diasdepago VARCHAR(MAX)='', @proxdia VARCHAR(10), @i int = 0, @diasparapagar int , @id_return BIGINT
DECLARE @TAB TABLE(id INT IDENTITY(1,1),DIAS VARCHAR(10))
DECLARE @fechafin VARCHAR(10), @fechainicio VARCHAR(10), @fecha_inicial SMALLDATETIME, @fecha_final SMALLDATETIME
DECLARE @x bit = 0	

SET @diasparapagar = 20--(SELECT diasapagar FROM [NOM].[Contrato] WHERE id = @id_contrato)
SET @fechafin = ISNULL(CONVERT(VARCHAR,(SELECT fecha_final FROM [NOM].[Contrato] WHERE id = @id_contrato),112),'0') --traer de la tabla contrato, si en null=0  para que  no se agrege
SET @fechainicio = CONVERT(VARCHAR,(SELECT fecha_inicio FROM [NOM].[Contrato] WHERE id = @id_contrato),112) --traer de la base de datos, para sabar la primera frecha de pago
IF(@fechainicio<CONVERT(VARCHAR,GETDATE(),112))
	SET @fechainicio = CONVERT(VARCHAR,GETDATE(),112)
SET @fecha_inicial = CONVERT(SMALLDATETIME,@fechainicio)


WHILE @i < 30 
BEGIN
	SET @i += @diasparapagar;
	IF (@i>30)
	BEGIN
		SET @i = @i-30
		SET @fechainicio = CONVERT(VARCHAR(8),DATEADD(MM,1,@fechainicio),112)
	END	
	INSERT @TAB	(DIAS)
	VALUES(@i)	

	IF(@x=0)
		IF(CONVERT(INT, CONVERT(VARCHAR(2), DATEPART(MM,@fechainicio))+'00')+@i > CONVERT(INT, CONVERT(VARCHAR(2), DATEPART(MM ,@fecha_inicial)) + CASE WHEN DATALENGTH(CONVERT(VARCHAR(2),DATEPART ( DD ,@fecha_inicial))) = 1 THEN '0'+CONVERT(VARCHAR(2),DATEPART ( DD ,@fecha_inicial)) else CONVERT(VARCHAR(2),DATEPART ( DD ,@fecha_inicial))END))
		BEGIN
			--SELECT @i
			SET @proxdia = @i-CONVERT(INT, DATEPART(DD,@fechainicio)); 
			SET @proxdia = CONVERT(VARCHAR(8),DATEADD(DD,CONVERT(INT,@proxdia),@fechainicio),112);
			SET @proxdia =  CASE WHEN DATALENGTH(CONVERT(varchar(2),DATEPART ( MM ,CONVERT(SMALLDATETIME,@proxdia)))) = 1 then '0'+CONVERT(varchar(2),DATEPART ( MM ,CONVERT(SMALLDATETIME,@proxdia))) else convert(varchar(2),DATEPART ( MM ,CONVERT(SMALLDATETIME,@proxdia)))end 
			+CASE WHEN DATALENGTH(CONVERT(varchar(2),DATEPART ( DD ,CONVERT(SMALLDATETIME,@proxdia)))) = 1 then '0'+CONVERT(varchar(2),DATEPART ( DD ,CONVERT(SMALLDATETIME,@proxdia))) else convert(varchar(2),DATEPART ( DD ,CONVERT(SMALLDATETIME,@proxdia)))end 
								
				SET @x = 1
			END
	END;
					
	--SELECT * FROM @TAB

	SELECT @diasdepago = ISNULL(STUFF((SELECT ','+ DIAS FROM @TAB WHERE id>(SELECT id FROM @TAB WHERE DIAS= DATEPART(DD,CONVERT(SMALLDATETIME, '2000'+@proxdia))) FOR XML PATH('')),1,1,''),''); 

	SET @diasdepago += ','+ ISNULL(STUFF((SELECT ','+ DIAS FROM @TAB WHERE id<=(SELECT id FROM @TAB WHERE DIAS= DATEPART(DD,CONVERT(SMALLDATETIME, '2000'+@proxdia))) FOR XML PATH('')),1,1,''),'');
			
	--SELECT @proxdia, @diasdepago


	INSERT INTO @TblResultante (proxdia, diasdepago)
	VALUES	(@proxdia, @diasdepago);
	RETURN;
END;
