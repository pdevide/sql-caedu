SELECT 
	   f.COD_FILIAL,
       CM_ESTOQUE_PA.filial, 
	   CM_ESTOQUE_PA.data_saldo, 
	   p.CONTA_CONTABIL,	
	   CP.DESC_CONTA,
       CM_ESTOQUE_PA.produto AS Codigo_mercadoria, 
	   'PA' AS ORIGEM,
       CM_ESTOQUE_PA.cor_produto, 
       CM_ESTOQUE_PA.desc_produto, 
	   P.CLASSIF_FISCAL,
	   P.UNIDADE,
       --CM_ESTOQUE_PA.cod_custo_medio, 
       --CM_ESTOQUE_PA.desc_cor_produto, 
       CM_ESTOQUE_PA.qtde_saldo, 
       CM_ESTOQUE_PA.custo_medio_unitario, 
       CM_ESTOQUE_PA.valor_saldo
       --CM_ESTOQUE_PA.filial_matriz_contabil, 
       --CM_ESTOQUE_PA.filial_matriz_fiscal, 
       --CM_ESTOQUE_PA.qtde_stk_proprio, 
       --CM_ESTOQUE_PA.valor_stk_proprio, 
       --CM_ESTOQUE_PA.qtde_stk_com_terc, 
       --CM_ESTOQUE_PA.valor_stk_com_terc, 
       --CM_ESTOQUE_PA.qtde_stk_de_terc, 
       --CM_ESTOQUE_PA.valor_stk_de_terc 
FROM   Fx_cm_estoque_pa('201812', 0) AS CM_ESTOQUE_PA 
LEFT JOIN FILIAIS f on f.filial = CM_ESTOQUE_PA.filial
LEFT JOIN PRODUTOS p on p.produto = CM_ESTOQUE_PA.PRODUTO
LEFT JOIN CTB_CONTA_PLANO CP ON CP.CONTA_CONTABIL = P.CONTA_CONTABIL
--where CM_ESTOQUE_PA.produto = 'B0010010'


/*
lx_cade composicao

select top 100 * from CM_ESTOQUE_PA_COMPOSICAO where ITEM_COMPOSICAO='999' and DATA_SALDO = '20181231'

227183

select CONTA_CONTABIL,* from WPRODUTOS where produto = '01225197'

lx_cade_coluna conta_contabil


select * from CTB_CONTA_PLANO cp where cp.conta_contabil = '114.01.005'          

*/