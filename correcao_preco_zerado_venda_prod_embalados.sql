select * from produtos_precos where produto = '76011097'


select * from vendas_prod_embalado where produto in ('76011096','76011097')        

begin tran
update vendas_prod_embalado set 
preco1 = 55
,valor_embalado = qtde_embalada * 55
where produto = '76011097'

commit



select * from faturamento_caixas where caixa in (
select CAIXA from vendas_prod_embalado where produto in ('76011097')        
)


