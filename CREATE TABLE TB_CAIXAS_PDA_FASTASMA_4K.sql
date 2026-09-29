CREATE TABLE [CCP\PAULO.DEVIDE].[TB_CAIXAS_PDA_FASTASMA_4K] (
caixa varchar(8) null,
filial varchar(25) null,
pkey varchar(8) null,
caixa1 varchar(8) null,
PRODUTO varchar(8) null,
QUANTIDADE INT null,
lojadestino varchar(25) null,
Distribuicao varchar(8) null,
Tabela varchar(50) null,
Pack varchar(1) null,
Grade varchar(25) null,
Cor_produto varchar(5) null,
qtde int null,
q1 int null,
q2 int null,
q3 int null,
q4 int null,
q5 int null,
q6 int null,
q7 int null,
q8 int null,
q9 int null,
q10 int null,
q11 int null,
q12 int null,
q13 int null,
q14 int null,
q15 int null,
q16 int null)

go

create index IDX_TB_CAIXAS_PDA_FASTASMA_4K 
ON [CCP\PAULO.DEVIDE].[TB_CAIXAS_PDA_FASTASMA_4K] (CAIXA)