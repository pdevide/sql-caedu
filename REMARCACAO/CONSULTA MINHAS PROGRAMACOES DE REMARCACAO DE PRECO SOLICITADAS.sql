select * 
from dbo.caedu_remarcacao_precos a
where 1=1
		AND a.scheduling_user = 'CCP\PAULO.DEVIDE'
		AND a.execution_date_time is null

