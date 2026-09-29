
WITH BASE (PRODUTO, COR_PRODUTO, QTD_BARRAS)
AS (
select p.produto,pc.cor_produto, count(codigo_barra) as qtd_barras
from produtos p
left join PRODUTO_CORES pc on pc.produto=p.produto
left join PRODUTOS_BARRA pb on pb.produto=pc.produto and pb.COR_PRODUTO=pc.COR_PRODUTO
--where p.DATA_PARA_TRANSFERENCIA>'20251201'
group by p.produto,pc.cor_produto
having count(codigo_barra)=0 AND pc.cor_produto is not null
)
SELECT *, 'EXEC CGP_LX_GERAR_CODIGO_BARRA '+CHAR(39)+RTRIM(LTRIM(A.PRODUTO))+CHAR(39)+';' AS COMANDO_SQL
FROM BASE A



