select * from produtos_precos where produto = '76011097'


select * from vendas_prod_embalado where produto in ('06062166')        

begin tran
update vendas_prod_embalado set 
preco1 = 16.30
,valor_embalado = qtde_embalada * 16.30
where produto = '06062166'

commit



select * from faturamento_caixas where caixa in (
select CAIXA from vendas_prod_embalado where produto in ('76011097')        
)


