CREATE VIEW DBO.VW_INVENTARIOS
AS
select distinct nome_contagem from ESTOQUE_PROD_CONTAGEM a
left join faturamento b on a.nome_contagem = b.conferido_por
where a.ESTOQUE_AJUSTADO=1 and b.NF_SAIDA is null
