
SELECT    unpvt.nome_contagem,
		  cast(unpvt.emissao as Date) as EMISSAO,
		  unpvt.griffe, 
          unpvt.linha, 
          unpvt.grupo_produto, 
          unpvt.subgrupo_produto, 
          unpvt.produto,
          unpvt.cor_produto, 
          b.codigo_barra, 
          unpvt.desc_cor_produto, 
		  unpvt.desc_produto,
          RIGHT('00'+CONVERT(VARCHAR,b.tamanho),2) AS tamanho, 
          unpvt.qtde,
		  UNPVT.CUSTO,
		  UNPVT.CUSTO_MEDIO 
FROM      ( SELECT aj.NOME_CONTAGEM,
				   e.EMISSAO,
				   aj.produto, 
                   aj.cor_produto, 
				   prod.DESC_PRODUTO,
				   prod.griffe, 
				   prod.linha, 
                   prod.grupo_produto, 
                   prod.subgrupo_produto, 
				   pco.DESC_COR_PRODUTO,
				   h.PRECO1 as CUSTO,
				   MM.PRECO1 AS CUSTO_MEDIO,
                   A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16
              FROM   [CAEDU].[dbo].ESTOQUE_PROD_CTG_AJUSTE AJ
			  inner join ESTOQUE_PROD_CONTAGEM e
					on e.NOME_CONTAGEM = aj.NOME_CONTAGEM
			  inner join produtos prod on prod.produto = aj.produto	
			  left  join produto_cores pco on pco.PRODUTO = aj.PRODUTO and pco.COR_PRODUTO=aj.COR_PRODUTO
				LEFT JOIN [CAEDU].[dbo].produtos_precos AS h 
				ON        aj.produto=h.produto  AND h.codigo_tab_preco ='00'

				LEFT JOIN [CAEDU].[dbo].produtos_precos AS MM 
				ON        aj.produto=MM.produto AND MM.codigo_tab_preco ='85'

                 WHERE E.EMISSAO>='20190101' AND E.FILIAL IN 
				 ('SANTOS - CENTRO','PIRASSUNUNGA','DIADEMA','INDAIATUBA','HORTOLANDIA','SP - METRO CAPAO','ITAIM','JUNDIAI','IPIRANGA',
				 'VILA DIRCE','PINDAMONHANGABA','SANTOS - GONZAGA','GUARATINGUETA','MOGI DAS CRUZES','COTIA','JARDIM IGUATEMI','TAUBATE','SP - LAJEADO')
				 ) p 
				 UNPIVOT (qtde FOR tamanho IN 
				 (A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15,A16) )AS unpvt
LEFT JOIN 
          ( 
                   SELECT   produto, 
                            cor_produto, 
                            tamanho, 
                            min(codigo_barra) AS codigo_barra 
                   FROM     [CAEDU].[dbo].produtos_barra 
                   GROUP BY produto, 
                            cor_produto, 
                            tamanho ) b 
ON        b.produto = unpvt.produto 
AND       b.cor_produto = unpvt.cor_produto 
AND       b.tamanho = substring(unpvt.tamanho,
								CASE WHEN unpvt.tamanho IN ('A10','A11','A12','A13','A14','A15','A16') THEN 2 
								ELSE 2 END,2) 

WHERE unpvt.qtde<>0
ORDER BY 1, 2, 7, 8, 12

      