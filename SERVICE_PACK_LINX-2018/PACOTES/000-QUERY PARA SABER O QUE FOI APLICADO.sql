select a.*, b.*, c.* 
from LxProcessoSP a
inner join LxProcessoSPItem b
			on b.IdLxProcessoSP = a.Id
inner join LxTipoTransacao c on c.Id = b.IdLxTipoTransacao
order by a.id desc


lx_cade transacao

lx_cade_coluna IdLxTipoTransacao

select * from LxTipoTransacao