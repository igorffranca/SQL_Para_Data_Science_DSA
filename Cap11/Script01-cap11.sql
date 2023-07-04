

CREATE TABLE cap11.TB_CLIENTES (
id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(50) NOT NULL,
telefone VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL);

CREATE TABLE cap11.TB_PEDIDOS (
id VARCHAR(20) PRIMARY KEY,
data_pedido date,
id_cliente INT NOT NULL,
endereco VARCHAR(50) NOT NULL,
valor INT,
FOREIGN KEY (id_cliente) REFERENCES cap11.TB_CLIENTES(id));

INSERT INTO cap11.TB_CLIENTES values
(NULL,'Bob Silva', '5521876541' , 'bob@teste.com'),
(NULL,'Maria Madalena', '5534789762','maria@teste.com'),
(NULL,'Zico Miranda','5531098713' , 'zico@teste.com'),
(NULL,'Ronaldo Teixeira','5512987689' , 'ronaldo@teste.com'),
(NULL,'Zinedine Zidane','5521213282' , 'zidane@teste.com');

INSERT INTO cap11.TB_PEDIDOS value
('2340991', '2022-01-02', 1, 'Natal', 1000),
('3981234', '2022-02-12', 3, 'Fortaleza', 1500),
('7832148', '2022-02-05', 1, 'Recife', 800),
('1298765', '2022-03-01' , 2 , 'Porto Alegre', 900),
('4398654', '2022-03-17', 3 , 'Londrina', 400),
('4398655', '2022-03-18', 4 , 'Rio de Janeiro', 1400),
('4398656', '2022-03-19', 5 , 'Rio de Janeiro', 1800);

EXPLAIN SELECT * FROM cap11.TB_CLIENTES;

DESCRIBE SELECT * FROM cap11.TB_CLIENTES;

SHOW WARNINGS;

EXPLAIN SELECT * FROM cap11.TB_CLIENTES WHERE id = 1;

EXPLAIN SELECT * FROM cap11.TB_CLIENTES WHERE nome = 'Bob Silva';

CREATE INDEX nome_cliente_index on cap11.TB_CLIENTES(nome);  

EXPLAIN SELECT * FROM cap11.TB_CLIENTES WHERE nome = 'Bob Silva';

DROP INDEX nome_cliente_index ON cap11.TB_CLIENTES;

EXPLAIN SELECT * FROM cap11.TB_CLIENTES WHERE nome = 'Bob Silva' OR nome = 'Zinedine Zidane';

EXPLAIN SELECT cap11.TB_CLIENTES.nome, cap11.TB_PEDIDOS.data_pedido, cap11.TB_PEDIDOS.valor
FROM cap11.TB_CLIENTES
JOIN cap11.TB_PEDIDOS ON (cap11.TB_CLIENTES.id = cap11.TB_PEDIDOS.id_cliente)
WHERE cap11.TB_CLIENTES.nome = 'Zico Miranda';

EXPLAIN SELECT id as ID FROM cap11.TB_CLIENTES  
UNION ALL  
SELECT id_cliente as ID FROM cap11.TB_PEDIDOS; 

EXPLAIN SELECT id AS ID FROM cap11.TB_CLIENTES  
UNION ALL  
SELECT id_cliente AS ID FROM cap11.TB_PEDIDOS
ORDER BY ID;


