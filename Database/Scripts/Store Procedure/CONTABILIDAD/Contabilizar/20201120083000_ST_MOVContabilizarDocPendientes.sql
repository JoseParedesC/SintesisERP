--liquibase formatted sql
--changeset ,jteheran:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[CNT].[ST_MOVContabilizarDocPendientes]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE  [CNT].[ST_MOVContabilizarDocPendientes] 
GO

CREATE PROCEDURE [CNT].[ST_MOVContabilizarDocPendientes] 
	-- Add the parameters for the stored procedure here
@fechaini    smalldatetime,
	@fechafin    smalldatetime,
	@esquema   VARCHAR(3)='dbo',
	@xml         XML=NULL,
	@id_user     BIGINT
	
AS
	DECLARE @mensaje VARCHAR(max),@rows int,@count int=1,@id_documento BIGINT,@fecha VARCHAR(10),@anomes VARCHAR(6),@vista VARCHAR(50),@manejador int;
	DECLARE @table TABLE (id int identity (1,1), id_documento BIGINT, fecha VARCHAR(10), anomes varchar(6),vista VARCHAR(50));

BEGIN TRANSACTION
BEGIN TRY


	IF(@xml is null)
		INSERT INTO @table 
		Select id,fecha,anomes,vista
		FROM [CNT].[VW_PROCESOSCONTABILIZAR] WHERE  
		fecha between convert(VARCHAR(10),@fechaini,120) and convert(VARCHAR(10),@fechafin,120)  and (isnull(@esquema,'')='' or Esquema=@esquema) 
		order by Esquema desc,NIVEL ASC
	ELSE
		BEGIN

		 EXEC sp_xml_preparedocument @manejador OUTPUT, @xml; 	

			INSERT INTO @table 
			SELECT id, convert(VARCHAR(10),fecha,120), convert(VARCHAR(6),fecha,112),vista
			FROM OPENXML(@manejador, N'root/cont') 
			WITH (  id			[BIGINT]			'@id',
					vista		[VARCHAR](50)		'@vista',
					fecha		SMALLDATETIME		'@fecha'
					)								
			EXEC sp_xml_removedocument @manejador;
		END
	
		

	SET @rows = @@ROWCOUNT;
	WHILE(@rows >= @count)
	BEGIN
		SELECT @id_documento=id_documento,@fecha=fecha,@anomes=anomes,@vista=vista FROM @table where id=@count
			
		EXEC CNT.ST_MOVContabilizar @id=@id_documento,@id_user=@id_user,@fecha=@fecha,@anomes=@anomes,@nombreView=@vista
		
	SET @count+=1
	END


COMMIT TRANSACTION;
END TRY
BEGIN CATCH	
	SET @mensaje = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@Mensaje,16,0);	
	ROLLBACK TRANSACTION;
END CATCH





