# Cria a tabela
CREATE TABLE exec05.TB_BIKES (
  `duracao_segundos` int DEFAULT NULL,
  `data_inicio` text,
  `data_fim` text,
  `numero_estacao_inicio` int DEFAULT NULL,
  `estacao_inicio` text,
  `numero_estacao_fim` int DEFAULT NULL,
  `estacao_fim` text,
  `numero_bike` text,
  `tipo_membro` text);


# Carga de dados via linha de comando

# Conecte no MySQL via linha de comando
/usr/local/mysql/bin/mysql --local-infile=1 -u root -p

# Execute:
SET GLOBAL local_infile = true;


# Carrega os dados
LOAD DATA LOCAL INFILE 'G:/My Drive/Mega/Faculdade/Cursos/Formacao_Analista_de_dados/SQL_para_Data_Science/Capitulo_9/8-dataset/dataset.csv' INTO TABLE `ana_caso_cap09`.`openaq` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'G:/My Drive/Mega/Faculdade/Cursos/Formacao_Analista_de_dados/SQL_para_Data_Science/Capitulo_9/8-dataset/dataset.csv' INTO TABLE `ana_caso_cap09`.`openaq` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 LINES;

