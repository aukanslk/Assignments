TRUNCATE table actuarial_health_benefit ;

select a.package_code, a.package_plan, a.pattern_cd, a.package_desc, a.product_id, a.*

select count(distinct a.policy_number)
from actuarial_health_benefit a
where a.package_code is null
or a.package_plan is null
or a.pattern_cd is NULL
or a.package_desc is NULL
or a.product_id is null;

--161261

select *
from actuarial_health_benefit a

-- ACT_POL_HEALTH_BENEFI --> insert_act_health_benefitT

exec p_actuary_pol_health.ACT_POL_HEALTH_BENEFIT(get_as_of_date);





