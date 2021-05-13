--liquibase formatted sql
--changeset ,jarciniegas:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If exists (select 1 from dbo.sysobjects where id = object_id(N'[NOM].[VW_Pago_contrato]') and
OBJECTPROPERTY(id, N'IsView') = 1)
BEGIN
Drop View [NOM].[VW_Pago_contrato]
END
GO
CREATE VIEW [NOM].[VW_Pago_contrato]
AS
		--salario
	SELECT C.id_contrato id, CONVERT(VARCHAR(6), PGCON.fecha_pago, 112) ANOMES, null CENTROCOSTO, id_periodo_contrato NRODOCUMENTO, C.id_contrato nrofactura, CONVERT(varchar, C.fecha_creacion_con, 111) FECHADCTO, PGCON.id_cuenta_sueldo CUENTA,
           C.id_empleado IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, PGCON.SalarioXdia VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP  ,0 CANTIDAD, 'NM' TIPODOC, 'SUELDO POR DÍA' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, NULL FECHAVENCIMIENTO,0 CIERRE 
		FROM [NOM].[Pago_por_Contrato] PGCON
			INNER JOIN [NOM].[VW_Contratos] C ON C.id_contrato = PGCON.id_contrato
		where C.id_contrato = 10010	

		union all
		--h_extras
	SELECT C.id_contrato id, CONVERT(VARCHAR(6), PGCON.fecha_pago, 112) ANOMES, null CENTROCOSTO, id_periodo_contrato NRODOCUMENTO, C.id_contrato nrofactura, CONVERT(varchar, C.fecha_creacion_con, 111) FECHADCTO, PGCON.id_cuenta_horas_extras CUENTA,
           C.id_empleado IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, PGCON.TotalHExtra VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP  ,0 CANTIDAD, 'NM' TIPODOC, 'HORAS EXTRAS' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, NULL FECHAVENCIMIENTO,0 CIERRE 
		FROM [NOM].[Pago_por_Contrato] PGCON
			INNER JOIN [NOM].[VW_Contratos] C ON C.id_contrato = PGCON.id_contrato
		where C.id_contrato = 10010		

		union all
	  --comisiones
	SELECT C.id_contrato id, CONVERT(VARCHAR(6), PGCON.fecha_pago, 112) ANOMES, null CENTROCOSTO, id_periodo_contrato NRODOCUMENTO, C.id_contrato nrofactura, CONVERT(varchar, C.fecha_creacion_con, 111) FECHADCTO, PGCON.id_cuenta_comi CUENTA,
           C.id_empleado IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, PGCON.Comision VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP  ,0 CANTIDAD, 'NM' TIPODOC, 'COMISIONES' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, NULL FECHAVENCIMIENTO,0 CIERRE 
		FROM [NOM].[Pago_por_Contrato] PGCON
			INNER JOIN [NOM].[VW_Contratos] C ON C.id_contrato = PGCON.id_contrato
		where C.id_contrato = 10010	

		union all
	  --bonificacion
	SELECT C.id_contrato id, CONVERT(VARCHAR(6), PGCON.fecha_pago, 112) ANOMES, null CENTROCOSTO, id_periodo_contrato NRODOCUMENTO, C.id_contrato nrofactura, CONVERT(varchar, C.fecha_creacion_con, 111) FECHADCTO, PGCON.id_cuenta_boni CUENTA,
           C.id_empleado IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, PGCON.Bonificacion VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP  ,0 CANTIDAD, 'NM' TIPODOC, 'BONIFICACION' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, NULL FECHAVENCIMIENTO,0 CIERRE 
		FROM [NOM].[Pago_por_Contrato] PGCON
			INNER JOIN [NOM].[VW_Contratos] C ON C.id_contrato = PGCON.id_contrato
		where C.id_contrato = 10010	

		union all
	  --aux trans
	SELECT C.id_contrato id, CONVERT(VARCHAR(6), PGCON.fecha_pago, 112) ANOMES, null CENTROCOSTO, id_periodo_contrato NRODOCUMENTO, C.id_contrato nrofactura, CONVERT(varchar, C.fecha_creacion_con, 111) FECHADCTO, PGCON.id_cuenta_aux_trans CUENTA,
           C.id_empleado IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, PGCON.AuxTrans VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP  ,0 CANTIDAD, 'NM' TIPODOC, 'AUX TRANSPORTE' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, NULL FECHAVENCIMIENTO,0 CIERRE 
		FROM [NOM].[Pago_por_Contrato] PGCON
			INNER JOIN [NOM].[VW_Contratos] C ON C.id_contrato = PGCON.id_contrato
		where C.id_contrato = 10010	

		union all
	  --cesantias
	SELECT C.id_contrato id, CONVERT(VARCHAR(6), PGCON.fecha_pago, 112) ANOMES, null CENTROCOSTO, id_periodo_contrato NRODOCUMENTO, C.id_contrato nrofactura, CONVERT(varchar, C.fecha_creacion_con, 111) FECHADCTO, PGCON.id_cuenta_cesan CUENTA,
           C.id_empleado IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, PGCON.Cesantias VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP  ,0 CANTIDAD, 'NM' TIPODOC, 'CESANTIAS' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, NULL FECHAVENCIMIENTO,0 CIERRE 
		FROM [NOM].[Pago_por_Contrato] PGCON
			INNER JOIN [NOM].[VW_Contratos] C ON C.id_contrato = PGCON.id_contrato
		where C.id_contrato = 10010	

		union all
	  --intereces cesantias
	SELECT C.id_contrato id, CONVERT(VARCHAR(6), PGCON.fecha_pago, 112) ANOMES, null CENTROCOSTO, id_periodo_contrato NRODOCUMENTO, C.id_contrato nrofactura, CONVERT(varchar, C.fecha_creacion_con, 111) FECHADCTO, PGCON.id_cuenta_int_cesan CUENTA,
           C.id_empleado IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, PGCON.Int_cesan VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP  ,0 CANTIDAD, 'NM' TIPODOC, 'INTERECES DE CESANTIAS' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, NULL FECHAVENCIMIENTO,0 CIERRE 
		FROM [NOM].[Pago_por_Contrato] PGCON
			INNER JOIN [NOM].[VW_Contratos] C ON C.id_contrato = PGCON.id_contrato
		where C.id_contrato = 10010	

		union all
	  --primas de servicios
	SELECT C.id_contrato id, CONVERT(VARCHAR(6), PGCON.fecha_pago, 112) ANOMES, null CENTROCOSTO, id_periodo_contrato NRODOCUMENTO, C.id_contrato nrofactura, CONVERT(varchar, C.fecha_creacion_con, 111) FECHADCTO, PGCON.id_cuenta_primas CUENTA,
           C.id_empleado IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, PGCON.Primas VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP  ,0 CANTIDAD, 'NM' TIPODOC, 'PRIMAS DE SERVICIO' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, NULL FECHAVENCIMIENTO,0 CIERRE 
		FROM [NOM].[Pago_por_Contrato] PGCON
			INNER JOIN [NOM].[VW_Contratos] C ON C.id_contrato = PGCON.id_contrato
		where C.id_contrato = 10010	

		union all
	  --arl
	SELECT C.id_contrato id, 
                        CONVERT(VARCHAR(6), PGCON.fecha_pago, 112) ANOMES, null CENTROCOSTO, id_periodo_contrato NRODOCUMENTO, C.id_contrato nrofactura, CONVERT(varchar, C.fecha_creacion_con, 111) FECHADCTO, PGCON.id_cuenta_arl CUENTA,
                        C.id_empleado IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, PGCON.ARL VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP  ,0 CANTIDAD, 'NM' TIPODOC, 'A.R.L.' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, NULL FECHAVENCIMIENTO,0 CIERRE 
		FROM [NOM].[Pago_por_Contrato] PGCON
			INNER JOIN [NOM].[VW_Contratos] C ON C.id_contrato = PGCON.id_contrato
		where C.id_contrato = 10010	

		union all
	  --aportes eps
	SELECT C.id_contrato id, 
                        CONVERT(VARCHAR(6), PGCON.fecha_pago, 112) ANOMES, null CENTROCOSTO, id_periodo_contrato NRODOCUMENTO, C.id_contrato nrofactura, CONVERT(varchar, C.fecha_creacion_con, 111) FECHADCTO, PGCON.id_cuenta_eps CUENTA,
                        C.id_empleado IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, (PGCON.SaludEmpdo + PGCON.SaludEmpdor) VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP  ,0 CANTIDAD, 'NM' TIPODOC, 'E.P.S.' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, NULL FECHAVENCIMIENTO,0 CIERRE 
		FROM [NOM].[Pago_por_Contrato] PGCON
			INNER JOIN [NOM].[VW_Contratos] C ON C.id_contrato = PGCON.id_contrato
		where C.id_contrato = 10010	

		union all
	  --aportes fp
	SELECT C.id_contrato id, 
                        CONVERT(VARCHAR(6), PGCON.fecha_pago, 112) ANOMES, null CENTROCOSTO, id_periodo_contrato NRODOCUMENTO, C.id_contrato nrofactura, CONVERT(varchar, C.fecha_creacion_con, 111) FECHADCTO, PGCON.id_cuenta_afp CUENTA,
                        C.id_empleado IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, (PGCON.PensionEmpdo + PGCON.PensionEmpdor) VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP  ,0 CANTIDAD, 'NM' TIPODOC, 'A.F.P.' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, NULL FECHAVENCIMIENTO,0 CIERRE 
		FROM [NOM].[Pago_por_Contrato] PGCON
			INNER JOIN [NOM].[VW_Contratos] C ON C.id_contrato = PGCON.id_contrato
		where C.id_contrato = 10010	

		union all
	  --aportes solidaridad pensional
	SELECT C.id_contrato id, 
                        CONVERT(VARCHAR(6), PGCON.fecha_pago, 112) ANOMES, null CENTROCOSTO, id_periodo_contrato NRODOCUMENTO, C.id_contrato nrofactura, CONVERT(varchar, C.fecha_creacion_con, 111) FECHADCTO, PGCON.id_cuenta_solid_pensional CUENTA,
                        C.id_empleado IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, PGCON.Solid_Pensional VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP  ,0 CANTIDAD, 'NM' TIPODOC, 'FONDO SOLIDARIFAD PENSIONAL' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, NULL FECHAVENCIMIENTO,0 CIERRE 
		FROM [NOM].[Pago_por_Contrato] PGCON
			INNER JOIN [NOM].[VW_Contratos] C ON C.id_contrato = PGCON.id_contrato
		where C.id_contrato = 10010	

		union all
	  --aportes caja compensacion
	SELECT C.id_contrato id, 
                        CONVERT(VARCHAR(6), PGCON.fecha_pago, 112) ANOMES, null CENTROCOSTO, id_periodo_contrato NRODOCUMENTO, C.id_contrato nrofactura, CONVERT(varchar, C.fecha_creacion_con, 111) FECHADCTO, PGCON.id_cuenta_cajacomp CUENTA,
                        C.id_empleado IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, PGCON.CajaComp VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP  ,0 CANTIDAD, 'NM' TIPODOC, 'CAJA DE COMPENSACION' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, NULL FECHAVENCIMIENTO,0 CIERRE 
		FROM [NOM].[Pago_por_Contrato] PGCON
			INNER JOIN [NOM].[VW_Contratos] C ON C.id_contrato = PGCON.id_contrato
		where C.id_contrato = 10010	
		
		union all
	  --aportes icbf
	SELECT C.id_contrato id, 
                        CONVERT(VARCHAR(6), PGCON.fecha_pago, 112) ANOMES, null CENTROCOSTO, id_periodo_contrato NRODOCUMENTO, C.id_contrato nrofactura, CONVERT(varchar, C.fecha_creacion_con, 111) FECHADCTO, PGCON.id_cuenta_ICBF CUENTA,
                        C.id_empleado IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, PGCON.ICBF VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP  ,0 CANTIDAD, 'NM' TIPODOC, 'I.C.B.F.' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, NULL FECHAVENCIMIENTO,0 CIERRE 
		FROM [NOM].[Pago_por_Contrato] PGCON
			INNER JOIN [NOM].[VW_Contratos] C ON C.id_contrato = PGCON.id_contrato
		where C.id_contrato = 10010	


		union all
	  --aportes sena
	SELECT C.id_contrato id, 
                        CONVERT(VARCHAR(6), PGCON.fecha_pago, 112) ANOMES, null CENTROCOSTO, id_periodo_contrato NRODOCUMENTO, C.id_contrato nrofactura, CONVERT(varchar, C.fecha_creacion_con, 111) FECHADCTO, PGCON.id_cuenta_SENA CUENTA,
                        C.id_empleado IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, PGCON.SENA VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP  ,0 CANTIDAD, 'NM' TIPODOC, 'S.E.N.A.' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, NULL FECHAVENCIMIENTO,0 CIERRE 
		FROM [NOM].[Pago_por_Contrato] PGCON
			INNER JOIN [NOM].[VW_Contratos] C ON C.id_contrato = PGCON.id_contrato
		where C.id_contrato = 10010	

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		union all
	--contra sueldo
	SELECT C.id_contrato id, 
                        CONVERT(VARCHAR(6), PGCON.fecha_pago, 112) ANOMES, null CENTROCOSTO, id_periodo_contrato NRODOCUMENTO, C.id_contrato nrofactura, CONVERT(varchar, C.fecha_creacion_con, 111) FECHADCTO, PGCON.id_cuenta_aux_trans CUENTA, --de momento, corregir la cuenta
                        C.id_empleado IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, PGCON.TotalDeven * -1 VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP  ,0 CANTIDAD, 'NM' TIPODOC, 'SALARIO A PAGAR' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, NULL FECHAVENCIMIENTO,0 CIERRE 
		FROM [NOM].[Pago_por_Contrato] PGCON
			INNER JOIN [NOM].[VW_Contratos] C ON C.id_contrato = PGCON.id_contrato
		where C.id_contrato = 10010	

		union all
	--contra aportes eps
	SELECT C.id_contrato id, 
                        CONVERT(VARCHAR(6), PGCON.fecha_pago, 112) ANOMES, null CENTROCOSTO, id_periodo_contrato NRODOCUMENTO, C.id_contrato nrofactura, CONVERT(varchar, C.fecha_creacion_con, 111) FECHADCTO, PGCON.id_cuenta_aux_trans CUENTA, --de momento, corregir la cuenta
                        C.id_empleado IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, (PGCON.SaludEmpdo + PGCON.SaludEmpdor) * -1 VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP  ,0 CANTIDAD, 'NM' TIPODOC, 'APORTES E.P.S.' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, NULL FECHAVENCIMIENTO,0 CIERRE 
		FROM [NOM].[Pago_por_Contrato] PGCON
			INNER JOIN [NOM].[VW_Contratos] C ON C.id_contrato = PGCON.id_contrato
		where C.id_contrato = 10010	

		union all
	--contra arl
	SELECT C.id_contrato id, 
                        CONVERT(VARCHAR(6), PGCON.fecha_pago, 112) ANOMES, null CENTROCOSTO, id_periodo_contrato NRODOCUMENTO, C.id_contrato nrofactura, CONVERT(varchar, C.fecha_creacion_con, 111) FECHADCTO, PGCON.id_cuenta_aux_trans CUENTA, --de momento, corregir la cuenta
                        C.id_empleado IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, PGCON.ARL * -1 VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP  ,0 CANTIDAD, 'NM' TIPODOC, 'APORTE A.R.L.' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, NULL FECHAVENCIMIENTO,0 CIERRE 
		FROM [NOM].[Pago_por_Contrato] PGCON
			INNER JOIN [NOM].[VW_Contratos] C ON C.id_contrato = PGCON.id_contrato
		where C.id_contrato = 10010	

		union all
	--contra fondo pension
	SELECT C.id_contrato id, 
                        CONVERT(VARCHAR(6), PGCON.fecha_pago, 112) ANOMES, null CENTROCOSTO, id_periodo_contrato NRODOCUMENTO, C.id_contrato nrofactura, CONVERT(varchar, C.fecha_creacion_con, 111) FECHADCTO, PGCON.id_cuenta_aux_trans CUENTA, --de momento, corregir la cuenta
                        C.id_empleado IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, (PGCON.PensionEmpdo + PGCON.PensionEmpdor + PGCON.Solid_Pensional) * -1 VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP  ,0 CANTIDAD, 'NM' TIPODOC, 'FONDO PENSIONAL' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, NULL FECHAVENCIMIENTO,0 CIERRE 
		FROM [NOM].[Pago_por_Contrato] PGCON
			INNER JOIN [NOM].[VW_Contratos] C ON C.id_contrato = PGCON.id_contrato
		where C.id_contrato = 10010	

		union all
	--contra cesantias
	SELECT C.id_contrato id, 
                        CONVERT(VARCHAR(6), PGCON.fecha_pago, 112) ANOMES, null CENTROCOSTO, id_periodo_contrato NRODOCUMENTO, C.id_contrato nrofactura, CONVERT(varchar, C.fecha_creacion_con, 111) FECHADCTO, PGCON.id_cuenta_aux_trans CUENTA, --de momento, corregir la cuenta
                        C.id_empleado IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, PGCON.Cesantias * -1 VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP  ,0 CANTIDAD, 'NM' TIPODOC, 'CESANTÍAS' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, NULL FECHAVENCIMIENTO,0 CIERRE 
		FROM [NOM].[Pago_por_Contrato] PGCON
			INNER JOIN [NOM].[VW_Contratos] C ON C.id_contrato = PGCON.id_contrato
		where C.id_contrato = 10010	

		union all
	--contra int cesantias
	SELECT C.id_contrato id, 
                        CONVERT(VARCHAR(6), PGCON.fecha_pago, 112) ANOMES, null CENTROCOSTO, id_periodo_contrato NRODOCUMENTO, C.id_contrato nrofactura, CONVERT(varchar, C.fecha_creacion_con, 111) FECHADCTO, PGCON.id_cuenta_aux_trans CUENTA, --de momento, corregir la cuenta
                        C.id_empleado IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, PGCON.Int_cesan * -1 VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP  ,0 CANTIDAD, 'NM' TIPODOC, 'INTERECES SOBRE LAS CESANTIAS' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, NULL FECHAVENCIMIENTO,0 CIERRE 
		FROM [NOM].[Pago_por_Contrato] PGCON
			INNER JOIN [NOM].[VW_Contratos] C ON C.id_contrato = PGCON.id_contrato
		where C.id_contrato = 10010	

		union all
	--contra prima
	SELECT C.id_contrato id, 
                        CONVERT(VARCHAR(6), PGCON.fecha_pago, 112) ANOMES, null CENTROCOSTO, id_periodo_contrato NRODOCUMENTO, C.id_contrato nrofactura, CONVERT(varchar, C.fecha_creacion_con, 111) FECHADCTO, PGCON.id_cuenta_aux_trans CUENTA, --de momento, corregir la cuenta
                        C.id_empleado IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, PGCON.Primas * -1 VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP  ,0 CANTIDAD, 'NM' TIPODOC, 'PRIMAS DE SERVICIO' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, NULL FECHAVENCIMIENTO,0 CIERRE 
		FROM [NOM].[Pago_por_Contrato] PGCON
			INNER JOIN [NOM].[VW_Contratos] C ON C.id_contrato = PGCON.id_contrato
		where C.id_contrato = 10010	

		union all
	--contra paraf caja
	SELECT C.id_contrato id, 
                        CONVERT(VARCHAR(6), PGCON.fecha_pago, 112) ANOMES, null CENTROCOSTO, id_periodo_contrato NRODOCUMENTO, C.id_contrato nrofactura, CONVERT(varchar, C.fecha_creacion_con, 111) FECHADCTO, PGCON.id_cuenta_aux_trans CUENTA, --de momento, corregir la cuenta
                        C.id_empleado IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, PGCON.CajaComp  * -1 VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP  ,0 CANTIDAD, 'NM' TIPODOC, 'PARAFISCALES' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, NULL FECHAVENCIMIENTO,0 CIERRE 
		FROM [NOM].[Pago_por_Contrato] PGCON
			INNER JOIN [NOM].[VW_Contratos] C ON C.id_contrato = PGCON.id_contrato
		where C.id_contrato = 10010

		union all
	--contra paraf icbf
	SELECT C.id_contrato id, 
                        CONVERT(VARCHAR(6), PGCON.fecha_pago, 112) ANOMES, null CENTROCOSTO, id_periodo_contrato NRODOCUMENTO, C.id_contrato nrofactura, CONVERT(varchar, C.fecha_creacion_con, 111) FECHADCTO, PGCON.id_cuenta_aux_trans CUENTA, --de momento, corregir la cuenta
                        C.id_empleado IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, PGCON.ICBF  * -1 VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP  ,0 CANTIDAD, 'NM' TIPODOC, 'PARAFISCALES' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, NULL FECHAVENCIMIENTO,0 CIERRE 
		FROM [NOM].[Pago_por_Contrato] PGCON
			INNER JOIN [NOM].[VW_Contratos] C ON C.id_contrato = PGCON.id_contrato
		where C.id_contrato = 10010

		union all
	--contra paraf sena
	SELECT C.id_contrato id, 
                        CONVERT(VARCHAR(6), PGCON.fecha_pago, 112) ANOMES, null CENTROCOSTO, id_periodo_contrato NRODOCUMENTO, C.id_contrato nrofactura, CONVERT(varchar, C.fecha_creacion_con, 111) FECHADCTO, PGCON.id_cuenta_aux_trans CUENTA, --de momento, corregir la cuenta
                        C.id_empleado IDEN_TERCERO, '' CODPRODUCTO, '' PRESENPRODUCTO, '' NOMPRODUCTO, PGCON.SENA * -1 VALOR, '' FORMAPAGO,0 BASEIMP,0 PORCEIMP  ,0 CANTIDAD, 'NM' TIPODOC, 'PARAFISCALES' DESCRIPCION,Dbo.ST_FnGetIdList('PROCE') ESTADO, NULL FECHAVENCIMIENTO,0 CIERRE 
		FROM [NOM].[Pago_por_Contrato] PGCON
			INNER JOIN [NOM].[VW_Contratos] C ON C.id_contrato = PGCON.id_contrato
		where C.id_contrato = 10010

GO