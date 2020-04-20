TRUNCATE table actuarial_health_fleet ;

select *
from actuarial_health_fleet;

exec p_actuary_pol_health.ACT_POL_HEALTH_FLEET(get_as_of_date) ;
