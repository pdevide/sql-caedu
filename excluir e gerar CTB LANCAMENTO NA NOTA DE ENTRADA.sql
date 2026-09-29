select b.*
from ctb_lancamento a
inner join ctb_lancamento_item b on b.LANCAMENTO = a.LANCAMENTO and b.EMPRESA = a.EMPRESA
where a.LANCAMENTO = 2847309

delete from ctb_lancamento where LANCAMENTO = 2843248 

select A.CTB_ITEM, a.CTB_LANCAMENTO 
--UPDATE A SET A.CTB_ITEM=NULL, CTB_LANCAMENTO =NULL, 
--ERP_EBS_AP_DATA_ENVIO=NULL, ERP_EBS_GL_DATA_ENVIO=NULL, ERP_EBS_SYNCHRO_DATA_ENVIO=NULL
from entradas A where NF_ENTRADA = '000075076' and NOME_CLIFOR='PAXA'

go
exec LX_CTB_INTEGRAR_ENTRADA 'PAXA', '000075076', '002'
go

-- atualizar pedido de compras
update compras set desconto = 432.00, TOT_VALOR_ORIGINAL = (TOT_VALOR_ORIGINAL - 432.00) WHERE PEDIDO = '299373'







