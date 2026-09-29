SELECT a.pedido, 
       p.griffe, 
       p.linha, 
       p.grupo_produto, 
       p.subgrupo_produto, 
       a.produto, 
       p.desc_produto, 
       a.cor_produto, 
       pc.desc_cor_produto, 
       a.cod_metrica, 
       b.desc_metrica, 
       a.data_log, 
       a.tipo_op, 
       a.valor_antes, 
       a.valor_depois, 
       a.usuario_pedido, 
       a.obs, 
       c.fornecedor, 
       k.entrega, 
       k.limite_entrega 
FROM   caedu_log_autoriza_compras_item a 
       INNER JOIN caedu_metricas_log_compras b 
               ON b.cod_metrica = a.cod_metrica 
       INNER JOIN produtos p 
               ON p.produto = a.produto 
       LEFT JOIN produto_cores pc 
              ON pc.produto = a.produto 
                 AND pc.cor_produto = a.cor_produto 
       INNER JOIN compras c 
               ON c.pedido = a.pedido 
       LEFT JOIN (SELECT DISTINCT pedido, 
                                  entrega, 
                                  limite_entrega, 
                                  produto, 
                                  cor_produto 
                  FROM   compras_produto) AS k 
              ON k.pedido = a.pedido 
                 AND k.produto = a.produto 
                 AND k.cor_produto = a.cor_produto 
WHERE  aprovado = 0 
ORDER  BY data_log DESC 