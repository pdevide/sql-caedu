declare @tabprodutos table (ID INT IDENTITY(1,1), PRODUTO VARCHAR(50))

insert into @tabprodutos (PRODUTO) values ('ESPUMA LIMP FACIAL')
insert into @tabprodutos (PRODUTO) values ('ÁGUA MICELAR')
insert into @tabprodutos (PRODUTO) values ('SHAMPOO SECO')
insert into @tabprodutos (PRODUTO) values ('LIXA DE UNHA')
insert into @tabprodutos (PRODUTO) values ('LENÇO LIMP FACIAL')
insert into @tabprodutos (PRODUTO) values ('LENÇO DE PAPEL')
insert into @tabprodutos (PRODUTO) values ('ALGODÃO DISCO')
insert into @tabprodutos (PRODUTO) values ('COTONETE')
insert into @tabprodutos (PRODUTO) values ('PERFUME')
insert into @tabprodutos (PRODUTO) values ('CANETA NUTRI CUTÍCULAS')
insert into @tabprodutos (PRODUTO) values ('HIDRATANTE LABIAL')
insert into @tabprodutos (PRODUTO) values ('MÁSCARA FACIAL')
insert into @tabprodutos (PRODUTO) values ('TOUCA BANHO')
insert into @tabprodutos (PRODUTO) values ('ADESIV REMOVE CRAVOS')

DECLARE @ULTIMO_CODIGO INT, @codigo varchar(6)
SELECT @ULTIMO_CODIGO = CAST(max(codigo) AS INT) from CAEDU_LISTA_COMBO

SELECT @codigo = FORMAT(id + @ULTIMO_CODIGO,'000000')
FROM @tabprodutos a

IF NOT EXISTS(SELECT 1 FROM CAEDU_DOMINIO_COMBOS WHERE COD_DOMINIO = '007')
BEGIN
	INSERT INTO CAEDU_DOMINIO_COMBOS VALUES ('007','PRODUTO','CADASTRO DE PRODUTO PLANEJAMENTO')
END

insert into CAEDU_LISTA_COMBO (codigo,descricao,id_dominio,desc_dominio,ERP_CUPS_DESCRICAO_IMPORTACAO)
select FORMAT(id + @ULTIMO_CODIGO,'000000') as codigo,
a.PRODUTO as descricao,
'007' id_dominio,
'PRODUTO' desc_dominio,
a.PRODUTO as ERP_CUPS_DESCRICAO_IMPORTACAO
from @tabprodutos a

UPDATE SEQUENCIAIS SET SEQUENCIA = @codigo WHERE TABELA_COLUNA = 'CAEDU_LISTA_COMBO.CODIGO'

/* PROVA DOS NOVE
-- RODE PRA VER SE ATUALIZOU CERTINHO --

select max(codigo) from caedu_lista_combo
SELECT * FROM SEQUENCIAIS WHERE TABELA_COLUNA LIKE 'CAEDU_LISTA%'
SELECT CODIGO,descricao as PRODUTO FROM CAEDU_LISTA_COMBO WHERE id_dominio = '007' order by codigo
SELECT * FROM CAEDU_DOMINIO_COMBOS
produtos
*/
