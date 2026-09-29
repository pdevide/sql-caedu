


select RTRIM(b.caixa) as caixa, a.filial 
into  [ccp\paulo.devide].[TB_CAIXAS_NAO_FATURADAS_PDA_4]
from [ccp\paulo.devide].[VW_CAIXAS_NAO_FATURADAS_PDA_4] a
left join vendas_prod_embalado b on b.caixa = a.caixa
where b.caixa is not null


declare @loja varchar(25) = 'VILA DAS MERCES'

SELECT * FROM [ccp\paulo.devide].[TB_CAIXAS_NAO_FATURADAS_PDA_4]
WHERE FILIAL = @loja

SELECT * FROM vendas 
WHERE pedido IN (SELECT 'CX-'+RTRIM(CAIXA) FROM [ccp\paulo.devide].[TB_CAIXAS_NAO_FATURADAS_PDA_4] WHERE FILIAL = @loja)

UPDATE VENDAS SET CLIENTE_ATACADO =@loja, REPRESENTANTE=@loja, GERENTE=@loja, NOME_CLIFOR_ENTREGA=@loja 
WHERE PEDIDO in ('CX-30177430'/*,'CX-30177580','CX-30177581','CX-30177582'*/  ) 



select p.grade, p.erp_qtd_pack, p.data_umode, pp.*
--update p set erp_qtd_pack = pp.qtde
from produtos p 
inner join produtos_packs_permitidos pp on pp.produto = p.produto
where p.produto = '51012761'


select * from caedu_compras_produtos_packs_total where produto = '51012761'