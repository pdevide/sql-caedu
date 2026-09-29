select item_composicao, sum(qtde) qtde, sum(valor) valor 
from CM_ESTOQUE_PA_COMPOSICAO where cod_custo_medio = '201805'
group by item_composicao





select * from NATUREZAS_ENTRADAS where CM_ITEM_COMPOSICAO = '304'
