USE [Aluno_Notas_Disciplina]
GO
/****** Object:  StoredProcedure [dbo].[PROC_MATRICULA]    Script Date: 3/18/2022 10:58:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[PROC_MATRICULA]
@NOTA1 DECIMAL(10,2), @NOTA2 DECIMAL(10,2), @SUB DECIMAL(10,2), @FALTA INT, @RA_ALUNO INT, @COD_DISC VARCHAR(15)
AS
BEGIN
	DECLARE @MEDIA DECIMAL(10,2), @MEDIASUB DECIMAL(10,2), @ST VARCHAR(30), @H_AULA_DISC INT, @MAXIMO_FALTA INT

	SELECT @H_AULA_DISC = dbo.Disciplina.Carga_Horaria FROM dbo.Disciplina WHERE @COD_DISC = dbo.Disciplina.Cod_Disc

	SET @MAXIMO_FALTA = CAST(@H_AULA_DISC * 0.25 as INT)
	SET @ST = ''

	IF @SUB = 0
		BEGIN
			PRINT('SUB = 0')
			SET @MEDIA = (@NOTA1 + @NOTA2) / 2.00
		END
	ELSE
		BEGIN
			IF @SUB > @NOTA1
				BEGIN
					SET @MEDIA = (@SUB + @NOTA2) / 2.00
				END
			ELSE IF @SUB > @NOTA2
				BEGIN
					SET @MEDIA = (@NOTA1 + @SUB) / 2.00
				END
			ELSE
				BEGIN
					SET @MEDIA = (@NOTA1 + @SUB) / 2.00
				END
		END

	IF @FALTA > @MAXIMO_FALTA
		BEGIN
			SET @ST = 'REPROVADO POR FALTA'
		END
	ELSE
		BEGIN
			IF @MEDIA < 5.0
				BEGIN
					SET @ST = 'REPROVADO POR NOTA'
				END
			ELSE
				BEGIN
					SET @ST = 'APROVADO'
					
				END
		END

	UPDATE MATRICULA SET Media = @MEDIA, Situacao = @ST WHERE @COD_DISC = Cod_Disc AND @RA_ALUNO = RA_Aluno
END