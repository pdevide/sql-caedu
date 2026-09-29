SELECT * FROM tb_modelagem WHERE nm_tabela LIKE '100%'

select P.DESC_PRODUTO,P.GRADE,P.ID_MODELAGEM,P.ID_MODELAGEM2,* 
from compras_produto 
INNER JOIN PRODUTOS P ON P.PRODUTO = COMPRAS_PRODUTO.PRODUTO
where COMPRAS_PRODUTO.produto in (
select produto from produtos where id_modelagem = 127)

select DISTINCT cp.produto, p.DESC_PRODUTO, p.grade, 
p.ID_MODELAGEM, (select nm_tabela from tb_modelagem WHERE id_modelagem = p.ID_MODELAGEM) AS NM_TABELA1,
p.ID_MODELAGEM2, (select nm_tabela from tb_modelagem WHERE id_modelagem = p.ID_MODELAGEM2) AS NM_TABELA2 
from 
	compras_produto cp
inner join 
	produtos p 
		on p.PRODUTO = cp.PRODUTO
where cp.PEDIDO = '170007'  

select DISTINCT cp.produto, P.GRADE, p.ID_MODELAGEM, p.ID_MODELAGEM2 
from 
	compras_produto cp
inner join 
	produtos p 
		on p.PRODUTO = cp.PRODUTO
where cp.PEDIDO = '165378'  

SELECT DISTINCT 
select count(*) from compras (nolock) where ERP_CAB_OPCAO =1


select * from tb_modelagem where id_modelagem = 80

select * from tb_modelagem where nm_tabela like '95%'
        --id_modelagem
        --Grade
        --Nm_tabela
        --tipo_medidas ( medias usadas para a tabela em questão)
        
--select * from produtos_tamanhos where grade = '36 ao 46'


--update compras
--set status_aprovacao='A'
--where pedido in ('167683','170229')

select * from tb_modelagem where id_modelagem=82

--32|23|33|87|7|80|30|17|78|83|29|28|26|37|88|73|72|82|

select * from tb_modelagem_tipo where id_tipo in (
32,23,33,87,7,80,30,17,78,83,29,28,26,37,88,73,72,82) and inativo = 0

select * 
from tb_modelagem_medida where id_modelagem = 82 and id_tipo in (
32,23,33,87,7,80,30,17,78,83,29,28,26,37,88,73,72,82)


select * from tb_modelagem_tolerancia where id_modelagem = 82 and id_tipo in 
 (32,23,33,87,7,80,30,17,78,83,29,28,26,37,88,73,72,82)


 select b.id_tipo, 
		b.nm_tipo,
		a.id_modelagem_medida,
		a.id_modelagem,
		a.id_usuario,
		a.grade,
		a.tamanho_1,
		a.tamanho_2,
		a.tamanho_3,
		a.tamanho_4,
		a.tamanho_5,
		a.tamanho_6,
		a.tamanho_7,
		a.tamanho_8,
		a.tamanho_9,
		a.tamanho_10,
		a.tamanho_11,
		a.tamanho_12,
		a.tamanho_13,
		a.tamanho_14,
		a.tamanho_15,
		a.tamanho_16,
		a.tamanho_17,
		a.tamanho_18,
		a.tamanho_19,
		a.tamanho_20,
		a.tamanho_21,
		a.tamanho_22,
		a.tamanho_23,
		a.tamanho_24,
		a.tamanho_25,
		a.tamanho_26,
		a.tamanho_27,
		a.tamanho_28,
		a.tamanho_29,
		a.tamanho_30,
		a.tamanho_31,
		a.tamanho_32,
		a.tamanho_33,
		a.tamanho_34,
		a.tamanho_35,
		a.tamanho_36,
		a.tamanho_37,
		a.tamanho_38,
		a.tamanho_39,
		a.tamanho_40,
		a.tamanho_41,
		a.tamanho_42,
		a.tamanho_43,
		a.tamanho_44,
		a.tamanho_45,
		a.tamanho_46,
		a.tamanho_47,
		a.tamanho_48,
		a.data, 
		c.tolerancia
 from tb_modelagem_medida a 
 inner join 
	tb_modelagem_tipo b
		on b.id_tipo = a.id_tipo
 left join 
	tb_modelagem_tolerancia c
		on c.id_modelagem = a.id_modelagem and c.id_tipo = a.id_tipo
 where a.id_modelagem = 80 and
	b.inativo=0 and b.id_tipo=82 


select * from produtos_tamanhos where grade = '36 AO 46'

SELECT * FROM COMPRAS_PRODUTO WHERE PEDIDO = '168704'           


SELECT GRADE,ID_MODELAGEM,* FROM PRODUTOS WHERE PRODUTO = '78010269'


36 A 60       36 ao 46
130

SELECT * FROM TB_MODELAGEM WHERE ID_MODELAGEM = 130           



select cp.pedido, a.produto, a.id_modelagem, a.grade, b.grade 
from produtos a 
inner join tb_modelagem b on b.ID_MODELAGEM = a.id_modelagem
inner join compras_produto cp on cp.produto = a.PRODUTO
where b.tipo_tabela=1 and a.grade = b.grade
