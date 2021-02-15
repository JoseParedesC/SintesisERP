--liquibase formatted sql
--changeset ,jeteme:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[VW_Productos]') and OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
	Drop View [dbo].[VW_Productos]
END
GO

CREATE VIEW [dbo].[VW_Productos]
AS
SELECT  A.id, 
		A.codigo, 
		A.presentacion, 
		A.nombre, 
		A.modelo, 
		A.impuesto, 
		A.id_iva,
		A.id_inc,
		P.nombre nomImpuestoIva,
		ISNULL(P.valor, 0) poriva,
		U.nombre nomImpuestoInc, 
		ISNULL(U.valor, 0) porinc,
		A.estado, 
		A.precio, 
		A.porcendescto, 
		A.categoria, 
		TA.nombre AS Tipo, 
		A.stock, 
		A.ivaincluido,
		A.serie, 
		A.formulado, 
		A.urlimg, 
		A.facturable, 
		A.color, 
		A.marca, 
        m.codigo + ' ' + m.nombre AS marcacompl, 
		A.codigobarra, 
		A.inventario, 
		A.tipoproducto, 
		l.iden AS nombreTipoProducto, 
		A.lote, 
		A.id_ctacontable, 
		C.codigo AS Cuentacontable,  
        A.id_tipodocu,
		T.codigo as codigoTipodocu,
		T.nombre nombreTipoDocumento,
		A.id_naturaleza,
		I.nombre Naturaleza,
		A.esDescuento
FROM    dbo.Productos AS A LEFT OUTER JOIN
	 dbo.CategoriasProductos AS TA ON TA.id = A.categoria LEFT OUTER JOIN
	 dbo.Marcas AS m ON A.marca = m.id LEFT OUTER JOIN
	 dbo.ST_Listados AS l ON A.tipoproducto = l.id LEFT OUTER JOIN
	 dbo.CNTCuentas AS C ON A.id_ctacontable = C.id LEFT OUTER JOIN
	 cnt.TipoDocumentos as T ON A.id_tipodocu=T.id LEFT OUTER JOIN
	 dbo.ST_Listados as I ON A.id_naturaleza=I.id LEFT OUTER JOIN
	 CNT.IMPUESTOS AS P ON A.id_iva=P.id LEFT OUTER JOIN
	 CNT.IMPUESTOS AS U ON A.id_inc=U.id










GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[34] 4[5] 2[29] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -96
         Left = 0
      End
      Begin Tables = 
         Begin Table = "A"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 29
         End
         Begin Table = "TA"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "m"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 136
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "l"
            Begin Extent = 
               Top = 6
               Left = 662
               Bottom = 136
               Right = 832
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "C"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "E"
            Begin Extent = 
               Top = 138
               Left = 246
               Bottom = 268
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 27
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VW_Productos'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VW_Productos'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VW_Productos'
GO


