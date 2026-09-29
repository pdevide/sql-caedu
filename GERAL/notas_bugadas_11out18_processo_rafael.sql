--select * from (
--select f . nf_saida , f . nome_clifor , fi . item_impressao , fi . filial , f . DATA_HORA_EMISSAO , f . serie_nf,  count ( 3 ) as conta
--FROM FATURAMENTO_ITEM FI WITH ( NOLOCK )
--INNER JOIN faturamento F WITH ( NOLOCK ) ON F . NF_SAIDA = FI . NF_SAIDA AND F . SERIE_NF = FI . SERIE_NF AND F . FILIAL = FI . FILIAL
--where f . DATA_HORA_EMISSAO >= '2018-10-11 10:00:00'
--group by F . NF_SAIDA , f . nome_clifor , fi . item_impressao , fi . filial , f . DATA_HORA_EMISSAO, f . serie_nf
--) t
--where t . conta > 1



select * from (
select f . nf_saida , f . nome_clifor , fi . item_impressao , fi . filial , f . DATA_HORA_EMISSAO , f . serie_nf,  count ( 3 ) as conta
FROM FATURAMENTO_ITEM FI WITH ( NOLOCK )
INNER JOIN faturamento F WITH ( NOLOCK ) ON F . NF_SAIDA = FI . NF_SAIDA AND F . SERIE_NF = FI . SERIE_NF AND F . FILIAL = FI . FILIAL
where f . DATA_HORA_EMISSAO >= '2018-10-11 10:00:00'
group by F . NF_SAIDA , f . nome_clifor , fi . item_impressao , fi . filial , f . DATA_HORA_EMISSAO, f . serie_nf
) t
where t . conta > 1


SELECT (SELECT COUNT(*) FROM entradas_ITEM 
WHERE nf_entrada=e.nf_entrada AND SERIE_NF_entrada=e.SERIE_NF_entrada and NOME_CLIFOR=e.NOME_CLIFOR) AS QT, e.*
FROM entradas e
WHERE /*filial = 'CD BARRA VELHA' AND NOME_CLIFOR='CD NAVEGANTES'*/ FILIAL='CD NAVEGANTES'
and NF_ENTRADA IN (
'000023327', '000023331', '000023326', '000023318', '000023325', '000023328', 
'000023330', '000023321', '000023324', '000023332', '000023314', '000023313', 
'000023323', '000023313', '000023319', '000023322', '000023328', '000023315', 
'000023317', '000023316', '000023329', '000023320'
) 


SELECT * FROM CSM_TRANSITO_NOTAS
WHERE NF_SAIDA IN 
(
'000023327', '000023331', '000023326', '000023318', '000023325', '000023328', 
'000023330', '000023321', '000023324', '000023332', '000023314', '000023313', 
'000023323', '000023313', '000023319', '000023322', '000023328', '000023315', 
'000023317', '000023316', '000023329', '000023320'
)



SELECT * FROM CSM_TRANSITO_NOTAS ORDER BY DATA DESC


select  * from vendas_prod_embalado where produto = '34015940' 