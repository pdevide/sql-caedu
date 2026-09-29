select a.produto, a.preco1 as preco_tab04, b.preco1 as preco_tab01, a.preco4
from produtos_precos a 
inner join produtos_precos b on b.produto = a.produto and b.CODIGO_TAB_PRECO = '01'
where a.CODIGO_TAB_PRECO = '04'
and a.produto in ('01020001', '01020002')
go

-- ida
update a
set a.preco4 = a.preco1, a.preco1 = (b.preco1 * 0.70)
from produtos_precos a 
inner join produtos_precos b on b.produto = a.produto and b.CODIGO_TAB_PRECO = '01'
where a.CODIGO_TAB_PRECO = '04'
--and a.produto in ('01020001', '01020002')
go

select a.produto, a.preco1 as preco_tab04, b.preco1 as preco_tab01, a.preco4
from produtos_precos a 
inner join produtos_precos b on b.produto = a.produto and b.CODIGO_TAB_PRECO = '01'
where a.CODIGO_TAB_PRECO = '04'
and a.produto in ('01020001', '01020002')
go

-- volta
update produtos_precos 
set preco1 = preco4, preco4 = 0.00 
where CODIGO_TAB_PRECO = '04'
--and produto in ('01020001', '01020002')
go

