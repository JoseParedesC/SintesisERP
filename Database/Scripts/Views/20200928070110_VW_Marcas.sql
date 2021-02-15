--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_Marcas]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
	Drop View [dbo].[VW_Marcas]
END
GO


CREATE VIEW [dbo].[VW_Marcas]
AS
/***************************************
*Nombre:		[dbo].[VW_Marcas]
----------------------------------------
*Tipo:			Vista
*creación:		15/11/19
*Desarrollador: (Jeteme)
***************************************/
		SELECT        
				m.id,	
				m.codigo,
				m.nombre,
				m.estado,
				m.created,
				m.updated,
				m.id_usercreated,
				m.id_userupdated
				
		FROM    dbo.Marcas AS m 
		

GO


