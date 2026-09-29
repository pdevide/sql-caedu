/*
select * from caedu_reserva_automatica a
inner join produtos p on p.produto = a.produto
where p.linha = 'BASKET' AND a.filial_origem = 'CD CAJAMAR'
AND YEAR(DATA)=2019
ORDER BY DATA DESC


--select * from produtos where linha = 'basket'

SELECT * FROM CAEDU_RESERVA_AUTOMATICA WHERE PEDIDO = '204005E1'  

SELECT * FROM PRODUTOS_PACKS_PERMITIDOS WHERE PRODUTO = '58010079'    
*/

SELECT F.COD_FILIAL, * FROM CAEDU_RESERVA_AUTOMATICA A
INNER JOIN FILIAIS F ON F.FILIAL = A.filial
WHERE PEDIDO = '204005E1'  

insert into PDA_WMS_TB_CX_EUREKA

select	tab1.COD_FILIAL,
		tab1.pedido,
		case 
		when tab1.RowNum between 1 and 5   then '14317430'
		when tab1.RowNum between 6 and 10  then '14317431'
		when tab1.RowNum between 11 and 15 then '14317432'
		when tab1.RowNum between 16 and 20 then '14317433'
		end as caixa_mae,
		tab1.caixa,
		tab1.qtde_total,
		tab1.usuario,
		tab1.dt_atualizacao
from (				
SELECT	ROW_NUMBER() OVER(ORDER BY caixa ASC) AS RowNum,
		F.COD_FILIAL, 
		A.pedido, 
		space(8) as caixa_mae, 
		A.caixa, 
		qtde_total, 
		1 as usuario, 
		GETDATE() dt_atualizacao
FROM CAEDU_RESERVA_AUTOMATICA A
INNER JOIN FILIAIS F ON F.FILIAL = A.filial
WHERE PEDIDO = '204005E1'  ) as tab1

select max(caixa) from FATURAMENTO_CAIXAS where len(caixa)=8