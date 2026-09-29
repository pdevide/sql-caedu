/*
select * 
from PDA_WMS_TB_EMBARQUE a
left join vendas_prod_embalado b on b.caixa=a.caixa
where a.FATURADO=0 
--AND DOCA LIKE '%guaru%'
and b.caixa is null

select * 
from PDA_WMS_TB_EMBARQUE a
where a.FATURADO=1 and a.caixa like '%87' and data>='20250829'
and not exists (select 1 from faturamento_prod where caixa = a.caixa) 
and not exists (select 1 from vendas_prod_embalado where caixa = a.caixa) 

*/

select *
--update a set q1=b.q1,q2=b.q2,q3=b.q3,q4=b.q4,q5=b.q5,q6=b.q6,q7=b.q7,q8=b.q8,
--q9=b.q9,q10=b.q10,q11=b.q11,q12=b.q12,q13=b.q13,q14=b.q14,q15=b.q15,q16=b.q16,
--qtde_total=b.QTDE, qtde_pack=1
from caedu_reserva_automatica a
--inner join produtos_packs_permitidos b on b.produto=a.produto and b.pack='B'
where pedido = '357685'  

select * from produtos_packs_permitidos where produto = '64022105'    

select c.caixa, gerado, *
from CAEDU_RESERVA_AUTOMATICA c
where c.caixa in (select a.caixa 
from PDA_WMS_TB_EMBARQUE a
left join vendas_prod_embalado b on b.caixa=a.caixa
where a.FATURADO=0 and b.caixa is null
)

--('32963882'
--,'32963883'
--,'32963884'
--,'32963891'
--,'32963892'
--,'32963893'
--,'32991885'
--,'32992549'
--,'33027334'
--,'33027335'
--,'33027340'
--,'33027341')

select a.*, b.filial from dbo.CGP_TRANSF_CAIXA_FILIAL a
inner join filiais b on b.cod_filial = a.filial_para
where caixa in
(select emb.caixa 
from PDA_WMS_TB_EMBARQUE emb
left join vendas_prod_embalado box on box.caixa=emb.caixa
where emb.FATURADO=0 and box.caixa is null
)

select * 
--update a set aprovacao='A'
--	CLIENTE_ATACADO='GO SH APARECIDA', 
--	REPRESENTANTE='GO SH APARECIDA', 
--	GERENTE='GO SH APARECIDA', 
--	APROVACAO='A', 
--	FILIAL_DIGITACAO='CD - SP - SAO ROQUE', 
--	NOME_CLIFOR_ENTREGA='GO SH APARECIDA'                                                        
from VENDAS a
where pedido in ('cx-32991852')
--where pedido in ('cx-29812325')


select * from VENDAS_PRODUTO
where pedido in ('cx-32991852')

select * from VENDAS_PROD_EMBALADO
where pedido in ('cx-32991852')

select * from FATURAMENTO_CAIXAS
where caixa in
('32991852')


select * 
from PDA_WMS_TB_EMBARQUE a
left join vendas_prod_embalado b on b.caixa=a.caixa
where a.FATURADO=0 and b.caixa is null
ORDER BY DOCA


SELECT * 
FROM CGP_LOG_DISTRIBUICOES_EXCLUIDAS A 
INNER JOIN CGP_LOG_DISTRIBUICOES_EXCLUIDAS_ITENS B ON B.ID=A.ID
WHERE B.CAIXA IN ('32089393')
(select emb.caixa 
from PDA_WMS_TB_EMBARQUE emb
left join vendas_prod_embalado box on box.caixa=emb.caixa
where emb.FATURADO=0 and box.caixa is null
)




select *
from VENDAS a
inner join FATURAMENTO_CAIXAS b on b.caixa = substring(pedido,4,8) 
inner join vendas_produto c on c.pedido=a.pedido
inner join vendas_prod_embalado d on d.pedido=a.pedido
where a.pedido in 
('cx-32963849',
'cx-32963850',
'cx-32963851',
'cx-32963882',
'cx-32963883',
'cx-32963884',
'cx-32963891',
'cx-32963892',
'cx-32963893'
)


select *
from faturamento_caixas 
where 
CAIXA IN 
('30252705',
'30252739',
'30199480')


select * from produtos_precos  where produto = 'C1300388'

select * from filiais where filial in 
('OSASCO CENTRO','SP - SAPOPEMBA','VILA FORMOSA')             




SELECT * 
FROM CGP_LOG_DISTRIBUICOES_EXCLUIDAS A 
INNER JOIN CGP_LOG_DISTRIBUICOES_EXCLUIDAS_ITENS B ON B.ID=A.ID
inner join VENDAS_PROD_EMBALADO C on c.caixa=b.CAIXA
WHERE a.id=810
and not exists (select 1 from faturamento_prod where caixa = b.caixa)


select a.*, b.filial from dbo.CGP_TRANSF_CAIXA_FILIAL a
inner join filiais b on b.cod_filial = a.filial_para
where caixa in (
'29873268'       
,'32691969'       
,'30104440'       
,'30104441'       
,'29775806'       
,'29873922'       
,'29873932'       
,'30114008'       
,'29874476'       
,'30168679'       
,'29873931')

select * from faturamento_caixas b where b.caixa = '30168671'--'31889426'

SELECT ve.* 
FROM VENDAS V
LEFT JOIN VENDAS_PRODUTO VP ON VP.PEDIDO=V.PEDIDO
LEFT JOIN VENDAS_PROD_EMBALADO VE ON VE.PEDIDO=V.PEDIDO
LEFT JOIN FATURAMENTO_CAIXAS FC ON FC.CAIXA = VE.CAIXA
where V.PEDIDO in ('CX-29563690','CX-30019555','CX-30104448','CX-30168671')

insert into faturamento_caixas 
values 
('29563690',1,'SP - SANTO AMARO',80,'20251002','automatico',12,1,'01',null,null,null,0,null,null,null,'SP - SANTO AMARO',null,null,null,null,getdate(),null,null,null),
('30019555',1,'SAO MATHEUS',80,'20251002','automatico',12,1,'01',null,null,null,0,null,null,null,'SAO MATHEUS',null,null,null,null,getdate(),null,null,null),
('30104448',1,'SAO MATHEUS',80,'20251002','automatico',12,1,'01',null,null,null,0,null,null,null,'SAO MATHEUS',null,null,null,null,getdate(),null,null,null),
('30168671',1,'SAO MATHEUS',80,'20251002','automatico',12,1,'01',null,null,null,0,null,null,null,'SAO MATHEUS',null,null,null,null,getdate(),null,null,null)

select * 
from PDA_WMS_TB_EMBARQUE a
--left join vendas_prod_embalado b on b.caixa=a.caixa
where a.FATURADO=0 and data>='20250901'
and exists (select 1 from vendas where pedido = 'CX-'+a.caixa and APROVACAO='R')

select a.doca,v.*
--'('+char(39)+FC.caixa+char(39)+','+char(39)+v.pedido+char(39)+')'
--update V set APROVACAO='A',
--	CLIENTE_ATACADO='MAUA', 
--	REPRESENTANTE='MAUA', 
--	GERENTE='MAUA', 
--	FILIAL_DIGITACAO='CD - SP - SAO ROQUE', 
--	NOME_CLIFOR_ENTREGA='MAUA'                                                        

from faturamento_caixas fc 
inner join PDA_WMS_TB_EMBARQUE a on a.CAIXA=fc.CAIXA
inner join vendas v on v.pedido='CX-'+fc.caixa
inner join vendas_produto vp on vp.pedido='CX-'+fc.caixa
left join VENDAS_PROD_EMBALADO ve on ve.pedido='CX-'+fc.caixa
where fc.caixa in ('30050433') 
--where fc.caixa in ('29960676','30050433')




--'32963804','32963805','32963806',
--					'32963831','32963832','32963833','32991843')       

--SP SH JARDIM ORIENTE


select * from filiais where filial like '%brasilandia'


select e.doca, e.data, e.caixa, vp.*
--v.CLIENTE_ATACADO, v.GERENTE,
--v.NOME_CLIFOR_ENTREGA, v.REPRESENTANTE ,a.NOME_CLIFOR, v.APROVACAO, v.TOT_QTDE_EMBALADA, v.TOT_QTDE_ENTREGAR
--'('+char(39)+a.caixa+char(39)+','+char(39)+v.pedido+char(39)+'),' --E.*
--UPDATE E SET CODIGO_FILIAL='000217'
--'('+char(39)+a.caixa+char(39)+','+char(39)+v.pedido+char(39)+'),' 
--update v set APROVACAO='A'
from faturamento_caixas a
inner join vendas v on v.pedido = 'CX-'+a.caixa
inner join vendas_produto vp on vp.pedido = 'CX-'+a.caixa
inner join VENDAS_PROD_EMBALADO ve on ve.pedido = 'CX-'+a.caixa
inner join PDA_WMS_TB_EMBARQUE e ON E.CAIXA=A.CAIXA
where faturado=0 and data>'20250903'  --and a.caixa = '31057473'       
order by doca, caixa

select * from PDA_WMS_TB_EMBARQUE where faturado=0
order by doca, caixa
--a.caixa in 
--('29889689','32991862','32991863')


SELECT * FROM FILIAIS WHERE FILIAL = 'MG SH BIG CONTAGEM'



select B.PEDIDO, B.NOME_CLIFOR, f.COD_FILIAL, a.* 
--update a set CODIGO_FILIAL=f.COD_FILIAL, doca=rtrim(B.NOME_CLIFOR)+' PACK'
from PDA_WMS_TB_EMBARQUE a
left join vendas_prod_embalado b on b.caixa=a.caixa
left join filiais f on f.filial=b.NOME_CLIFOR
where a.FATURADO=0 
AND DOCA LIKE 'POS%'

---================================================================================================================----
select e.doca,v.CLIENTE_ATACADO, v.filial, ve.filial, v.* 
--update v set filial='CD - SP - SAO ROQUE', FILIAL_DIGITACAO='CD - SP - SAO ROQUE', APROVACAO='A'
--update V set APROVACAO='A',
--	CLIENTE_ATACADO='MAUA', 
--	REPRESENTANTE='MAUA', 
--	GERENTE='MAUA', 
--	FILIAL_DIGITACAO='CD - SP - SAO ROQUE', 
--	NOME_CLIFOR_ENTREGA='MAUA'
--UPDATE FC SET NOME_CLIFOR='MAUA',NOME_CLIFOR_ENTREGA='MAUA'
--UPDATE VE SET NOME_CLIFOR='MAUA'
--'('+char(39)+rtrim(e.caixa)+char(39)+','+char(39)+rtrim(v.pedido)+char(39)+'),' --E.*
--update ve set FILIAL='CD - SP - SAO ROQUE'
--update e set doca = rtrim(cliente_atacado)+' CAIXA', CODIGO_FILIAL='000018'
from pda_wms_tb_embarque e
--inner join VENDAS_PROD_EMBALADO ve on ve.caixa=e.caixa
inner join vendas v on v.pedido='CX-'+e.caixa
INNER JOIN FATURAMENTO_CAIXAS FC ON FC.CAIXA=E.CAIXA
INNER JOIN VENDAS_PROD_EMBALADO VE ON VE.CAIXA=E.CAIXA
where e.FATURADO=0 
--and REPLACE(replace(doca,'PACK',''),'CAIXA','')<>CLIENTE_ATACADO
--and right(doca,5)='CAIXA'
--and e.caixa in ('32215725','32215726','32991886')
--AND DOCA LIKE 'MAUA%' --and CLIENTE_ATACADO<>'MAUA'
and (Ve.filial<>'CD - SP - SAO ROQUE' or V.filial<>'CD - SP - SAO ROQUE')


--select f.cod_filial,b.* from VENDAS_PROD_EMBALADO a
--inner join faturamento_caixas b on b.caixa=a.caixa
--inner join filiais f on f.filial=a.NOME_CLIFOR
--where pedido in ('CX-30179046','CX-31104984','CX-32760913')

select DOCA,VE.* 
--update V set APROVACAO='A',
--	CLIENTE_ATACADO='TAUBATE', 
--	REPRESENTANTE='TAUBATE', 
--	GERENTE='TAUBATE', 
--	FILIAL_DIGITACAO='CD - SP - SAO ROQUE', 
--	NOME_CLIFOR_ENTREGA='TAUBATE'
--UPDATE FC SET NOME_CLIFOR='TAUBATE', NOME_CLIFOR_ENTREGA='TAUBATE'
--UPDATE VE SET NOME_CLIFOR='TAUBATE', REPRESENTANTE='TAUBATE'
--UPDATE VE SET FILIAL='CD - SP - SAO ROQUE'
--UPDATE V SET FILIAL='CD - SP - SAO ROQUE', FILIAL_DIGITACAO='CD - SP - SAO ROQUE', APROVACAO='A'
from PDA_WMS_TB_EMBARQUE a
INNER JOIN VENDAS V ON V.PEDIDO='CX-'+A.CAIXA
INNER JOIN FATURAMENTO_CAIXAS FC ON FC.CAIXA=A.CAIXA
INNER JOIN VENDAS_PROD_EMBALADO VE ON VE.CAIXA=A.CAIXA
where faturado=0 
--and A.CAIXA = '30125418'
and doca like 'TAUBATE CAIXA%'
--AND CLIENTE_ATACADO<>'TAUBATE'
--AND FC.NOME_CLIFOR<>'TAUBATE'
AND VE.NOME_CLIFOR<>'TAUBATE'



select REPLACE(REPLACE(doca,'PACK',''),'CAIXA','') as filial, * 
from PDA_WMS_TB_EMBARQUE a
where a.FATURADO=0 


select a.caixa, a.DOCA, v.filial, v.FILIAL_DIGITACAO,  v.CLIENTE_ATACADO,fc.NOME_CLIFOR, ve.NOME_CLIFOR, ve.FILIAL
,'('+char(39)+RTRIM(a.caixa)+char(39)+','+char(39)+rtrim(v.pedido)+char(39)+'),',VP.PEDIDO
--update v set APROVACAO='A', FILIAL='CD - SP - SAO ROQUE', FILIAL_DIGITACAO='CD - SP - SAO ROQUE'
--update ve set FILIAL='CD - SP - SAO ROQUE'
--UPDATE V SET APROVACAO='A', CLIENTE_ATACADO='SAO MATHEUS', 
--REPRESENTANTE='SAO MATHEUS', NOME_CLIFOR_ENTREGA='SAO MATHEUS', GERENTE='SAO MATHEUS'
--UPDATE VE SET NOME_CLIFOR='SAO MATHEUS',REPRESENTANTE='SAO MATHEUS'
--update fc SET NOME_CLIFOR='SAO MATHEUS', NOME_CLIFOR_ENTREGA='SAO MATHEUS'
--update a set FATURADO=0
from PDA_WMS_TB_EMBARQUE a
left join vendas v on v.pedido='CX-'+a.caixa
LEFT JOIN VENDAS_PRODUTO VP ON VP.PEDIDO='CX-'+a.caixa
left join VENDAS_PROD_EMBALADO ve on ve.caixa=a.caixa
left join faturamento_caixas fc on fc.caixa=a.CAIXA
where 1=1 and a.FATURADO=0 
--and a.caixa in ('30019555')
and a.caixa in ('29873268','32691969','30104440','30104441','29775806','29873922'
,'29873932','30114008','29874476','30168679','29873931')
--and a.doca like '%aric%' 
--and (v.filial  <> 'CD - SP - SAO ROQUE' or ve.FILIAL <> 'CD - SP - SAO ROQUE')
--and v.CLIENTE_ATACADO <> REPLACE(REPLACE(doca,'PACK',''),'CAIXA','')
--AND VE.NOME_CLIFOR <> REPLACE(REPLACE(doca,'PACK',''),'CAIXA','')
--and fc.NOME_CLIFOR  <> REPLACE(REPLACE(doca,'PACK',''),'CAIXA','')



	

select *
--UPDATE A SET FATURADO=1
from PDA_WMS_TB_EMBARQUE a
LEFT JOIN FATURAMENTO_PROD B ON B.CAIXA=A.CAIXA
where FATURADO=0
AND a.doca like 'RS - PORTO ALEGRE CENTRO PACK'
AND B.CAIXA IS NOT NULL

select b.aprovacao, e.NOME_CLIFOR, b.pedido, b.CLIENTE_ATACADO, b.GERENTE, b.REPRESENTANTE, e.REPRESENTANTE, d.NOME_CLIFOR, d.NOME_CLIFOR_ENTREGA,
 b.FILIAL, b.FILIAL_DIGITACAO, '('+char(39)+a.caixa+char(39)+','+char(39)+rtrim(b.pedido)+char(39)+'),'
--update b set filial='CD - SP - SAO ROQUE', FILIAL_DIGITACAO='CD - SP - SAO ROQUE'
--update b set APROVACAO='A'
from caedu_reserva_automatica a
inner join vendas b on b.pedido=a.venda
inner join VENDAS_PRODUTO c on c.pedido=b.PEDIDO
inner join FATURAMENTO_CAIXAS d on d.caixa=a.caixa
inner join VENDAS_PROD_EMBALADO e on e.caixa=a.caixa
where a.pedido='344925'


select * from filiais A where A.filial like '%BER%' 
AND EXISTS (SELECT 1 FROM ESTOQUE_PRODUTOS WHERE FILIAL=A.FILIAL)



--Item Já Informado !


select b.produto, b.COR_PRODUTO, count(b.cor_produto) as qt_cor, count(b.produto) as qt_produto, count(*) as qty
from PDA_WMS_TB_EMBARQUE a 
inner join VENDAS_PROD_EMBALADO b on b.caixa=a.caixa
inner join PRODUTO_CORES c on c.PRODUTO=b.PRODUTO and c.COR_PRODUTO=b.COR_PRODUTO
where FATURADO=0
and doca like 'SAO MATHEUS CAIXA'
group by b.produto, b.COR_PRODUTO
order by PRODUTO

select * from CGP_LOG_DISTRIBUICOES_EXCLUIDAS where id=1053

select doca, codigo_filial,a.* 
from CGP_LOG_DISTRIBUICOES_EXCLUIDAS_ITENS a
inner join PDA_WMS_TB_EMBARQUE b on b.caixa=a.caixa
where 1=1 --and id=1053
and a.caixa in ('33587392') 

select *
from CGP_LOG_DISTRIBUICOES_EXCLUIDAS_ITENS a
left join faturamento_prod b on b.caixa=a.caixa
where 1=1 and id=1053
and b.caixa is null

select * 
from VENDAS
where --PEDIDO in  ('CX-33565497','CX-33565495','CX-33565494','CX-33565496') 
PEDIDO IN ('CX-31331346','CX-32117078') 

SELECT * FROM CAEDU_RESERVA_AUTOMATICA
WHERE CAIXA IN  ('33587392') 



select doca,count(a.caixa) as caixas_pda, count(b.caixa) as caixas_linx
from PDA_WMS_TB_EMBARQUE a
left join VENDAS_PROD_EMBALADO b on b.CAIXA =a.CAIXA
where faturado=0 
group by doca
--having count(a.caixa) <> count(b.caixa)




select FC.* 
--UPDATE FC SET NOME_CLIFOR='SAO MATHEUS', NOME_CLIFOR_ENTREGA='SAO MATHEUS'
from PDA_WMS_TB_EMBARQUE a
inner join VENDAS_PROD_EMBALADO B ON B.CAIXA=A.CAIXA
INNER JOIN FATURAMENTO_CAIXAS FC ON FC.CAIXA=A.CAIXA
WHERE A.FATURADO=0
AND A.DOCA LIKE 'SAO MATHEUS%' AND B.PRODUTO= '23030868'



select b.pedido,gerado,* 
from caedu_reserva_automatica a
left join VENDAS_PROD_EMBALADO b on b.pedido=a.venda
where a.pedido='361162' and b.pedido is not null

select b.CAIXA,gerado,* 
from caedu_reserva_automatica a
left join FATURAMENTO_CAIXAS b on b.CAIXA=a.CAIXA
where a.pedido='361162' and b.CAIXA is not null


select * 
from vendas a
inner join VENDAS_PROD_EMBALADO b on b.pedido=a.pedido
where a.pedido in ('CX-33590231','CX-33590232')

--DELETE FROM CAEDU_RESERVA_AUTOMATICA WHERE VENDA IN  ('CX-33590231','CX-33590232')



select a.doca, a.caixa, v.* 
--update v set FILIAL='CD - SP - SAO ROQUE',FILIAL_DIGITACAO='CD - SP - SAO ROQUE',APROVACAO='A', NOME_CLIFOR_ENTREGA='SP - ARICANDUVA',CLIENTE_ATACADO='SP - ARICANDUVA'          
--update b set NOME_CLIFOR='SP - ARICANDUVA',REPRESENTANTE='SP - ARICANDUVA'
--update c set NOME_CLIFOR='SP - ARICANDUVA', NOME_CLIFOR_ENTREGA='SP - ARICANDUVA'                    
from PDA_WMS_TB_EMBARQUE a
left join VENDAS_PROD_EMBALADO b on b.caixa=a.caixa
left join FATURAMENTO_CAIXAS c on c.caixa=a.caixa
left join vendas v on v.pedido = 'CX-'+a.CAIXA
where doca = 'SP - ARICANDUVA PACK'
and faturado = 0 AND V.FILIAL='CD CAJAMAR'




SELECT V.APROVACAO, V.FILIAL, V.FILIAL_DIGITACAO, V.CLIENTE_ATACADO, V.REPRESENTANTE,FC.NOME_CLIFOR,FC.NOME_CLIFOR_ENTREGA ,
V.TOT_QTDE_ENTREGAR, V.TOT_QTDE_EMBALADA,A.* 
from PDA_WMS_TB_EMBARQUE a
INNER JOIN VENDAS V ON V.PEDIDO='CX-'+A.CAIXA
INNER JOIN FATURAMENTO_CAIXAS FC ON FC.CAIXA=A.CAIXA
WHERE doca = 'SP - ARICANDUVA PACK' 
AND FATURADO=0

SELECT * FROM VENDAS WHERE PEDIDO = 'CX-33528208'


SELECT * FROM VENDAS_PRODUTO WHERE PEDIDO = 'CX-33528208'

SELECT * FROM VENDAS_PROD_EMBALADO WHERE PEDIDO = 'CX-33528208'

SELECT * FROM FATURAMENTO_CAIXAS WHERE CAIXA = '33528208'


SELECT * 
UPDATE A SET FATURADO=1
FROM PDA_WMS_TB_EMBARQUE A WHERE CAIXA = '33528208'







SELECT * FROM FILIAIS WHERE FILIAL LIKE 'SP - ARICANDUVA'



