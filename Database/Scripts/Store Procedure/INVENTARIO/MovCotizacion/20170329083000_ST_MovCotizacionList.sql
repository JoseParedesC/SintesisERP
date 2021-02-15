--liquibase formatted sql
--changeset ,JARCINIEGAS:3 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[dbo].[ST_MovCotizacionList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ST_MovCotizacionList]
GO
CREATE PROCEDURE [dbo].[ST_MovCotizacionList]
    @page INT = 1,
    @numpage INT = 10,
    @countpage INT = 0 OUTPUT,
    @filter VARCHAR(50) = NULL,
    @id_caja BIGINT ,
    @id_user INT ,
    @estado VARCHAR(20) 
 
AS
/***************************************
*Nombre:        [dbo].[ST_MovCotizacionList]
----------------------------------------
*Tipo:            Procedimiento almacenado
*creaci�n:        27/03/17
*Desarrollador: (JTOUS)
***************************************/
DECLARE @error VARCHAR(MAX), @starpage INT = 1, @endpage INT = 1;
DECLARE @temp TABLE(id_record INT IDENTITY(1,1) ,id_pk INT )
BEGIN TRY
 
    IF EXISTS(SELECT 1 FROM Dbo.Usuarios U Inner JOIN aspnet_Roles R ON U.id_perfil = R.id WHERE U.id = @id_user AND UPPER(R.RoleName) IN ('ADMINISTRADOR', 'SUPER ADMINISTRADOR'))
        SET @id_caja = -1;
 
    SET @numpage = ISNULL(@numpage,10);
 
    SET @starpage = (@page * @numpage) - @numpage +1;
    SET @endpage = @numpage * @page;
 
    INSERT INTO @temp(id_pk)
    SELECT  id    
    FROM dbo.VW_MOVCotizaciones
    WHERE  
    ((isnull(@filter,'')='' or CAST(id AS Varchar) like '%' + @filter + '%') OR
    (isnull(@filter,'')='' or cliente like '%' + @filter + '%')) 
    ORDER BY id DESC;
 
    SET @countpage = @@rowcount;        
        
    if (@numpage = -1)
        SET @endpage = @countpage;
 
    IF(ISNULL(@estado,'') = '')
    BEGIN
 
        SELECT  A.id, A.fechacot, A.total, A.estado, cliente
        FROM @temp Tm
                Inner join dbo.VW_MOVCotizaciones A on Tm.id_pk = A.id
        WHERE id_record between @starpage AND @endpage 
        ORDER  BY A.id DESC;
    END
    ELSE
    BEGIN
        SELECT  A.id, A.fechacot, A.total, A.estado, A.cliente, T.iden identificacion
        FROM @temp Tm
                Inner join dbo.VW_MOVCotizaciones A on Tm.id_pk = A.id
                LEFT JOIN [CNT].[Terceros] T ON T.id = A.id_cliente
        WHERE id_record between @starpage AND @endpage AND A.estado = (SELECT nombre FROM ST_Listados WHERE iden = @estado) 
        ORDER  BY A.id DESC;
    END
            
END TRY
BEGIN CATCH
 
        --Getting the error description
        Select @error   =  ERROR_PROCEDURE() + 
                    ';  ' + convert(varchar,ERROR_LINE()) + 
                    '; ' + ERROR_MESSAGE()
        -- save the error in a Log file
        RaisError(@error,16,1)
        Return  
End Catch