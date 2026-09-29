SELECT 
       w_faturamento_prod_02.filial, 
       CONVERT(VARCHAR(6),w_faturamento_prod_02.emissao,112) AS EMISSAO,
       SUM(w_faturamento_prod_02.qtde) AS QTDE 
FROM   w_faturamento_prod_02 
       LEFT JOIN clientes_atacado CLIENTES_ATACADO 
              ON clientes_atacado.cliente_atacado = 
                 w_faturamento_prod_02.nome_clifor 
       JOIN produtos 
         ON w_faturamento_prod_02.produto = produtos.produto 
       JOIN filiais 
         ON filiais.filial = w_faturamento_prod_02.filial 
WHERE  w_faturamento_prod_02.emissao >= '20160101' 
       AND w_faturamento_prod_02.emissao <= '20180307' 
       AND filiais.matriz IN ( 'MATRIZ' ) 
	   AND w_faturamento_prod_02.filial IN ('CD REGIS','CD ARAQUARI', 'CD NAVEGANTES')
GROUP BY        
	w_faturamento_prod_02.filial, 
       CONVERT(VARCHAR(6),w_faturamento_prod_02.emissao,112) 

