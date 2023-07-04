# Total de vendas
SELECT sum(valor_venda)
FROM cap06.tb_vendas;

# Total de vendas por ano fiscal

SELECT ano_fiscal, SUM(valor_venda) as Soma
FROM cap06.tb_vendas
GROUP BY ano_fiscal
ORDER BY ano_fiscal DESC;

# Total de vendas por funcionarios

SELECT nome_funcionario, SUM(valor_venda) as Soma
FROM cap06.tb_vendas
GROUP BY nome_funcionario
ORDER BY soma DESC;

# Total de vendas por funcionarios e ano

SELECT nome_funcionario, ano_fiscal, SUM(valor_venda) as Soma
FROM cap06.tb_vendas
GROUP BY nome_funcionario, ano_fiscal
ORDER BY ano_fiscal DESC;

SELECT
	ano_fiscal,
	nome_funcionario,
	valor_venda,
	SUM(valor_venda) OVER (PARTITION BY ano_fiscal) as total_vendas_ano
FROM cap06.tb_vendas
ORDER BY ano_fiscal;

SELECT
	ano_fiscal,
	nome_funcionario,
	valor_venda,
	SUM(valor_venda) OVER () as total_vendas_ano
FROM cap06.tb_vendas
ORDER BY ano_fiscal;

# Numero de vendas por ano, por funcionario e numero total de vendas em todos os anos

SELECT
	ano_fiscal,
	nome_funcionario,
	COUNT(*) as total_vendas_ano,
	COUNT(*) OVER() as total_vendas_todos_anos
FROM cap06.tb_vendas
GROUP BY ano_fiscal, nome_funcionario;

SELECT ano_fiscal,
	   nome_funcionario,
	   COUNT(*) as total_vendas_ano,
	   (SELECT count(*) from cap06.tb_vendas) as total_vendas_todos_anos
FROM cap06.tb_vendas
GROUP BY ano_fiscal, nome_funcionario;


# Laboratorio

# Duracao total do aluguel das bikes (horas)

SELECT ROUND(((sum(duracao_segundos)/60)/60),2) as duracao_horas
FROM cap06.tb_bikes;

# Duracao total do aluguel das bikes (horas), ao longo do tempo (soma acumulada)

SELECT duracao_segundos, 
	sum(duracao_segundos/60/60) OVER (ORDER BY data_inicio) as duracao_total
FROM cap06.tb_bikes;

# Duracao total do aluguel das bikes (em horas), ao longo do tempo, por estacao de inicio do aluguel da bike,
# quando a data de inicio foi inferior a '2012-01-08'


SELECT data_inicio, duracao_segundos,
	sum(duracao_segundos/60/60) OVER (PARTITION BY estacao_inicio ORDER BY data_inicio) as duracao_total
FROM cap06.tb_bikes
WHERE data_inicio < '2012-01-08';

# Qual a media de tempo (em horas) de aluguel de bike da estacao de inicio 31017?

SELECT estacao_inicio, avg(duracao_segundos/60/60) as media
FROM cap06.tb_bikes
WHERE numero_estacao_inicio = 31017
GROUP BY estacao_inicio;

# Qual a media de tempo (em horas) de aluguel de bike da estacao de inicio 31017, ao longo do tempo?
SELECT estacao_inicio,
	duracao_segundos,
	avg(duracao_segundos/60/60) OVER (PARTITION BY estacao_inicio ORDER BY data_inicio) as media
FROM cap06.tb_bikes
WHERE numero_estacao_inicio = 31017;


# Desafio

SELECT estacao_inicio, 
	data_inicio, 
	duracao_segundos,
	sum(duracao_segundos/60/60) OVER (PARTITION BY estacao_inicio ORDER BY data_inicio) as total_tempo,
	avg(duracao_segundos/60/60) OVER (PARTITION BY estacao_inicio ORDER BY data_inicio) as media_tempo,
	count(*) OVER (PARTITION BY estacao_inicio ORDER BY data_inicio) as alugueis_bikes
FROM cap06.tb_bikes
WHERE data_inicio < '2012-01-08';

# Desafio 2

SELECT estacao_inicio, 
	data_inicio,
	duracao_segundos,
	COUNT(duracao_segundos/60/60) OVER (ORDER BY data_inicio)
FROM cap06.tb_bikes
WHERE data_inicio < '2012-01-08';


Solucao 2:

SELECT estacao_inicio, 
	data_inicio,
	duracao_segundos,
	ROW_NUMBER() OVER (ORDER BY data_inicio)
FROM cap06.tb_bikes
WHERE data_inicio < '2012-01-08';

SELECT estacao_inicio, 
	CAST(data_inicio as date) as data_inicio,
	duracao_segundos,
	ROW_NUMBER() OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date))
FROM cap06.tb_bikes
WHERE data_inicio < '2012-01-08'
AND numero_estacao_inicio = 31000;

# DENSE RANK

SELECT estacao_inicio, 
	CAST(data_inicio as date) as data_inicio,
	duracao_segundos,
	DENSE_RANK() OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date))
FROM cap06.tb_bikes
WHERE data_inicio < '2012-01-08'
AND numero_estacao_inicio = 31000;

# RANK

SELECT estacao_inicio, 
	CAST(data_inicio as date) as data_inicio,
	duracao_segundos,
	RANK() OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date))
FROM cap06.tb_bikes
WHERE data_inicio < '2012-01-08'
AND numero_estacao_inicio = 31000;

# RANK, DENSE_RANK E ROW_NUMBER

SELECT estacao_inicio, 
	CAST(data_inicio as date) as data_inicio,
	duracao_segundos,
	RANK() OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) as ranking_aluguel_rank,
	DENSE_RANK() OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) as ranking_aluguel_dense_rank,
	ROW_NUMBER() OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) as ranking_aluguel_row_number
FROM cap06.tb_bikes
WHERE data_inicio < '2012-01-08'
AND numero_estacao_inicio = 31000;

# Qual a diferença da duração do aluguel de bikes ao longo do tempo, de um registro para outro?

SELECT estacao_inicio,
	   CAST(data_inicio as date) as data_inicio,
	   duracao_segundos,
	   duracao_segundos - LAG(duracao_segundos,1) OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS diferenca
FROM cap06.tb_bikes
WHERE data_inicio < '2012-01-08'
AND numero_estacao_inicio = 31000;


# LAG com Subquery

SELECT * FROM (
SELECT estacao_inicio,
	   CAST(data_inicio as date) as data_inicio,
	   duracao_segundos,
	   duracao_segundos - LAG(duracao_segundos,1) OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as date)) AS diferenca
FROM cap06.tb_bikes
WHERE data_inicio < '2012-01-08'
AND numero_estacao_inicio = 31000
) as resultado
WHERE resultado.diferenca IS NOT NULL;

# Extraindo itens especificos da data

SELECT data_inicio,
	   DATE(data_inicio),
	   TIMESTAMP(data_inicio),
	   YEAR(data_inicio),
	   MONTH(data_inicio),
	   DAY(data_inicio)
FROM cap06.tb_bikes
WHERE numero_estacao_inicio = 31000;

# Extraindo o mes da data

SELECT EXTRACT(MONTH FROM data_inicio) AS mes,
	   MONTH(data_inicio),
	   duracao_segundos
FROM cap06.tb_bikes
WHERE numero_estacao_inicio = 31000;

# Adicionando 10 dias a data de inicio

SELECT data_inicio, DATE_ADD(data_inicio, INTERVAL 10 DAY) AS data_inicio_adicionado, duracao_segundos
FROM cap06.tb_bikes
WHERE numero_estacao_inicio = 31000;

# Retornando dados de 10 dias anteriores a data de inicio do aluguel da bike

SELECT data_inicio, duracao_segundos
FROM cap06.tb_bikes
WHERE DATE_SUB("2012-03-31", INTERVAL 10 DAY) <= data_inicio
AND numero_estacao_inicio = 31000;

# Diferenca entre data_inicio e data_fim

SELECT DATE_FORMAT(data_inicio, '%H') as data_inicio,
	   DATE_FORMAT(data_fim, '%H') as data_fim,
	   (DATE_FORMAT(data_inicio, '%H') - DATE_FORMAT(data_fim, '%H')) as diff
FROM cap06.tb_bikes
WHERE numero_estacao_inicio = 31000;



# Exercicios

# 1-Qual a média de tempo (em segundos) de duração do aluguel de bike por tipo de membro?

SELECT ROUND(avg(duracao_segundos),2) as media, tipo_membro
FROM exec05.tb_bikes
GROUP BY tipo_membro
ORDER BY media;

# 2-Qual a média de tempo (em segundos) de duração do aluguel de bike por tipo de membro e por estação fim (onde as bikes são entregues após o aluguel)?

SELECT ROUND(avg(duracao_segundos),2) as media, tipo_membro, estacao_fim
FROM exec05.tb_bikes
GROUP BY tipo_membro, estacao_fim
ORDER BY media;

# 3-Qual a média de tempo (em segundos) de duração do aluguel de bike por tipo de membro e por estação fim (onde as bikes são entregues após o aluguel) ao longo do tempo?

SELECT duracao_segundos,
	   tipo_membro,
	   estacao_fim,
	   avg(duracao_segundos) OVER (PARTITION BY tipo_membro ORDER BY CAST(data_inicio as date)) as tipo_membro
FROM exec05.tb_bikes;

# 4-Qual hora do dia (independente do mês) a bike de número W01182 teve o maior número de aluguéis considerando a data de início?

SELECT HOUR(data_inicio) as hora, numero_bike, count(*) as qtd_alugueis
FROM exec05.tb_bikes
WHERE numero_bike = 'W01182'
GROUP BY hora
ORDER BY qtd_alugueis DESC;

RESPOSTA: 17:00 (91 alugueis)

# 5-Qual o número de aluguéis da bike de número W01182 ao longo do tempo considerando a data de início?

SELECT CAST(data_inicio as DATE) as data_inicio,
	   count(*) OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as DATE)) as qtd_alugueis
FROM exec05.tb_bikes
WHERE numero_bike = 'W01182'
ORDER BY data_inicio;


# 6-Retornar:# Estação fim, data fim de cada aluguel de bike e duração de cada aluguel em segundos
# Número de aluguéis de bikes (independente da estação) ao longo do tempo 
# Somente os registros quando a data fim foi no mês de Abril

SELECT estacao_fim, 
	   MONTH(data_fim) as mes, 
	   duracao_segundos,
	   DATE_FORMAT(data_fim, '%m-%d-%Y') as data_formatada,
	   count(*) OVER (ORDER BY CAST(data_fim as DATE)) as qtd_alugueis
FROM exec05.tb_bikes
WHERE MONTH(data_fim) = 04;


# 7-Retornar:
# Estação fim, data fim e duração em segundos do aluguel 
# A data fim deve ser retornada no formato: 01/January/2012 00:00:00
# Queremos a ordem (classificação ou ranking) dos dias de aluguel ao longo dotempo
# Retornar os dados para os aluguéis entre 7 e 11 da manhã

SELECT estacao_fim,
	   DATE_FORMAT(data_fim, '%d/%M/%Y %H:%i:%S') as data_formatada,
	   duracao_segundos,
	   DENSE_RANK() OVER (PARTITION BY estacao_fim ORDER BY CAST(data_inicio as DATE)) as ranking_aluguel_rank
FROM exec05.tb_bikes
WHERE HOUR(data_fim) BETWEEN 7 AND 11;



# 8-Qual a diferença da duração do aluguel de bikes ao longo do tempo, de um registro para outro, considerando data de início do aluguel e estação de início?
# A data de início deve ser retornada no formato: Sat/Jan/12 00:00:00 (Sat = Dia da semana abreviado e Jan igual mês abreviado). 
#Retornar os dados para os aluguéis entre 01 e 03 da manhã

SELECT * FROM (SELECT estacao_inicio,
	   DATE_FORMAT(data_inicio, '%a/%b/%d %H:%i:%s'),
	   duracao_segundos - LAG(duracao_segundos, 1) OVER (PARTITION BY estacao_inicio ORDER BY CAST(data_inicio as DATE)) as diff
FROM exec05.tb_bikes
WHERE HOUR(data_inicio) BETWEEN 1 AND 3) as diferenca
WHERE diferenca.diff IS NOT NULL;


# 9-Retornar:# Estação fim, data fim e duração em segundos do aluguel 
# A data fim deve ser retornada no formato: 01/January/2012 00:00:00
# Queremos os registros divididos em 4 grupos ao longo do tempo por partição
# Retornar os dados para os aluguéis entre 8 e 10 da manhã
# Qual critério usado pela função NTILE para dividir os grupos?

SELECT estacao_fim,
	   DATE_FORMAT(data_fim, '%d/%M/%Y %H:%i:%s') as data_formatada,
	   duracao_segundos,
	   NTILE(4) OVER (PARTITION BY estacao_fim ORDER BY CAST(data_inicio as DATE)) as grupos
FROM exec05.tb_bikes
WHERE HOUR(data_fim) BETWEEN 8 AND 10;

# 10-Quais estações tiveram mais de 35 horas de duração total do aluguel de bike ao longo do tempo considerando a data fim e estação fim?
# Retorne os dados entre os dias '2012-04-01' e '2012-04-02'
# Dica: Use função window e subquery


SELECT * FROM 
	(SELECT estacao_fim,
	   CAST(data_fim as DATE) as data_fim,
	   ROUND(sum(duracao_segundos/60/60) OVER (PARTITION BY estacao_fim ORDER BY CAST(data_fim as DATE)),2) as soma_horas
FROM exec05.tb_bikes
WHERE data_fim BETWEEN '2012-04-01' AND '2012-04-02') as horas
WHERE horas.soma_horas > 35
ORDER BY horas.estacao_fim;