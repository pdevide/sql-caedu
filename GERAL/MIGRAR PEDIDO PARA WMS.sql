

select * from compras where pedido in ('189034-1','189034-2','189533-1','189533-2','188250-5')

update compras
set erp_percent_distrib = 0, ERP_TOTAL_QTD_DISTRIB=0
where pedido in ('189034-1','189034-2','189533-1','189533-2','188250-5')

/*
189034-1
189034-2
189533-1
189533-2
188250-5
*/