--liquibase formatted sql
--changeset ,CZULBARAN:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_Dashboard]') and OBJECTPROPERTY(id, N'IsProcedure') = 1) 
DROP PROCEDURE dbo.ST_Dashboard
GO
CREATE PROCEDURE [dbo].[ST_Dashboard]
	@id_user [int] = 0


AS
	
BEGIN TRY
DECLARE @error VARCHAR(MAX) = ''
/***************************************
*Nombre:		[Dbo].[ST_Dashboard]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		10/04/17 - 28/11/20
*Desarrollador: (JTOUS) y (CZULBARAN)
*Descripción:   Graficacíón en el dashboard consumiendo un xml haciendo 4 consultas y pintando dos graficas:
                Compras  vs Ventas // Cartera vs Recaudo
***************************************/

DECLARE @anoactual VARCHAR(4) = CONVERT(VARCHAR(4), GETDATE(), 112), @facturas VARCHAR(MAX) = '', @id_empresa INT, @id_role BIGINT;
DECLARE @faturas INT = 0, @ordened INT = 0, @compras INT = 0, @recaudos INT = 0;
DECLARE @SQL VARCHAR (MAX) = '';

		SELECT @facturas = COUNT(1) FROM MOVFactura WHERE CONVERT(VARCHAR(4), fechafac, 112) = CONVERT(VARCHAR(4), GETDATE(), 112);	
		SELECT @compras = COUNT(1) FROM MOVEntradas WHERE CONVERT(VARCHAR(4), fechadocumen, 112) = CONVERT(VARCHAR(4), GETDATE(), 112);
		SELECT @ordened =  COUNT(1) FROM MovOrdenCompras WHERE CONVERT(VARCHAR(4), fechadocument, 112) = CONVERT(VARCHAR(4), GETDATE(), 112);	


		SET @facturas = (SELECT TOP 1 ISNULL(@ordened, 0) ordenes, ISNULL(@compras, 0) compras, ISNULL(@facturas, 0) facturas, ISNULL(@recaudos, 0) recaudos FROM parametros AS cabecera FOR XML AUTO, ELEMENTS)

		SET @SQL = 'SELECT ''<top>''+'''+@facturas+'<ventas>'' +ISNULL((SELECT ISNULL(['+@anoactual+'01],0) enero, ISNULL(['+@anoactual+'02],0) febrero, ISNULL(['+@anoactual+'03],0) marzo, ISNULL(['+ @anoactual+'04],0) abril, ISNULL(['+ @anoactual+'05],0) mayo, ISNULL(['+ @anoactual+'06],0) junio, ISNULL(['+ @anoactual+'07],0) julio, ISNULL(['+ @anoactual+'08],0) agosto, ISNULL(['+ @anoactual+'09],0) septiembre, ISNULL(['+
				@anoactual+'10],0) octubre, ISNULL(['+ @anoactual+'11],0) noviembre, ISNULL(['+ @anoactual+'12],0) diciembre'+
		' FROM  
		(		
			SELECT CONVERT(VARCHAR(6), fechafac, 112) fecha, total 
			FROM Movfactura
			WHERE estado = [dbo].[ST_FnGetIdList](''PROCE'') AND CONVERT(VARCHAR(4), fechafac, 112) = '''+@anoactual+'''
		) AS TEMP
		PIVOT  
		(  
		SUM(total)  
		FOR fecha IN (['+@anoactual+'01], ['+ @anoactual+'02], ['+ @anoactual+'03], ['+ @anoactual+'04], ['+ @anoactual+'05], ['+ @anoactual+'06], ['+  
						@anoactual+'07], ['+ @anoactual+'08], ['+ @anoactual+'09], ['+ @anoactual+'10], ['+ @anoactual+'11], ['+ @anoactual+'12])  
		) AS Meses FOR XML AUTO, ELEMENTS), '''') +''</ventas><compras>''+
		ISNULL((SELECT ISNULL(['+@anoactual+'01],0) enero, ISNULL(['+@anoactual+'02],0) febrero, ISNULL(['+@anoactual+'03],0) marzo, ISNULL(['+ @anoactual+'04],0) abril, ISNULL(['+ @anoactual+'05],0) mayo, ISNULL(['+ @anoactual+'06],0) junio, ISNULL(['+ @anoactual+'07],0) julio, ISNULL(['+ @anoactual+'08],0) agosto, ISNULL(['+ @anoactual+'09],0) septiembre, ISNULL(['+
				@anoactual+'10],0) octubre, ISNULL(['+ @anoactual+'11],0) noviembre, ISNULL(['+ @anoactual+'12],0) diciembre'+
		' FROM  
		(		
			SELECT CONVERT(VARCHAR(6), fechadocumen, 112) fecha, valor 
			FROM MovEntradas
			WHERE estado = [dbo].[ST_FnGetIdList](''PROCE'') AND CONVERT(VARCHAR(4), fechadocumen, 112) = '''+@anoactual+'''
		) AS TEMP
		PIVOT  
		(  
		SUM(valor)  
		FOR fecha IN (['+@anoactual+'01], ['+ @anoactual+'02], ['+ @anoactual+'03], ['+ @anoactual+'04], ['+ @anoactual+'05], ['+ @anoactual+'06], ['+  
						@anoactual+'07], ['+ @anoactual+'08], ['+ @anoactual+'09], ['+ @anoactual+'10], ['+ @anoactual+'11], ['+ @anoactual+'12])  
		) AS Meses FOR XML AUTO, ELEMENTS), '''')+''</compras><cartera>'' +ISNULL((SELECT ISNULL(['+@anoactual+'01],0) enero, ISNULL(['+@anoactual+'02],0) febrero, ISNULL(['+@anoactual+'03],0) marzo, ISNULL(['+ @anoactual+'04],0) abril, ISNULL(['+ @anoactual+'05],0) mayo, ISNULL(['+ @anoactual+'06],0) junio, ISNULL(['+ @anoactual+'07],0) julio, ISNULL(['+ @anoactual+'08],0) agosto, ISNULL(['+ @anoactual+'09],0) septiembre, ISNULL(['+
				@anoactual+'10],0) octubre, ISNULL(['+ @anoactual+'11],0) noviembre, ISNULL(['+ @anoactual+'12],0) diciembre'+
		' FROM  
		(		
			SELECT CONVERT(VARCHAR(6),fechafac,112) as anomes, totalcredito
			FROM MOVFactura WHERE estado = [dbo].[ST_FnGetIdList](''PROCE'') AND CONVERT(VARCHAR(4), fechafac, 112) = '''+@anoactual+'''
	
		) AS TEMP
		PIVOT  
		(  
		SUM(totalcredito)   
		FOR anomes  IN (['+@anoactual+'01], ['+ @anoactual+'02], ['+ @anoactual+'03], ['+ @anoactual+'04], ['+ @anoactual+'05], ['+ @anoactual+'06], ['+  
						@anoactual+'07], ['+ @anoactual+'08], ['+ @anoactual+'09], ['+ @anoactual+'10], ['+ @anoactual+'11], ['+ @anoactual+'12])  
		) AS Meses FOR XML AUTO, ELEMENTS), '''') +''</cartera><recaudo>''+
		ISNULL((SELECT ISNULL(['+@anoactual+'01],0) enero, ISNULL(['+@anoactual+'02],0) febrero, ISNULL(['+@anoactual+'03],0) marzo, ISNULL(['+ @anoactual+'04],0) abril, ISNULL(['+ @anoactual+'05],0) mayo, ISNULL(['+ @anoactual+'06],0) junio, ISNULL(['+ @anoactual+'07],0) julio, ISNULL(['+ @anoactual+'08],0) agosto, ISNULL(['+ @anoactual+'09],0) septiembre, ISNULL(['+
				@anoactual+'10],0) octubre, ISNULL(['+ @anoactual+'11],0) noviembre, ISNULL(['+ @anoactual+'12],0) diciembre'+
		' FROM  
		(		
			SELECT CONVERT(VARCHAR(6), fecha, 112) as anomes, valorcliente
				FROM cnt.MOVReciboCajas WHERE estado = [dbo].[ST_FnGetIdList](''PROCE'') AND CONVERT(VARCHAR(4), fecha, 112) = '''+@anoactual+'''
			
		) AS TEMP
		PIVOT  
		(  
		SUM(valorcliente)  
		FOR anomes  IN (['+@anoactual+'01], ['+ @anoactual+'02], ['+ @anoactual+'03], ['+ @anoactual+'04], ['+ @anoactual+'05], ['+ @anoactual+'06], ['+  
						@anoactual+'07], ['+ @anoactual+'08], ['+ @anoactual+'09], ['+ @anoactual+'10], ['+ @anoactual+'11], ['+ @anoactual+'12])  
		) AS Meses FOR XML AUTO, ELEMENTS), '''')+''</recaudo></top>'' AS [xml];'  
		
		EXECUTE (@SQL)
END TRY
BEGIN CATCH
	--Getting the error description
	Select @error   =  ERROR_PROCEDURE() + 
				';  ' + convert(varchar,ERROR_LINE()) + 
				'; ' + ERROR_MESSAGE()
	-- save the error in a Log file
	RaisError(@error,16,1)  
End Catch