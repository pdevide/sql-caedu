--select * from CAEDU_LISTA_COMBO where id_dominio='025'
--select max(codigo) from CAEDU_LISTA_COMBO
declare @tabesqueleto table (rownum INT IDENTITY(1,1), descricao VARCHAR(50), id varchar(3))

insert into @tabesqueleto (descricao,id) values ('0.01 - EMPRESA - TODAS AS LOJAS + ECOMM','49')
insert into @tabesqueleto (descricao,id) values ('0.02 - EMPRESA - LOJAS FISICAS','50')
insert into @tabesqueleto (descricao,id) values ('0.03 - EMPRESA - ALOCACAO NECESSIDADE','51')
insert into @tabesqueleto (descricao,id) values ('0.04 - EMPRESA - VND A','52')
insert into @tabesqueleto (descricao,id) values ('0.05 - EMPRESA - VND A e B','53')
insert into @tabesqueleto (descricao,id) values ('0.06 - EMPRESA - VND A, B e C','54')
insert into @tabesqueleto (descricao,id) values ('0.07 - EMPRESA - VND A, B, C e D','67')
insert into @tabesqueleto (descricao,id) values ('0.08 - EMPRESA - CLIMA QUENTE','68')
insert into @tabesqueleto (descricao,id) values ('0.09 - EMPRESA - CLIMA QUENTE e MODERADO','69')
insert into @tabesqueleto (descricao,id) values ('0.10 - EMPRESA - CLIMA FRIO','70')
insert into @tabesqueleto (descricao,id) values ('0.11 - EMPRESA - CLIMA FRIO e MODERADO','71')
insert into @tabesqueleto (descricao,id) values ('0.12 - EMPRESA - TAM. M² GG e G','89')
insert into @tabesqueleto (descricao,id) values ('0.13 - EMPRESA - TAM. M² GG, G e M','90')
insert into @tabesqueleto (descricao,id) values ('0.14 - EMPRESA - TAM. M² GG, G, M e P','91')
insert into @tabesqueleto (descricao,id) values ('0.15 - EMPRESA - LOJAS DE RUA','72')
insert into @tabesqueleto (descricao,id) values ('0.16 - EMPRESA - LOJAS DE SHOPPING','73')
insert into @tabesqueleto (descricao,id) values ('0.17 - EMPRESA - LOJAS DE SHOPPING FRIAS_MODERADAS','139')
insert into @tabesqueleto (descricao,id) values ('0.18 - EMPRESA - LOJAS QUENTES E LITORAL','75')
insert into @tabesqueleto (descricao,id) values ('1.01 - FEM - INVERNO - VND A','100')
insert into @tabesqueleto (descricao,id) values ('1.02 - FEM - INVERNO - VND A e B','101')
insert into @tabesqueleto (descricao,id) values ('1.03 - FEM - INVERNO - VND A, B e C','102')
insert into @tabesqueleto (descricao,id) values ('1.04 - FEM - INVERNO - VND A, B, C e D','79')
insert into @tabesqueleto (descricao,id) values ('1.05 - FEM - VERAO - VND A','109')
insert into @tabesqueleto (descricao,id) values ('1.06 - FEM - VERAO - VND A e B','110')
insert into @tabesqueleto (descricao,id) values ('1.07 - FEM - VERAO - VND A, B e C','111')
insert into @tabesqueleto (descricao,id) values ('1.08 - FEM - VERAO - VND A, B, C e D','80')
insert into @tabesqueleto (descricao,id) values ('1.09 - FEM - INVERNO - A, B e QUENTE','58')
insert into @tabesqueleto (descricao,id) values ('1.10 - FEM - INVERNO A, B e SHOP','59')
insert into @tabesqueleto (descricao,id) values ('1.11 - FEM - VERAO - A, B e SHOP','60')
insert into @tabesqueleto (descricao,id) values ('1.12 - FEM - MESA ESPORTE','61')
insert into @tabesqueleto (descricao,id) values ('2.01 - INF - INVERNO - VND A','122')
insert into @tabesqueleto (descricao,id) values ('2.02 - INF - INVERNO - VND A e B','123')
insert into @tabesqueleto (descricao,id) values ('2.03 - INF - INVERNO - VND A, B e C','114')
insert into @tabesqueleto (descricao,id) values ('2.04 - INF - INVERNO - VND A, B, C e D','81')
insert into @tabesqueleto (descricao,id) values ('2.05 - INF - VERAO - VND A','124')
insert into @tabesqueleto (descricao,id) values ('2.06 - INF - VERAO - VND A e B','125')
insert into @tabesqueleto (descricao,id) values ('2.07 - INF - VERAO - VND A, B e C','126')
insert into @tabesqueleto (descricao,id) values ('2.08 - INF - VERAO - VND A, B, C e D','82')
insert into @tabesqueleto (descricao,id) values ('2.09 - INF - LOJAS BB','55')
insert into @tabesqueleto (descricao,id) values ('2.10 - INF - LOJAS MESA GRANDE 1/3','56')
insert into @tabesqueleto (descricao,id) values ('2.11 - INF - LOJAS DISNEY + TOP30','57')
insert into @tabesqueleto (descricao,id) values ('3.01 - MASC - INVERNO - VND A','129')
insert into @tabesqueleto (descricao,id) values ('3.02 - MASC - INVERNO - VND A e B','130')
insert into @tabesqueleto (descricao,id) values ('3.03 - MASC - INVERNO - VND A, B e C','127')
insert into @tabesqueleto (descricao,id) values ('3.04 - MASC - INVERNO - VND A, B, C e D','83')
insert into @tabesqueleto (descricao,id) values ('3.05 - MASC - VERAO - VND A','131')
insert into @tabesqueleto (descricao,id) values ('3.06 - MASC - VERAO - VND A e B','132')
insert into @tabesqueleto (descricao,id) values ('3.07 - MASC - VERAO - VND A, B e C','128')
insert into @tabesqueleto (descricao,id) values ('3.08 - MASC - VERAO - VND A, B, C e D','84')
insert into @tabesqueleto (descricao,id) values ('3.09 - MASC - LOJAS MESA 4','76')
insert into @tabesqueleto (descricao,id) values ('3.10 - MASC - INVERNO - LOJAS TOP (RUA + SHOP)','77')
insert into @tabesqueleto (descricao,id) values ('3.11 - MASC - VERAO - LOJAS TOP (RUA + SHOP)','78')
insert into @tabesqueleto (descricao,id) values ('4.01 - JEANS - INVERNO - VND A','106')
insert into @tabesqueleto (descricao,id) values ('4.02 - JEANS - INVERNO - VND A e B','107')
insert into @tabesqueleto (descricao,id) values ('4.03 - JEANS - INVERNO - VND A, B e C','108')
insert into @tabesqueleto (descricao,id) values ('4.04 - JEANS - INVERNO - VND A, B, C e D','86')
insert into @tabesqueleto (descricao,id) values ('4.05 - JEANS - VERAO - VND A','103')
insert into @tabesqueleto (descricao,id) values ('4.06 - JEANS - VERAO - VND A e B','104')
insert into @tabesqueleto (descricao,id) values ('4.07 - JEANS - VERAO - VND A, B e C','105')
insert into @tabesqueleto (descricao,id) values ('4.08 - JEANS - VERAO - VND A, B, C e D','85')
insert into @tabesqueleto (descricao,id) values ('5.01 - INTIMA e PRAIA - INVERNO - VND A','133')
insert into @tabesqueleto (descricao,id) values ('5.02 - INTIMA e PRAIA - INVERNO - VND A e B','134')
insert into @tabesqueleto (descricao,id) values ('5.03 - INTIMA e PRAIA - INVERNO - VND A, B e C','112')
insert into @tabesqueleto (descricao,id) values ('5.04 - INTIMA e PRAIA - INVERNO - VND A, B, C e D','87')
insert into @tabesqueleto (descricao,id) values ('5.05 - INTIMA e PRAIA - VERAO - VND A','135')
insert into @tabesqueleto (descricao,id) values ('5.06 - INTIMA e PRAIA- VERAO - VND A e B','136')
insert into @tabesqueleto (descricao,id) values ('5.07 - INTIMA e PRAIA - VERAO - VND A, B e C','137')
insert into @tabesqueleto (descricao,id) values ('5.08 - INTIMA e PRAIA - VERAO - VND A, B, C e D','88')
insert into @tabesqueleto (descricao,id) values ('5.09 - INTIMA e PRAIA - EQUIP. DEMILLUS','66')
insert into @tabesqueleto (descricao,id) values ('6.01 - ACESS - INVERNO - VND A','117')
insert into @tabesqueleto (descricao,id) values ('6.02 - ACESS - INVERNO - VND A e B','115')
insert into @tabesqueleto (descricao,id) values ('6.03 - ACESS - INVERNO - VND A, B e C','113')
insert into @tabesqueleto (descricao,id) values ('6.04 - ACESS - INVERNO - VND A, B, C e D','116')
insert into @tabesqueleto (descricao,id) values ('6.05 - ACESS - VERAO - VND A','118')
insert into @tabesqueleto (descricao,id) values ('6.06 - ACESS - VERAO - VND A e B','119')
insert into @tabesqueleto (descricao,id) values ('6.07 - ACESS - VERAO - VND A, B e C','120')
insert into @tabesqueleto (descricao,id) values ('6.08 - ACESS - VERAO - VND A, B, C e D','121')
insert into @tabesqueleto (descricao,id) values ('6.09 - ACESS - LOJAS EQUIP. PUMA','63')
insert into @tabesqueleto (descricao,id) values ('6.10 - ACESS - EQUIP. BASKET GRANDE','62')
insert into @tabesqueleto (descricao,id) values ('6.11 - ACESS - LOJAS TOP VND BASKET','64')
insert into @tabesqueleto (descricao,id) values ('6.12 - ACESS - LOJAS TOP VND MEIA LICENCIADA','65')
insert into @tabesqueleto (descricao,id) values ('7.01 - CALC - INVERNO - VND A','92')
insert into @tabesqueleto (descricao,id) values ('7.02 - CALC - INVERNO - VND A e B','93')
insert into @tabesqueleto (descricao,id) values ('7.03 - CALC - INVERNO - VND A, B e C','94')
insert into @tabesqueleto (descricao,id) values ('7.04 - CALC - INVERNO - VND A, B, C e D','95')
insert into @tabesqueleto (descricao,id) values ('7.05 - CALC - VERAO - VND A','96')
insert into @tabesqueleto (descricao,id) values ('7.06 - CALC - VERAO - VND A e B','97')
insert into @tabesqueleto (descricao,id) values ('7.07 - CALC - VERAO - VND A, B e C','98')
insert into @tabesqueleto (descricao,id) values ('7.08 - CALC - VERAO - VND A, B, C e D','99')




DECLARE @ULTIMO_CODIGO INT, @codigo varchar(6)
SELECT @ULTIMO_CODIGO = CAST(max(codigo) AS INT) from CAEDU_LISTA_COMBO

SELECT @codigo = FORMAT(rownum + @ULTIMO_CODIGO,'000000')
FROM @tabesqueleto a

--IF NOT EXISTS(SELECT 1 FROM CAEDU_DOMINIO_COMBOS WHERE COD_DOMINIO = '026')
--BEGIN
--	INSERT INTO CAEDU_DOMINIO_COMBOS VALUES ('026','ESQUELETO','CADASTRO DE ESQUELETO PLANEJAMENTO')
--END

insert into CAEDU_LISTA_COMBO (codigo,descricao,id_dominio,desc_dominio,ERP_CUPS_DESCRICAO_IMPORTACAO)
select FORMAT(rownum + @ULTIMO_CODIGO,'000000') as codigo,
a.descricao as descricao,
'025' id_dominio,
'CLUSTER UNOUS' desc_dominio,
a.id as ERP_CUPS_DESCRICAO_IMPORTACAO
from @tabesqueleto a

UPDATE SEQUENCIAIS SET SEQUENCIA = @codigo WHERE TABELA_COLUNA = 'CAEDU_LISTA_COMBO.CODIGO'

/* PROVA DOS NOVE
-- RODE PRA VER SE ATUALIZOU CERTINHO --
SELECT * FROM SEQUENCIAIS WHERE TABELA_COLUNA LIKE 'CAEDU_LISTA%'
SELECT * FROM CAEDU_LISTA_COMBO WHERE id_dominio = '026'

delete from caedu_lista_combo
where codigo in (
 '001401'
,'001402'
,'001403'
,'001404'
,'001405'
,'001406'
,'001407'
,'001408'
,'001409'
,'001410'
,'001411'
,'001412'
,'001413'
,'001414'
,'001418')
*/