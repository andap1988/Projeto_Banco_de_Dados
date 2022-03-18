USE Aluno_Notas_Disciplina;

CREATE TABLE Aluno (
	RA INT NOT NULL,
	CPF VARCHAR(14),
	Nome VARCHAR(100),
	CONSTRAINT PK_RA_ALUNO PRIMARY KEY (RA)
)
GO

CREATE TABLE Disciplina (
	Cod_Disc VARCHAR(15) NOT NULL,
	Nome VARCHAR(50),
	Carga_Horaria INT,
	CONSTRAINT PK_COD_DISC_DISCIPLINA PRIMARY KEY (Cod_Disc)
)
GO

CREATE TABLE Matricula (
	Nota1 DECIMAL(4,2),
	Nota2 DECIMAL(4,2),
	Sub DECIMAL(4,2),
	Media DECIMAL(4,2),
	Falta INT,
	Semestre INT,
	Ano INT,
	Situacao VARCHAR(20),
	RA_Aluno INT NOT NULL,
	Cod_Disc VARCHAR(15) NOT NULL,
	CONSTRAINT PK_RA_ALUNO_MATRICULA PRIMARY KEY (RA_Aluno, Cod_Disc),
	CONSTRAINT FK_RA_ALUNO_MATRICULA FOREIGN KEY (RA_Aluno) REFERENCES Aluno(RA),
	CONSTRAINT FK_COD_DISC_MATRICULA FOREIGN KEY (Cod_Disc) REFERENCES Disciplina(Cod_Disc)
)
GO

SELECT * FROM Matricula
GO

/*
CONSULTA
1 - Quais sao os alunos de uma determinada disciplina ministrada no ano de 2021, com suas notas faltas e situacao
2 - Quais sao as notas, faltas e situacao de um determinado aluno, em todas as disciplinas por ele cursada no ano de 21 no SEGUNDO SEMESTRE
3 - Quais sao os alunos reprovados por nota em 21 e o nome das disciplinas em q eles reprovaram, com suas notas e medias
*/
/*
CHAMAR PROC CONSULTA:
PARA 1 - passar o N_CONS, COD_DISCIPLINA e o ANO
PARA 2 - passar o N_CONS, RA_ALUNO, ANO, SEMESTRE
PARA 3 - passar o N_CONS, ANO
*/

-- @N_CONSULTA INT, @RA_ALUNO, @COD_DISCIPLINA VARCHAR(15), @ANO_CONSULTA INT, @SEMESTRE_CONSULTA INT

EXECUTE PROC_CONSULTA 1, 0, 'IHC', 2021, 0 -- consulta 1
EXECUTE PROC_CONSULTA 2, 20201013, '', 2021, 2 -- consulta 2
EXECUTE PROC_CONSULTA 3, 0, '', 2021, 0 -- consulta 3

/*

INSERT INTO Aluno
VALUES	(20201001, '559.009.100-40', 'Julia Pereira'),
		(20201002, '157.909.760-00', 'Maria Silva'),
		(20201003, '070.685.280-07', 'Luiz Dias'),
		(20201004, '444.557.970-09', 'Roberto Gomes'),
		(20201005, '465.137.690-86', 'Fabio Pires'),
		(20201006, '393.035.090-48', 'Adriano Curry'),
		(20201007, '578.819.060-65', 'Willian Amer'),
		(20201008, '189.993.110-40', 'Antonio Pereira'),
		(20201009, '879.423.920-74', 'Nick Becker'),
		(20201010, '606.101.630-19', 'Steph Pereira'),
		(20201011, '670.052.820-86', 'Bruna Gomes'),
		(20201012, '389.626.020-08', 'Kelly Silva'),
		(20201013, '547.645.850-65', 'Larissa Pereira'),
		(20201014, '304.035.510-48', 'Vanessa Souza'),
		(20201015, '570.152.080-32', 'Carol Sousa'),
		(20201016, '241.593.720-74', 'Beatriz Gimenes'),
		(20201017, '600.552.940-49', 'Juliano Ramos'),
		(20201018, '440.775.270-07', 'Mario Souza'),
		(20201019, '132.039.890-18', 'Anderson Pereira'),
		(20201020, '131.155.850-04', 'Gabriel Silva')
GO

INSERT INTO Disciplina
VALUES	('IHC', 'Intercao Humano-Computador', 80), -- limite: 20
		('PPW', 'Programacao Para Web', 60), -- limite: 15
		('SCI', 'Sistemas de Computacao e Informacao', 80), -- limite: 20
		('SI', 'Seguranca da Informacao', 60) -- limite: 15
GO

INSERT INTO Matricula
VALUES	(8.4, 5.1, 0, 0, 5, 1, 2021, '', 20201001, 'IHC') -- APROVADO

INSERT INTO Matricula
VALUES	(8.6, 5.5, 0, 0, 5, 1, 2021, '', 20201001, 'PPW') -- APROVADO

INSERT INTO Matricula
VALUES	(8.4, 6.1, 8.4, 0, 5, 2, 2021, '', 20201001, 'SCI') -- SUB igual nota1

INSERT INTO Matricula
VALUES	(9.4, 5.1, 5.1, 0, 5, 2, 2021, '', 20201001, 'SI') -- SUB igual nota2

INSERT INTO Matricula
VALUES	(8.0, 5.3, 9.9, 0, 5, 2, 2021, '', 20201002, 'IHC') -- -- SUB maior nota1

INSERT INTO Matricula
VALUES	(8.4, 5.5, 6.5, 0, 5, 2, 2021, '', 20201002, 'PPW') -- SUB maior nota2

INSERT INTO Matricula
VALUES	(9.5, 7.2, 0, 0, 5, 1, 2021, '', 20201002, 'SCI')  -- falta abaixo do limite

INSERT INTO Matricula
VALUES	(7.4, 5.5, 0, 0, 15, 1, 2021, '', 20201002, 'SI') -- falta no limite

INSERT INTO Matricula
VALUES	(8.4, 7.2, 0, 0, 22, 1, 2021, '', 20201003, 'IHC') -- falta acima do limite REPROVADO POR FALTA mesmo com nota alta

INSERT INTO Matricula
VALUES	(9.1, 8.2, 0, 0, 5, 1, 2021, '', 20201003, 'PPW') -- falta abaixo

INSERT INTO Matricula
VALUES	(1.4, 4.2, 1.8, 0, 5, 2, 2021, '', 20201003, 'SCI') -- falta abaixo REPROVADO na nota1 e na SUB

INSERT INTO Matricula
VALUES	(3.4, 2.1, 1.5, 0, 5, 2, 2021, '', 20201003, 'SI') -- falta abaixo REPROVADO na nota2 e na sub

INSERT INTO Matricula
VALUES	(2.7, 2.0, 3.1, 25, 5, 2, 2021, '', 20201004, 'IHC') -- REPROVADO por FALTA mas com nota baixa

INSERT INTO Matricula
VALUES	(8.7, 7.8, 0, 0, 5, 2, 2021, '', 20201004, 'PPW') -- APROVADO

INSERT INTO Matricula
VALUES	(7.7, 6.8, 0, 0, 5, 1, 2021, '', 20201004, 'SCI') -- APROVADO

INSERT INTO Matricula
VALUES	(5.5, 5.8, 0, 0, 5, 1, 2021, '', 20201004, 'SI') -- APROVADO

INSERT INTO Matricula
VALUES	(8.4, 5.1, 0, 0, 5, 1, 2021, '', 20201005, 'IHC') -- APROVADO

INSERT INTO Matricula
VALUES	(8.6, 5.5, 0, 0, 5, 1, 2021, '', 20201005, 'PPW') -- APROVADO

INSERT INTO Matricula
VALUES	(8.4, 6.1, 8.4, 0, 5, 2, 2021, '', 20201005, 'SCI') -- SUB igual nota1

INSERT INTO Matricula
VALUES	(9.4, 5.1, 5.1, 0, 5, 2, 2021, '', 20201005, 'SI') -- SUB igual nota2

INSERT INTO Matricula
VALUES	(8.0, 5.3, 9.9, 0, 5, 2, 2021, '', 20201006, 'IHC') -- -- SUB maior nota1

INSERT INTO Matricula
VALUES	(8.4, 5.5, 6.5, 0, 5, 2, 2021, '', 20201006, 'PPW') -- SUB maior nota2

INSERT INTO Matricula
VALUES	(9.5, 7.2, 0, 0, 5, 1, 2021, '', 20201006, 'SCI')  -- falta abaixo do limite

INSERT INTO Matricula
VALUES	(7.4, 5.5, 0, 0, 15, 1, 2021, '', 20201006, 'SI') -- falta no limite

INSERT INTO Matricula
VALUES	(8.4, 7.2, 0, 0, 22, 1, 2021, '', 20201007, 'IHC') -- falta acima do limite REPROVADO POR FALTA mesmo com nota alta

INSERT INTO Matricula
VALUES	(9.1, 8.2, 0, 0, 5, 1, 2021, '', 20201008, 'PPW') -- falta abaixo

INSERT INTO Matricula
VALUES	(1.4, 4.2, 1.8, 0, 5, 2, 2021, '', 20201008, 'SCI') -- falta abaixo REPROVADO na nota1 e na SUB

INSERT INTO Matricula
VALUES	(3.4, 2.1, 1.5, 0, 5, 2, 2021, '', 20201008, 'SI') -- falta abaixo REPROVADO na nota2 e na sub

INSERT INTO Matricula
VALUES	(2.7, 2.0, 3.1, 25, 5, 2, 2021, '', 20201009, 'IHC') -- REPROVADO por FALTA mas com nota baixa

INSERT INTO Matricula
VALUES	(8.7, 7.8, 0, 0, 5, 2, 2021, '', 20201009, 'PPW') -- APROVADO

INSERT INTO Matricula
VALUES	(7.7, 6.8, 0, 0, 5, 1, 2021, '', 20201009, 'SCI') -- APROVADO

INSERT INTO Matricula
VALUES	(5.5, 5.8, 0, 0, 5, 1, 2021, '', 20201009, 'SI') -- APROVADO

INSERT INTO Matricula
VALUES	(8.4, 5.1, 0, 0, 5, 1, 2021, '', 20201010, 'IHC') -- APROVADO

INSERT INTO Matricula
VALUES	(8.6, 5.5, 0, 0, 5, 1, 2021, '', 20201010, 'PPW') -- APROVADO

INSERT INTO Matricula
VALUES	(8.4, 6.1, 8.4, 0, 5, 2, 2021, '', 20201010, 'SCI') -- SUB igual nota1

INSERT INTO Matricula
VALUES	(9.4, 5.1, 5.1, 0, 5, 2, 2021, '', 20201010, 'SI') -- SUB igual nota2

INSERT INTO Matricula
VALUES	(8.0, 5.3, 9.9, 0, 5, 2, 2021, '', 20201011, 'IHC') -- -- SUB maior nota1

INSERT INTO Matricula
VALUES	(8.4, 5.5, 6.5, 0, 5, 2, 2021, '', 20201011, 'PPW') -- SUB maior nota2

INSERT INTO Matricula
VALUES	(9.5, 7.2, 0, 0, 5, 1, 2021, '', 20201011, 'SCI')  -- falta abaixo do limite

INSERT INTO Matricula
VALUES	(7.4, 5.5, 0, 0, 15, 1, 2021, '', 20201011, 'SI') -- falta no limite

INSERT INTO Matricula
VALUES	(8.4, 7.2, 0, 0, 22, 1, 2021, '', 20201012, 'IHC') -- falta acima do limite REPROVADO POR FALTA mesmo com nota alta

INSERT INTO Matricula
VALUES	(9.1, 8.2, 0, 0, 5, 1, 2021, '', 20201012, 'PPW') -- falta abaixo

INSERT INTO Matricula
VALUES	(1.4, 4.2, 1.8, 0, 5, 2, 2021, '', 20201012, 'SCI') -- falta abaixo REPROVADO na nota1 e na SUB

INSERT INTO Matricula
VALUES	(3.4, 2.1, 1.5, 0, 5, 2, 2021, '', 20201012, 'SI') -- falta abaixo REPROVADO na nota2 e na sub

INSERT INTO Matricula
VALUES	(2.7, 2.0, 3.1, 25, 5, 2, 2021, '', 20201013, 'IHC') -- REPROVADO por FALTA mas com nota baixa

INSERT INTO Matricula
VALUES	(8.7, 7.8, 0, 0, 5, 2, 2021, '', 20201013, 'PPW') -- APROVADO

INSERT INTO Matricula
VALUES	(7.7, 6.8, 0, 0, 5, 1, 2021, '', 20201013, 'SCI') -- APROVADO

INSERT INTO Matricula
VALUES	(5.5, 5.8, 0, 0, 5, 1, 2021, '', 20201013, 'SI') -- APROVADO

INSERT INTO Matricula
VALUES	(8.4, 5.1, 0, 0, 5, 1, 2021, '', 20201014, 'IHC') -- APROVADO

INSERT INTO Matricula
VALUES	(8.6, 5.5, 0, 0, 5, 1, 2021, '', 20201014, 'PPW') -- APROVADO

INSERT INTO Matricula
VALUES	(8.4, 6.1, 8.4, 0, 5, 2, 2021, '', 20201014, 'SCI') -- SUB igual nota1

INSERT INTO Matricula
VALUES	(9.4, 5.1, 5.1, 0, 5, 2, 2021, '', 20201014, 'SI') -- SUB igual nota2

INSERT INTO Matricula
VALUES	(8.0, 5.3, 9.9, 0, 5, 2, 2021, '', 20201015, 'IHC') -- -- SUB maior nota1

INSERT INTO Matricula
VALUES	(8.4, 5.5, 6.5, 0, 5, 2, 2021, '', 20201015, 'PPW') -- SUB maior nota2

INSERT INTO Matricula
VALUES	(9.5, 7.2, 0, 0, 5, 1, 2021, '', 20201015, 'SCI')  -- falta abaixo do limite

INSERT INTO Matricula
VALUES	(7.4, 5.5, 0, 0, 15, 1, 2021, '', 20201015, 'SI') -- falta no limite

INSERT INTO Matricula
VALUES	(8.4, 7.2, 0, 0, 22, 1, 2021, '', 20201016, 'IHC') -- falta acima do limite REPROVADO POR FALTA mesmo com nota alta

INSERT INTO Matricula
VALUES	(9.1, 8.2, 0, 0, 5, 1, 2021, '', 20201016, 'PPW') -- falta abaixo

INSERT INTO Matricula
VALUES	(1.4, 4.2, 1.8, 0, 5, 2, 2021, '', 20201016, 'SCI') -- falta abaixo REPROVADO na nota1 e na SUB

INSERT INTO Matricula
VALUES	(3.4, 2.1, 1.5, 0, 5, 2, 2021, '', 20201016, 'SI') -- falta abaixo REPROVADO na nota2 e na sub

INSERT INTO Matricula
VALUES	(2.7, 2.0, 3.1, 25, 5, 2, 2021, '', 20201017, 'IHC') -- REPROVADO por FALTA mas com nota baixa

INSERT INTO Matricula
VALUES	(8.7, 7.8, 0, 0, 5, 2, 2021, '', 20201017, 'PPW') -- APROVADO

INSERT INTO Matricula
VALUES	(7.7, 6.8, 0, 0, 5, 1, 2021, '', 20201017, 'SCI') -- APROVADO

INSERT INTO Matricula
VALUES	(5.5, 5.8, 0, 0, 5, 1, 2021, '', 20201017, 'SI') -- APROVADO

INSERT INTO Matricula
VALUES	(8.4, 5.1, 0, 0, 5, 1, 2021, '', 20201018, 'IHC') -- APROVADO

INSERT INTO Matricula
VALUES	(8.6, 5.5, 0, 0, 5, 1, 2021, '', 20201018, 'PPW') -- APROVADO

INSERT INTO Matricula
VALUES	(8.4, 6.1, 8.4, 0, 5, 2, 2021, '', 20201018, 'SCI') -- SUB igual nota1

INSERT INTO Matricula
VALUES	(9.4, 5.1, 5.1, 0, 5, 2, 2021, '', 20201018, 'SI') -- SUB igual nota2

INSERT INTO Matricula
VALUES	(8.0, 5.3, 9.9, 0, 5, 2, 2021, '', 20201019, 'IHC') -- -- SUB maior nota1

INSERT INTO Matricula
VALUES	(8.4, 5.5, 6.5, 0, 5, 2, 2021, '', 20201019, 'PPW') -- SUB maior nota2

INSERT INTO Matricula
VALUES	(9.5, 7.2, 0, 0, 5, 1, 2021, '', 20201019, 'SCI')  -- falta abaixo do limite

INSERT INTO Matricula
VALUES	(7.4, 5.5, 0, 0, 15, 1, 2021, '', 20201019, 'SI') -- falta no limite

INSERT INTO Matricula
VALUES	(8.4, 7.2, 0, 0, 22, 1, 2021, '', 20201020, 'IHC') -- falta acima do limite REPROVADO POR FALTA mesmo com nota alta

INSERT INTO Matricula
VALUES	(9.1, 8.2, 0, 0, 5, 1, 2021, '', 20201020, 'PPW') -- falta abaixo

INSERT INTO Matricula
VALUES	(1.4, 4.2, 1.8, 0, 5, 2, 2021, '', 20201020, 'SCI') -- falta abaixo REPROVADO na nota1 e na SUB

INSERT INTO Matricula
VALUES	(3.4, 2.1, 1.5, 0, 5, 2, 2021, '', 20201020, 'SI') -- falta abaixo REPROVADO na nota2 e na sub
	--   N1   N2  SUB M  F  S  ANO  SIT    RA       DISC
*/