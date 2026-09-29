SELECT filiais.tipo_filial, 
       produtos.produto, 
       w_estoque_produtos_00.cor_produto, 
       w_estoque_produtos_00.filial, 
       w_estoque_produtos_00.data_custo_medio, 
       w_estoque_produtos_00.data_ult_custo, 
       w_estoque_produtos_00.ultima_saida, 
       w_estoque_produtos_00.ultima_entrada, 
       w_estoque_produtos_00.disponivel, 
       w_estoque_produtos_00.estoque, 
       w_estoque_produtos_00.embalado, 
       w_estoque_produtos_00.transito, 
       w_estoque_produtos_00.fat_dev, 
       w_estoque_produtos_00.es1, 
       w_estoque_produtos_00.es2, 
       w_estoque_produtos_00.es3, 
       w_estoque_produtos_00.es4, 
       w_estoque_produtos_00.es5, 
       w_estoque_produtos_00.es6, 
       w_estoque_produtos_00.es7, 
       w_estoque_produtos_00.es8, 
       w_estoque_produtos_00.es9, 
       w_estoque_produtos_00.es10, 
       w_estoque_produtos_00.es11, 
       w_estoque_produtos_00.es12, 
       w_estoque_produtos_00.es13, 
       w_estoque_produtos_00.es14, 
       w_estoque_produtos_00.es15, 
       w_estoque_produtos_00.es16, 
       w_estoque_produtos_00.tipo_produto, 
       w_estoque_produtos_00.desc_produto, 
       w_estoque_produtos_00.grupo_produto, 
       w_estoque_produtos_00.subgrupo_produto, 
       w_estoque_produtos_00.colecao, 
       w_estoque_produtos_00.grade, 
       w_estoque_produtos_00.linha, 
       w_estoque_produtos_00.griffe, 
       w_estoque_produtos_00.unidade, 
       w_estoque_produtos_00.revenda, 
       w_estoque_produtos_00.fabricante, 
       w_estoque_produtos_00.refer_fabricante, 
       w_estoque_produtos_00.desc_cor_produto, 
       w_estoque_produtos_00.tinturaria_lavagem, 
       w_estoque_produtos_00.custo_medio1, 
       w_estoque_produtos_00.custo_medio2, 
       w_estoque_produtos_00.custo_medio3, 
       w_estoque_produtos_00.custo_medio4, 
       w_estoque_produtos_00.ultimo_custo1, 
       w_estoque_produtos_00.ultimo_custo4, 
       w_estoque_produtos_00.ultimo_custo3, 
       w_estoque_produtos_00.ultimo_custo2, 
       w_estoque_produtos_00.custo4_a_valorizar, 
       w_estoque_produtos_00.custo3_a_valorizar, 
       w_estoque_produtos_00.custo2_a_valorizar, 
       w_estoque_produtos_00.custo1_a_valorizar, 
       w_estoque_produtos_00.valor_estoque, 
       w_estoque_produtos_00.valor_disponivel, 
       w_estoque_produtos_00.valor_embalado, 
       w_estoque_produtos_00.valor_transito, 
       w_estoque_produtos_00.emb1, 
       w_estoque_produtos_00.emb2, 
       w_estoque_produtos_00.emb3, 
       w_estoque_produtos_00.emb4, 
       w_estoque_produtos_00.emb5, 
       w_estoque_produtos_00.emb6, 
       w_estoque_produtos_00.emb7, 
       w_estoque_produtos_00.emb8, 
       w_estoque_produtos_00.emb9, 
       w_estoque_produtos_00.emb10, 
       w_estoque_produtos_00.emb11, 
       w_estoque_produtos_00.emb12, 
       w_estoque_produtos_00.emb13, 
       w_estoque_produtos_00.emb14, 
       w_estoque_produtos_00.emb15, 
       w_estoque_produtos_00.emb16, 
       CASE 
         WHEN produtos.varia_preco_cor = 1 THEN 
         w_estoque_produtos_00.custo_reposicao1 
         ELSE produtos.custo_reposicao1 
       END AS CUSTO_REPOSICAO1, 
       CASE 
         WHEN produtos.varia_preco_cor = 2 THEN 
         w_estoque_produtos_00.custo_reposicao2 
         ELSE produtos.custo_reposicao2 
       END AS CUSTO_REPOSICAO2, 
       CASE 
         WHEN produtos.varia_preco_cor = 3 THEN 
         w_estoque_produtos_00.custo_reposicao3 
         ELSE produtos.custo_reposicao3 
       END AS CUSTO_REPOSICAO3, 
       CASE 
         WHEN produtos.varia_preco_cor = 4 THEN 
         w_estoque_produtos_00.custo_reposicao4 
         ELSE produtos.custo_reposicao4 
       END AS CUSTO_REPOSICAO4, 
       w_estoque_produtos_00.varia_custo_cor, 
       w_estoque_produtos_00.varia_custo_tam, 
       w_estoque_produtos_00.empresa, 
       w_estoque_produtos_00.matriz_fiscal, 
       w_estoque_produtos_00.mat_contabil, 
       w_estoque_produtos_00.inativo, 
       w_estoque_produtos_00.categoria_produto, 
       w_estoque_produtos_00.subcategoria_produto, 
       w_estoque_produtos_00.custo_rep_unitario, 
       w_estoque_produtos_00.custo_rep_total, 
       w_estoque_produtos_00.en1, 
       w_estoque_produtos_00.en2, 
       w_estoque_produtos_00.en3, 
       w_estoque_produtos_00.en4, 
       w_estoque_produtos_00.en5, 
       w_estoque_produtos_00.en6, 
       w_estoque_produtos_00.en7, 
       w_estoque_produtos_00.en8, 
       w_estoque_produtos_00.en9, 
       w_estoque_produtos_00.en10, 
       w_estoque_produtos_00.en11, 
       w_estoque_produtos_00.en12, 
       w_estoque_produtos_00.en13, 
       w_estoque_produtos_00.en14, 
       w_estoque_produtos_00.en15, 
       w_estoque_produtos_00.en16,
       PRODUTOS.DATA_CADASTRAMENTO,
	   YEAR(PRODUTOS.DATA_CADASTRAMENTO) AS ANO_CADASTRO,
	   CASE WHEN LEFT(PRODUTOS.REFER_FABRICANTE,5) = 'CHIKS' THEN CAST(1 AS BIT) 
	   ELSE CAST(0 AS BIT)
	   END AS CHIKS_CENTER
FROM   w_estoque_produtos_00 
       JOIN produtos 
         ON w_estoque_produtos_00.produto = produtos.produto 
       JOIN filiais 
         ON w_estoque_produtos_00.filial = filiais.filial 
WHERE  filiais.matriz IN ( 'MATRIZ' ) 
AND w_estoque_produtos_00.FILIAL = 'CD REGIS'
