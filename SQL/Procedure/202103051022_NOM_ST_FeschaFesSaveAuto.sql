--liquibase formatted sql
--changeset ,JARCINIEGAS:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_FechaFesSaveAuto]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_FechaFesSaveAuto]
GO
CREATE PROCEDURE [NOM].[ST_FechaFesSaveAuto]
AS

/***************************************
*Nombre:		[NOM].[ST_FechaFesSaveAuto]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		16/10/2020
*Desarrollador: (JARCINIEGAS)
*DESCRIPCIÓN:	Guarda la información re-
				cogida de la vista en la
				tabla [dbo].[FechaFes]
***************************************/

BEGIN TRANSACTION
BEGIN TRY

	DECLARE  @id_return INT, @error VARCHAR(MAX);

declare @fecha_inicial smalldatetime = convert(smalldatetime, convert (varchar(4),DATEPART ( YY , getdate())) +'0101');
declare @fecha_final smalldatetime = convert(smalldatetime, convert (varchar(4),DATEPART ( YY , getdate())) +'1231');
declare @domingo int = 0
declare @sabado int = 0
declare @otrodia int = 0
declare @fecha varchar(8)
declare @mandar smalldatetime

while (@fecha_inicial < @fecha_final)
begin 
    if (DATEPART(WEEKDAY, @fecha_inicial) = 6)
	begin

		 set @sabado = @sabado + 1

		set @fecha=
		convert (varchar(4),DATEPART ( YY , @fecha_inicial )) +
		case when DATALENGTH(convert(varchar(2),DATEPART ( MM , @fecha_inicial ))) = 1 then '0'+convert(varchar(2),DATEPART ( MM , @fecha_inicial )) else convert(varchar(2),DATEPART ( MM , @fecha_inicial ))end +
		case when DATALENGTH(convert(varchar(2),DATEPART ( DD , @fecha_inicial ))) = 1 then '0'+convert(varchar(2),DATEPART ( DD , @fecha_inicial )) else convert(varchar(2),DATEPART ( DD , @fecha_inicial ))end


		--select @fecha día, datename(DW, @fecha) nombre

		set  @mandar = convert(date, @fecha, 120)

		EXEC [NOM].[ST_FechaFesSave] @fecha = @fecha, @tipo = 'S', @id_user = 1;
   
	end
	else if (DATEPART(WEEKDAY, @fecha_inicial) = 7)
	begin
		set @domingo = @domingo + 1;

		set @fecha=
		convert (varchar(4),DATEPART ( YY , @fecha_inicial )) +
		case when DATALENGTH(convert(varchar(2),DATEPART ( MM , @fecha_inicial ))) = 1 then '0'+convert(varchar(2),DATEPART ( MM , @fecha_inicial )) else convert(varchar(2),DATEPART ( MM , @fecha_inicial ))end +
		case when DATALENGTH(convert(varchar(2),DATEPART ( DD , @fecha_inicial ))) = 1 then '0'+convert(varchar(2),DATEPART ( DD , @fecha_inicial )) else convert(varchar(2),DATEPART ( DD , @fecha_inicial ))end


		--select @fecha día, datename(DW, @fecha) nombre

		set  @mandar = convert(date, @fecha, 120)

		EXEC [NOM].[ST_FechaFesSave] @fecha = @fecha, @tipo = 'D', @id_user = 1;

	end
	else
	begin
		set @otrodia = @otrodia + 1
end                  
    set @fecha_inicial = DATEADD(DAY, 1, @fecha_inicial);
end

select @otrodia diasSemana, @sabado sabado, @domingo domingo;



	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	SET @error = 'Error: '+ERROR_MESSAGE();
	RAISERROR(@error,16,0);		
	ROLLBACK TRANSACTION;
END CATCH

SELECT @id_return id ;

