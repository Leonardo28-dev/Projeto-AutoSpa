CREATE DATABASE licaoccoa;
Use licaoccoa;

CREATE TABLE cliente (
    id int PRIMARY KEY auto_increment,
    nome VARCHAR(100),
    cidade VARCHAR(100)
);

CREATE TABLE produto (
    id int PRIMARY KEY auto_increment,
    nome VARCHAR(100),
    categoria VARCHAR(50),
    preco DECIMAL(10, 2)
);

CREATE TABLE pedido (
    id int PRIMARY KEY auto_increment,
    cliente_id INT,
    FOREIGN KEY (id) REFERENCES cliente(id),
    data DATE,
    valor_total DECIMAL(10, 2)
);
CREATE TABLE itens_pedido (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pedido_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INTEGER NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    -- Configuração correta das chaves estrangeiras
    CONSTRAINT fk_pedido FOREIGN KEY (pedido_id) REFERENCES pedido(id),
    CONSTRAINT fk_produto FOREIGN KEY (produto_id) REFERENCES produto(id)
);


-- 1. Inserindo Clientes
INSERT INTO cliente (nome, cidade) VALUES 
('Ana Silva', 'São Paulo'),
('Bruno Costa', 'Rio de Janeiro'),
('Carla Souza', 'São Paulo'),
('Diego Lima', 'Belo Horizonte'),
('Elena Moraes', 'Curitiba'),
('Fabio Santos', 'São Paulo'); -- Cliente  ficará sem pedidos 

-- 2. Inserindo Produtos
INSERT INTO produto (nome, categoria, preco) VALUES 
('Smartphone X', 'Eletrônicos', 2500.00),
('Notebook Gamer', 'Eletrônicos', 5500.00),
('Mouse Sem Fio', 'Informática', 120.00),
('Teclado Mecânico', 'Informática', 350.00),
('Monitor 24"', 'Informática', 900.00),
('Cadeira Office', 'Móveis', 1200.00),
('Cafeteira Express', 'Eletro', 450.00),
('Fone Bluetooth', 'Acessórios', 200.00),
('Livro SQL Expert', 'Livros', 90.00); -- Produto que não será vendido

-- 3. Inserindo Pedidos
INSERT INTO pedido (cliente_id, data, valor_total) VALUES 
(1, '2023-10-01', 2620.00), -- Ana (Smartphone + Mouse)
(1, '2023-10-15', 120.00),  -- Ana (Mais um Mouse)
(2, '2023-10-05', 5500.00), -- Bruno (Notebook)
(3, '2023-10-10', 1650.00), -- Carla (Cadeira + Eletro)
(4, '2023-10-12', 200.00),  -- Diego (Fone)
(5, '2023-10-20', 1020.00); -- Elena (Monitor + Mouse)

-- 4. Inserindo Itens do Pedido

INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unitario) VALUES 
(1, 1, 1, 2500.00), -- Pedido 1
(1, 3, 1, 120.00),
(2, 3, 1, 120.00),  -- Pedido 2
(3, 2, 1, 5500.00), -- Pedido 3
(4, 6, 1, 1200.00), -- Pedido 4
(4, 7, 1, 450.00),
(5, 8, 1, 200.00),  -- Pedido 5
(6, 5, 1, 900.00),  -- Pedido 6
(6, 3, 1, 120.00);

SELECT DISTINCT c.nome 
FROM cliente c
JOIN pedido p on c.id =p.cliente_id
WHERE p.valor_total >(SELECT AVG(valor_total) from pedido);

SELECT  nome,preco 
FROM produto
WHERE preco=(SELECT Max(preco) from produto);

SELECT * from pedido 
WHERE valor_total>(SELECT MIN(valor_total) from pedido);

SELECT nome FROM cliente 
WHERE id NOT IN (SELECT cliente_id FROM pedido);


SELECT  nome,preco 
FROM produto
WHERE preco>(SELECT AVG(preco) from produto);

SELECT c.nome,SUM(p.valor_total) as total
FROM cliente c 
Join pedido p ON  p.cliente_id=c.id
GROUP BY c.nome
HAVING SUM(p.valor_total) > (SELECT AVG(total) FROM (SELECT SUM(valor_total) as total FROM pedido GROUP BY cliente_id) as sub);

SELECT * FROM pedido ORDER BY valor_total DESC LIMIT 1;

SELECT nome FROM produto 
WHERE id NOT IN (SELECT DISTINCT produto_id FROM itens_pedido);

SELECT c.nome, COUNT(p.id) as total_pedidos
FROM cliente c
LEFT JOIN pedido p ON c.id = p.cliente_id
GROUP BY c.id, c.nome;
SELECT categoria, COUNT(*) as qtd_produtos
FROM produto 
GROUP BY categoria
HAVING COUNT(*) > 5;


SELECT p1.* FROM  pedido p1
WHERE valor_total>(SELECT AVG(valor_total) FROM pedido p2 WHERE p1.cliente_id = p2.cliente_id);


SELECT c1.nome, c1.cidade, SUM(p.valor_total)
FROM cliente c1
JOIN pedido p ON c1.id = p.cliente_id
GROUP BY c1.id, c1.nome, c1.cidade
HAVING SUM(p.valor_total) > (
    SELECT AVG(total_cidade) FROM (
        SELECT SUM(p2.valor_total) as total_cidade 
        FROM cliente c2 JOIN pedido p2 ON c2.id = p2.cliente_id 
        WHERE c2.cidade = c1.cidade GROUP BY c2.id
    ) as sub
);

SELECT pr.nome, SUM(i.quantidade) as total
FROM produto pr
JOIN itens_pedido i ON pr.id=i.produto_id
GROUP BY pr.nome
ORDER BY total DESC;

SELECT cliente_id , COUNT(*) as quantidade
FROM pedido 
GROUP BY cliente_id
HAVING COUNT(*) >(SELECT AVG(contagem) from(select COUNT(*) as contagem)sub);

SELECT p.id 
FROM pedido p
WHERE p.valor_total > (SELECT AVG(valor_total) FROM pedido) -- Média de Valor
  AND (SELECT SUM(quantidade) FROM itens_pedido WHERE pedido_id = p.id) > -- Soma de itens deste pedido
      (SELECT AVG(qtd_soma) FROM (SELECT SUM(quantidade) as qtd_soma FROM itens_pedido GROUP BY pedido_id) as sub); -- Média de itens geral
      
      SELECT c.nome, SUM(p.valor_total) as total
      FROM cliente c JOIN pedido p ON c.id=p.cliente_id
	  GROUP BY c.nome ORDER BY total DESC LIMIT 1;
      
      SELECT pr.nome, SUM(i.quantidade * i.preco_unitario) as receita
FROM produto pr
JOIN itens_pedido i ON pr.id = i.produto_id
GROUP BY pr.id, pr.nome
ORDER BY receita DESC LIMIT 3;


SELECT cliente_id , AVG(valor_total) as total
FROM pedido 
GROUP BY cliente_id
HAVING AVG(valor_total)>(SELECT AVG(valor_total) FROM pedido);


SELECT categoria, AVG(preco) as media FROM
produto
GROUP BY categoria
HAVING AVG(preco) >(SELECT AVG(preco) FROM produto);

SELECT pedido_id, SUM(quantidade) AS total
FROM itens_pedido
GROUP BY pedido_id
HAVING SUM(quantidade) >(SELECT AVG(soma_geral) from (SELECT SUM(quantidade) as soma_geral from itens_pedido group by pedido_id)sub);






