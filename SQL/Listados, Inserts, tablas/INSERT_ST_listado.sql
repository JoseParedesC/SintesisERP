IF NOT EXISTS(SELECT 1 FROM [dbo].[ST_Listados] WHERE [codigogen] = 'TIPOSANGRE')
BEGIN
INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES ('TIPOSANGRE',N'', N'','Tipo de sangre',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'TIPOSANGRE','ONEG','O-',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'TIPOSANGRE','OPOS','O+',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'TIPOSANGRE','ANEG','A-',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'TIPOSANGRE','APOS','A+',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'TIPOSANGRE','BNEG','B-',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'TIPOSANGRE','BPOS','B+',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'TIPOSANGRE','ABNEG','AB+',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'TIPOSANGRE','ABPOS','AB+',1,1,0)

END

IF NOT EXISTS(SELECT 1 FROM [dbo].[ST_Listados] WHERE [codigogen] = 'TIPOCONTRA')
BEGIN


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES ('TIPOCONTRA',N'', N'','Tipo de Contrato',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'TIPOCONTRA','OBRALABOR','Obra/Labor',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'TIPOCONTRA','INDEFINIDO','Terminio Indefinido',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'TIPOCONTRA','FIJO','Terminio Fijo',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'TIPOCONTRA','APRENDIZ','Universitario',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'TIPOCONTRA','SENALECT','SENA Etapa Lectiva',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'TIPOCONTRA','SENAPRODUCT','SENA Etapa Productiva',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'TIPOCONTRA','PRESSERVIS','Prestacion de servicio',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'TIPOCONTRA','MEDITIEMP','Medio Tiempo',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'TIPOCONTRA','PEN','Pensionado',1,1,0)



END

IF NOT EXISTS(SELECT 1 FROM [dbo].[ST_Listados] WHERE [codigogen] = 'TIPOSAL')
BEGIN


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES ('TIPOSAL',N'', N'','Tipo de Salario',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'TIPOSAL','MEN','Mensual',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'TIPOSAL','QUIN','Quincenal',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'TIPOSAL','SEM','Semanal',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'TIPOSAL','OTRO','Otro',1,1,0)


END


IF NOT EXISTS(SELECT 1 FROM [dbo].[ST_Listados] WHERE [codigogen] = 'FORMAPAGONOM')
BEGIN


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES ('FORMAPAGONOM',N'', N'','Forma de Pago de la Nomina',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'FORMAPAGONOM','EFE','Efectivo',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'FORMAPAGONOM','CHE','Pago por Cheque',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'FORMAPAGONOM','TRANS','Transferencia Bancaria',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'FORMAPAGONOM','TARPAGO','Tarjetas de pago',1,1,0)




END


IF NOT EXISTS(SELECT 1 FROM [dbo].[ST_Listados] WHERE [codigogen] = 'TIPOJORNADA')
BEGIN


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES ('TIPOJORNADA',N'', N'','Tipo de Jornada',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'TIPOJORNADA','DIA','Día',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'TIPOJORNADA','NOCHE','Noche',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'TIPOJORNADA','MIXTA','Mixta',1,1,0)


END

IF NOT EXISTS(SELECT 1 FROM [dbo].[ST_Listados] WHERE [codigogen] = 'ESTADOCONTRATO')
BEGIN


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES ('ESTADOCONTRATO',N'', N'','Estado de contrato',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'ESTADOCONTRATO','VIG','Vigente',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'ESTADOCONTRATO','ESP','En espera',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'ESTADOCONTRATO','FIN','Finalizado',1,1,0)

END


IF NOT EXISTS(SELECT 1 FROM [dbo].[ST_Listados] WHERE [codigogen] = 'TIPOHORARIO')
BEGIN

INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES ('TIPOHORARIO',N'', N'','Tipo de Horario',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'TIPOHORARIO','REG','Regular',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'TIPOHORARIO','CXD','Cada X Día',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'TIPOHORARIO','IREG','Irregular',1,1,0)

END


IF NOT EXISTS(SELECT 1 FROM [dbo].[ST_Listados] WHERE [codigogen] = 'CONTRATACION')
BEGIN

INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES ('CONTRATACION',N'', N'','Tipo de Contratacion',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'CONTRATACION','EMP','Empleado',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'CONTRATACION','EST','Estudiante',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'CONTRATACION','PEN','Pensionado',1,1,0)

END


IF NOT EXISTS(SELECT 1 FROM [dbo].[ST_Listados] WHERE [codigogen] = 'PROCEDIMIENTO')
BEGIN

INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES ('PROCEDIMIENTO',N'', N'','Tipo de Procedimiento',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'PROCEDIMIENTO','1','Procedimiento 1',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'PROCEDIMIENTO','2','Procedimiento 2',1,1,0)

END


IF NOT EXISTS(SELECT 1 FROM [dbo].[ST_Listados] WHERE [codigogen] = 'TIPOCUENTABANCO')
BEGIN

INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES ('TIPOCUENTABANCO',N'', N'','Tipo de Cuenta Bancaria',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'TIPOCUENTABANCO','CUENTCOR',' Cuenta corriente',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'TIPOCUENTABANCO','CUENTAHO','Cuenta de ahorro',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'TIPOCUENTABANCO','CUENTNOM','Cuenta nómina',1,1,0)

END


IF NOT EXISTS(SELECT 1 FROM [dbo].[ST_Listados] WHERE [codigogen] = 'LIQUID')
BEGIN

INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES ('LIQUID',N'', N'','Tipo de Liquidación',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'LIQUID','PERIOD',' Por Periodo',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'LIQUID','CONTRA','Por Contrato',1,1,0)


END


IF NOT EXISTS(SELECT 1 FROM [dbo].[ST_Listados] WHERE [codigogen] = 'SEG_SOCIAL')
BEGIN

INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES ('SEG_SOCIAL',N'', N'','Tipo de Seguridad Social',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'SEG_SOCIAL','SEPS',' E.P.S.',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'SEG_SOCIAL','SPEN','Pensión',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'SEG_SOCIAL','SCAJA','Caja de compensación',1,1,0)


INSERT INTO [dbo].[ST_Listados] ([codigogen],[codigo],[iden],[nombre],[estado],[id_user],[bloqueo]) VALUES (NULL,'SEG_SOCIAL','SARL','A.R.L.',1,1,0)


END


IF NOT EXISTS(SELECT 1 FROM ST_Listados WHERE codigogen = 'TIPOPRESTACION')
BEGIN

INSERT INTO ST_Listados (codigogen, codigo, iden, nombre,  estado, id_user, bloqueo) VALUES('TIPOPRESTACION', '', '', 'Tipo Seguridad Social', 1, 1, 0)


INSERT INTO ST_Listados (codigo, iden, nombre, estado, id_user, bloqueo) VALUES('TIPOPRESTACION', 'CESAN', 'Cesntias', '', 1, 0)


INSERT INTO ST_Listados (codigo, iden, nombre, estado, id_user, bloqueo) VALUES('TIPOPRESTACION', 'INCESAN', 'Int. de cesantias', '', 1, 0)


INSERT INTO ST_Listados (codigo, iden, nombre, estado, id_user, bloqueo) VALUES('TIPOPRESTACION', 'PRIM', 'Primas', '', 1, 0)


INSERT INTO ST_Listados (codigo, iden, nombre, estado, id_user, bloqueo) VALUES('TIPOPRESTACION', 'VACA', 'Vacaciones', '', 1, 0)


END



IF NOT EXISTS(SELECT 1 FROM ST_Listados WHERE codigogen = 'NATUSALARIO')
BEGIN

INSERT INTO ST_Listados (codigogen, codigo, iden, nombre,  estado, id_user, bloqueo) VALUES('NATUSALARIO', '', '', 'Naturaleza del Salario ', 1, 1, 0)


INSERT INTO ST_Listados (codigo, iden, nombre, estado, id_user, bloqueo) VALUES('NATUSALARIO', 'SALFIJO', 'Fijo', '', 1, 0)


INSERT INTO ST_Listados (codigo, iden, nombre, estado, id_user, bloqueo) VALUES('NATUSALARIO', 'SALINT', 'Integral', '', 1, 0)


INSERT INTO ST_Listados (codigo, iden, nombre, estado, id_user, bloqueo) VALUES('NATUSALARIO', 'SALVARIABLE', 'Variable', '', 1, 0)


END