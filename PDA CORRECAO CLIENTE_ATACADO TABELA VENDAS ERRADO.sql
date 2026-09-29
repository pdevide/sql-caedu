declare @loja varchar(25) = 'VILA DAS MERCES'

SELECT b.nome_clifor,* FROM [CCP\PAULO.DEVIDE].TB_CAIXAS_A_FATURAR_20250514 a
inner join vendas_prod_embalado b on b.caixa = a.caixa
WHERE a.FILIAL = @loja

SELECT * FROM vendas 
WHERE pedido IN (SELECT 'CX-'+RTRIM(CAIXA) FROM [CCP\PAULO.DEVIDE].TB_CAIXAS_A_FATURAR_20250514 WHERE FILIAL = @loja)

UPDATE VENDAS SET CLIENTE_ATACADO =@loja, REPRESENTANTE=@loja, GERENTE=@loja, NOME_CLIFOR_ENTREGA=@loja 
WHERE PEDIDO in ('CX-30177430'/*,'CX-30177580','CX-30177581','CX-30177582'*/  ) 

/*
SELECT B.* 
--update b set qtde_embalada=10, e4=2,e5=4,e6=4, valor_embalado=10*preco1
update a set FATURADO=1
FROM 
[CCP\PAULO.DEVIDE].TB_CAIXAS_A_FATURAR_20250514 A
INNER JOIN VENDAS_PROD_EMBALADO B ON B.CAIXA=A.CAIXA
where qtde_embalada=0

WHERE A.FILIAL='BARREIRO' AND FATURADO=0
and b.produto = '47012245' and b.cor_produto='00013'


--select * from produtos_packs_permitidos where produto = '55110306' and cor_produto='00263'     
select * from produtos_packs_permitidos where produto = '47012245' and cor_produto='00013'

--32047554

select * from faturamento_caixas where caixa in ('32047554')

select * from vendas_produto where pedido in ('cx-32047554')
*/
