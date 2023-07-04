# Script 07 - A

# Cria a tabela
CREATE TABLE cap08.TB_PIPELINE_VENDAS (
  `Account` text,
  `Opportunity_ID` text,
  `Sales_Agent` text,
  `Deal_Stage` text,
  `Product` text,
  `Created_Date` text,
  `Close_Date` text,
  `Close_Value` text DEFAULT NULL
);

# Carregue o dataset3.csv na tabela anterior a partir do MySQL Workbench

# Cria a tabela
CREATE TABLE cap08.TB_VENDEDORES (
  `Sales_Agent` text,
  `Manager` text,
  `Regional_Office` text,
  `Status` text
);

# Carregue o dataset4.csv na tabela anterior a partir do MySQL Workbench

# Responda os itens abaixo com Linguagem SQL

# 1- Total de vendas

SELECT count(close_value) as qtd_vendas
FROM cap08.TB_PIPELINE_VENDAS;

# 2- Valor total vendido

SELECT SUM(CAST(close_value as decimal(10,2))) as valor
FROM cap08.TB_PIPELINE_VENDAS;

# 3- Número de vendas concluídas com sucesso

SELECT count(close_value) as qtd_vendas
FROM cap08.TB_PIPELINE_VENDAS
WHERE deal_stage = 'Won';

# 4- Média do valor das vendas concluídas com sucesso

SELECT round(avg(CAST(close_value as decimal)),2) as media_vendas
FROM cap08.TB_PIPELINE_VENDAS
WHERE deal_stage = 'Won';

# 5- Valor máximo vendido

SELECT max(CAST(close_value as decimal)) as valor_max
FROM cap08.TB_PIPELINE_VENDAS
WHERE deal_stage = 'Won';

# 6- Valor mínimo vendido entre as vendas concluídas com sucesso

SELECT min(CAST(close_value as decimal)) as valor_min
FROM cap08.TB_PIPELINE_VENDAS
WHERE deal_stage = 'Won';

# 7- Valor médio das vendas concluídas com sucesso por agente de vendas

SELECT sales_agent, TRUNCATE(avg(CAST(close_value as decimal)),2) as valor_med
FROM cap08.TB_PIPELINE_VENDAS
WHERE deal_stage = 'Won'
GROUP BY sales_agent;

# 8- Valor médio das vendas concluídas com sucesso por gerente do agente de vendas

SELECT v.manager, TRUNCATE(avg(CAST(pv.close_value as decimal)),2) as valor_med
FROM cap08.TB_PIPELINE_VENDAS pv, cap08.TB_vendedores v
WHERE pv.sales_agent = v.sales_agent
AND pv.deal_stage = 'Won'
GROUP BY v.manager;

# 9- Total do valor de fechamento da venda por agente de venda e por conta das vendas concluídas com sucesso

SELECT account, sales_agent, SUM(CAST(close_value as decimal)) as total
FROM cap08.TB_PIPELINE_VENDAS
GROUP BY sales_agent, account;


# 10- Número de vendas por agente de venda para as vendas concluídas com sucesso e valor de venda superior a 1000

SELECT sales_agent, count(close_value) as qtd_vendas
FROM cap08.TB_PIPELINE_VENDAS
WHERE CAST(close_value as decimal) > 1000
GROUP BY sales_agent;

# 11- Número de vendas e a média do valor de venda por agente de vendas

SELECT sales_agent, count(close_value) as qtd_vendas, ROUND(avg(CAST(close_value as decimal)),2) as media_vendas
FROM cap08.TB_PIPELINE_VENDAS
GROUP BY sales_agent
ORDER BY qtd_vendas DESC;

# 12- Quais agentes de vendas tiveram mais de 30 vendas?

SELECT sales_agent, count(close_value) as qtd_vendas
FROM cap08.TB_PIPELINE_VENDAS
GROUP BY sales_agent
HAVING qtd_vendas > 30
ORDER BY qtd_vendas;