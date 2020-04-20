select *
from actuarial_health_benefit;

--เพิ่ม 5 column

select *
from actuarial_health_fleet;

-- เพิ่ม 4 column

SELECT 
distinct m.pol_no||m.pol_run,
         m.package_code||'0'||m.package_seq package_code,
         m.package_plan,
         m.patn_code pattern_cd ,
         P_ACTUARY_POL_HEALTH.get_package_desc(m.package_code,m.package_seq) package_desc,
         m.prod_type product_id
from  mis_mas m, pa_ph_ben b
where m.pol_no =  b.pol_no
and m.pol_run = b.pol_run
and m.end_seq = b.end_seq
and m.prod_type in ( select distinct  p.product_type_new
                     from product_3digit p
                     where p.data_source = '21'  )
and to_char(m.fr_date,'yyyy') >= '2003'
and to_char(nvl(m.original_date,m.trn_date),'yyyymm') <= to_char(get_as_of_date,'yyyymm')
and M.PROD_TYPE = '026'
and (m.pol_no||m.pol_run) in (select distinct a.policy_number
                                from actuarial_health_benefit a
                                where a.package_code is null
                                or a.package_plan is null
                                or a.pattern_cd is NULL
                                or a.package_desc is NULL
                                or a.product_id is null)
and (m.package_code||'0'||m.package_seq is null
    or    m.package_plan is null
    or    m.patn_code is null
    or    P_ACTUARY_POL_HEALTH.get_package_desc(m.package_code,m.package_seq) is null
    or    m.prod_type is null)
;



select a.package_code||'0'||a.package_seq package_code,
      a.package_plan,
      a.patn_code pattern_cd ,
      P_ACTUARY_POL_HEALTH.get_package_desc(a.package_code,a.package_seq) package_desc,
      a.prod_type product_id
from mis_mas a
where a.prod_type = '026'


