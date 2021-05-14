--liquibase formatted sql
--changeset ,jarciniegas:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
IF EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_LiquidacionEmpleadoGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_LiquidacionEmpleadoGet]
GO
CREATE PROCEDURE [NOM].[ST_LiquidacionEmpleadoGet]

@id_contrato BIGINT ,
@id_percontra BIGINT = null, 
@id_user BIGINT = 9
	
AS
/***************************************
*Nombre:		[NOM].[ST_LiquidacionEmpleadoGet]
----------------------------------------
*Tipo:			Procedimiento almacenado
*creación:		16/10/2020
*Desarrollador: (JARCINIEGAS)
*DESCRIPCIÓN:	Recoge el id que envia 
				la función PilaGet
				y envia la información
				del elemento que coinci-
				de con el id recogido
***************************************/
BEGIN

	DECLARE @ds_error VARCHAR(MAX), @ano INT = DATEPART(YY, GETDATE()), @equidias NUMERIC (18,4), @equivaldias NUMERIC(18,4)
	DECLARE @auxtrans NUMERIC, @SMMLV NUMERIC = (SELECT PA.salario_MinimoLegal FROM [NOM].[VW_ParametrosAnuales] PA WHERE DATEPART(YY, PA.fecha_vigencia) = @ano)
	DECLARE @DEVENGO TABLE(id INT IDENTITY(1,1), id_contra BIGINT, periodo VARCHAR(10), salario NUMERIC(18,4), auxtrascompleto NUMERIC(18,4), diaspagar INT, diasau INT, auxtrans NUMERIC(18,4), recargoN NUMERIC(18,4), salarioXdia NUMERIC(18,4), dia NUMERIC(18,4), noche NUMERIC(18,4), dia_fes NUMERIC(18,4), noche_fes NUMERIC(18,4), bonificacion NUMERIC(18,4), comision NUMERIC(18,4));
	DECLARE @DEDUCCION TABLE(id INT IDENTITY(1,1), id_contra BIGINT, IBCsegsocial NUMERIC(18,4), porcensalud NUMERIC(8,5), salud NUMERIC(18,4), pension NUMERIC(18,4), saludEm NUMERIC(18,4), pensionEm NUMERIC(18,4), solidaridad_pensional NUMERIC(18,4));
	DECLARE @PRESTACIONES TABLE(id INT IDENTITY(1,1), id_contra BIGINT, diasbase NUMERIC(18,10), primas NUMERIC(18,4), cesantias NUMERIC(18,4), intereces_cesan NUMERIC(18,4), dias NUMERIC(18,10));
	DECLARE @PARAFISCALES TABLE(id INT IDENTITY(1,1), id_contra BIGINT, ICBF NUMERIC(18,4), SENA NUMERIC(18,4), CAJA_COMP NUMERIC(18,4));
	DECLARE @Hextra NUMERIC = ISNULL((SELECT h_extras FROM [NOM].[Devengos] D INNER JOIN [NOM].[Periodos_Por_Contrato] PPC ON PPC.id = D.id_per_cont  WHERE PPC.id_contrato = @id_contrato),0)
	DECLARE @valor_h NUMERIC(18,4) = (SELECT (C.salario/30)/HporDia FROM [NOM].[VW_Contratos] C WHERE id_contrato = @id_contrato)
	DECLARE @maxsegsocial INT = (SELECT num_salariosMinSegSocial FROM [NOM].[VW_ParametrosAnuales] PA WHERE DATEPART(YY, PA.fecha_vigencia) = @ano)
	
	BEGIN TRY

		IF ((SELECT tipo_salario FROM [NOM].[VW_Contratos] WHERE id_contrato = @id_contrato) = dbo.ST_FnGetIdList('SALFIJO'))
		BEGIN
		--DEVENGADO 
			INSERT INTO @DEVENGO (id_contra, periodo, salario, auxtrascompleto, diaspagar, diasau, auxtrans, recargoN, dia, noche , dia_fes , noche_fes, bonificacion, salarioXdia, comision)
				SELECT C.id_contrato,
				CONVERT(VARCHAR(10),PPC.fecha_pago, 120), 
				C.salario,
				(IIF(C.salario>=(@SMMLV * 2), 0, (SELECT aux_transporte FROM [NOM].[VW_ParametrosAnuales] PA WHERE DATEPART(YY, PA.fecha_vigencia) = @ano))),
				C.diasapagar, 
				(ISNULL((SELECT SUM((CONVERT(NUMERIC, DATEDIFF(MI, ISNULL(fecha_ini, 0), ISNULL(fecha_fin, 0)))/CONVERT(NUMERIC,60))/24) FROM NOM.Ausencias WHERE remunerado = 0 AND id_per_cont = (SELECT id FROM NOM.Periodos_Por_Contrato WHERE id_contrato = @id_contrato AND estado = 0)),0)), 
				(IIF(C.salario>=(@SMMLV * 2), 0, (SELECT aux_transporte FROM [NOM].[VW_ParametrosAnuales] PA WHERE DATEPART(YY, PA.fecha_vigencia) = @ano)) * ((CONVERT(NUMERIC,C.diasapagar) - ISNULL((SELECT SUM((CONVERT(NUMERIC, DATEDIFF(MI, ISNULL(fecha_ini, 0), ISNULL(fecha_fin, 0)))/CONVERT(NUMERIC,60))/24) FROM NOM.Ausencias WHERE id_per_cont = (SELECT id FROM NOM.Periodos_Por_Contrato WHERE id_contrato = @id_contrato AND estado = 0)),0))/CONVERT(NUMERIC,30))),
				CASE (SELECT tipo_jornada FROM [NOM].[VW_Contratos] C WHERE id_contrato = @id_contrato) WHEN 'Día' THEN 0 ELSE @valor_h * (SELECT Hnoche FROM [NOM].[VW_Contratos] C WHERE id_contrato = @id_contrato) END R_NOCHE,
				IIF( @Hextra = 0 ,0,ISNULL((SELECT dia FROM [NOM].[Devengos] N INNER JOIN [NOM].[Periodos_Por_Contrato] PPC ON PPC.id = N.id_per_cont  WHERE PPC.id_contrato = @id_contrato),0)) * (@valor_h * 1.25)DÍA,
				IIF( @Hextra = 0 ,0,ISNULL((SELECT noche FROM [NOM].[Devengos] N INNER JOIN [NOM].[Periodos_Por_Contrato] PPC ON PPC.id = N.id_per_cont  WHERE PPC.id_contrato = @id_contrato),0)) * (@valor_h * 1.75) NOCHE,
				IIF( @Hextra = 0 ,0,ISNULL((SELECT dias_festivos FROM [NOM].[Devengos] N INNER JOIN [NOM].[Periodos_Por_Contrato] PPC ON PPC.id = N.id_per_cont  WHERE PPC.id_contrato = @id_contrato),0)) * (@valor_h * 2)DÍA_FES,
				IIF( @Hextra = 0 ,0,ISNULL((SELECT noches_festivos FROM [NOM].[Devengos] N INNER JOIN [NOM].[Periodos_Por_Contrato] PPC ON PPC.id = N.id_per_cont  WHERE PPC.id_contrato = @id_contrato),0)) * (@valor_h * 2.5)NOCHE_FES,
				ISNULL((SELECT boni FROM [NOM].[Devengos] N INNER JOIN [NOM].[Periodos_Por_Contrato] PPC ON PPC.id = N.id_per_cont  WHERE PPC.id_contrato = @id_contrato),0),
				(C.salario * (CONVERT(NUMERIC,(CONVERT(NUMERIC,C.diasapagar) - ISNULL((SELECT SUM((CONVERT(NUMERIC, DATEDIFF(MI, ISNULL(fecha_ini, 0), ISNULL(fecha_fin, 0)))/CONVERT(NUMERIC,60))/24) FROM NOM.Ausencias WHERE id_per_cont = (SELECT id FROM NOM.Periodos_Por_Contrato WHERE id_contrato = @id_contrato AND estado = 0)),0)))/CONVERT(NUMERIC,30))),
				0
				FROM [NOM].[VW_Contratos] C 
					 INNER JOIN [NOM].[Periodos_Por_Contrato] PPC ON PPC.id_contrato = C.id_contrato				
				WHERE C.id_contrato = @id_contrato

				SELECT id_contra id, periodo Periodo, salario, auxtrascompleto aux_transporte, (diaspagar - diasau) diaspagar, auxtrans aux_transporte_X_dias, recargoN REC_NOC, dia DÍA, noche NOCHE, dia_fes DÍA_FES, noche_fes NOCHE_FES, 
				(dia + noche + dia_fes + noche_fes) TOTAL_H_EXTRA, bonificacion BONI, salarioXdia salario_X_dias, (auxtrans + salarioXdia + dia + noche + dia_fes + noche_fes + bonificacion + comision) TOTAL_DEVENGADO 
				FROM @DEVENGO

				--SELECT periodo Periodo, SUM(salario), diaspagar, SUM(auxtrans) aux_transporte_X_dias, SUM(salarioXdia) salario_X_dias, SUM((auxtrans + salarioXdia)) TOTAL_DEVENGADO FROM @DEVENGO 
				--GROUP BY diaspagar, periodo

				--SELECT  SUM((auxtrans + salarioXdia)) TOTAL_DEVENGADO_EMPRESA FROM @DEVENGO 

				SET @equidias = (SELECT (CONVERT(NUMERIC,30)/CONVERT(NUMERIC,(diaspagar - diasau))) FROM  @DEVENGO WHERE id_contra = @id_contrato)
				SET @equivaldias = (SELECT (CONVERT(NUMERIC,diaspagar)/CONVERT(NUMERIC,30)) FROM  @DEVENGO WHERE id_contra = @id_contrato)

		--DEDUCCIÓN - SEGURIDAD SOCIAL
			INSERT INTO @DEDUCCION(id_contra, IBCsegsocial, salud, pension, solidaridad_pensional, saludEm, pensionEm)
				SELECT C.id_contrato,
					   IIF(D.salario/@SMMLV > @maxsegsocial, (@SMMLV * @maxsegsocial)/@equidias, (salarioXdia+dia+noche+dia_fes+noche_fes+bonificacion)),
					   IIF(D.salario/@SMMLV > @maxsegsocial, (((@SMMLV * @maxsegsocial)/@equidias) * @equivaldias), (salarioXdia+dia+noche+dia_fes+noche_fes )) * ((SELECT porcen_salud_Empleado FROM [NOM].[VW_ParametrosAnuales] PA WHERE DATEPART(YY, PA.fecha_vigencia) = @ano)/100) , --
					   IIF(D.salario/@SMMLV > @maxsegsocial, (((@SMMLV * @maxsegsocial)/@equidias) * @equivaldias), (salarioXdia+dia+noche+dia_fes+noche_fes )) * ((SELECT porcen_pension_Empleado FROM [NOM].[VW_ParametrosAnuales] PA WHERE DATEPART(YY, PA.fecha_vigencia) = @ano)/100) ,
					   IIF(D.salario/@SMMLV > @maxsegsocial, ISNULL((((@SMMLV * @maxsegsocial)/@equidias) * ((SELECT porcentaje FROM [NOM].[ParamsAnual_Solid] WHERE (D.salario/((SELECT PA.salario_MinimoLegal  FROM [NOM].[VW_ParametrosAnuales] PA WHERE DATEPART(YY, PA.fecha_vigencia) = @ano))) BETWEEN desde AND IIF(hasta!=0,hasta,9999))/100)),0), ISNULL(( (salarioXdia+dia+noche+dia_fes+noche_fes+bonificacion) * ((SELECT porcentaje FROM [NOM].[ParamsAnual_Solid] WHERE (D.salario/((SELECT PA.salario_MinimoLegal  FROM [NOM].[VW_ParametrosAnuales] PA WHERE DATEPART(YY, PA.fecha_vigencia) = @ano))) BETWEEN desde AND IIF(hasta!=0,hasta,9999))/100)),0)),
					   
					   IIF((SELECT exonerado FROM [NOM].[VW_ParametrosAnuales] PA WHERE DATEPART(YY, PA.fecha_vigencia) = @ano) = 0,(IIF(D.salario/@SMMLV > @maxsegsocial, ((@SMMLV * @maxsegsocial) * @equivaldias), (salarioXdia+dia+noche+dia_fes+noche_fes+bonificacion)) * ((SELECT porcen_salud_Empleador FROM [NOM].[VW_ParametrosAnuales] PA WHERE DATEPART(YY, PA.fecha_vigencia) = @ano)/100)),0) , --.
					   IIF(D.salario/@SMMLV > @maxsegsocial, (((@SMMLV * @maxsegsocial)/@equidias) * @equivaldias), (salarioXdia+dia+noche+dia_fes+noche_fes+bonificacion)) * ((SELECT porcen_pension_Empleador FROM [NOM].[VW_ParametrosAnuales] PA WHERE DATEPART(YY, PA.fecha_vigencia) = @ano)/100) 					   
				FROM [NOM].[VW_Contratos] C 
					 INNER JOIN @DEVENGO D ON D.id_contra = C.id_contrato
				WHERE C.id_contrato = @id_contrato

				SELECT	IBCsegsocial IBC_SEGSOCIAL, (SELECT porcen_salud_Empleado FROM [NOM].[VW_ParametrosAnuales] PA WHERE DATEPART(YY, PA.fecha_vigencia) = @ano) PORCEN_SALUD, salud SALUD, 
						(SELECT porcen_pension_Empleado FROM [NOM].[VW_ParametrosAnuales] PA WHERE DATEPART(YY, PA.fecha_vigencia) = @ano) PORCEN_PENSION, pension PENSION, 
						 solidaridad_pensional PORCEN_FONDO_PENSIONAL, solidaridad_pensional FONDO_PENSIONAL,(salud + pension + solidaridad_pensional) TOTAL_DEDUCCION, (SELECT porcen_salud_Empleador FROM [NOM].[VW_ParametrosAnuales] PA WHERE DATEPART(YY, PA.fecha_vigencia) = @ano) PORCEN_SALUDE, 
						 saludEm SALUD_EMPLEADOR, (SELECT porcen_pension_Empleador FROM [NOM].[VW_ParametrosAnuales] PA WHERE DATEPART(YY, PA.fecha_vigencia) = @ano) PORCEN_PENSIONE, pensionEm PENSION_EMPLEADOR, (saludEm+pensionEm) TOTAL_SEGURIDAD_SOCIAL_EMPLEADOR 
				FROM @DEDUCCION

				--SELECT SUM(salud) SALUD, SUM(pension) PENSION, SUM(solidaridad_pensional) SOLID_PENSIONAL,SUM((salud + pension + solidaridad_pensional)) TOTAL_DEDUCCION FROM @DEDUCCION


		--TOTALES
			SELECT (auxtrans + salarioXdia) TOTAL_DEVENGO, (salud + pension + solidaridad_pensional) TOTAL_DEDUCCION , (auxtrans + salarioXdia) - (salud + pension + solidaridad_pensional) TOTAL_PAGAR 
			FROM @DEVENGO DEV INNER JOIN @DEDUCCION DEDUC ON DEDUC.id_contra = DEV.id_contra

		--PRESTACIONES SOCIALES
			INSERT INTO @PRESTACIONES(id_contra, diasbase, primas, cesantias, intereces_cesan, dias)
				SELECT id_contra,
					   (diaspagar - diasau),
					   (((salario + auxtrascompleto) * (diaspagar - diasau))/360),-- SE LE RESTA LOS DIAS DE AUSENCIAS LOS QUE SE DEBAN RESTAR
					   (((salario + auxtrascompleto) * (diaspagar - diasau))/360),
					   ((((salario + auxtrascompleto) * (diaspagar - diasau))/360) * (diaspagar - diasau) * 0.12)/360,
					   (0.04166667 * (diaspagar - diasau))
				FROM @DEVENGO

			SELECT primas PRIMAS, diasbase, cesantias CESANTIAS, intereces_cesan INTERECES_CESANTIAS, dias DIAS_VACACIONES FROM @PRESTACIONES

		--PARAFISCALES
			INSERT INTO @PARAFISCALES (id_contra, ICBF, SENA, CAJA_COMP)
				SELECT	id_contra,
						IIF((SELECT num_salariosMinICBF FROM [NOM].[VW_ParametrosAnuales] PA WHERE DATEPART(YY, PA.fecha_vigencia) = @ano) <= salario/@SMMLV, salarioXdia * ((SELECT porcen_icbf FROM [NOM].[VW_ParametrosAnuales] PA WHERE DATEPART(YY, PA.fecha_vigencia) = @ano)/100),0) ICBF,
						IIF((SELECT num_salariosMinSENA FROM [NOM].[VW_ParametrosAnuales] PA WHERE DATEPART(YY, PA.fecha_vigencia) = @ano) <= salario/@SMMLV, salarioXdia * ((SELECT porcen_sena FROM [NOM].[VW_ParametrosAnuales] PA WHERE DATEPART(YY, PA.fecha_vigencia) = @ano)/100),0) SENA,
						salarioXdia * 0.04 CAJA_COMP--((SELECT porcen_icbf FROM [NOM].[VW_ParametrosAnuales] PA WHERE DATEPART(YY, PA.fecha_vigencia) = @ano)/100)
						--salario/@SMMLV HOLA
				FROM @DEVENGO

			SELECT ICBF, SENA, CAJA_COMP FROM @PARAFISCALES


		END
		ELSE IF ((SELECT tipo_salario FROM [NOM].[VW_Contratos] WHERE id_contrato = @id_contrato) = dbo.ST_FnGetIdList('SALVARIABLE'))
		 BEGIN
		--Base para seguridad social
			

		--Devengos 
				SELECT C.salario Salario_Integral
				FROM [NOM].[VW_Contratos] C 

				--WHERE C.id_contrato = @id_contrato
		END
		ELSE IF ((SELECT tipo_salario FROM [NOM].[VW_Contratos] WHERE id_contrato = @id_contrato) = SAndbo.ST_FnGetIdList('SALINT'))
		BEGIN

		--DEVENGADO 
			INSERT INTO @DEVENGO (id_contra, periodo, salario, auxtrascompleto, diaspagar, diasau, auxtrans, recargoN, dia, noche , dia_fes , noche_fes, bonificacion, salarioXdia )
				SELECT C.id_contrato,
				CONVERT(VARCHAR(10),PPC.fecha_pago, 120), 
				C.salario,
				0,
				C.diasapagar, 
				(ISNULL((SELECT SUM((CONVERT(NUMERIC, DATEDIFF(MI, ISNULL(fecha_ini, 0), ISNULL(fecha_fin, 0)))/CONVERT(NUMERIC,60))/24) FROM NOM.Ausencias WHERE remunerado = 0 AND id_per_cont = (SELECT id FROM NOM.Periodos_Por_Contrato WHERE id_contrato = @id_contrato AND estado = 0)),0)), 
				0,
				0 R_NOCHE,

				0 DÍA,
				0 NOCHE,
				0 DÍA_FES,
				0 NOCHE_FES,
				ISNULL((SELECT boni FROM [NOM].[Devengos] N INNER JOIN [NOM].[Periodos_Por_Contrato] PPC ON PPC.id = N.id_per_cont  WHERE PPC.id_contrato = @id_contrato),0),
				(C.salario * (CONVERT(NUMERIC,C.diasapagar)/CONVERT(NUMERIC,30)))  
				--((C.salario + IIF(C.salario>=((SELECT PA.salario_MinimoLegal * 2 FROM [NOM].[VW_ParametrosAnuales] PA WHERE DATEPART(YY, PA.fecha_vigencia) = @ano)), 0, (SELECT aux_transporte FROM [NOM].[VW_ParametrosAnuales] PA WHERE DATEPART(YY, PA.fecha_vigencia) = @ano))) * (CONVERT(NUMERIC,C.diasapagar)/CONVERT(NUMERIC,30)))
				FROM [NOM].[VW_Contratos] C 
					 INNER JOIN [NOM].[Periodos_Por_Contrato] PPC ON PPC.id_contrato = C.id_contrato				
				WHERE C.id_contrato = @id_contrato

				SELECT periodo Periodo, salario, auxtrascompleto aux_transporte, (diaspagar - diasau) diaspagar, auxtrans aux_transporte_X_dias, recargoN REC_NOC, dia DÍA, noche NOCHE, dia_fes DÍA_FES, noche_fes NOCHE_FES, 
				(dia + noche + dia_fes + noche_fes) TOTAL_H_EXTRA, bonificacion BONI, salarioXdia salario_X_dias, (auxtrans + salarioXdia + dia + noche + dia_fes + noche_fes + bonificacion) TOTAL_DEVENGADO 
				FROM @DEVENGO

				--SELECT periodo Periodo, SUM(salario), diaspagar, SUM(auxtrans) aux_transporte_X_dias, SUM(salarioXdia) salario_X_dias, SUM((auxtrans + salarioXdia)) TOTAL_DEVENGADO FROM @DEVENGO 
				--GROUP BY diaspagar, periodo

				--SELECT  SUM((auxtrans + salarioXdia)) TOTAL_DEVENGADO_EMPRESA FROM @DEVENGO 

				SET @equidias = (SELECT (CONVERT(NUMERIC,30)/CONVERT(NUMERIC,(diaspagar - diasau))) FROM  @DEVENGO WHERE id_contra = @id_contrato)
				SET @equivaldias = (SELECT (CONVERT(NUMERIC,diaspagar)/CONVERT(NUMERIC,30)) FROM  @DEVENGO WHERE id_contra = @id_contrato)

		--DEDUCCIÓN - SEGURIDAD SOCIAL
			INSERT INTO @DEDUCCION(id_contra, IBCsegsocial, salud, pension, solidaridad_pensional, saludEm, pensionEm)
				SELECT C.id_contrato,
					   IIF((D.salario*0.7) < @SMMLV*10, (@SMMLV * 10)/@equidias, IIF((D.salario*0.7)/@SMMLV > @maxsegsocial, (@SMMLV * @maxsegsocial), (((D.salario*0.7)/30) * (diaspagar - diasau)) +bonificacion)),					   					   
					   IIF((D.salario*0.7) < @SMMLV*10, (((@SMMLV * 10)/@equidias) * @equivaldias), IIF((D.salario*0.7)/@SMMLV  > @maxsegsocial, (@SMMLV * @maxsegsocial), (((D.salario*0.7)/30) * (diaspagar - diasau)) +bonificacion)) * ((SELECT porcen_salud_Empleado FROM [NOM].[VW_ParametrosAnuales] PA WHERE DATEPART(YY, PA.fecha_vigencia) = @ano)/100) , --
					   IIF((D.salario*0.7) < @SMMLV*10, (((@SMMLV * 10)/@equidias) * @equivaldias), IIF((D.salario*0.7)/@SMMLV  > @maxsegsocial, (@SMMLV * @maxsegsocial), (((D.salario*0.7)/30) * (diaspagar - diasau)) +bonificacion)) * ((SELECT porcen_pension_Empleado FROM [NOM].[VW_ParametrosAnuales] PA WHERE DATEPART(YY, PA.fecha_vigencia) = @ano)/100) ,
					   IIF((D.salario*0.7) < @SMMLV*10, ISNULL(((@SMMLV * 10)/@equidias * ((SELECT porcentaje FROM [NOM].[ParamsAnual_Solid] WHERE (D.salario/((SELECT PA.salario_MinimoLegal  FROM [NOM].[VW_ParametrosAnuales] PA WHERE DATEPART(YY, PA.fecha_vigencia) = @ano))) BETWEEN desde AND IIF(hasta!=0,hasta,9999))/100)),0), ISNULL((IIF(D.salario*0.7 > @maxsegsocial, (@SMMLV * @maxsegsocial), (((D.salario*0.7)/30) * (diaspagar - diasau)) +bonificacion) * ((SELECT porcentaje FROM [NOM].[ParamsAnual_Solid] WHERE (D.salario/((SELECT PA.salario_MinimoLegal  FROM [NOM].[VW_ParametrosAnuales] PA WHERE DATEPART(YY, PA.fecha_vigencia) = @ano))) BETWEEN desde AND IIF(hasta!=0,hasta,9999))/100)),0)),
					   
					   IIF((SELECT exonerado FROM [NOM].[VW_ParametrosAnuales] PA WHERE DATEPART(YY, PA.fecha_vigencia) = @ano) = 0,(IIF((D.salario*0.7)/@SMMLV  < @SMMLV*10, ((@SMMLV * 10)/@equidias * @equivaldias), IIF((D.salario*0.7)/@SMMLV > @maxsegsocial, (@SMMLV * @maxsegsocial), (((D.salario*0.7)/30) * (diaspagar - diasau)) +bonificacion)) * ((SELECT porcen_salud_Empleador FROM [NOM].[VW_ParametrosAnuales] PA WHERE DATEPART(YY, PA.fecha_vigencia) = @ano)/100)),0) , --.
					   IIF((D.salario*0.7) < @SMMLV*10, ((@SMMLV * 10)/@equidias * @equivaldias), IIF((D.salario*0.7)/@SMMLV > @maxsegsocial, (@SMMLV * @maxsegsocial), (((D.salario*0.7)/30) * (diaspagar - diasau)) +bonificacion)) * ((SELECT porcen_pension_Empleador FROM [NOM].[VW_ParametrosAnuales] PA WHERE DATEPART(YY, PA.fecha_vigencia) = @ano)/100) 					   
				FROM [NOM].[VW_Contratos] C 
					 INNER JOIN @DEVENGO D ON D.id_contra = C.id_contrato
				WHERE C.id_contrato = @id_contrato

				SELECT IBCsegsocial IBC_SEGSOCIAL, salud SALUD, pension PENSION, solidaridad_pensional FONDO_PENSIONAL,(salud + pension + solidaridad_pensional) TOTAL_DEDUCCION, saludEm SALUD_EMPLEADOR, pensionEm PENSION_EMPLEADOR, (saludEm+pensionEm) TOTAL_SEGURIDAD_SOCIAL_EMPLEADOR 
				FROM @DEDUCCION

				--SELECT SUM(salud) SALUD, SUM(pension) PENSION, SUM(solidaridad_pensional) SOLID_PENSIONAL,SUM((salud + pension + solidaridad_pensional)) TOTAL_DEDUCCION FROM @DEDUCCION


		--TOTALES
			SELECT (auxtrans + salarioXdia) TOTAL_DEVENGO, (salud + pension + solidaridad_pensional) TOTAL_DEDUCCION , (auxtrans + salarioXdia) - (salud + pension + solidaridad_pensional) TOTAL_PAGAR 
			FROM @DEVENGO DEV INNER JOIN @DEDUCCION DEDUC ON DEDUC.id_contra = DEV.id_contra

		--PRESTACIONES SOCIALES
			
				SELECT 
					   (0.04166667 * (diaspagar - diasau)) DIAS_VAC
				FROM @DEVENGO

			

		--PARAFISCALES
			INSERT INTO @PARAFISCALES (id_contra, ICBF, SENA, CAJA_COMP)
				SELECT	id_contra,
						IIF((SELECT num_salariosMinICBF FROM [NOM].[VW_ParametrosAnuales] PA WHERE DATEPART(YY, PA.fecha_vigencia) = @ano) <= salario*0.7, IIF((salario*0.7)/@SMMLV  < @SMMLV*10, (((@SMMLV * 10)/@equidias) * @equivaldias), IIF(salario*0.7 > @maxsegsocial, (@SMMLV * @maxsegsocial), (((salario*0.7)/30) * (diaspagar - diasau)) + bonificacion)) * ((SELECT porcen_icbf FROM [NOM].[VW_ParametrosAnuales] PA WHERE DATEPART(YY, PA.fecha_vigencia) = @ano)/100),0) ICBF,
						IIF((SELECT num_salariosMinSENA FROM [NOM].[VW_ParametrosAnuales] PA WHERE DATEPART(YY, PA.fecha_vigencia) = @ano) <= salario*0.7, IIF((salario*0.7)/@SMMLV  < @SMMLV*10, (((@SMMLV * 10)/@equidias) * @equivaldias), IIF(salario*0.7 > @maxsegsocial, (@SMMLV * @maxsegsocial), (((salario*0.7)/30) * (diaspagar - diasau)) + bonificacion)) * ((SELECT porcen_sena FROM [NOM].[VW_ParametrosAnuales] PA WHERE DATEPART(YY, PA.fecha_vigencia) = @ano)/100),0) SENA,
						IIF((salario*0.7)/@SMMLV  < @SMMLV*10, (((@SMMLV * 10)/@equidias) * @equivaldias), IIF(salario*0.7 > @maxsegsocial, (@SMMLV * @maxsegsocial), (((salario*0.7)/30) * (diaspagar - diasau)) + bonificacion)) * 0.04 CAJA_COMP --((SELECT porcen_icbf FROM [NOM].[VW_ParametrosAnuales] PA WHERE DATEPART(YY, PA.fecha_vigencia) = @ano)/100)
					   
				FROM @DEVENGO

				SELECT ICBF, SENA, CAJA_COMP FROM @PARAFISCALES
			
		END

		IF( ISNULL(@id_percontra,0) != 0)
		BEGIN
			IF NOT EXISTS(SELECT 1 FROM NOM.Pago_por_Contrato WHERE id_periodo_contrato  = @id_percontra AND id_contrato = @id_contrato)
			BEGIN
				INSERT INTO NOM.Pago_por_Contrato (id_contrato, id_periodo_contrato, HExtraDia, HExtraNoche, HExtraDiaDom, HExtraNocheDom, TotalHExtra, Bonificacion, Comision, DiasAusentes, DiasPeriodo, AuxTrans, SalarioXdia, TotalDeven, 
				PensionEmpdo, PensionEmpdor, SaludEmpdo, SaludEmpdor, Solid_Pensional, CajaComp, ICBF, SENA, TotalDeduc, TotalPago, Cesantias, Int_cesan, Primas, id_cuenta_sueldo, id_cuenta_aux_trans, id_cuenta_horas_extras, id_cuenta_comi, id_cuenta_boni, id_cuenta_cesan, 
				id_cuenta_int_cesan, id_cuenta_primas, id_cuenta_vacas, id_cuenta_arl, id_cuenta_eps, id_cuenta_afp, id_cuenta_solid_pensional, id_cuenta_cajacomp, id_cuenta_ICBF, id_cuenta_SENA, fecha_pago, id_usercreated, id_userupdated)
			
				SELECT DEV.id_contra, @id_percontra, DEV.dia, DEV.noche, DEV.dia_fes, DEV.noche_fes, (DEV.dia + DEV.noche + DEV.dia_fes + DEV.noche_fes), DEV.bonificacion, DEV.comision, DEV.diasau, DEV.diaspagar, DEV.auxtrans, DEV.salarioXdia,
				(auxtrans + salarioXdia + dia + noche + dia_fes + noche_fes + bonificacion), DEDUC.pension, DEDUC.pensionEm, DEDUC.salud, DEDUC.saludEm, DEDUC.solidaridad_pensional, PARAF.CAJA_COMP, PARAF.ICBF, PARAF.SENA, (salud + pension + solidaridad_pensional),
				(auxtrans + salarioXdia) - (salud + pension + solidaridad_pensional), PRES.cesantias, PRES.intereces_cesan, PRES.primas, A.id_cuen_Sueldo, A.id_cuen_Aux_transporte, A.id_cuen_Horas_extras, A.id_cuen_Comisiones, A.id_cuen_Bonificaciones, A.id_cuen_Cesantias, A.id_cuen_Int_cesantias,
				A.id_cuen_Prima_servicios, A.id_cuen_Vacaciones, A.id_cuen_ARL, A.id_cuen_Aprts_EPS, A.id_cuen_Aprts_AFP, A.id_cuen_FonSolPen, A.id_cuen_Aprts_CCF, A.id_cuen_ICBF, A.id_cuen_SENA, PPC.fecha_pago, @id_user, @id_user 
			
				--DEV.salarioXdia, (DEV.dia + DEV.noche + DEV.dia_fes + DEV.noche_fes) TOTAL_H_EXTRA, DEV.comision, DEV.auxtrans, PRES.cesantias, PRES.intereces_cesan, PRES.primas, (DEDUC.salud + DEDUC.saludEm) Aportes_EPS, 
				--	(DEDUC.pension + DEDUC.pensionEm + DEDUC.solidaridad_pensional) Aportes_Pension, PARAF.CAJA_COMP, PARAF.ICBF, PARAF.SENA
				FROM @DEVENGO DEV
				INNER JOIN @PRESTACIONES PRES ON PRES.id_contra = DEV.id_contra
				INNER JOIN @DEDUCCION DEDUC ON DEDUC.id_contra = DEV.id_contra
				INNER JOIN @PARAFISCALES PARAF ON PARAF.id_contra = DEV.id_contra
				INNER JOIN [NOM].[VW_Contratos] C ON C.id_contrato = DEV.id_contra
				INNER JOIN [NOM].[Area] A ON A.id = C.id_area
				INNER JOIN [NOM].[Periodos_Por_Contrato] PPC ON PPC.id_contrato = DEV.id_contra
				WHERE DEV.id_contra = @id_contrato
			END
		END
		
	END TRY
    BEGIN CATCH
	--Getting the error description
	SET @ds_error   =  ERROR_PROCEDURE() + 
					';  ' + CONVERT(VARCHAR,ERROR_LINE()) + 
					'; ' + ERROR_MESSAGE() 
	-- save the error in a Log file
	RAISERROR(@ds_error,16,1)
	RETURN
	END CATCH
END

