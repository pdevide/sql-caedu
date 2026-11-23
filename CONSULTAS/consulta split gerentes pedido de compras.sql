--select NOTA_PROGRAMADOR from parametros where parametro =	'PALMA_GERENTES_PEDIDO'

select * from dbo.FX_SPLITSTRING(
(select NOTA_PROGRAMADOR from parametros where parametro =	'PALMA_GERENTES_PEDIDO'), ';')
order by 1

