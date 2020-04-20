select a.package_code, a.package_plan, a.pattern_cd, a.package_desc, a.*

select count(distinct a.policy_number)
from actuarial_health_fleet a
where a.package_code is null
or a.package_plan is null
or a.pattern_cd is NULL
or a.package_desc is NULL

;
