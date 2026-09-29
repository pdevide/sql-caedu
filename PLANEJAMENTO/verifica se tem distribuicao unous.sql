declare @produto varchar(8) = '83010051'

select * from caedu_reserva_automatica_pack_wms where produto = @produto and data>='20200125'

select * from caedu_reserva_automatica where produto = @produto and data>='20200125'

select * from produtos where produto = @produto



select data, pedido, produto, count(*) as qty
from caedu_reserva_automatica
where data>='20200125'
group by data, pedido, produto
