--SELECT * FROM TRANSACOES WHERE CONTROL_SISTEMA LIKE '005102%'

--update compras 

--set status_aprovacao = 'A' 

--where pedido in ('169696')

--select * from compras where pedido like '169696%'


--select * from produtos_precos where produto = '06370788'

--update produtos_precos 
--set preco1 = 31.99
--where produto = '06370788' and CODIGO_TAB_PRECO='04'


select P.fator_p, P.data_para_transferencia, PP.PRECO1, * 
from produtos P
INNER JOIN PRODUTOS_PRECOS PP ON PP.PRODUTO=P.PRODUTO AND PP.CODIGO_TAB_PRECO='01'
WHERE P.grupo_produto = 'BOTTOM CONT' and P.subgrupo_produto = 'CALCA' AND P.LINHA = 'JEANS' AND P.GRIFFE = 'MASCULINO'
AND (PP.PRECO1 BETWEEN 70.00 AND	79.99)




SELECT * FROM CAE_PRODUTOS_FATOR_P
WHERE grupo_produto = 'BOTTOM CONT' and subgrupo_produto = 'CALCA' AND LINHA = 'JEANS' AND GRIFFE = 'MASCULINO'



SELECT p.produto, 
       p.desc_produto, 
       p.grupo_produto, 
       p.subgrupo_produto, 
       p.linha, 
       p.griffe, 
       p.inativo, 
       p.data_para_transferencia, 
       p.fator_p, 
       fp.referencia, 
       fp.codigo_fator, 
       fp.valor1, 
       fp.valor2, 
       fp.atualizado, 
       pp.codigo_tab_preco, 
       pp.preco1 
FROM   dbo.produtos AS p 
       INNER JOIN dbo.produtos_precos AS pp 
               ON p.produto = pp.produto 
                  AND pp.codigo_tab_preco = '01' 
       LEFT OUTER JOIN dbo.cae_produtos_fator_p AS fp 
                    ON fp.grupo_produto = p.grupo_produto 
                       AND fp.subgrupo_produto = p.subgrupo_produto 
                       AND fp.linha = p.linha 
                       AND fp.griffe = p.griffe 
					   AND pp.PRECO1 between fp.VALOR1 and fp.VALOR2

WHERE  P.FATOR_P <> FP.REFERENCIA
		AND P.DATA_PARA_TRANSFERENCIA > '20151231'
	    AND P.grupo_produto = 'BOTTOM CONT' 
       AND P.subgrupo_produto = 'CALCA' 
       AND P.linha = 'JEANS' 
       AND P.griffe = 'MASCULINO' 
	   