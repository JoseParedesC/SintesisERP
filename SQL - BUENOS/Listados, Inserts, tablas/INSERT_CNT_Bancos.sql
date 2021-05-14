DECLARE @contador INT = ISNULL((SELECT SUM(1) FROM [CNT].[Bancos]), 0);
IF (@contador = 0)
BEGIN

INSERT INTO [CNT].[Bancos] ([nombre],[codigo_compensacion],[id_usercreated],[id_userupdated]) VALUES ('BANCO DE LA REPUBLICA',N'00',1,1)

INSERT INTO [CNT].[Bancos] ([nombre],[codigo_compensacion],[id_usercreated],[id_userupdated]) VALUES ('BANCO DE BOGOTÁ',N'01',1,1)

INSERT INTO [CNT].[Bancos] ([nombre],[codigo_compensacion],[id_usercreated],[id_userupdated]) VALUES ('BANCO DE POPULAR',N'02',1,1)

INSERT INTO [CNT].[Bancos] ([nombre],[codigo_compensacion],[id_usercreated],[id_userupdated]) VALUES ('ITAÚ CORPBANCA COLOMBIA S.A.',N'06',1,1)

INSERT INTO [CNT].[Bancos] ([nombre],[codigo_compensacion],[id_usercreated],[id_userupdated]) VALUES ('BANCOLOMBIA S.A.',N'07',1,1)

INSERT INTO [CNT].[Bancos] ([nombre],[codigo_compensacion],[id_usercreated],[id_userupdated]) VALUES ('CITIBANK COLOMBIA',N'09',1,1)

INSERT INTO [CNT].[Bancos] ([nombre],[codigo_compensacion],[id_usercreated],[id_userupdated]) VALUES ('GNB SUDAMERIS S.A.',N'12',1,1)

INSERT INTO [CNT].[Bancos] ([nombre],[codigo_compensacion],[id_usercreated],[id_userupdated]) VALUES ('BBVA COLOMBIA',N'13',1,1)

INSERT INTO [CNT].[Bancos] ([nombre],[codigo_compensacion],[id_usercreated],[id_userupdated]) VALUES ('COLPATRIA',N'19',1,1)

INSERT INTO [CNT].[Bancos] ([nombre],[codigo_compensacion],[id_usercreated],[id_userupdated]) VALUES ('BANCO DE OCCIDENTE',N'23',1,1)

INSERT INTO [CNT].[Bancos] ([nombre],[codigo_compensacion],[id_usercreated],[id_userupdated]) VALUES ('BANCO CAJA SOCIAL - BCSC S.A.',N'32',1,1)

INSERT INTO [CNT].[Bancos] ([nombre],[codigo_compensacion],[id_usercreated],[id_userupdated]) VALUES ('BANCO AGRARIO DE COLOMBIA S.A.',N'40',1,1)

INSERT INTO [CNT].[Bancos] ([nombre],[codigo_compensacion],[id_usercreated],[id_userupdated]) VALUES ('BANCO DAVIVIENDA S.A.',N'51',1,1)

INSERT INTO [CNT].[Bancos] ([nombre],[codigo_compensacion],[id_usercreated],[id_userupdated]) VALUES ('BANCO AV VILLAS',N'52',1,1)

INSERT INTO [CNT].[Bancos] ([nombre],[codigo_compensacion],[id_usercreated],[id_userupdated]) VALUES ('BANCO W S.A.',N'53',1,1)

INSERT INTO [CNT].[Bancos] ([nombre],[codigo_compensacion],[id_usercreated],[id_userupdated]) VALUES ('BANCO CREDIFINANCIERA S.A.C.F',N'58',1,1)

INSERT INTO [CNT].[Bancos] ([nombre],[codigo_compensacion],[id_usercreated],[id_userupdated]) VALUES ('BANCAMIA',N'59',1,1)

INSERT INTO [CNT].[Bancos] ([nombre],[codigo_compensacion],[id_usercreated],[id_userupdated]) VALUES ('BANCO PICHINCHA S.A.',N'60',1,1)

INSERT INTO [CNT].[Bancos] ([nombre],[codigo_compensacion],[id_usercreated],[id_userupdated]) VALUES ('BANCOOMEVA',N'61',1,1)

INSERT INTO [CNT].[Bancos] ([nombre],[codigo_compensacion],[id_usercreated],[id_userupdated]) VALUES ('CMR FALABELLA S.A.',N'62',1,1)

INSERT INTO [CNT].[Bancos] ([nombre],[codigo_compensacion],[id_usercreated],[id_userupdated]) VALUES ('BANCO FINANDINA S.A.',N'63',1,1)

INSERT INTO [CNT].[Bancos] ([nombre],[codigo_compensacion],[id_usercreated],[id_userupdated]) VALUES ('BANCO SANTANDER DE NEGOCIOS COLOMBIA S.A.',N'65',1,1)

INSERT INTO [CNT].[Bancos] ([nombre],[codigo_compensacion],[id_usercreated],[id_userupdated]) VALUES ('BANCO COOPERATIVO COOPCENTRAL',N'66',1,1)

INSERT INTO [CNT].[Bancos] ([nombre],[codigo_compensacion],[id_usercreated],[id_userupdated]) VALUES ('BANCO COMPARTIR S.A',N'67',1,1)

INSERT INTO [CNT].[Bancos] ([nombre],[codigo_compensacion],[id_usercreated],[id_userupdated]) VALUES ('BANCO SERFINANZA S.A ',N'69',1,1)

END