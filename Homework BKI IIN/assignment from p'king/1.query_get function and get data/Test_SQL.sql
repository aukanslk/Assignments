select a.sale_chnl_id, a.leaf_description, p.product_type_new||' : '||get_product_description(e.product_id) product,
       sum(e.prem_di_written) premuim
from ins_endt e, product_3digit p, ofs_rpt_hier_100200@stgofsa_ofsa_devofsa a
where e.as_of_date = '29-Feb-2020'
and e.sale_chnl_id = a.sale_chnl_id 
group by a.sale_chnl_id, a.leaf_description, p.product_type_new, get_product_description(e.product_id)
;


select e.*
from ins_endt e
where e.as_of_date = '29-Feb-2020'


SELECT *
from product_3digit a;

select distinct e.sale_chnl_id
from ins_endt e
where e.as_of_date = '29-Feb-2020'
;
