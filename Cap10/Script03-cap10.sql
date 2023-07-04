# Update e Delete

UPDATE cap10.TB_PRODUTO
SET nm_marca_produto = 'LG';

UPDATE cap10.TB_PRODUTO
SET nm_marca_produto = 'LG'
WHERE sk_produto = 4;

DELETE FROM cap10.TB_PRODUTO;

DELETE FROM cap10.TB_PRODUTO
WHERE sk_produto = 10;