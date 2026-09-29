SET NOCOUNT ON;

SELECT sj.name AS [Name],
   sh.step_name AS [StepName],
   DATETIMEFROMPARTS(
       LEFT(padded_run_date, 4),         -- year
       SUBSTRING(padded_run_date, 5, 2), -- month
       RIGHT(padded_run_date, 2),        -- day
       LEFT(padded_run_time, 2),         -- hour
       SUBSTRING(padded_run_time, 3, 2), -- minute
       RIGHT(padded_run_time, 2),        -- second
       0) AS [LastRunDateTime],          -- millisecond
   CASE
       WHEN sh.run_duration > 235959
           THEN CAST((CAST(LEFT(CAST(sh.run_duration AS VARCHAR), LEN(CAST(sh.run_duration AS VARCHAR)) - 4) AS INT) / 24) AS VARCHAR) + '.' + RIGHT('00' + CAST(CAST(LEFT(CAST(sh.run_duration AS VARCHAR), LEN(CAST(sh.run_duration AS VARCHAR)) - 4) AS INT) % 24 AS VARCHAR), 2) + ':' + STUFF(CAST(RIGHT(CAST(sh.run_duration AS VARCHAR), 4) AS VARCHAR(6)), 3, 0, ':')
       ELSE STUFF(STUFF(RIGHT(REPLICATE('0', 6) + CAST(sh.run_duration AS VARCHAR(6)), 6), 3, 0, ':'), 6, 0, ':')
       END AS [LastRunDuration (d.HH:MM:SS)]
FROM msdb.dbo.sysjobs sj
INNER JOIN msdb.dbo.sysjobhistory sh
   ON sj.job_id = sh.job_id
CROSS APPLY (
   SELECT RIGHT('000000' + CAST(sh.run_time AS VARCHAR(6)), 6),
       RIGHT('00000000' + CAST(sh.run_date AS VARCHAR(8)), 8)
   ) AS shp(padded_run_time, padded_run_date)
where sj.name like '%ARB%'
GO