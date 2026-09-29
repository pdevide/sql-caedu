--delete from CM_DATA_FECHAMENTO

--LX_CM_FECHAMENTO_CUSTO_MEDIO '201805',1

--select * from sysobjects where name = 'LX_CM_CUSTO_PA'


delete from cm_estoque_pa where COD_CUSTO_MEDIO = '201805'

delete from CM_ESTOQUE_PA_COMPOSICAO where COD_CUSTO_MEDIO = '201805' and item_composicao in ('199','399','999')

lx_cm_custo_pa '201805',1




 
