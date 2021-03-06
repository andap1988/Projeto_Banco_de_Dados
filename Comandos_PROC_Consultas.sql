USE [Aluno_Notas_Disciplina]
GO
/****** Object:  StoredProcedure [dbo].[PROC_CONSULTA]    Script Date: 3/18/2022 10:48:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[PROC_CONSULTA]
@N_CONSULTA INT, @RA_ALUNO INT, @COD_DISCIPLINA VARCHAR(15), @ANO_CONSULTA INT, @SEMESTRE_CONSULTA INT
AS
BEGIN
	DECLARE @MATRICULA_N1 DECIMAL(10,2), @MATRICULA_N2 DECIMAL(10,2), @MATRICULA_SUB DECIMAL(10,2), @MATRICULA_FALTA INT,
			@MATRICULA_SIT VARCHAR(20), @MATRICULA_RA INT, @MATRICULA_COD_DISC VARCHAR(15)

	IF @N_CONSULTA = 1
		BEGIN
			SELECT Matricula.RA_Aluno, Matricula.Cod_Disc, Disciplina.Nome, Matricula.Nota1, Matricula.Nota2, Matricula.Sub, Matricula.Falta, Matricula.Situacao, Matricula.Ano, Matricula.Semestre
			FROM Matricula, Disciplina
			WHERE @COD_DISCIPLINA = Matricula.Cod_Disc AND Matricula.Ano = @ANO_CONSULTA AND Matricula.Cod_Disc = Disciplina.Cod_Disc
			ORDER BY Matricula.Cod_Disc
		END
	ELSE IF @N_CONSULTA = 2
		BEGIN
			IF @RA_ALUNO = 0
				BEGIN
					PRINT('Para essa consulta o nome do aluno tem que ser passado')
				END
			ELSE
				BEGIN
					SELECT Matricula.RA_Aluno, Matricula.Cod_Disc, Disciplina.Nome, Matricula.Nota1, Matricula.Nota2, Matricula.Sub, Matricula.Falta, Matricula.Situacao, Matricula.Ano, Matricula.Semestre
					FROM Matricula, Disciplina
					WHERE @RA_ALUNO = Matricula.RA_Aluno AND Matricula.Ano = @ANO_CONSULTA AND Matricula.Semestre = @SEMESTRE_CONSULTA AND Matricula.Cod_Disc = Disciplina.Cod_Disc
					ORDER BY Matricula.Cod_Disc
				END
		END
	ELSE IF @N_CONSULTA = 3
		BEGIN
			SELECT Matricula.RA_Aluno, Matricula.Cod_Disc, Disciplina.Nome, Matricula.Nota1, Matricula.Nota2, Matricula.Sub, Matricula.Falta, Matricula.Situacao, Matricula.Ano, Matricula.Semestre, Matricula.Situacao
			FROM Matricula, Disciplina
			WHERE 'REPROVADO POR NOTA' = Matricula.Situacao AND Matricula.Ano = @ANO_CONSULTA AND Matricula.Cod_Disc = Disciplina.Cod_Disc
			ORDER BY Matricula.RA_Aluno
		END
	ELSE
		BEGIN
			PRINT('O parametro da consulta esta invalido')
		END
END