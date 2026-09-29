declare @qtd_total int, @qtde_faturada int

select @qtd_total = count(*)  
from PDA_WMS_TB_EMBARQUE a
where a.data>'20250101' and a.data < convert(varchar,getdate(),112)

select @qtde_faturada = count(*)  
from PDA_WMS_TB_EMBARQUE a
left join faturamento_prod b on b.caixa = a.caixa
where a.data>'20250101' and a.data < convert(varchar,getdate(),112)
and b.caixa is not null


select @qtd_total as qtd_total, @qtde_faturada as qtde_faturada, @qtd_total - @qtde_faturada as nao_faturadas