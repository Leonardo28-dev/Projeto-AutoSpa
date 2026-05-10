CREATE DATABASE 1ccoa;
Use 1ccoa;

CREATE TABLE departamento (
idDepartamento int primary key auto_increment,
nome Varchar(45)
);

	CREATE TABLE funcionario (
    idFuncionario int primary key auto_increment,
    nome VARCHAR(45),
    salario DECIMAL(10,2),
    fkDepartamento INT,
    FOREIGN KEY(fkDepartamento) REFERENCES
    departamento (idDepartamento))
    ;
    
    INSERT INTO departamento (nome) VALUES
    ("TI"),
    ("RH"),
    ("DP"),
    ("Vendas");
    
    INSERT INTO funcionario(nome,salario,fkDepartamento) VALUES
    ('Clara',5000,1),
    ('Vivian',5500,1),
    ('Pedro',6200,2),
    ('Walter',8500,4);
    
    -- Subquary consulta dentro de consulta
    -- separar por ()
    
    -- trazendo nome e salário de todos que são TI
    SELECT 
    nome,salario
    from funcionario
    where fkDepartamento IN(
    select idDepartamento
    from departamento
    where nome='TI'
    );
    
    -- Trazendo o nome dos funcionarios onde o salario é maior que a media 
    -- exemplo de subquary utilizada com where 
    
    select nome from funcionario
    where  salario >(
    select AVG(salario) from funcionario 
    );
    
    -- exemplo de subquary utilizada no from trazedo uma tabela virtual como resultado, como o resultado é uma tabela preciso de um alias
    
    select media_salario from 
    (SELECT fkDepartamento,
    AVG(salario) AS media_salario
    from funcionario
    group by fkDepartamento 
    ) as medias
    WHERE media_salario>4000
    ;
    
    CREATE TABLE empresa(
    idEmpresa int primary key auto_increment,
    nomeEmpresa VARCHAR(45),
    cnpj CHAR (14)
    );
    
    ALTER TABLE departamento ADD COLUMN fkEmpresa INT;
        ALTER TABLE departamento ADD CONSTRAINT ctfkEmpresa 
        FOREIGN KEY (fkEmpresa) references empresa (idEmpresa);
        
        
        INSERT INTO empresa (nomeEmpresa,cnpj) VALUES 
        ('Empresa da Matheus','11111111112');
        
        
        UPDATE departamento SET fkEmpresa =1
        WHERE idDepartamento 	IN(1,2,3,4);
        
        
        SELECT * FROM empresa 
       left   join departamento 
        on fkEmpresa=idEmpresa
        join funcionario
        on fkDepartamento =idDepartamento;
    
    
    
    