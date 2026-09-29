/*
Boa tarde!

O produto Z2010176, pedido 289619 foi distribuído, porém o pack está com 10 
Por gentileza alterar o pack para 40 que é a quantidade que está na caixa.
Quantidade total de peças que foram distribuídas 2520
Por favor derrubar a distribuição atual e se possível redistribuir novamente com o pack de 40

Aguardo retorno, qualquer dúvida estou à disposição 
*/

select p.produto, p.ERP_QTD_PACK, pp.QTDE, pp.q1, 
		CPP.PEDIDO, CPP.PRODUTO, CPP.QTDE, CPP.Q1,
		CPPT.PEDIDO, CPPT.PRODUTO, CPPT.QTDE, CPPT.Q1
--UPDATE P SET ERP_QTD_PACK=40
--UPDATE PP SET QTDE=40, Q1=40
--UPDATE CPP SET  QTDE=40, Q1=40
--UPDATE CPPT SET  QTDE=40, Q1=40
from produtos p
inner join PRODUTOS_PACKS_PERMITIDOS pp on pp.PRODUTO=p.PRODUTO
inner join COMPRAS_PRODUTO cp on cp.PRODUTO = p.PRODUTO
inner join CAEDU_COMPRAS_PRODUTOS_PACKS CPP 
		ON CPP.PEDIDO=CP.PEDIDO AND CPP.PRODUTO=CP.PRODUTO AND CPP.COR_PRODUTO=CP.COR_PRODUTO
inner join CAEDU_COMPRAS_PRODUTOS_PACKS_TOTAL CPPT 
		ON CPPT.PEDIDO=CP.PEDIDO AND CPPT.PRODUTO=CP.PRODUTO 
where cp.pedido in ('289621')

--Produto Z2010179 Pedido 289623 total distribuído 2520
--Produto Z2010178 Pedido 289622 total distribuído 1520



