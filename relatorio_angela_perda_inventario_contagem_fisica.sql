select E.nome_Contagem, E.produto, sum(qtde_ajuste) as qtde, MAX(PP.PRECO1) AS CUSTO, MAX(EMISSAO) AS EMISSAO, MAX(DATA_AJUSTE) AS DATA_AJUSTE 
from ESTOQUE_PROD_CTG_AJUSTE E
INNER JOIN ESTOQUE_PROD_CONTAGEM EC ON EC.NOME_CONTAGEM = E.NOME_CONTAGEM
LEFT JOIN PRODUTOS_PRECOS PP ON PP.PRODUTO = E.PRODUTO AND PP.CODIGO_TAB_PRECO='00'
--where nome_Contagem = 'CARAPICUIBA 29-09-2017' 
group by E.nome_Contagem, E.produto 
having sum(qtde_ajuste) < 0
ORDER BY nome_Contagem, produto

SELECT * FROM ESTOQUE_PROD_CONTAGEM WHERE NOME_CONTAGEM = 'CARAPICUIBA 29-09-2017'



update compras set status_aprovacao = 'A' where pedido = '168321'