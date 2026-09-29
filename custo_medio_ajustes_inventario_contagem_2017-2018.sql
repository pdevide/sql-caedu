select b.preco1, a.* from ESTOQUE_PROD_CTG_AJUSTE a
inner join produtos_precos b on b.PRODUTO = a.PRODUTO and b.CODIGO_TAB_PRECO='85'
where a.nome_contagem 
in (select nome_contagem from ESTOQUE_PROD_CONTAGEM where year(emissao) between 2017 and 2018)





--INVENTARIO_AJUSTE
--LJ_AJUSTE_TICKET_LOG