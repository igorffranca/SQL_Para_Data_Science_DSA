1-Aplique label encoding à variável menopausa.

SELECT DISTINCT menopausa FROM cap03.tb_dados2;

CREATE TABLE cap03.tb_dados3
AS
SELECT
	CASE
		WHEN menopausa = 'premeno' THEN 1
		WHEN menopausa = 'ge40' THEN 2
		WHEN menopausa = 'lt40' THEN 3
	END as menopausa,
	classe,
	tamanho_tumor,
	inv_nodes,
	node_caps,
	deg_malig,
	seio,
	quadrante,
	irradiando
FROM cap03.tb_dados2;

2-[Desafio] Crie uma nova coluna chamada posicao_tumor concatenando as colunas inv_nodes e quadrante.

SELECT * FROM cap03.tb_dados3;

CREATE TABLE cap03.tb_dados4
AS
SELECT classe,
tamanho_tumor,
menopausa,
CONCAT(inv_nodes, '-',quadrante) as posicao_tumor,
deg_malig,
seio,
irradiando
FROM cap03.tb_dados3;

3-[Desafio] Aplique One-Hot-Encoding à coluna deg_malig.

SELECT DISTINCT deg_malig FROM cap03.tb_dados2;

CREATE TABLE cap03.tb_dados4
AS
SELECT classe,
tamanho_tumor,
menopausa,
posicao_tumor,
CASE
	WHEN deg_malig = 1 THEN 1
    WHEN deg_malig = 2 THEN 0
    WHEN deg_malig = 3 THEN 0
END as deg_malig_1,
CASE
	WHEN deg_malig = 1 THEN 0
	WHEN deg_malig = 2 THEN 1
    WHEN deg_malig = 3 THEN 0
END as deg_malig_2,
CASE
	WHEN deg_malig = 1 THEN 0
    WHEN deg_malig = 2 THEN 0
	WHEN deg_malig = 3 THEN 1
END as deg_malig_3,
seio,
irradiando
FROM cap03.tb_dados4;


4-Crie um novo dataset com todas as variáveis após as transformações anteriores.

CREATE TABLE cap03.tb_dados4
AS
SELECT classe,
tamanho_tumor,
menopausa,
posicao_tumor,
CASE
	WHEN deg_malig = 1 THEN 1
    ELSE 0
END as deg_malig_1,
CASE
	WHEN deg_malig = 2 THEN 1
    ELSE 0
END as deg_malig_2,
CASE
	WHEN deg_malig = 3 THEN 1
	ELSE 0
END as deg_malig_3,
seio,
irradiando
FROM cap03.tb_dados4;