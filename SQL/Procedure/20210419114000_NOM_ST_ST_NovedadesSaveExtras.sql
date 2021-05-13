--liquibase formatted sql
--changeset ,JPAREDES:1 dbms:mssql runOnChange:true endDelimiter:GO stripComments:false
If EXISTS (SELECT 1 FROM dbo.SYSOBJECTS WHERE id = OBJECT_ID(N'[NOM].[ST_NovedadesSaveExtras]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [NOM].[ST_NovedadesSaveExtras]
GO
CREATE PROCEDURE [NOM].[ST_NovedadesSaveExtras]

@id_periodo_contrato BIGINT,
@id_contrato BIGINT

AS

DECLARE @error VARCHAR(MAX);
/**********************************************
*Nombre:		[NOM].[ST_NovedadesSaveExtras]
-----------------------------------------------
*Tipo:			Procedimiento almacenado
*creaci�n:		04/05/2021
*Desarrollador: JPAREDES
*Descripcion:	Actualiza la informacin de las 
				horas exrtas en la tabla 
				NOM.Devengos
**********************************************/

DECLARE @id_padre BIGINT;

BEGIN TRY
		
		IF(ISNULL(@id_contrato,0) = 0)
			RAISERROR('No se pudo encontrar el contrato', 16, 0)

		SET @id_padre =  (SELECT id FROM NOM.Horario H INNER JOIN NOM.VW_Contratos C ON C.id_horario = H.id WHERE C.id_contrato = @id_contrato)

		;WITH DATES (fecha_ini, fecha_fin, tipo) AS (
			SELECT	D.fecha_inicio,
					D.fecha_fin,
					F.tipo
				FROM	[NOM].[Devengos] D LEFT JOIN 
						[NOM].[FechaFes] AS F ON CONVERT(VARCHAR(10),F.fecha,120) BETWEEN CONVERT(VARCHAR(10),D.fecha_inicio,120) AND CONVERT(VARCHAR(10),D.fecha_fin,120)
				WHERE id_per_cont = @id_periodo_contrato
		),

		
		HORARIO (tipo_horario, id_horario, hinicio, hfin, hiniciodes, hfindes, tipo, id_contrato, fecha_ini, fecha_fin, minutos_ini, minutos_fin) AS (
			SELECT iden, H.id, H.hinicio, H.hfin, H.hiniciodesc, H.hfindesc, ISNULL(H.sab,0), @id_contrato, NULL, NULL, NULL, NULL FROM NOM.Horario H	INNER JOIN 
								ST_listados L ON H.tipo_horario = L.id INNER JOIN 
								NOM.VW_Contratos C ON C.id_horario = H.id 
			WHERE C.id_contrato = @id_contrato
			UNION ALL
			SELECT iden, H.id, H.hinicio, H.hfin, H.hiniciodesc, H.hfindesc, ISNULL(H.sab,0), @id_contrato, NULL, NULL, NULL, NULL FROM NOM.Horario H	INNER JOIN 
								ST_listados L ON H.tipo_horario = L.id
			WHERE H.id_padre = @id_padre

			UNION ALL

			SELECT NULL,NULL,NULL,NULL,NULL,NULL,
				CASE WHEN tipo = 'S' THEN 1 ELSE CASE WHEN tipo = 'D' THEN NULL ELSE 0 END END, @id_contrato, 
				fecha_ini, 
				fecha_fin,
				DATEPART(HOUR, fecha_ini) + (DATEPART(MINUTE, fecha_ini) / 60), --CONVERT(TIME(0),fecha_ini)
				DATEPART(HOUR, fecha_fin) + (DATEPART(MINUTE, fecha_fin) / 60 ) -- CONVERT(TIME(0), fecha_fin)
				FROM DATES GROUP BY fecha_ini, fecha_fin, tipo
		),
		

		-- los totales están en minutos, se divide sobre 60 y se obtienen las horas
		CTE (fecha_ini, fecha_fin, hora_ini, hora_fin, diurna, nocturna, [horas no extra], total_ext, festiva_diurna, festiva_nocturna, tipo_dia, domingo) AS (
			SELECT -- Sabados y entre semana
				H2.fecha_ini,
				H2.fecha_fin,
				H1.hinicio,
				H1.hfin,

				CASE	WHEN H2.minutos_ini > 6 AND H2.minutos_ini < 21 THEN 
							CASE	WHEN H2.minutos_fin > 6 AND H2.minutos_fin < 21 
										THEN DATEDIFF(MI, H2.fecha_ini, H2.fecha_fin) 
								ELSE 1260 - (DATEPART(HOUR, H2.fecha_ini)*60 + DATEPART(MINUTE, H2.fecha_ini))
							END 
						ELSE 
							CASE	WHEN H2.minutos_fin > 6 AND H2.minutos_fin < 21 
										THEN (DATEPART(HOUR, H2.fecha_fin)*60 + DATEPART(MINUTE, H2.fecha_fin)) - 360
							END 
						END diurna,

				CASE	WHEN H2.minutos_ini <= 6 OR H2.minutos_ini >= 21 THEN 
							CASE	WHEN H2.minutos_fin <= 6 OR H2.minutos_fin >= 21 
										THEN	CASE	WHEN (H2.minutos_ini <= 6 AND H2.minutos_fin <= 6) OR (H2.minutos_ini >= 21 AND H2.minutos_fin >= 21)
															THEN DATEDIFF(MI, H2.fecha_ini, H2.fecha_fin)
														ELSE
															CASE WHEN  DATEPART(HOUR, H2.fecha_ini) = 0 THEN CASE WHEN DATEPART(HOUR,H2.fecha_fin) <= 6 OR DATEPART(HOUR,H2.fecha_fin) >= 21 THEN DATEPART(HOUR,H2.fecha_fin) * 60 END ELSE DATEDIFF(MI, H2.fecha_ini, H2.fecha_fin) END
												END
								ELSE IIF(H2.minutos_ini <= 6 , 360 - (DATEPART(HOUR, H2.fecha_ini)*60 + DATEPART(MINUTE, H2.fecha_ini))  , (DATEPART(HOUR, H2.fecha_ini)*60 + DATEPART(MINUTE, H2.fecha_ini)) - 1260)
							END 
						ELSE 
							CASE	WHEN H2.minutos_fin <= 6 OR H2.minutos_fin >= 21 
										THEN IIF(H2.minutos_fin <= 6 , 360 - (DATEPART(HOUR, H2.fecha_fin)*60 + DATEPART(MINUTE, H2.fecha_fin))  , (DATEPART(HOUR, H2.fecha_fin)*60 + DATEPART(MINUTE, H2.fecha_fin)) - 1260)
							END 
						END nocturna,
						
				CASE	WHEN CONVERT(TIME(0),H2.fecha_ini) BETWEEN H1.hinicio AND H1.hiniciodes THEN DATEDIFF(MINUTE, CONVERT(TIME(0),H2.fecha_ini), H1.hiniciodes)
							ELSE CASE WHEN CONVERT(TIME(0),H2.fecha_ini) BETWEEN H1.hfindes AND H1.hfin THEN DATEDIFF(MINUTE, CONVERT(TIME(0),H2.fecha_ini), H1.hfin) 
									ELSE 0 END
						END [horas no extras],

				CASE	WHEN	((CONVERT(TIME(0),H2.fecha_ini) NOT BETWEEN H1.hinicio AND H1.hiniciodes) AND (CONVERT(TIME(0),H2.fecha_ini) NOT BETWEEN H1.hfindes AND H1.hfin))  
						THEN CASE WHEN ((CONVERT(TIME(0), H2.fecha_fin) NOT BETWEEN H1.hinicio AND H1.hiniciodes) AND (CONVERT(TIME(0), H2.fecha_fin) NOT BETWEEN H1.hfindes AND H1.hfin))
							THEN DATEDIFF(MINUTE, H2.fecha_ini, H2.fecha_fin) 
								ELSE IIF(DATEDIFF(MINUTE,(CONVERT(TIME(0), H2.fecha_ini)),H1.hiniciodes) <= 0, DATEDIFF(MINUTE, H1.hfin, CONVERT(TIME(0), H2.fecha_ini)), DATEDIFF(MINUTE, H1.hinicio, CONVERT(TIME(0), H2.fecha_ini))) 
							END
						ELSE CASE WHEN ((CONVERT(TIME(0), H2.fecha_fin) NOT BETWEEN H1.hinicio AND H1.hiniciodes) AND (CONVERT(TIME(0), H2.fecha_fin) NOT BETWEEN H1.hfindes AND H1.hfin))
								THEN IIF(DATEDIFF(MINUTE,(CONVERT(TIME(0), H2.fecha_fin)), H1.hiniciodes) <= 0, DATEDIFF(MINUTE, H1.hfin, CONVERT(TIME(0),H2.fecha_fin)) , DATEDIFF(MINUTE, CONVERT(TIME(0),H2.fecha_fin), H1.hinicio))
							END
					END total_ext,

				NULL,
				NULL,
				H2.tipo,
				0
			FROM HORARIO H1 INNER JOIN HORARIO H2 ON H1.id_contrato = H2.id_contrato WHERE H1.tipo IS NOT NULL
			
			UNION ALL
			-- Domingos
			SELECT 
				H2.fecha_ini,
				H2.fecha_fin,
				h1.hinicio,
				H1.hfin,
				NULL h_diurna,
				NULL h_nocturna,
				0 [horas no extras],
				0 total_ext,

				CASE	WHEN H2.minutos_ini > 6 AND H2.minutos_ini < 21 THEN 
							CASE	WHEN H2.minutos_fin > 6 AND H2.minutos_fin < 21 
										THEN DATEDIFF(MI, H2.fecha_ini, H2.fecha_fin) 
								ELSE 1260 - (DATEPART(HOUR, H2.fecha_ini)*60 + DATEPART(MINUTE, H2.fecha_ini))
							END 
						ELSE 
							CASE	WHEN H2.minutos_fin > 6 AND H2.minutos_fin < 21 
										THEN (DATEPART(HOUR, H2.fecha_fin)*60 + DATEPART(MINUTE, H2.fecha_fin)) - 360
							END 
						END total_dom_diur,

				CASE	WHEN H2.minutos_ini <= 6 OR H2.minutos_ini >= 21 THEN 
							CASE	WHEN H2.minutos_fin <= 6 OR H2.minutos_fin >= 21 
										THEN	CASE	WHEN (H2.minutos_ini <= 6 AND H2.minutos_fin <= 6) OR (H2.minutos_ini >= 21 AND H2.minutos_fin >= 21)
															THEN DATEDIFF(MI, H2.fecha_ini, H2.fecha_fin)
														ELSE
															CASE WHEN  DATEPART(HOUR, H2.fecha_ini) = 0 THEN CASE WHEN DATEPART(HOUR,H2.fecha_fin) <= 6 OR DATEPART(HOUR,H2.fecha_fin) >= 21 THEN DATEPART(HOUR,H2.fecha_fin) * 60 END ELSE DATEDIFF(MI, H2.fecha_ini, H2.fecha_fin) END
												END
								ELSE IIF(H2.minutos_ini <= 6 , 360 - (DATEPART(HOUR, H2.fecha_ini)*60 + DATEPART(MINUTE, H2.fecha_ini))  , (DATEPART(HOUR, H2.fecha_ini)*60 + DATEPART(MINUTE, H2.fecha_ini)) - 1260)
							END 
						ELSE 
							CASE	WHEN H2.minutos_fin <= 6 OR H2.minutos_fin >= 21 
										THEN IIF(H2.minutos_fin <= 6 , 360 - (DATEPART(HOUR, H2.fecha_fin)*60 + DATEPART(MINUTE, H2.fecha_fin))  , (DATEPART(HOUR, H2.fecha_fin)*60 + DATEPART(MINUTE, H2.fecha_fin)) - 1260)
							END 
						END total_dom_noc,

				H2.tipo,
				1
			FROM HORARIO H1 INNER JOIN HORARIO H2 ON H1.id_contrato = H2.id_contrato WHERE H1.tipo IS NULL AND H2.tipo IS NULL
		),


		TOTALES (total_total, diurna, nocturna, total_ext, total_dominical , festiva_nocturna, festiva_diurna, tipo_dia) AS (
			SELECT ((ISNULL(diurna,0) + ISNULL(nocturna,0) + ISNULL(festiva_diurna,0) + ISNULL(festiva_nocturna,0)) /*- ISNULL([horas no extra],0)*/) total_total, diurna, nocturna, total_ext, SUM(festiva_nocturna + festiva_diurna) total_dominical , festiva_nocturna, festiva_diurna, tipo_dia
			FROM CTE C
			WHERE 
				--total_ext IS NOT NULL AND 
				(CASE WHEN hora_ini IS NULL AND tipo_dia IS NULL THEN domingo ELSE CASE WHEN hora_ini IS NOT NULL AND tipo_dia = 0 THEN 1 ELSE CASE WHEN hora_ini IS NULL AND tipo_dia = 1 THEN 1 ELSE 0 END END END) != 0 
			GROUP BY  C.fecha_fin, C.fecha_ini, hora_ini, hora_fin, total_ext, festiva_diurna, festiva_nocturna, tipo_dia, domingo, diurna, nocturna, [horas no extra]
		)


		UPDATE [NOM].[Devengos] 
			SET h_extras = T.total_total / 60,
				dia = ISNULL(T.diurna,0) / 60,
				noche = ISNULL(T.nocturna,0) / 60,
				dias_festivos = ISNULL(T.festiva_diurna,0) / 60,
				noches_festivos = ISNULL(T.festiva_nocturna,0) / 60
			FROM TOTALES T WHERE total_total != 0


END TRY
BEGIN CATCH
	SET @error = 'Error: ' + ERROR_MESSAGE();
	RAISERROR(@error, 16, 0)
END CATCH