select *
from caedu_reserva_automatica where caixa in ('34861824')       

select a.caixa
--gerado, b.pedido, a.caixa, * 
from caedu_reserva_automatica a
left join vendas_prod_embalado b on b.caixa=a.caixa
left join faturamento_prod fp on fp.caixa = a.caixa
where a.pedido in ('367744') 
and b.pedido is null and fp.nf_saida is null


select gerado,data,*
--update a set data='20260211'
from caedu_reserva_automatica a
where pedido = '357810E'


UPDATE dbo.produtos SET Griffe = 'JEANS', Linha = 'FEMININO', Subgrupo_produto = 'TOP JEANS JAQUETA FPM' WHERE produto = '51010272';
UPDATE dbo.produtos SET Griffe = 'JEANS', Linha = 'FEMININO', Subgrupo_produto = 'TOP JEANS JAQUETA FPM' WHERE produto = '51012286';
UPDATE dbo.produtos SET Griffe = 'JEANS', Linha = 'FEMININO', Subgrupo_produto = 'TOP JEANS JAQUETA FPM' WHERE produto = '51012330';


select *
from produtos_subgrupo where subgrupo_produto = 'TOP JEANS JAQUETA FPM'


SELECT * FROM PRODUTOS WHERE PRODUTO IN ('51010272','51012286','51012330')

with base (caixa, doca, pedido, distribuicao)
as 
(
select a.caixa, a.doca, b.pedido, c.distribuicao
from pda_wms_tb_embarque a
left join caedu_reserva_automatica b on b.caixa = a.caixa
left join caedu_reserva_automatica_pack_wms c on c.caixa = a.caixa
where a.faturado=0)

select pedido,count(*) 
from base
group by pedido
order by pedido


select b.* 
--update b set faturado = 1
from faturamento_prod a 
inner join pda_wms_tb_embarque b on b.caixa = a.caixa
where a.caixa in 
('36389037',
'36389038')


select * from pda_wms_tb_embarque 
where caixa in
('36389037',
'36389038')


select *  
from caedu_reserva_automatica_pack_wms where caixa in
('37150801'       
,'37150802'       
,'37150803'       
,'37150804'       
,'37150811'       
,'37150812'       
,'37150813'       
,'37150814'       
,'37150815'       
,'37150823'       
,'37150824'       
,'37150825'       
,'37150826'       
,'37150827'       
,'37150828'       
,'37150829'       
,'37150838'       
,'37150839'       
,'37150840'       
,'37150892'       
,'37150893'       
,'37150894'       
,'37150895'       
,'37151237'       
,'37151238'       
,'37151239'       
,'37151248'       
,'37151249'       
,'37151250'       
,'37151251'       
,'37151252'       
,'37151260'       
,'37151261'       
,'37151262'       
,'37151263'       
,'37151264'       
,'37151265'       
,'37151266'       
,'37151267'       
,'37151277'       
,'37151278'       
,'37151279'       
,'37164884'       
,'37164885'       
,'37194451'       
,'37199461')       

select * from faturamento_prod where caixa in
('36348896',
'36348897',
'36615287',
'36627702',
'36627703',
'36653547',
'36755755',
'36756942')


SELECT
    name,
    is_disabled,
    default_database_name
FROM sys.sql_logins
WHERE name = 'PRINTBAR_USER';


SELECT
    r.session_id,
    r.blocking_session_id,
    r.status,
    r.command,
    r.wait_type,
    r.wait_time,
    r.wait_resource,
    DB_NAME(r.database_id) AS banco,
    t.text AS comando
FROM sys.dm_exec_requests r
OUTER APPLY sys.dm_exec_sql_text(r.sql_handle) t
WHERE r.database_id = DB_ID('CAEDU');


