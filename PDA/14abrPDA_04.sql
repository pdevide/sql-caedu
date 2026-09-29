
--declare @tabela table (caixa varchar(8))

--insert into @tabela (caixa) values ('30211087')
--insert into @tabela (caixa) values ('30211088')


--select a.* --, b.caixa, b.distribuicao, b.produto 
--from @tabela a 
----left join CAEDU_RESERVA_AUTOMATICA_PACK_WMS b (nolock) on b.caixa = a.caixa




select a.CAIXA as caixa_pda, a.DOCA, a.CODIGO_FILIAL, a.DATA, a.FATURADO, 
convert(varchar,a.data,112) as Data1, b.nf_saida,  c.nome_clifor, b.caixa as caixa_linx ,
D.DISTRIBUICAO, D.PRODUTO, D.FILIAL, D.VENDA, D.PACK, D.GERADO, D.FILIAL_ORIGEM, D.QTDE_TOTAL
from PDA_WMS_TB_EMBARQUE a  
left join FATURAMENTO_PROD b on b.caixa = a.caixa 
left join FATURAMENTO c ON c.NF_SAIDA=b.NF_SAIDA AND c.filial=b.filial and c.SERIE_NF=b.SERIE_NF 
left join CAEDU_RESERVA_AUTOMATICA_PACK_WMS D ON D.CAIXA = A.CAIXA
where a.data>'20250101' AND a.data<convert(varchar,getdate(),112) 
and b.nf_saida is null --AND D.CAIXA IS not NULL
and a.caixa not in (select caixa from [ccp\paulo.devide].tb_pda_wms_estoque_caixas
					union 
					select caixa from [ccp\paulo.devide].tb_pda_wms_estoque_caixas_2)
order by a.data, a.doca



select a.CAIXA as caixa_pda, a.DOCA, a.CODIGO_FILIAL, a.DATA, a.FATURADO, 
convert(varchar,a.data,112) as Data1, b.nf_saida,  c.nome_clifor, b.caixa as caixa_linx ,
D.pedido, D.PRODUTO, D.FILIAL, D.VENDA,D.GERADO, D.FILIAL_ORIGEM, D.QTDE_TOTAL
from PDA_WMS_TB_EMBARQUE a  
left join FATURAMENTO_PROD b on b.caixa = a.caixa 
left join FATURAMENTO c ON c.NF_SAIDA=b.NF_SAIDA AND c.filial=b.filial and c.SERIE_NF=b.SERIE_NF 
left join CAEDU_RESERVA_AUTOMATICA D ON D.CAIXA = A.CAIXA
where a.data>'20250101' AND a.data<convert(varchar,getdate(),112) 
and b.nf_saida is null --AND D.CAIXA IS not NULL
and a.caixa not in (select caixa from [ccp\paulo.devide].tb_pda_wms_estoque_caixas
					union 
					select caixa from [ccp\paulo.devide].tb_pda_wms_estoque_caixas_2)
order by a.data, a.doca