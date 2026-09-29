SELECT 
	   E.NF_ENTRADA,
	   E.SERIE_NF_ENTRADA,
	   EI.ITEM_IMPRESSAO,
	   filial, 
       P.fabricante, 
       E.nome_clifor, 
       recebimento       AS RECEBIMENTO, 
       cast(EI.qtde_item as int) as qtde,
	   P.PRODUTO,
	   P.DESC_PRODUTO,
	   P.GRIFFE,
	   P.LINHA,
	   P.GRUPO_PRODUTO,
	   P.SUBGRUPO_PRODUTO 
FROM   entradas E 
       INNER JOIN entradas_item EI 
               ON EI.nome_clifor = E.nome_clifor 
                  AND EI.nf_entrada = E.nf_entrada 
                  AND EI.serie_nf_entrada = E.serie_nf_entrada 
       INNER JOIN produtos P 
               ON P.produto = EI.codigo_item 
WHERE  1 = 1 
       AND cod_transacao = 'ENTRADAS_102' 
ORDER BY NF_ENTRADA, SERIE_NF_ENTRADA, EI.ITEM_IMPRESSAO
