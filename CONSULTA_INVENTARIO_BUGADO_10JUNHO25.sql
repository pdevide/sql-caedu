
select a.emissao, 
(select sum(qtde) as qtde
from FATURAMENTO_PROD fp
inner join faturamento f on f.nf_saida=fp.nf_saida and f.serie_nf=fp.serie_nf and f.filial=fp.FILIAL
where produto = b.PRODUTO and cor_produto=b.COR_PRODUTO
and f.NOME_CLIFOR= a.filial and f.EMISSAO<a.emissao) as nfe_pcs_faturadas
,b.* 
from ESTOQUE_PROD_CONTAGEM a
inner join ESTOQUE_PROD_CTG_ITENS b on b.NOME_CONTAGEM=a.NOME_CONTAGEM
where emissao > '20250501'
and filial in ('GO SH APARECIDA', 'SP SH JARDIM ORIENTE', 'GO SH PASSEIO DAS AGUAS')  
and QTDE_CONTAGEM > SALDO_CONTAGEM AND QTDE_CONTAGEM=1037

--SELECT * FROM CAEDU_RESERVA_AUTOMATICA_PACK_WMS WHERE PRODUTO='34016279'    


--SELECT * FROM CAEDU_RESERVA_AUTOMATICA_PACK_WMS WHERE caixa = '31659836'


