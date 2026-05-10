CREATE DATABASE Licao10_15;
Use Licao10_15;

DROP TABLE IF EXISTS PAGAMENTOS;
DROP TABLE IF EXISTS MATRICULAS;
DROP TABLE IF EXISTS ALUNOS;
DROP TABLE IF EXISTS FORMAS_PAGAMENTO;
DROP TABLE IF EXISTS PLANOS;


CREATE TABLE PLANOS (
    id_plano INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100) NOT NULL UNIQUE,
    preco DECIMAL(10, 2) NOT NULL,
    duracao_dias INT NOT NULL
);

CREATE TABLE FORMAS_PAGAMENTO (
    id_forma INT PRIMARY KEY AUTO_INCREMENT,
    nome_forma VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE ALUNOS (
    id_aluno INT PRIMARY KEY AUTO_INCREMENT,
    nome_aluno VARCHAR(150) NOT NULL,
    data_nascimento DATE,
    data_matricula DATE NOT NULL
);

CREATE TABLE MATRICULAS (
    id_matricula INT PRIMARY KEY AUTO_INCREMENT,
    id_aluno INT NOT NULL,
    id_plano INT NOT NULL,
    data_inicio DATE NOT NULL,
    data_vencimento DATE NOT NULL,
    FOREIGN KEY (id_aluno) REFERENCES ALUNOS(id_aluno),
    FOREIGN KEY (id_plano) REFERENCES PLANOS(id_plano)
);

CREATE TABLE PAGAMENTOS (
    id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    id_matricula INT NOT NULL,
    id_forma INT NOT NULL,
    valor_pago DECIMAL(10, 2) NOT NULL,
    data_pagamento DATE NOT NULL,
    status_pagamento VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_matricula) REFERENCES MATRICULAS(id_matricula),
    FOREIGN KEY (id_forma) REFERENCES FORMAS_PAGAMENTO(id_forma)
);


INSERT INTO PLANOS (titulo, preco, duracao_dias) VALUES ('Mensal', 100, 30), ('Trimestral', 270, 90), ('Anual', 960, 365);
INSERT INTO FORMAS_PAGAMENTO (nome_forma) VALUES ('Cartão'), ('Pix'), ('Dinheiro');
INSERT INTO ALUNOS (nome_aluno, data_nascimento, data_matricula) VALUES 
('João', '1995-05-10', '2024-01-15'), ('Maria', '2000-11-20', '2024-02-01'), 
('Pedro', '1988-03-03', '2024-03-10'), ('Ana', '1999-07-25', '2024-04-05'), ('Carlos', '1990-01-01', '2024-05-20');


INSERT INTO MATRICULAS (id_aluno, id_plano, data_inicio, data_vencimento) VALUES
(1, 3, '2024-01-15', '2025-01-15'), -- ID 1
(2, 1, '2024-02-01', '2024-03-01'), -- ID 2
(2, 1, '2024-03-01', '2024-04-01'), -- ID 3
(3, 2, '2024-03-10', '2024-06-10'), -- ID 4
(4, 1, '2024-04-05', '2024-05-05'), -- ID 5
(5, 3, '2024-05-20', '2025-05-20'); -- ID 6


INSERT INTO PAGAMENTOS (id_matricula, id_forma, valor_pago, data_pagamento, status_pagamento) VALUES 
(1, 2, 960.00, '2024-01-15', 'Pago'),
(2, 1, 100.00, '2024-02-01', 'Pago'),
(3, 1, 100.00, '2024-03-01', 'Pago'),
(4, 3, 270.00, '2024-03-10', 'Pago'),
(4, 3, 50.00, '2024-04-10', 'Atrasado'),
(5, 2, 100.00, '2024-04-05', 'Pago'),
(6, 1, 480.00, '2024-05-20', 'Pago'),
(6, 1, 480.00, '2024-06-20', 'Pago'),
(1, 3, 10.00, '2024-06-01', 'Pago'),
(3, 2, 10.00, '2024-06-05', 'Pago');

SELECT
A.nome_aluno,
P.titulo
FROM
MATRICULAS M
JOIN
  ALUNOS A ON A.id_aluno = M.id_aluno
JOIN
PLANOS P ON M.id_plano = P.id_plano; 


 
SELECT
A.nome_aluno
FROM
ALUNOS A
JOIN
MATRICULAS M ON A.id_aluno = M.id_aluno
JOIN
PAGAMENTOS PG ON M.id_matricula = PG.id_matricula
JOIN 
FORMAS_PAGAMENTO FG ON PG.id_forma = FG.id_forma
WHERE 	FG.nome_forma="Cartão";

SELECT
        A.nome_aluno,
        SUM(PG.valor_pago) AS valor_total_pago
    FROM
        ALUNOS A
    JOIN
        MATRICULAS M ON A.id_aluno = M.id_aluno
    JOIN
        PAGAMENTOS PG ON M.id_matricula = PG.id_matricula
    GROUP BY
        A.nome_aluno;
        
         
SELECT
A.nome_aluno
FROM
ALUNOS A
left join
MATRICULAS M ON A.id_aluno = M.id_aluno
left join
PAGAMENTOS PG ON M.id_p = PG.id_matricula
WHERE 	PG.valor_pago is null;

SELECT 
ROUND(AVG(preco),2) as media
from PLANOS;


SELECT 
FG.nome_forma,
SUM(valor_pago) as Total
FROM FORMAS_PAGAMENTO as FG
JOIN
PAGAMENTOS PG ON PG.id_forma=FG.id_forma
GROUP BY FG.nome_forma;

SELECT 
PL.titulo,
COUNT(M.id_aluno) AS quantidade_alunos
FROM PLANOS as PL
JOIN
MATRICULAS M ON M.id_plano=PL.id_plano
GROUP BY PL.titulo;


 SELECT
DATE_FORMAT(data_pagamento, '%Y-%m') AS mes_ano,
SUM(valor_pago) AS arrecadacao_mensal
FROM
PAGAMENTOS
GROUP BY
mes_ano
ORDER BY
arrecadacao_mensal DESC
LIMIT 1;

SELECT 
timestampdiff(YEAR, data_nascimento , CURDATE()) AS idade
FROM ALUNOS;


SELECT
        P.titulo
    FROM
        PLANOS P
    JOIN
        MATRICULAS M ON P.id_plano = M.id_plano
    JOIN
        PAGAMENTOS PG ON M.id_matricula = PG.id_matricula
    GROUP BY
        P.titulo
    HAVING
        SUM(PG.valor_pago) > 5000.00;
        
        
        
SELECT
        A.nome_aluno
    FROM
   ALUNOS A
    JOIN
        MATRICULAS M ON M.id_aluno = A.id_aluno
    GROUP BY
       A.nome_aluno
    HAVING
        COUNT(M.id_matricula) > 1;
        
               
SELECT
        FM.nome_forma
    FROM
   PAGAMENTOS P
    JOIN
        FORMAS_PAGAMENTO FM ON P.id_forma = P.id_forma
    GROUP BY
     FM.nome_forma
    HAVING
        COUNT(P.id_pagamento) > 3;
        
        UPDATE PLANOS
    SET preco = preco * 1.10
    WHERE titulo = 'Mensal';
    
    
     UPDATE PAGAMENTOS
    SET id_forma = (SELECT id_forma FROM FORMAS_PAGAMENTO WHERE nome_forma = 'Pix')
    WHERE data_pagamento >= DATE_SUB(LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 2 MONTH)), INTERVAL DAY(LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 2 MONTH))) - 1 DAY)
      AND data_pagamento <= LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 1 MONTH));
      
      DELETE FROM PAGAMENTOS 
      WHERE id_forma=(SELECT id_forma FROM FORMAS_PAGAMENTO where nome_forma = 'Dinheiro');
      
      DELETE FROM ALUNOS 
      WHERE id_aluno=(
         SELECT id_aluno FROM (
         SELECT
      A.id_aluno
      FROM 
      ALUNOS A
      JOIN 
      MATRICULAS M ON M.id_aluno = A.id_aluno
      JOIN 
      PAGAMENTOS P ON P.id_matricula=M.id_matricula
      group by A.id_aluno
      ORDER BY SUM(P.valor_pago) asc
      LIMIT 1
      ) AS ALUNO
	);


 SELECT
        A.nome_aluno
    FROM
        ALUNOS A
    JOIN
        MATRICULAS M ON A.id_aluno = M.id_aluno
    JOIN
        PAGAMENTOS PG ON M.id_matricula = PG.id_matricula
    GROUP BY
        A.nome_aluno
    HAVING
        SUM(PG.valor_pago) > (
            SELECT AVG(TotalPago)
            FROM (
                SELECT SUM(valor_pago) AS TotalPago
                FROM PAGAMENTOS
                GROUP BY id_matricula
            ) AS MediaGeral
        );
        
        
        
        SELECT
        A.nome_aluno,
        P.preco - MediaPlanos.media_geral AS diferenca_plano_media
    FROM
        ALUNOS A
    JOIN
        MATRICULAS M ON A.id_aluno = M.id_aluno
    JOIN
        PLANOS P ON M.id_plano = P.id_plano
        JOIN 
        (SELECT AVG(preco) AS Media from PLANOS) AS mediaplanos;
        
        
        CREATE VIEW V_RELATORIO_FINANCEIRO AS
        SELECT 
        A.nome_aluno,
         P.titulo AS titulo_plano,
        P.preco AS valor_plano,
        coalesce(SUM(PG.valor_pago),0) as total_pago
        FROM 
        ALUNOS A 
        JOIN 
        MATRICULAS M ON M.id_aluno = A.id_aluno
        LEFT JOIN  
        PAGAMENTOS PG ON PG.id_matricula=M.id_matricula
		JOIN PLANOS P ON M.id_plano=P.id_plano
        GROUP BY A.nome_aluno,P.titulo,P.preco;
        
       