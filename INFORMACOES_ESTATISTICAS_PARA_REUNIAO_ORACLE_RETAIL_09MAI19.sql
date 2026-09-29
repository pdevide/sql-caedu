
/*Qtd de Produtos cadastrados por mês em 2017 e 2018*/
select convert(varchar(6),DATA_CADASTRAMENTO,112) as Ano_mes, count(*) as qtd
from produtos (nolock) 
where DATA_CADASTRAMENTO >='20170101'
group by convert(varchar(6),DATA_CADASTRAMENTO,112)
order by 1
go

/*Fornecedores que movimentaram pedido de compras entre 2017 e 2018*/
select ROW_NUMBER() OVER(ORDER BY fornecedor ASC) AS Rownum, fornecedor 
from fornecedores (nolock)
where inativo=0 and fornecedor in (select fornecedor from compras where emissao >= '20170101')
go

select convert(varchar(6),emissao,112) as Ano_mes, count(*) as qtd 
from compras (nolock) 
where emissao >='20170101'
group by convert(varchar(6),emissao,112)
order by 1
go

select FILIAL, convert(varchar(6),emissao,112) as Ano_mes, COUNT(*) AS QTD
from entradas where COD_TRANSACAO='ENTRADAS_102'
AND EMISSAO>='20170101'
group by FILIAL,convert(varchar(6),emissao,112)
ORDER BY 1,2
GO

SELECT FILIAL,NOME_CLIFOR, convert(varchar(6),emissao,112) as Ano_mes, COUNT(*) AS QTD
FROM FATURAMENTO (NOLOCK)
WHERE EMISSAO>='20170101'
AND FILIAL IN ('CD REGIS','CD CAJAMAR') AND TIPO_FATURAMENTO='TRANSFERENCIA' AND NATUREZA_SAIDA='120.01'                          
GROUP BY FILIAL,NOME_CLIFOR, convert(varchar(6),emissao,112)
ORDER BY 1,2,3
GO
