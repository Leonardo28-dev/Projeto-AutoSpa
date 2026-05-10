CREATE DATABASE SistemaAcademico;
USE SistemaAcademico;

-- Tabela Curso
CREATE TABLE curso (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nomeCurso VARCHAR(100),
    coordenador VARCHAR(150)
);

-- Tabela Aluno
CREATE TABLE aluno (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150),
    email VARCHAR(150),
    fkCurso INT,
    CONSTRAINT fk_aluno_curso FOREIGN KEY (fkCurso) REFERENCES curso(id)
);

-- Tabela Projeto
CREATE TABLE projeto (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nomeProjeto VARCHAR(100),
    descricao TEXT
);

-- Tabela AlunoProjeto (Relacionamento N:N)
CREATE TABLE alunoProjeto (
    fkAluno INT,
    fkProjeto INT,
    dataEntrada DATE,
    PRIMARY KEY (fkAluno, fkProjeto),
    CONSTRAINT fk_ap_aluno FOREIGN KEY (fkAluno) REFERENCES aluno(id),
    CONSTRAINT fk_ap_projeto FOREIGN KEY (fkProjeto) REFERENCES projeto(id)
);

-- Tabela Professor
CREATE TABLE professor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nomeProfessor VARCHAR(150),
    especialidade VARCHAR(100)
);

-- Tabela Disciplina
CREATE TABLE disciplina (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nomeDisciplina VARCHAR(100),
    cargaHoraria INT,
    fkProfessor INT,
    CONSTRAINT fk_disc_prof FOREIGN KEY (fkProfessor) REFERENCES professor(id)
);

-- Tabela AlunoDisciplina (Relacionamento N:N)
CREATE TABLE alunoDisciplina (
    fkAluno INT,
    fkDisciplina INT,
    semestre VARCHAR(10),
    PRIMARY KEY (fkAluno, fkDisciplina, semestre),
    CONSTRAINT fk_ad_aluno FOREIGN KEY (fkAluno) REFERENCES aluno(id),
    CONSTRAINT fk_ad_disciplina FOREIGN KEY (fkDisciplina) REFERENCES disciplina(id)
);

INSERT INTO curso (nomeCurso, coordenador) VALUES 
('ADS', 'Gerson Santos'),
('Ciência da Computação', 'Ana Paula'),
('Direito', 'Roberto Nunes');

INSERT INTO professor (nomeProfessor, especialidade) VALUES 
('Fábio Santos', 'Banco de Dados'),
('Mônica Hillman', 'Desenvolvimento Web'),
('Alex Felipe', 'Java'),
('Priscila Caminha', 'UX Design');

INSERT INTO aluno (nome, email, fkCurso) VALUES 
('João Silva', 'joao@email.com', 1),   -- ADS
('Maria Oliveira', 'maria@email.com', 1), -- ADS
('Pedro Souza', 'pedro@email.com', 2),   -- CC
('Ana Costa', 'ana@email.com', 1),     -- ADS
('Carlos Lima', 'carlos@email.com', 3),  -- Direito
('Beatriz Silva', 'beatriz@email.com', 1); -- ADS

INSERT INTO projeto (nomeProjeto, descricao) VALUES 
('Flow', 'Sistema de gerenciamento de fluxo de caixa'),
('EcoMundo', 'Portal de conscientização ambiental'),
('Alpha', 'Projeto de inteligência artificial'),
('Vazio', 'Projeto recém-criado sem alunos');

INSERT INTO disciplina (nomeDisciplina, cargaHoraria, fkProfessor) VALUES 
('Modelagem de Dados', 80, 1),
('Algoritmos', 120, 3),
('Programação Web', 100, 2),
('Design Experimental', 40, 4),
('Direito Civil', 80, 1); -- Professor 1 ministrando duas

-- Alunos nos Projetos
INSERT INTO alunoProjeto (fkAluno, fkProjeto, dataEntrada) VALUES 
(1, 1, '2026-02-10'), -- João no Flow
(2, 1, '2026-03-01'), -- Maria no Flow
(3, 2, '2025-12-15'), -- Pedro no EcoMundo
(4, 1, '2026-05-20'), -- Ana no Flow (Entrou após jan/2026)
(4, 2, '2026-06-01'); -- Ana também no EcoMundo (Mais de 1 projeto)

-- Alunos nas Disciplinas
INSERT INTO alunoDisciplina (fkAluno, fkDisciplina, semestre) VALUES 
(1, 1, '2026/1'), -- João em Modelagem
(1, 2, '2026/1'), -- João em Algoritmos (Mais de 1 disciplina)
(2, 1, '2026/1'), -- Maria em Modelagem
(3, 1, '2026/1'), -- Pedro em Modelagem
(4, 1, '2026/1'), -- Ana em Modelagem (Disciplina 1 agora tem 4 alunos)
(6, 1, '2026/1'); -- Beatriz em Modelagem


-- 1. Nome dos alunos e nome do curso
SELECT a.nome, c.nomeCurso 
FROM aluno a 
JOIN curso c ON a.fkCurso = c.id;

-- 2. Nome do aluno, nome do projeto e data de entrada
SELECT a.nome, p.nomeProjeto, ap.dataEntrada 
FROM aluno a 
JOIN alunoProjeto ap ON a.id = ap.fkAluno
JOIN projeto p ON ap.fkProjeto = p.id;

-- 3. Nome do aluno, disciplina e semestre
SELECT a.nome, d.nomeDisciplina, ad.semestre 
FROM aluno a 
JOIN alunoDisciplina ad ON a.id = ad.fkAluno
JOIN disciplina d ON ad.fkDisciplina = d.id;

-- 4. Alunos que pertencem ao curso "ADS"
SELECT a.nome 
FROM aluno a 
JOIN curso c ON a.fkCurso = c.id 
WHERE c.nomeCurso = 'ADS';

-- 5. Projetos que possuem alunos cadastrados
SELECT DISTINCT p.nomeProjeto 
FROM projeto p 
JOIN alunoProjeto ap ON p.id = ap.fkProjeto;

-- 6. Alunos do projeto "Flow"
SELECT a.nome 
FROM aluno a 
JOIN alunoProjeto ap ON a.id = ap.fkAluno
JOIN projeto p ON ap.fkProjeto = p.id 
WHERE p.nomeProjeto = 'Flow';

-- 7. Professor e disciplina ministrada
SELECT prof.nomeProfessor, d.nomeDisciplina 
FROM professor prof 
JOIN disciplina d ON prof.id = d.fkProfessor;

SELECT a.nome
FROM aluno a
join alunoProjeto  ap on ap.fkAluno = a.id
WHERE ap.fkAluno is null;



-- 9. Projetos sem alunos cadastrados
SELECT p.nomeProjeto 
FROM projeto p 
LEFT JOIN alunoProjeto ap ON p.id = ap.fkProjeto 
WHERE ap.fkProjeto IS NULL;

CREATE VIEW vwAlunoCurso AS 
SELECT a.nome as aluno,
c.nomeCurso
FROM
aluno a 
join curso c ON a.fkCurso=c.id;

SELECT * FROM vwAlunoCurso;

CREATE VIEW vwAlunoProjeto AS 
SELECT a.nome AS nome_aluno, p.nomeProjeto, ap.dataEntrada 
FROM aluno a 
JOIN alunoProjeto ap ON a.id = ap.fkAluno
JOIN projeto p ON ap.fkProjeto = p.id;

SELECT * FROM vwAlunoProjeto WHERE dataEntrada > '2026-01-01';

-- 14. Alunos com mais de uma disciplina
SELECT a.nome 
FROM aluno a 
JOIN alunoDisciplina ad ON a.id = ad.fkAluno
GROUP BY a.nome
HAVING COUNT(ad.fkDisciplina)>1;


-- 16. Professor da disciplina com maior carga horária
SELECT prof.nomeProfessor 
FROM professor prof 
JOIN disciplina d ON prof.id = d.fkProfessor
WHERE d.cargaHoraria=(SELECT MAX(cargahoraria) from disciplina);


SELECT a.nome 
FROM aluno a 
JOIN alunoProjeto ap ON a.id = ap.fkAluno 
GROUP BY a.id, a.nome 
HAVING COUNT(ap.fkProjeto) > (
select avg(total) from (
select count(fkProjeto) as  total from alunoprojeto group by fkAluno
)as sub
);

SELECT p.nomeProjeto 
FROM projeto p 
JOIN alunoProjeto ap ON p.id = ap.fkProjeto 
GROUP BY p.id, p.nomeProjeto 
ORDER BY COUNT(ap.fkAluno) DESC 
LIMIT 1;

SELECT DISTINCT c.nomeCurso 
FROM curso c 
JOIN aluno a ON c.id = a.fkCurso;

SELECT DISTINCT a.nome 
FROM aluno a
JOIN alunoProjeto ap ON a.id = ap.fkAluno
JOIN alunoDisciplina ad ON a.id = ad.fkAluno;

-- 21. Alunos que NÃO cursam disciplinas
SELECT a.nome 
FROM aluno a 
LEFT JOIN alunoDisciplina ad ON a.id = ad.fkAluno 
WHERE ad.fkAluno IS NULL;


SELECT d.nomeDisciplina 
FROM disciplina d 
left JOIN alunoDisciplina ad ON d.id = ad.fkDisciplina 
WHERE ad.fkDisciplina IS NULL;


SELECT a.nome 
FROM aluno a
left JOIN alunoDisciplina ad ON a.id = ad.fkAluno
group by a.nome
 order by count(ad.fkDisciplina) desc
 limit 1;
 
SELECT c.nomeCurso 
FROM curso c 
JOIN aluno a ON c.id = a.fkCurso 
GROUP BY c.id, c.nomeCurso 
HAVING COUNT(a.id) > (
    select avg(qtd) from(
    select count(id) as qtd from aluno group by fkCurso
    )as sub
    );




