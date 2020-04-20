select uy.* 
from ins_policy_uy uy;

select *
from ins_policy_uy uy
where uy.policy_number||uy.policy_run = '6187033127691';

select p.policy_number||p.policy_run
from ins_policy p , ins_policy_uy uy
where p.policy_number = uy.policy_number
and p.policy_run = uy.policy_run;
 

select *
from ins_policy p
where p.product_id in ('100','111','112','113','114','115')
and p.policy_status_pc_cd = 'N'
and p.bbl_type_cd in('BLC','CLC')
and p.cancel_type_cd not in ( 'NTU','PR','SR');


select *
from cube_package_group c;


select *
from ofs_rpt_hier_100063 prod;


select distinct (ag.bu)
from agent_group ag
where ((ag.agent_code = '6900' and ag.agent_seq not in ('91','92'))
or ag.agent_code like '5%')
;

select distinct (ag.bu)
from agent_group ag
where ag.agent_code like '5%';


select *
from agent_group ag
where (ag.agent_code = '6900' and ag.agent_seq not in ('91','92'));




bbl_type_cd in('BLC','CLC')

cancel_type_cd not in ( 'NTU','PR','SR')
