CREATE DATABASE invencivel;
use invencivel;


CREATE TABLE planeta (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    tipo VARCHAR(50),
    ponto_referencia VARCHAR(255)
);

CREATE TABLE organizacao (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    objetivo VARCHAR(255),
    fkPlaneta INT,
     CONSTRAINT ctfk_planetao
    FOREIGN KEY(fkPlaneta)  REFERENCES planeta(id)
);

CREATE TABLE raça (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    caracteristicas VARCHAR(100),
    fkPlaneta_origem INT,
      CONSTRAINT ctfk_planetaorigem
  FOREIGN KEY (fkPlaneta_origem) REFERENCES planeta(id)
);

CREATE TABLE lider (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    fkRaca INT , 
    CONSTRAINT ctfk_lider_raca 
        FOREIGN KEY (fkRaca) 
        REFERENCES raça(id)
);
CREATE TABLE viltrumita (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    status VARCHAR(20), 
    fkOrganizacao int,
      CONSTRAINT ctfk_organizacao
      FOREIGN KEY(fkOrganizacao) REFERENCES organizacao(id)
);


CREATE TABLE organizacao_raca (
    fkOrganizacao INT,
    fkRaca INT,
    dataAfiliacao DATE , 
    PRIMARY KEY (fkOrganizacao, fkRaca),
    CONSTRAINT fk_or_organizacao 
        FOREIGN KEY (fkOrganizacao) 
        REFERENCES organizacao(id),
	    CONSTRAINT fk_or_raca 
        FOREIGN KEY (fkRaca) 
        REFERENCES raça(id)
);



-- Planetas conhecidos
INSERT INTO planeta (nome, tipo, ponto_referencia) VALUES 
('Talescria', 'Habitável', 'Setor 7, Núcleo da Coalisão'),
('Unopa', 'Habitável', 'Sistema Estelar Binário Próximo ao Cinturão de Asteroides'),
('Planeta Sem Nome', 'Habitável', 'Setor Desconhecido, Florestas Densas'),
('Viltrum', 'Habitável', 'Centro do Império (Destruído)');

-- A Organização Inimiga
INSERT INTO organizacao (nome, objetivo, sede_planeta_id) VALUES 
('Coalisão de Planetas', 'Destruir o Império Viltrumita', 1);

-- Raças e os seus Planetas
INSERT INTO raça (nome, caracteristicas, planeta_origem_id) VALUES 
('Unopanos', 'Olho único, grande resistência física', 2),
('Viltrumita Traidor', 'Habilidades de voo e força extrema', 3);

-- Líderes das Raças
INSERT INTO lider (nome, raca_id) VALUES 
('Allen, o Alien', 1),
('Thaedus', 2); -- Líder principal da Coalisão e nesse caso seria o primeiro traidor

-- O Traidor
INSERT INTO viltrumita (nome, status, organizacao_id) VALUES 
('Nolan Grayson', 'Traidor', 1);

-- Associando Raças à Coalisão
INSERT INTO organizacao_raca (organizacao_id, raca_id) VALUES 
(1, 1),
(1, 2);


 --  (SELECT Final)
 
 
 SELECT 
    p_sede.nome AS planeta_sede,
    p_sede.ponto_referencia,
    org.nome AS organizacao,
    l_sede.nome AS lider_da_sede,
    p_racas.nome AS planeta_das_racas,
    r.nome AS raca_participante,
    v.nome AS viltrumita_traidor
FROM organizacao org
JOIN planeta p_sede ON org.sede_planeta_id = p_sede.id
JOIN lider l_sede ON l_sede.nome = 'Thaedus' 
JOIN organizacao_raca orr ON org.id = orr.organizacao_id
JOIN raça r ON orr.raca_id = r.id
JOIN planeta p_racas ON r.planeta_origem_id = p_racas.id
CROSS JOIN viltrumita v 
WHERE v.status = 'Traidor' AND org.nome = 'Coalisão de Planetas';