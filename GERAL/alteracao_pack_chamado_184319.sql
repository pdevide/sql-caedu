/*
Chamado CAP # 184319
====================
Bom dia,

O Pedido 184575 Cod. do produto 62060034, foi cadastrado como TAMANHO UNICO, 
porem esta incorreto, preciso que altere para o TAM 41 ao 44 por favor.


Att,

Jéssica Souza
*/

select produto, pedido from compras_produto where pedido ='184575'
/*
produto      pedido
------------ --------
62060034     184575  

(1 row(s) affected)
*/

select ROMANEIO_PRODUTO, PRODUTO, FILIAL, COR_PRODUTO, QTDE from estoque_prod1_ent where produto ='62060034'
/*
ROMANEIO_PRODUTO PRODUTO      FILIAL                    COR_PRODUTO QTDE
---------------- ------------ ------------------------- ----------- -----------

(0 row(s) affected)
Portanto nao deu entrada no estoque ainda --> alteração permitida
*/

SELECT grade,erp_qtd_pack, PRODUTO, DESC_PRODUTO /*,GRUPO_PRODUTO, SUBGRUPO_PRODUTO, LINHA, GRIFFE*/
from produtos where produto = '62060034'
/*
 Estava assim, grade UNICO, e ela quer que mude para 41 AO 44
 grade                     erp_qtd_pack PRODUTO      DESC_PRODUTO
------------------------- ------------ ------------ ----------------------------------------
UNICO                     12           62060034     KIT 3X1 LUPO MASC 03223-089    

*/

SELECT GRADE, TAMANHO_1, TAMANHO_2, TAMANHO_3 /*, ...*/
FROM PRODUTOS_TAMANHOS WHERE GRADE LIKE '%41%'

/*
GRADE                     TAMANHO_1 TAMANHO_2 TAMANHO_3
------------------------- --------- --------- ---------
33/34 AO 40/41            33/34     35        36
====>41 AO 44                  41 AO 44             (selecionar este)
FEM 33/34 AO 41/42        33/34     35/36     37/38

(3 row(s) affected)
*/

update produtos set grade = '41 AO 44' where produto = '62060034'
/*
Não precisa mexer na tabela produtos_packs_permitidos neste caso, pois as grades antiga e nova ambas tem uma unica posição
e o Linx não grava o Label da grade nesta tabela
*/

-- Necessário recriar os codigos de barra, pois muda o Label de UNICO para 41 AO 44 e isto vc faz pela tela, conforme print
