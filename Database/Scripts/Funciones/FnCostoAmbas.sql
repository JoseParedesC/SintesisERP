--liquibase formatted sql
--changeset ,jteheran:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[FnCostoAmbas]') and OBJECTPROPERTY(id, N'IsScalarFunction') = 1)
DROP FUNCTION [dbo].[FnCostoAmbas]
GO

-- =============================================
-- Author:		Jeteme
-- Create date: 
-- Description:	Funcion que me retorna el total de impuestos o costos de una entrada de todos los item servicio
-- =============================================
CREATE FUNCTION [dbo].[FnCostoAmbas] 
(
	-- Add the parameters for the function here
@idEntrada int,
	@opcion CHAR,
	@op VARCHAR(2),
	@id_iva BIGINT
)
RETURNS Numeric (18,2)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result Numeric (18,2)

	-- Add the T-SQL statements to compute the return value here
	SELECT @Result =CASE WHEN(@op='EN') 
	THEN 
	(CASE WHEN (@opcion='C') 
		THEN 
		(Select Sum((costo*cantidad)) from MOVEntradasItems M inner join Productos P ON M.id_articulo=p.id inner join ST_Listados S on p.tipoproducto=s.id where M.id_entrada=@idEntrada and (s.nombre='SERVICIO' or s.nombre='De Consumo' ))
		 WHEN (@opcion='D')--sumamos el total de costo -descuentos de servicios 
		 THEN
		 (Select SUM((costo-descuentound)*cantidad) from MOVEntradasItems M inner join Productos P ON M.id_articulo=p.id inner join ST_Listados S on p.tipoproducto=s.id where M.id_entrada=@idEntrada and (s.nombre='SERVICIO' or s.nombre='De Consumo' ))
		 WHEN (@opcion='I')
		 THEN
		(Select Sum(M.iva*cantidad) from MOVEntradasItems M inner join Productos P ON M.id_articulo=p.id inner join ST_Listados S on p.tipoproducto=s.id  where M.id_entrada=@idEntrada and (s.nombre='SERVICIO' or s.nombre='De Consumo' )) 
		WHEN(@opcion='R')
	    THEN (Select Sum(M.retefuente*cantidad) from MOVEntradasItems M inner join Productos P ON M.id_articulo=p.id inner join ST_Listados S on p.tipoproducto=s.id  where M.id_entrada=@idEntrada and (s.nombre='SERVICIO' or s.nombre='De Consumo' ))
		WHEN(@opcion='V')
	    THEN (Select Sum(M.reteiva*cantidad) from MOVEntradasItems M inner join Productos P ON M.id_articulo=p.id inner join ST_Listados S on p.tipoproducto=s.id  where M.id_entrada=@idEntrada and (s.nombre='SERVICIO' or s.nombre='De Consumo' ))
		WHEN(@opcion='A')
	    THEN (Select Sum(M.reteica*cantidad) from MOVEntradasItems M inner join Productos P ON M.id_articulo=p.id inner join ST_Listados S on p.tipoproducto=s.id  where M.id_entrada=@idEntrada and (s.nombre='SERVICIO' or s.nombre='De Consumo' ))  END)
	 ELSE
	 (CASE WHEN (@opcion='C')
	 THEN 
	 (Select Sum((costo*cantidad)) from MOVdEVEntradasItems M inner join Productos P ON M.id_articulo=p.id inner join ST_Listados S on p.tipoproducto=s.id where M.id_devolucion=@idEntrada and (s.nombre='SERVICIO' or s.nombre='De Consumo' ))
	 WHEN (@opcion='D')--sumamos el total de costo -descuentos de servicios 
	 THEN
	 (Select SUM((costo-descuentound)*cantidad) from MOVdEVEntradasItems M inner join Productos P ON M.id_articulo=p.id inner join ST_Listados S on p.tipoproducto=s.id where M.id_devolucion=@idEntrada and (s.nombre='SERVICIO' or s.nombre='De Consumo' ))
	 WHEN (@opcion='I')
	 THEN
	 (Select Sum(M.iva*cantidad) from MOVDevEntradasItems M inner join Productos P ON M.id_articulo=p.id inner join ST_Listados S on p.tipoproducto=s.id where M.id_devolucion=@idEntrada and (s.nombre='SERVICIO' or s.nombre='De Consumo' )) 
	 WHEN(@opcion='R')
	 THEN 
	(Select Sum(M.retefuente*cantidad) from MOVDevEntradasItems M inner join Productos P ON M.id_articulo=p.id inner join ST_Listados S on p.tipoproducto=s.id where M.id_devolucion=@idEntrada and (s.nombre='SERVICIO' or s.nombre='De Consumo' )) 
	WHEN (@opcion='V')
	THEN (Select Sum(M.reteiva*cantidad) from MOVDevEntradasItems M inner join Productos P ON M.id_articulo=p.id inner join ST_Listados S on p.tipoproducto=s.id where M.id_devolucion=@idEntrada and (s.nombre='SERVICIO' or s.nombre='De Consumo' ))
	WHEN (@opcion='A')
	THEN (Select Sum(M.reteica*cantidad) from MOVDevEntradasItems M inner join Productos P ON M.id_articulo=p.id inner join ST_Listados S on p.tipoproducto=s.id where M.id_devolucion=@idEntrada and (s.nombre='SERVICIO' or s.nombre='De Consumo' ))
	END)
	END 

	-- Return the result of the function
	RETURN @Result

END
