SELECT * FROM ESTOQUE_PROD1_ENT WHERE produto = '60020071'

select grade,* from produtos where produto = '60020071'

select * from PRODUTOS_TAMANHOS where grade in ('1 AO 3','4 AO 8')

SELECT * FROM PRODUTOS_PACKS_PERMITIDOS WHERE PRODUTO = '60020071'

UPDATE PRODUTOS SET GRADE = '4 AO 8'
WHERE PRODUTO = '60020071'

UPDATE PRODUTOS_PACKS_PERMITIDOS
SET Q1 = 0, Q2 = 0, Q3 = 0, Q4 = 2, Q5 = 4, Q6 = 4
WHERE PRODUTO = '60020071'

DELETE FROM PRODUTOS_BARRA WHERE PRODUTO = '60020071'

/*REFAZER PELA TELA O CODIGO DE BARRAS DO PRODUTO */

/* outro formato de solicitação 
alterar a grade para os pedidos abaixo

27/28  29/30  31/32  33/34 
  2      2        4   4

230916-2
230911-2
230918
230919-2
230919-1
230911-1

*/

select * from compras_produto where pedido in (
'230916-2','230911-2','230918','230919-2','230919-1','230911-1')

select grade,* from produtos where produto in ('D9030017','D9040018','D6070014','D6080013','D6070015','D6070016')

select * from PRODUTOS_TAMANHOS where grade in 
('INF 27/28 AO 33/34','INF 21/22 AO 27/28')  

select * from PRODUTOS_PACKS_PERMITIDOS 
where produto in ('D9030017','D9040018','D6070014','D6080013','D6070015','D6070016')

update produtos set grade = 'INF 27/28 AO 33/34'
where produto in ('D9030017','D9040018','D6070014','D6080013','D6070015','D6070016')

delete from produtos_barra where produto in ('D9030017','D9040018','D6070014','D6080013','D6070015','D6070016')

