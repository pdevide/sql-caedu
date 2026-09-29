select pb.CODIGO_BARRA, pb.PRODUTO, p.DESC_PRODUTO, pb.COR_PRODUTO, pb.TAMANHO, pb.GRADE, 
p.GRADE as grade_base, p.DATA_CADASTRAMENTO, p.ERP_DATA_ATUALIZACAO
from PRODUTOS p
inner join produtos_barra pb on pb.PRODUTO=p.PRODUTO
where p.inativo = 0 and pb.INATIVO=0
order by pb.PRODUTO, pb.TAMANHO