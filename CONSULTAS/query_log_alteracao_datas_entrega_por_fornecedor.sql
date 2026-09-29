select c.FORNECEDOR, t.* 
from trigger_portal t
inner join compras c on c.PEDIDO = t.pedido
where c.fornecedor like '%JEZZIAN%' and year(c.emissao) = 2019 
order by t.pedido, t.data_alteracao desc
