--[15:08] Ricardo da Costa Guirado
---- Verifica NFs que estão em transito


SELECT (SELECT MAX(DATA_AJUSTE) FROM ESTOQUE_PRODUTOS WHERE FILIAL = L.FILIAL_ORIGEM
) AS DT_AJUSTE_ESTOQUE, L.*

FROM LOJA_ENTRADAS l 

inner join FILIAIS C on c.FILIAL = l.FILIAL AND C.FECHA_CUSTO_MEDIO = 1

WHERE l.EMISSAO BETWEEN '20240201' AND '20240229'

AND l.ENTRADA_CONFERIDA=0 


SELECT FILIAL, MAX(DATA_AJUSTE) DT
FROM ESTOQUE_PRODUTOS 

WHERE FILIAL IN (
'VICENTE DE CARVALHO',      
'RS - PORTO ALEGRE CENTRO', 
'SAO MATHEUS',             
'REJEITADO - CD CAJAMAR',   
'PIRASSUNUNGA',  
'AMOSTRA TIJUCO'          
)
GROUP BY FILIAL

--update loja_entradas set emissao = '20240131' where filial_origem = 'IPIRANGA                 ' and numero_nf_transferencia = '000076661      ';

update loja_entradas set ENTRADA_CONFERIDA = 1 /*emissao = '20240131'*/ where filial_origem = 'IPIRANGA                 ' and numero_nf_transferencia = '000076661      ' and ROMANEIO_PRODUTO = 'A0845336       '

update loja_entradas set ENTRADA_CONFERIDA = 1 /*emissao = '20240103'*/ where filial_origem = 'REJEITADO - CD CAJAMAR   ' and numero_nf_transferencia = '000000169      ' and ROMANEIO_PRODUTO = 'A1229769       '

update loja_entradas set ENTRADA_CONFERIDA = 1 /*emissao = '20240301'*/ where filial_origem = 'ITAPEVI                  ' and numero_nf_transferencia = '000107721      ' and ROMANEIO_PRODUTO = 'A0828537       '

update loja_entradas SET ENTRADA_CONFERIDA = 1 /*set emissao = '20240228'*/ where filial_origem = 'MG - BH CENTRO           ' and numero_nf_transferencia = '000000007      ' and ROMANEIO_PRODUTO = 'A0871545       '

update loja_entradas set ENTRADA_CONFERIDA = 1 /*emissao = '20240228'*/ where filial_origem = 'MG - BH CENTRO           ' and numero_nf_transferencia = '000000005      ' and ROMANEIO_PRODUTO = 'A0830737       '

update loja_entradas set ENTRADA_CONFERIDA = 1 /*emissao = '20240228'*/ where filial_origem = 'MG - BH CENTRO           ' and numero_nf_transferencia = '000000003      ' and ROMANEIO_PRODUTO = 'A0803311       '

update loja_entradas set ENTRADA_CONFERIDA = 1 /*emissao = '20240128' */ where filial_origem = 'CD CAJAMAR               ' and numero_nf_transferencia = '000081858      ' and ROMANEIO_PRODUTO = 'A0114042       '

update loja_entradas set ENTRADA_CONFERIDA = 1 /*emissao = '20240128'*/ where filial_origem = 'CD CAJAMAR               ' and numero_nf_transferencia = '000081852      ' and ROMANEIO_PRODUTO = 'A0178717       '

update loja_entradas set ENTRADA_CONFERIDA = 1 /*emissao = '20240128'*/ where filial_origem = 'CD CAJAMAR               ' and numero_nf_transferencia = '000081847      ' and ROMANEIO_PRODUTO = 'A0138027       '


update loja_entradas set ENTRADA_CONFERIDA = 1 /*emissao = '20240128'*/ where filial_origem = 'CD CAJAMAR               ' and numero_nf_transferencia = '000081856      ' and ROMANEIO_PRODUTO = 'A0181363       '


update loja_entradas set ENTRADA_CONFERIDA = 1 /*emissao = '20240128'*/ where filial_origem = 'CD CAJAMAR               ' and numero_nf_transferencia = '000075880      ' and ROMANEIO_PRODUTO = 'A0844104       '


SELECT MAX(DATA_AJUSTE) FROM ESTOQUE_PRODUTOS WHERE FILIAL = 'CD CAJAMAR'



--SELECT * 
UPDATE A SET ENTRADA_CONFERIDA = 1
FROM LOJA_ENTRADAS A WHERE ROMANEIO_PRODUTO = 'A0204775'  AND FILIAL_ORIGEM = 'AMOSTRA TIJUCO'                
--SELECT * 
UPDATE A SET ENTRADA_CONFERIDA = 1
FROM LOJA_ENTRADAS A WHERE ROMANEIO_PRODUTO = 'A0272420'   AND FILIAL_ORIGEM = 'AMOSTRA TIJUCO'                  
--SELECT * 
UPDATE A SET ENTRADA_CONFERIDA = 1
FROM LOJA_ENTRADAS A WHERE ROMANEIO_PRODUTO = 'A0239349'    AND FILIAL_ORIGEM = 'CD CAJAMAR'                     
--SELECT * 
UPDATE A SET ENTRADA_CONFERIDA = 1
FROM LOJA_ENTRADAS A WHERE ROMANEIO_PRODUTO = 'A0127310'    AND FILIAL_ORIGEM = 'PIRASSUNUNGA'                  
--SELECT * 
UPDATE A SET ENTRADA_CONFERIDA = 1
FROM LOJA_ENTRADAS A WHERE ROMANEIO_PRODUTO = 'A0871168'  AND FILIAL_ORIGEM = 'PIRASSUNUNGA'                    

