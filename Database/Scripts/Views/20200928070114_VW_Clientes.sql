--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_Clientes]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
	Drop View [dbo].[VW_Clientes]
END
GO

CREATE VIEW [dbo].[VW_Clientes]
AS
/***************************************
*Nombre:		[dbo].[VW_Clientes]
----------------------------------------
*Tipo:			Vista
*creaci�n:		02/04/17
*Desarrollador: (JTOUS)
***************************************/
		SELECT        
				 C.id
				,C.tercero	
				,C.iden	
				,C.nombretipoiden				
				,C.primernombre	
				,C.segundonombre	
				,C.primerapellido	
				,C.segundoapellido	
				,C.razonsocial	
				,C.ciudad	
				,C.id_ciudad	
				,C.direccion	
				,C.sucursal	
				,C.tiporegimen	
				,C.regimen	
				,C.nombrecomercial	
				,C.paginaweb	
				,C.fechaexpedicion	
				,C.fechanacimiento	
				,C.telefono	
				,C.email	
				,C.celular	
				,C.digitoverificacion	
				,C.nombrescontacto	
				,C.telefonocontacto	
				,C.emailcontacto	
				,C.estado	
				,C.tipoiden	
				,C.id_personeria	
				,C.personeria	
				,C.id_catfiscal
				,T.id id_tipoter				
		FROM    CNT.VW_Terceros AS C 
		INNER JOIN CNT.TipoTerceros T ON T.id_tercero = C.id
		WHERE T.id_tipotercero = Dbo.ST_FnGetIdList('CL')

GO


