SELECT * FROM FATURAMENTO WHERE NOME_CLIFOR = 'CLARO SERVIÇOS TÊXTEIS' ORDER BY NF_SAIDA
select * from entradas where nome_clifor like 'CLARO SERVIÇOS TÊXTEIS%'


select a.emissao, b.* 
from estoque_prod_ent a
inner join estoque_prod1_ent b 
	on b.ROMANEIO_PRODUTO = a.ROMANEIO_PRODUTO and b.FILIAL = a.FILIAL
where produto = '51042135' 

select * from LOJA_ENTRADAS a
inner join LOJA_ENTRADAS_PRODUTO b
	on b.ROMANEIO_PRODUTO = a.ROMANEIO_PRODUTO
		and b.FILIAL = a.FILIAL
where b.PRODUTO = '51042135' and a.ROMANEIO_PRODUTO = 'A0464328'

select filial_origem, count(*) as qty from loja_entradas
where datepart(HH,EMISSAO)>0
group by FILIAL_ORIGEM
--order by emissao desc


select count(*) from loja_entradas

