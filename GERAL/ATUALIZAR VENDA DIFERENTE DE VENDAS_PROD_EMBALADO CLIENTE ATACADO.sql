declare @loja varchar(25) 
set @loja = 'VILA DIRCE'

--select b.* 
UPDATE b SET 
CLIENTE_ATACADO =@loja, 
REPRESENTANTE=@loja, 
GERENTE=@loja, 
NOME_CLIFOR_ENTREGA=@loja 
from [ccp\paulo.devide].TB_CAIXAS_A_FATURAR_20250526 a
left join vendas b on b.PEDIDO = a.venda
where a.filial=@loja


select (select top 1 nf_saida from faturamento_prod where caixa=a.caixa) as nota_nro, a.* 
from [ccp\paulo.devide].TB_CAIXAS_A_FATURAR_20250526 a
left join faturamento_prod b on b.caixa = a.caixa
order by lojadestino



select * from vendas where pedido = 'CX-31088392'
select * from vendas_prod_embalado where pedido = 'CX-31088392'


