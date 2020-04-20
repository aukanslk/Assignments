  SELECT   r.region_name,
           d.department_id || ' ' || d.department_name department_name,
           mn.first_name || ' ' || mn.last_name head_dept_name,
           j.job_title,
           CASE
               WHEN a.new_salary > j.max_salary THEN 'New Salary Over'
               WHEN a.last_salary > j.max_salary THEN 'Last Salary Over'
               WHEN a.last_salary <= j.max_salary THEN 'Not Over'
           END
               AS range_rate,
           j.max_salary,
           ROUND (AVG (a.last_salary)) avg_last_salary,
           SUM (a.last_salary) last_salary,
           COUNT (a.employee_id) emp_cnt,
           SUM (jh.cnt_time) cnt_promote_time,
           SUM (jh.cnt_emp) cnt_promote_emp
           
    --select count(1)
    FROM   (SELECT   s.employee_id,
                     s.department_id,
                     s.manager_id,
                     s.new_salary,
                     s.longevity,
                     s.job_id,
                     ROUND (
                         s.new_salary + (s.new_salary * (s.longevity / 100)))
                         last_salary
              FROM   (SELECT   e.employee_id,
                               e.department_id,
                               e.manager_id,
                               e.salary + (e.salary * (20 / 100)) new_salary,
                               CASE
                                   WHEN e.commission_pct IS NOT NULL
                                   THEN
                                       ROUND(MONTHS_BETWEEN (ADD_MONTHS (SYSDATE, -120),e.hire_date)/ 12)
                                   ELSE
                                       ROUND(MONTHS_BETWEEN (SYSDATE,e.hire_date)/ 12)
                               END
                                   AS longevity,
                               e.job_id
                        FROM   hr.employees e
                        ) s
              ) a,
           hr.departments d,
           hr.jobs j,
           hr.locations l,
           hr.countries c,
           hr.regions r,
           hr.employees mn,
           (  SELECT   h.employee_id,
                       COUNT (h.employee_id) cnt_time,
                       COUNT (DISTINCT h.employee_id) cnt_emp
                FROM   hr.job_history h
            GROUP BY   h.employee_id) jh
   WHERE       a.department_id = d.department_id
           AND a.job_id = j.job_id
           AND d.location_id = l.location_id
           AND l.country_id = c.country_id
           AND c.region_id = r.region_id
           AND d.manager_id = mn.employee_id
           AND a.employee_id = jh.employee_id(+)
GROUP BY   r.region_name,
           d.department_id || ' ' || d.department_name,
           mn.first_name || ' ' || mn.last_name,
           j.job_title,
           CASE
               WHEN a.new_salary > j.max_salary THEN 'New Salary Over'
               WHEN a.last_salary > j.max_salary THEN 'Last Salary Over'
               WHEN a.last_salary <= j.max_salary THEN 'Not Over'
           END,
           j.max_salary
ORDER BY   r.region_name,
           d.department_id || ' ' || d.department_name,
           mn.first_name || ' ' || mn.last_name,
           j.job_title,
           CASE
               WHEN a.new_salary > j.max_salary THEN 'New Salary Over'
               WHEN a.last_salary > j.max_salary THEN 'Last Salary Over'
               WHEN a.last_salary <= j.max_salary THEN 'Not Over'
           END,
           j.max_salary;

