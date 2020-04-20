select distinct ag.agent_code,ag.bancass_flg
     ,case when ag.agent_code = '6900' and ag.bancass_flg = 'BBL' then 'Counter'
           when ag.agent_code = '6900' and ag.bancass_flg <> 'BBL' then 'No_counter'
           else 'XX' end as grp
           
from agent_group ag
where ag.agent_code = '6900' and ag.bancass_flg = 'BBL')
