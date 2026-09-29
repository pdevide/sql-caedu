23170083
369617v

select *
from caedu_reserva_automatica
where pedido = '369617v'

select * from CGP_LOG_DISTRIBUICOES_EXCLUIDAS where DISTRIBUICAO= '369617v'


select linxkey, login, count(*) as qt_acessos 
from _CONTROLE_CHAVE
where dt_access>'20260101'
group by linxkey, login
order by 1 asc, 2 asc



select *, RIGHT(REPLICATE('0', 8)+CAST(NUMERO AS VARCHAR),8)  as linxkey 
from CAEDU_INVENTARIO_CHAVES


