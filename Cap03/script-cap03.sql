# Binarização da coluna CLASSE

SELECT DISTINCT classe FROM cap03.tb_dados;

SELECT
  CASE
    WHEN classe = 'no-recurrence-events' THEN 0
        WHEN classe = 'recurrence-events' THEN 1
  END as classe
FROM cap03.tb_dados;

# Binarização da coluna IRRADIANDO

SELECT DISTINCT irradiando FROM cap03.tb_dados;

SELECT
  CASE
    WHEN irradiando = 'no' THEN 0
        WHEN irradiando = 'yes' THEN 1
  END as Irradiando
FROM cap03.tb_dados;

# Binarização da coluna NODE_CAPS

SELECT DISTINCT node_caps FROM cap03.tb_dados;

SELECT
  CASE
    WHEN node_caps = 'no' THEN 0
    WHEN node_caps = 'yes' THEN 1
    ELSE 2
  END as Node_caps
FROM cap03.tb_dados;

# Categorização da variável seio (E/D)

SELECT DISTINCT seio FROM cap03.tb_dados;

SELECT
  CASE
    WHEN seio = 'left' THEN 'E'
    WHEN seio = 'right' THEN 'D'
  END as Seio
FROM cap03.tb_dados;

# Categorização da variável tamanho_tumor (6 categorias)

SELECT DISTINCT tamanho_tumor FROM cap03.tb_dados;

SELECT
  CASE
    WHEN tamanho_tumor = '0-4' OR tamanho_tumor = '5-9' THEN '0-9'
    WHEN tamanho_tumor = '10-14' OR tamanho_tumor = '15-19' THEN '10-19'
    WHEN tamanho_tumor = '20-24' OR tamanho_tumor = '25-29' THEN '20-29'
    WHEN tamanho_tumor = '30-34' OR tamanho_tumor = '35-39' THEN '30-39'
    WHEN tamanho_tumor = '40-44' OR tamanho_tumor = '45-49' THEN '40-49'
    WHEN tamanho_tumor = '50-54' OR tamanho_tumor = '55-59' THEN '50-54'
  END as 'Tamanho Tumor'
FROM cap03.tb_dados;

# Label Enconding da variável quadrante (1,2,3,4,5)

SELECT DISTINCT quadrante FROM cap03.tb_dados;

SELECT
  CASE
    WHEN quadrante = 'left_low' THEN 1
    WHEN quadrante = 'right_up' THEN 2
    WHEN quadrante = 'left_up' THEN 3
    WHEN quadrante = 'right_low' THEN 4
    WHEN quadrante = 'central' THEN 5
    ELSE 0
  END as Quadrante
FROM cap03.tb_dados;

# Query para executar as transformações

SELECT
  CASE
    WHEN classe = 'no-recurrence-events' THEN 0
        WHEN classe = 'recurrence-events' THEN 1
  END as classe, idade, menopausa,
  CASE
    WHEN tamanho_tumor = '0-4' OR tamanho_tumor = '5-9' THEN '0-9'
    WHEN tamanho_tumor = '10-14' OR tamanho_tumor = '15-19' THEN '10-19'
    WHEN tamanho_tumor = '20-24' OR tamanho_tumor = '25-29' THEN '20-29'
    WHEN tamanho_tumor = '30-34' OR tamanho_tumor = '35-39' THEN '30-39'
    WHEN tamanho_tumor = '40-44' OR tamanho_tumor = '45-49' THEN '40-49'
    WHEN tamanho_tumor = '50-54' OR tamanho_tumor = '55-59' THEN '50-54'
  END as 'Tamanho Tumor', inv_nodes,
  CASE
    WHEN node_caps = 'no' THEN 0
    WHEN node_caps = 'yes' THEN 1
    ELSE 2
  END as Node_caps, deg_malig,
  CASE
    WHEN seio = 'left' THEN 'E'
    WHEN seio = 'right' THEN 'D'
  END as Seio,
  CASE
    WHEN quadrante = 'left_low' THEN 1
    WHEN quadrante = 'right_up' THEN 2
    WHEN quadrante = 'left_up' THEN 3
    WHEN quadrante = 'right_low' THEN 4
    WHEN quadrante = 'central' THEN 5
    ELSE 0
  END as Quadrante,
  CASE
    WHEN irradiando = 'no' THEN 0
        WHEN irradiando = 'yes' THEN 1
  END as Irradiando
FROM cap03.tb_dados;

# Criação da tabela com as transformações

CREATE TABLE cap03.tb_dados2
AS
SELECT
  CASE
    WHEN classe = 'no-recurrence-events' THEN 0
        WHEN classe = 'recurrence-events' THEN 1
  END as classe, idade, menopausa,
  CASE
    WHEN tamanho_tumor = '0-4' OR tamanho_tumor = '5-9' THEN '0-9'
    WHEN tamanho_tumor = '10-14' OR tamanho_tumor = '15-19' THEN '10-19'
    WHEN tamanho_tumor = '20-24' OR tamanho_tumor = '25-29' THEN '20-29'
    WHEN tamanho_tumor = '30-34' OR tamanho_tumor = '35-39' THEN '30-39'
    WHEN tamanho_tumor = '40-44' OR tamanho_tumor = '45-49' THEN '40-49'
    WHEN tamanho_tumor = '50-54' OR tamanho_tumor = '55-59' THEN '50-54'
  END as 'Tamanho Tumor', inv_nodes,
  CASE
    WHEN node_caps = 'no' THEN 0
    WHEN node_caps = 'yes' THEN 1
    ELSE 2
  END as Node_caps, deg_malig,
  CASE
    WHEN seio = 'left' THEN 'E'
    WHEN seio = 'right' THEN 'D'
  END as Seio,
  CASE
    WHEN quadrante = 'left_low' THEN 1
    WHEN quadrante = 'right_up' THEN 2
    WHEN quadrante = 'left_up' THEN 3
    WHEN quadrante = 'right_low' THEN 4
    WHEN quadrante = 'central' THEN 5
    ELSE 0
  END as Quadrante,
  CASE
    WHEN irradiando = 'no' THEN 0
        WHEN irradiando = 'yes' THEN 1
  END as Irradiando
FROM cap03.tb_dados;

SELECT COUNT(*) FROM cap03.tb_dados2;