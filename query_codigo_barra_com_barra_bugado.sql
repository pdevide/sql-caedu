--select produto from estoque_produtos (nolock) where produto = '23030203'    


select codigo_barra from produtos_barra p where charindex('/',p.codigo_barra)>0
and produto in (
select produto from estoque_produtos (nolock) where estoque > 0)


select * from estoque_produtos where produto = 'D6050101'    


select * from loja_venda_produto (nolock)
where codigo_barra in (
select codigo_barra from produtos_barra p where charindex('/',p.codigo_barra)>0
and produto in (
select produto from estoque_produtos (nolock) where estoque > 0)
)
