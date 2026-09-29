select
    obj.name, [text]
from
    sys.syscomments comm
	inner join sys.objects obj on obj.object_id = comm.id
    inner join sys.procedures procs on procs.object_id = comm.id
where
    procs.[name] like 'PDA_WMS%'