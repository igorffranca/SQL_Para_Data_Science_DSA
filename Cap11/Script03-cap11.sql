# Script 03 - Otimização da Query 1

# Query 1
# Retorna os nomes dos clientes, cidades dos clientes, valor do pedido e vendedores que fizeram o atendimento, de clientes 
# do estado de SP cujo valor do pedido foi maior que 150
SELECT nome_cliente, cidade_cliente, valor_pedido, nome_vendedor
FROM cap05.TB_PEDIDOS P INNER JOIN cap05.TB_CLIENTES C INNER JOIN cap05.TB_VENDEDOR V
ON P.id_cliente = C.id_cliente
AND P.id_vendedor = V.id_vendedor
AND estado_cliente = 'SP'
AND valor_pedido > 150
ORDER BY nome_cliente;

Custo Geral: 6.24

Tempos de Execução:

Execution time: 0:00:0.00066018
Execution time: 0:00:0.00048300

ALTER TABLE `cap05`.`TB_CLIENTES` 
CHANGE COLUMN `id_cliente` `id_cliente` INT NOT NULL ,
ADD PRIMARY KEY (`id_cliente`);

ALTER TABLE `cap05`.`TB_VENDEDOR` 
CHANGE COLUMN `id_vendedor` `id_vendedor` INT NOT NULL ,
ADD PRIMARY KEY (`id_vendedor`);

ALTER TABLE `cap05`.`TB_PEDIDOS` 
CHANGE COLUMN `id_pedido` `id_pedido` INT NOT NULL ,
ADD PRIMARY KEY (`id_pedido`);

ALTER TABLE `cap05`.`TB_PEDIDOS` 
ADD INDEX `ix_id_vendedor` (`id_vendedor` ASC) VISIBLE;

ALTER TABLE `cap05`.`TB_PEDIDOS` 
DROP INDEX `ix_id_vendedor` ;

ALTER TABLE `cap05`.`TB_PEDIDOS` 
ADD INDEX `ix_id_cliente` (`id_cliente` ASC) VISIBLE;

ALTER TABLE `cap05`.`TB_PEDIDOS` 
DROP INDEX `ix_id_cliente` ;

ALTER TABLE `cap05`.`TB_PEDIDOS` 
ADD INDEX `ix_composto` (`id_cliente` ASC, `id_vendedor` ASC, `id_pedido` ASC) VISIBLE;

ALTER TABLE `cap05`.`TB_PEDIDOS` 
DROP INDEX `ix_composto` ;

ALTER TABLE `cap05`.`TB_PEDIDOS` 
ADD INDEX `ix_id_cliente` (`id_cliente` ASC) VISIBLE;

ALTER TABLE `cap05`.`TB_CLIENTES` 
ADD INDEX `ix_estado` (`estado_cliente` ASC) VISIBLE;

ALTER TABLE `cap05`.`TB_PEDIDOS` 
ADD INDEX `id_valor` (`valor_pedido` ASC) VISIBLE;

ALTER TABLE `cap05`.`TB_PEDIDOS` 
DROP INDEX `id_valor` ;

ALTER TABLE `cap05`.`TB_CLIENTES` 
ADD INDEX `ix_nome` (`nome_cliente` DESC) VISIBLE;

ALTER TABLE `cap05`.`TB_CLIENTES` 
DROP INDEX `ix_nome` ;

ALTER TABLE `cap05`.`TB_PEDIDOS` 
ADD CONSTRAINT `fk_id_vendedor`
  FOREIGN KEY (`id_vendedor`)
  REFERENCES `cap05`.`TB_VENDEDOR` (`id_vendedor`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `cap05`.`TB_PEDIDOS` 
ADD CONSTRAINT `fk_id_cliente`
  FOREIGN KEY (`id_cliente`)
  REFERENCES `cap05`.`TB_CLIENTES` (`id_cliente`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

Custo Geral: 4.47

Tempos de Execução:

Execution time: 0:00:0.00055408
Execution time: 0:00:0.00033700


Resumo:

-- Antes da Otimização:

Custo Geral: 6.24

Tempos de Execução:

Execution time: 0:00:0.00066018
Execution time: 0:00:0.00048300

-- Depois da Otimização:

Custo Geral: 4.47

Tempos de Execução:

Execution time: 0:00:0.00055408
Execution time: 0:00:0.00033700








