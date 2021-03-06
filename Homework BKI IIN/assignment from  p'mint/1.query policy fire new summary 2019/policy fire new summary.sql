select d.bu,d.Agent_Type,d.package_subgroup,d.Product
      ,count(distinct(d.policy_number||d.policy_run)) No_of_Pol ,
       sum(d.Sum_Insured) Sum_Insured, 
       sum(d.prem_full_term) Premium

from(
select uy.as_of_date, 
       ag.bu, 
       case when ag.agent_code = '6900' and ag.bancass_flg = 'BBL' then 'Counter'
            when ag.agent_code like '5%' then '�Թ�����١����������'
            end as Agent_Type,
       (prod.product_id||' : '|| prod.leaf_description) Product, 
       uy.policy_number,
       uy.policy_run,
       p.effective_date, 
       p.producer_cd, 
       p.package_cd, 
       cu.package_subgroup , 
       cu.package_description ,
       sum((p.tot_amt_of_ins*uy.pct_share)/100) Sum_Insured ,
       sum(p.prem_full_term) prem_full_term , 
       uy.pct_share

from ins_policy_uy uy, ins_policy p--18740--18517
, cube_package_group cu, ofs_rpt_hier_100063 prod, agent_group ag

where uy.end_status_date = p.as_of_date
and uy.policy_number = p.policy_number(+)
and uy.policy_run = p.policy_run(+)
and uy.as_of_date = '29-Feb-2020'
and TO_CHAR(uy.uw_date,'YYYY') = '2019'
and p.product_id in ('100','111','112','113','114','115')
and p.policy_status_pc_cd = 'N'
and p.bbl_type_cd in('BLC','CLC')
and p.cancel_type_cd not in ( 'NTU','PR','SR')
and p.package_cd = cu.package_cd(+)
and p.product_id = prod.product_id
and uy.agent_cd = ag.party_number
and uy.as_of_date = ag.as_of_date
and (((ag.agent_code = '6900' ) and (ag.agent_seq not in ('91','92')))
    or((ag.agent_code like '5%') and (p.bbl_type_cd in('BLC','CLC')))
    )
      
      
group by uy.as_of_date, ag.bu, ag.agent_code, ag.bancass_flg,
prod.product_id ,prod.leaf_description, uy.policy_number, uy.policy_run, 
p.effective_date, p.producer_cd, p.package_cd, cu.package_subgroup , 
cu.package_description, uy.pct_share
) d
group by d.bu,d.Agent_Type,d.package_subgroup,d.Product
